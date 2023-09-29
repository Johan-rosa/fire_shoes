library(readxl)
library(dplyr)
library(janitor)
library(stringr)

original_data <- read_excel("data/original_data/Venta de tenis.xlsx", sheet = "Tenis comprados") |>
  clean_names()

original_data |> 
  filter(!is.na(tenis)) |>
  mutate(
    tenis = tolower(tenis),
    modelo = str_extract(tenis, ".+(?=\\s-)"),
    modelo = str_remove(modelo, "nike|adidas|puma") |> str_squish(),
    size_usa = str_extract(tenis, "(?<=size\\s)\\d+(\\.\\d)?"), 
    marca = str_extract(tolower(tenis), "nike|adidas|puma"),
    color = str_extract(tenis, "\\(.+\\)") |> str_remove_all("[\\(\\)]")
  ) |> clipr::write_clip()
  pull(tenis)
  
