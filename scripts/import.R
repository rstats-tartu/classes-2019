library(tidyverse)
library(here)

date_format <- col_date(format = "%d.%m.%Y")
pac_csv <- read_delim("hf-data/post-acute_care_data_only (rows).csv",
                      delim = ";", 
                      escape_double = FALSE, 
                      trim_ws = TRUE, na = "n/a",
                      col_types = cols(fake_id = "c",
                                       invoice_number = "c",
                                       invoice_start = date_format,
                                       invoice_end = date_format,
                                       `post-acute_type` = "c",
                                       LOS = "d",
                                       therapy = "d"))

pac_csv <- rename_all(pac_csv, str_replace_all, "-", "_") %>% 
  rename(id = fake_id)
pac_csv
write_csv(pac_csv, here("output", "post_acute_care.csv"))

coltypes <- cols(
  id = col_double(),
  sex = col_character(),
  age = col_double(),
  county = col_character(),
  comorbidity = col_double(),
  myocardial_infarction = col_integer(),
  congestive_heart_failure = col_integer(),
  peripheral_vascular_disease = col_integer(),
  cerebrovascular_disease = col_integer(),
  dementia = col_integer(),
  chronic_pulmonary_disease = col_integer(),
  rheumatic_disease = col_integer(),
  peptic_ulcer_disease = col_integer(),
  diabetes = col_integer(),
  `hemi-paraplegia` = col_integer(),
  renal_disease = col_integer(),
  any_malignancy = col_integer(),
  liver_disease = col_integer(),
  metastatic_solid_tumor = col_integer(),
  `aids-hiv` = col_integer(),
  alcohol_abuse = col_integer(),
  obesity = col_integer(),
  psychoses = col_integer(),
  depression = col_double(),
  date_of_fracture = date_format,
  year = col_integer(),
  fracture_type = col_character(),
  operation_date = date_format,
  days_to_operation = col_double(),
  operation_weekday = col_integer(),
  management_method = col_character(),
  acute_LOS = col_double(),
  acute_therapy = col_double(),
  `post-acute_LOS` = col_double(),
  `post-acute_therapy` = col_double(),
  `post-acute_type` = col_character(),
  `in-hospital_mortality` = col_double(),
  time_3m = col_double(),
  status_3m = col_double(),
  time_12m = col_double(),
  status_12m = col_double()
)

summary_csv <- read_delim("hf-data/summary (columns).csv",
                          delim = ";", 
                          escape_double = FALSE, 
                          trim_ws = TRUE, na = "n/a",
                          col_types = coltypes)
spec(summary_csv)
summary_csv <- rename_all(summary_csv, str_replace_all, "-", "_")
summary_csv
write_csv(summary_csv, here("output", "summary.csv"))
