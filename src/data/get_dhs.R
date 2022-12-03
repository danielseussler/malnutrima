# load available surveys for selected countries
#
#
#

library(here)
library(data.table)
require(rdhs)

# country selection
countries = rdhs::dhs_countries()
mycountries = c("Nigeria", "Ethiopia")
cselected = countries[CountryName %in% mycountries, DHS_CountryCode]

# only include surveys with anthropometric measurements
surveychar = rdhs::dhs_survey_characteristics()
surveychar[grepl("Anthropometry", SurveyCharacteristicName, ignore.case = TRUE)]

# survey selection
# fileType is PR Household Member Recode and GE Geographic Data
# see also https://dhsprogram.com/data/File-Types-and-Names.cfm

surveys = rdhs::dhs_surveys(surveyCharacteristicIds = 10, countryIds = cselected)
surveys[, .(SurveyId, CountryName, SurveyYear, NumberOfWomen, SurveyNum, FieldworkEnd)]

datasets = rdhs::dhs_datasets(surveyIds = surveys$SurveyId, fileType = c("PR", "GE", "KR"), fileFormat = "flat")
datasets[, .(SurveyId, SurveyNum, FileDateLastModified, FileName)]

datasets = datasets[SurveyId %in% c("ET2019DHS", "NG2018DHS")]

# download datasets
rdhs::get_datasets(dataset_filenames = datasets$FileName, output_dir_root = here("data", "raw", "rdhs"), clear_cache = TRUE)
rdhs::get_downloaded_datasets()
