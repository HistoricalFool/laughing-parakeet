library(pacman)
  p_load(ggplot2,gganimate, hrbrthemes, gapminder)

gapminder

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp)) + geom_point()
  # Data comes from gapminder and the aesthetics mappings define the x and y axes
ggplot(data = gapminder, aes(x=gdpPercap, y=lifeExp, size=pop, col=continent)) + geom_point(alpha = 0.3)
  # can drop the mapping part, starting with aes as ggplot2 knows the order of args
ggplot(data = gapminder, aes(x=gdpPercap, y=lifeExp)) + geom_point(aes(size='big', col='black'), alpha = 0.3)
  # aesthetics must be mapped to variables not descriptions

p = ggplot(data=gapminder, aes(x = gdpPercap, y=lifeExp))
p
  # Defining a plot object which can be reused easily
p +
  geom_point(alpha=0.3) +
  geom_smooth(method = 'loess')
  # this allows for combinations of different geoms to create different visualizations

p +
  geom_point(aes(size=pop, col=continent), alpha=0.3)+
  geom_smooth(method='loess')

ggplot(data=gapminder) + 
  geom_density(aes(x=gdpPercap,fill=continent), alpha=0.3)

## Building in Layers: example of complicated layered plot
p2 =
  p +
  geom_point(aes(size=pop, col=continent), alpha=0.3) +
  scale_color_brewer(name="Continent", palette="Set1") +
  scale_size(name = "Population", labels=scales::comma) +
  scale_x_log10(labels=scales::dollar) +
  labs(x="Log (GDP per Capita)", y = "Life Expectancy") 
## External Theme
p2 + theme_modern_rc() + geom_point(aes(size=pop,col=continent), alpha=0.2)

##Animation:
ggplot(gapminder, aes(gdpPercap, lifeExp, size=pop, colour=country)) + 
  geom_point(alpha=0.7, show.legend=FALSE) +
  scale_colour_manual(values=country_colors) +
  scale_size(range = c(2,12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # gganimate specific stuff:
  labs(title='Year: {frame_time}', x='GDP per capita', y='life expectancy')
  transition_time(year) +
  ease_aes('linear')
