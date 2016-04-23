library(ff)
N <- 8e7
n <- 1e6
countries <- factor(c('FR', 'ES', 'PT', 'IT', 'DE', 'GB', 'NL', 'SE', 'DK', 'FI'))
years <- 2000:2009
genders <- factor(c("male", "female"))

country <- ff(countries, vmode = 'ubyte', length=N, update = FALSE, filename="c:/Users/tmp/country.ff", finalizer = "close")
for (i in chunk(1, N, n))
country[i] <- sample(countries, sum(i), TRUE)
year <- ff(years, vmode='ushort', length = N, update = FALSE, filename="c:/Users/tmp/year.ff", finalizer = "close")

gender <- ff(genders, vmode = 'quad', length = N, update=FALSE)
for (i in chunk(1, N, n))
    gender[i] <- sample(genders, sum(1), TRUE)
    
age <- ff(0, vmode='ubyte', length=N, update = FALSE, filename="c:/Users/tmp/age.ff",finalizer="close")
    for (i in chunk(1, N, n))
      age[i] <- ifelse(gender[i] =="male"
      , rnorm(sum(i), 40, 10), rnorm(sum(i), 50, 12))

income <- ff(0, vmode='single', length=N, update=FALSE, 
    filename="c:/Users/tmp/income.ff", finalizer="close")
      for (i in chunk(1, N, n))
         income[i] <- ifelse(gender[i] == "male"
         , rnorm(sum(i), 34000, 5000), rnorm(sum(i), 30000, 6000))

close(age)
close(income)
close(country)
close(year)
save(age, income, country, year, countries, years, genders, W, n, file="c:/Users/tmp/ff.RData")
