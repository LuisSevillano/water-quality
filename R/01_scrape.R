html <- read_html("https://www.saihduero.es/saica/EC211/")

file_name <-  'duero_data.csv'
if (!file.exists(file_name)) {
  df = data.frame(
    id = character(0),
    name = character(0),
    value = numeric(0),
    date = character(0)
  )
} else {
  df <- read_csv(file_name)
}

id <- 'EC211'
name <- 'turbidity'

turbidity <-
  html |> html_node(xpath = '//*[@id="main-wrapper"]/div/div/div[2]/div/div[2]/div/div/table/tbody/tr[9]/td[2]/text()')
date <-
  html |> html_node(xpath = '//*[@id="main-wrapper"]/div/div/div[2]/div/div[2]/div/div/table/tbody/tr[9]/td[3]/span[1]')

df <-
  df %>% add_row(
    id = id,
    name = 'turbidity',
    value = as.numeric(turbidity %>% html_text2()),
    date = date %>% html_text2()
  ) %>%
  distinct(id, name, value, date)

write_csv(df, file_name)
