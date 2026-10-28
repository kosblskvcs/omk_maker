library(tidyverse)

kezek_norm <- list(
  AporK = function(oldal) {
    case_when(
      oldal < 37 ~ 1,
      oldal < 176 ~ 2,
      oldal >= 189 & oldal <= 198 ~ 4,
      TRUE ~ 3,
    )
  },
    
  BecsiK = function(oldal) {
    # 1--101, 104, 285--289, 303--305, 315
    # 102--103, 105--284, 290--302, 306--314, 315--320
    # 321--324
    case_when(
      oldal > 320 ~ 3,
      oldal < 102 ~ 1,
      oldal < 104 ~ 2,
      oldal == 104 ~ 1,
      oldal < 285 ~ 2,
      oldal < 290 ~ 1,
      oldal < 303 ~ 2,
      oldal < 306 ~ 1,
      oldal < 315 ~ 2,
      oldal == 315 ~ 1,
      oldal <= 320 ~ 2
    )
  },
  
  BirkK = 1,
  BodK = 1,
  CzechK = 1,
  FestK = 1,
  GuaryK = 1,
  JokK = 1,
  JordK = 1,
  KazK = 1,
  Konyvecse = 1,
  KrisztLeg = 1,
  LanyiK = function(oldal) {
    case_when(
      oldal < 186 ~ 1,
      oldal < 223 ~ 2,
      TRUE ~ 3,
    )
  },
  MiskTor = 1,
  MunchK = 1,
  NadK = 1,
  SimorK = 1
  # SzekK = function(oldal) {
  #   case_when(
  #     oldal < 233 ~ 1,
  #     oldal < 313 ~ 2,
  #     oldal < 322 ~ 3,
  #     oldal < 337 ~ 4,
  #     oldal < 357 ~ 5,
  #     TRUE ~ 6,
  #   )
  # }
)

# Gömöry-kódex 58. oldala már a 8. kézhez tartozik

