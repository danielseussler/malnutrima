# download country shape files from gadm database
#
#
#

library(here)
library(sf)
require(geodata)
require(purrr)

nigeria = purrr::map(
  .x = c(0, 1, 2),
  .f = ~ geodata::gadm(
    country = "Nigeria",
    level = .,
    path = tempdir(),
    version = "latest",
    resolution = 2
  ) |>
    st_as_sf() |>
    st_transform(crs = 4326)
) |> setNames(c("admin0", "admin1", "admin2"))

kenya = purrr::map(
  .x = c(0, 1, 2),
  .f = ~ geodata::gadm(
    country = "Kenya",
    level = .,
    path = tempdir(),
    version = "latest",
    resolution = 2
  ) |>
    st_as_sf() |>
    st_transform(crs = 4326)
) |> setNames(c("admin0", "admin1", "admin2"))


ethiopia = purrr::map(
  .x = c(0, 1, 2),
  .f = ~ geodata::gadm(
    country = "Ethiopia",
    level = .,
    path = tempdir(),
    version = "latest",
    resolution = 2
  ) |>
    st_as_sf() |>
    st_transform(crs = 4326)
) |> setNames(c("admin0", "admin1", "admin2"))

saveRDS(object = nigeria, file = here("data", "processed", "nigeria", "gadm.rds"))
saveRDS(object = kenya, file = here("data", "processed", "kenya", "gadm.rds"))
saveRDS(object = ethiopia, file = here("data", "processed", "ethiopia", "gadm.rds"))
