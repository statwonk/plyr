context("List to data frame")

a <- as.POSIXct(1, origin="2011-01-01")

test_that("classes preserved for atomic scalars", {
  li <- list(a, a+1)
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(class(df[,1]), equals(class(a)))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(1))
})

test_that("classes preserved for atomic scalars in list of length 1", {
  li <- list(a)
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(1))
  expect_that(ncol(df), equals(1))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for atomic vectors", {
  li <- list(c(a, a+1), c(a+2, a+3))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(2))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for atomic vectors in list of length 1", {
  li <- list(c(a, a+1))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(1))
  expect_that(ncol(df), equals(2))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("classes preserved for data.frames", {
  li <- list(data.frame(V1=a, V2=a+1), data.frame(V1=a+2, V2=a+3))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(2))
  expect_that(class(df[,1]), equals(class(a)))
})

test_that("names preserved for atomic scalars", {
  li <- list(c(foo=1), c(foo=2))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(1))
  expect_that(names(df), equals(c("foo")))
})

test_that("names preserved for atomic scalars in list of length 1", {
  li <- list(c(foo=1))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(1))
  expect_that(ncol(df), equals(1))
  expect_that(names(df), equals(c("foo")))
})

test_that("names preserved for atomic vectors", {
  li <- list(c(foo=1, bar=2), c(foo=3, bar=4))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(2))
  expect_that(class(df), equals("data.frame"))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("names preserved for atomic vectors n list of length 1", {
  li <- list(c(foo=1, bar=2))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(1))
  expect_that(ncol(df), equals(2))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("names preserved for data.frames", {
  li <- list(data.frame(foo=1, bar=2), data.frame(foo=3, bar=4))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(2))
  expect_that(names(df), equals(c("foo","bar")))
})

test_that("names preserved and filled for atomic vectors", {
  li <- list(c(foo=1, 2), c(foo=3, 4))
  df <- list_to_dataframe(li)
  expect_that(df, is_a("data.frame"))
  expect_that(nrow(df), equals(2))
  expect_that(ncol(df), equals(2))
  expect_that(names(df), equals(c("foo","V1")))
})
