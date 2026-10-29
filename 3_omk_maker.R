source("1_omk_texts_list.R")
source("2_omk_hands.R")

library(readxl)

codex_list <- paste0("http://omagyarkorpusz.nytud.hu/documents/kodexek/", codices, "/rmkinput")
bible_list <- paste0("http://omagyarkorpusz.nytud.hu/documents/bibliak/", bibles, "/rmkinput")
minor_list <- paste0("http://omagyarkorpusz.nytud.hu/documents/kisebbek/", minors, "/rmkinput")

omk_text_list <- list(codex_list, bible_list, minor_list)
omk_names <- list(codices, bibles, minors)
omk_text_list <- map2(omk_text_list, omk_names, ~set_names(.x, .y))

omk_parts_list  <- c(
  "codex_list_from_url",
  "bible_list_from_url",
  "minor_list_from_url"
)

for (i in seq_along(omk_parts_list)) {
  col_nms <- map(
    omk_text_list[[i]], 
    ~read_tsv(.x, col_names = F, n_max = 1) |> 
      select(1) |> 
      pull() |> 
      str_sub(12) |> 
      str_split(" ")
  ) |> 
    list_flatten()
  
  list1 <- map2(
    omk_text_list[[i]], 
    col_nms,
      ~read_tsv(.x, col_names = .y, skip = 1, quote = "") |> 
      mutate(
        across(
          .cols = where(is.logical),
          .fns = ~NA_character_
        ),
        X98 = NA_character_,
        X99 = NA_character_,
      ) |> 
      rename_with(
        .cols = starts_with("X")[1:7], 
        ~c("betuhu", "norm", "ertelm", "igekoto", "megj", "lemma", "tags")
      ) |> 
      mutate(
        across(
          .cols = starts_with("X"),
          .fns = ~NULL
        ),
      ) 
  )
  assign(omk_parts_list[i], list1)
}

codex_bible_minor_list <- c(
  codex_list_from_url, 
  bible_list_from_url,
  minor_list_from_url
)


## azért csak ennél kell átírni a lapjelzetet, mert a többi rv-jelölésűnél csak 1 kéz van
codex_bible_minor_list[["SzekK"]] <- 
  codex_bible_minor_list[["SzekK"]] |> 
  mutate(
    oldal_n = as.numeric(str_sub(oldal, 1, -2)),
    oldal_rv = str_sub(oldal, -1, -1),
    oldal2 = case_when(
      oldal_rv == "r" ~ 2*oldal_n-1,
      oldal_rv == "v" ~ 2*oldal_n,
      TRUE ~ oldal_n,
    ),
  ) |> 
  rename(oldal_orig = oldal, oldal = oldal2)

omk <- map2(
  codex_bible_minor_list, 
  kezek,
   ~mutate(.x, ## plusz feltétel: & lag(text) == text
      kez = if (is.function(.y)) .y(oldal) else .y,
      oldal = if ("oldal" %in% names(.x)) as.character(oldal) else NA_character_,
      sor = if ("sor" %in% names(.x)) as.numeric(sor) else NA,
      könyv_fejezet = if ("könyv_fejezet" %in% names(.x)) as.character(könyv_fejezet) else NA_character_,
      vers = if ("vers" %in% names(.x)) as.character(vers) else NA_character_,
   )
) |>
  bind_rows(.id = "id") |> 
  mutate(
    subcorpus = case_when(
      id %in% codices ~ "codex",
      id %in% bibles ~ "bible",
      id == "Level" ~ "missive",
      id %in% minors ~ "minor",
    ),
    id = ifelse(!is.na(sorszám), paste0(id, sorszám), id),
    sorszám = NULL,
    betuhu = str_remove_all(betuhu, "\"") 
  ) |> 
  relocate(subcorpus, .before = id) |> 
  relocate(kez, .after = id) |> 
  relocate(sor, .after = oldal) |> 
  select(-starts_with("oldal_"), -kéz) 

# write_tsv(omk, "omk.tsv")
# omk <- read_tsv("omk.tsv")

codex_years <- read_excel("codex_years.xlsx") |> 
  mutate(copy_avg = as.character(copy_avg))

omk_years <- omk |> 
  left_join(codex_years, by = join_by(id == kodex, kez, keletkezés == copy_avg))
