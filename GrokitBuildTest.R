library(gtBase)
library(datasets)


# Using R base 'datasets' package for test data
# table: women
# dim: 15 rows by 2 columns
# fields: Height, Weight

# Fix illegal attribute names
names(women) <- c("Height", "Weight")
write.csv(women, "women.csv", row.names = FALSE)

# print("Check: Test Data Written to CSV")

test.data <- ReadCSV("women.csv", attributes = c(Height = INT, Weight = INT), header = TRUE, simple = TRUE)

print(names(test.data))
print(names(test.data$schema))

print("Check: Data Loaded")

grouping <- GroupBy(
  test.data,
  group = Height,
  Weight = Mean(Weight)
)

print("Check: Ran Group By")

grokit.results <- as.data.frame.data(grouping)
grokit.results <- grokit.results[order(grokit.results$Height),]

print(grokit.results)

if (isTRUE(all.equal(grokit.results, women, check.attributes = FALSE))){
	print("Test: GroupByTest.R SUCCEEDED")
} else {
	print("Test: GroupByTest.R FAILED")
}
