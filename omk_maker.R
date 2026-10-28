library(tidyverse)

codices <- c(
  "AporK",
  "BecsiK",
  "BirkK",
  "BodK",
  "CornK",
  "CzechK",
  "DebrK",
  "DobrK",
  "DomK",
  "ErdyK",
  "ErsK",
  "FestK",
  "GomK",
  "GuaryK",
  "GyongyK",
  "HorvK",
  "JokK",
  "JordK",
  "KazK",
  "KeszthK",
  "Konyvecse",
  "KrisztLeg",
  "KrizaK",
  "KulcsarK",
  "LanyiK",
  "LazK",
  "LobkK",
  "MargLeg",
  "MarTor",
  "MiskTor",
  "MunchK",
  "NadK",
  "NagyszK",
  "PeerK",
  "PeldK",
  "PiryH",
  "PozsK",
  "SandK",
  "SimorK",
  "SzekK",
  "TelK",
  "TihK",
  "ThewrK",
  "VirgK",
  "VitkK",
  "WeszprK",
  "WinklK"
)

codices_norm <- c(
  "AporK",
  "BecsiK",
  "BirkK",
  "BodK",
  "CzechK",
  "FestK",
  "GuaryK",
  "JokK",
  "JordK",
  "KazK",
  "Konyvecse",
  "KrisztLeg",
  "LanyiK",
  "MiskTor",
  "MunchK",
  "NadK",
  "SimorK",
  "SzekK"
)

bibles <- c(
  "Heltai",
  "Kaldi",
  "Karoli",
  "Pesti",
  "Sylvester"
)

minors <- c(
  "Bag",
  "Cant",
  "Csi",
  "Cze",
  "Dal",
  "GLe",
  "GyS",
  "HB",
  "HNe",
  "Hadi",
  "Jak",
  "Jog",
  "KTSz",
  "Korm",
  "LaskS",
  "Level",
  "ME",
  "MS",
  "OMS",
  "Orv",
  "Pann",
  "Rot",
  "Sop",
  "SzV",
  "SztMik"
)

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
      ~read_tsv(.x, col_names = .y, skip = 1) |> 
      mutate(
        across(
          .cols = starts_with("X"),
          .fns = ~ifelse(is.logical(.x), NA_character_, .x) #as.character(.x)
        )
      ) |> 
      rename_with(
        .cols = starts_with("X")[1:5], 
        ~c("betuhu", "norm", "ertelm", "igekoto", "megj")
      )
  )
  assign(omk_parts_list[i], list1)
}


list(
  codex_list_from_url |> 
    bind_rows(.id = "text"),
  bible_list_from_url |> 
    bind_rows(.id = "text"),
  minor_list_from_url |> 
    bind_rows(.id = "text")
) |> 
  bind_rows(.id = "subcorpus")

# egy db tsv, ld. feljebb
# + kodex_evek <- read_excel("data/0b_kodex_evek.xlsx")
# readme
# join
#### aztán find_nelkul
#### + manuálisan összevont szavak nélkül repo-ba külön behívása
