raw <- read_csv('duero_data.csv')

parsed <- raw %>%
  mutate(dateParsed = dmy_hm(date))

latestDate <- parsed %>%
  arrange(desc(dateParsed)) %>%
  pull(dateParsed)

g <- ggplot(parsed, aes(x = dateParsed, y = value)) +
  geom_point() +
  ylim(c(0, 350)) +
  theme_minimal() +
  labs(title = str_glue('Turbidity in Aranda de Duero {format(latestDate, format="%m/%d/%Y %H:%M")}'),
       caption = "Sistema Automático de Información del Duero") + 
  theme(
    axis.title.x=element_blank(),
    axis.title.y=element_blank()
  )


ggsave(str_glue('plots/{as.numeric(Sys.time())}.jpg'), g)
ggsave(str_glue('plots/latest.jpg'), g)
