antes <- c(7, 6, 5, 6, 7)
despues <- c(8, 7, 8, 8, 9)

t.test(despues, antes, paired = TRUE)