kezek_unnorm <- list(
  CornK = 1,
  DebrK = function(oldal) {
    case_when(
      oldal < 229 ~ 1,
      oldal < 327 ~ 2,
      oldal < 491 ~ 3,
      oldal < 558 ~ 4,
      oldal > 558 & oldal < 625 ~ 5,
      oldal < 631 ~ 6,
      oldal == 631 ~ 7,
    )
  },
  DobrK = 1,
  DomK = 1,
  ErdyK = 1, # két kéz?,
  ErsK = function(oldal) {
    case_when(
      oldal < 311 ~ 1,
      oldal < 317 ~ 2,
      oldal < 425 ~ 3,
      oldal < 429 ~ 2,
      oldal < 431 ~ 3,
      oldal < 441 ~ 2,
      oldal < 445 ~ 1, # 445-ön nincs nélkül
      oldal < 447 ~ 4, # ?? nem világos a táblázatból
      oldal < 545 ~ 1, # 544 csekkolva: 1. kézé
      oldal < 552 ~ 4,
      oldal < 556 ~ 5, # 555-ön nincs nélkül
      oldal < 569 ~ 4,
      oldal == 569 ~ 5, # 569-en nincs nélkül
      oldal < 574 ~ 4, # 570-es nélkülök a 4. kézhez tartoznak
      oldal < 576 ~ 5,
      oldal < 578 ~ 4,
      oldal > 578 ~ 3,
    )
  },
  GomK = function(oldal){
    case_when(
      oldal == 2 ~ 1,
      oldal > 3 & oldal < 11 ~ 2,
      oldal < 43 ~ 3, # 43-on nincs nélkül
      oldal < 46 ~ 4, 
      oldal == 46 ~ 6, # és 5. kéz 1-6. sor, utána 6. kéz
      oldal < 58 ~ 7, # 53-on nincs nélkül; 53/12-15 a 8. kézé
      oldal < 139 ~ 8,
      oldal < 141 ~ 1,
      oldal < 238 ~ 8,
      oldal < 269 ~ 3,
      oldal < 296 ~ 8,
      oldal < 298 ~ 5, # 298-on nincs nélkül
      oldal < 319 ~ 3, # 319-en nincs nélkül
      # oldal == 318 ~ 4, # csak a 14-18. sor
      # oldal == 319 ~ 9, # csak az 1-4. sor
      oldal < 321 ~ 10,
      oldal < 323 ~ 5,
      oldal == 323 ~ 10,
      oldal == 324 ~ 11,
      oldal > 324 ~ 5,
    )
  },
  GyongyK = function(oldal){
    case_when(
      oldal < 7 ~ 1,
      oldal < 23 ~ 2,
      oldal < 28 ~ 3,
      oldal == 28 ~ 4, # csak a 3-15. sor
      oldal == 41 ~ 3,
      oldal > 43 & oldal < 55 ~ 3,
      oldal > 60 & oldal < 65 ~ 6,
      oldal > 67 ~ 3
    )
  },
  HorvK = 1,
  # Jord2K = 1,
  KeszthK = 1, 
  KrizaK = 1, # nincs nélkül benne, mapből deselectelni
  KulcsarK = 1,
  LazK = function(oldal) {
    case_when(
      oldal < 18 ~ 1,
      oldal < 24 ~ 2,
      oldal < 45 ~ 3,
      oldal < 140 ~ 4,
      oldal == 140 ~ 6, # 6-8. kéz
      oldal < 157 ~ 4,
      oldal < 191 ~ 5,
      oldal < 193 ~ 9, # nincs benne a táblázatban
      oldal < 195 ~ 5,
      oldal > 194 ~ 4,
    )
  },
  LobkK = function(oldal) {
    case_when(
      oldal < 3 ~ 1,
      oldal == 3 ~ 2,
      oldal < 31 ~ 1,
      oldal < 175 ~ 3,
      oldal < 185 ~ 1,
      oldal < 221 ~ 4,
      oldal < 230 ~ 1,
      oldal < 248 ~ 5,
      oldal < 250 ~ 2,
      oldal < 250 ~ 2,
      oldal < 254 ~ 6, # megkérdezni
      oldal < 343 ~ 2,
      oldal > 342 ~ 1,
    )
  },
  MargLeg = 1,
  MarTor = 1, # nincs nélkül benne, mapből deselectelni
  NagyszK = 1,
  PeerK = function(oldal) {
    case_when(
      oldal < 185 ~ 1,
      oldal < 217 ~ 2,
      oldal < 347 ~ 1,
      oldal < 357 ~ 4,
      oldal < 363 ~ 5,
      oldal < 367 ~ 6,
      oldal == 367 ~ 7, # csak az utolsó 6-8 sor
      oldal == 368 ~ 6,
      oldal == 369 ~ 1,
    )
  },
  PeldK = function(oldal) {
    case_when(
      oldal < 19 ~ 1,
      oldal < 65 ~ 2,
      oldal > 64 ~ 3,
    )
  },
  PiryH = 1, # nincs nélkül benne, mapből deselectelni
  PozsK = function(oldal) {
    case_when(
      oldal < 23 ~ 1,
      oldal < 48 ~ 1,
      oldal == 49 ~ 3,
      oldal < 52 ~ 4,
      oldal < 66 ~ 6, # 50 első 3 sora az 5. kézé
      oldal < 75 ~ 7,
    )
  },
  SandK = 1,
  SzekK = function(oldal) {
    case_when(
      oldal < 233 ~ 1,
      oldal < 313 ~ 2,
      oldal < 322 ~ 3,
      oldal < 337 ~ 4,
      oldal < 357 ~ 5,
      TRUE ~ 6,
    )
  },
  TelK = NA, # lappang
  ThewrK = function(oldal) {
    case_when(
      oldal < 105 ~ 1,
      oldal < 111 ~ 2,
      oldal < 119 ~ 1,
      oldal < 123 ~ 3,
      oldal < 127 ~ 4,
      oldal < 157 ~ 1,
      oldal < 164 ~ 5,
      oldal < 185 ~ 6,
      oldal < 283 ~ 1, # 282-n az utolsó két sor a 3. kézé
      oldal < 308 ~ 3,
      oldal > 308 ~ 5,
    )
  },
  TihK = 1,
  VirgK = 1,
  VitkK = 1,
  WeszprK = function(oldal) {
    case_when(
      oldal < 113 ~ 1,
      oldal < 117 ~ 3,
      oldal > 116 ~ 2,
    )
  },
  WinklK = function(oldal) {
    case_when(
      (oldal == 32 | oldal == 44) ~ 2,
      oldal < 357 ~ 1,
      oldal > 356 ~ 3,
    )
  }
)

kezek_minors <- set_names(rep(1, length(minors)), minors)
kezek_bibles <- set_names(rep(1, length(bibles)), bibles)

kezek_codices <- c(kezek_norm, kezek_unnorm)
kezek <- c(
  kezek_codices[order(names(kezek_codices))],
  kezek_bibles,
  kezek_minors
)
