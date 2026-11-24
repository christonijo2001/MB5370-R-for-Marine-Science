
# ================================================================
# MB5370 - TECHNIQUES IN MARINE SCIENCE 1
# MODULE: R FOR MARINE SCIENCE
# WORKSHOP 1: FOUNDATIONS OF DATA SCIENCE
# ================================================================
#
# Topic: Data Importing and Initial Data Wrangling
#
# Purpose:
# This script demonstrates how to import marine science datasets
# using R and identify common problems associated with raw
# environmental field data.
#
# Skills covered:
# - Loading R packages
# - Importing CSV, TSV and Excel files
# - Handling field metadata
# - Identifying missing-value codes
# - Preparing datasets for further analysis
#
# Source: MB5370 R for Marine Science - Workshop 1 Workbook
#
# ================================================================


# ----------------------------------------------------------------
# SECTION 1: LOAD REQUIRED PACKAGES
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.1 - ENVIRONMENT HOUSEKEEPING
# ================================================================

# Inventory every active object currently residing in session RAM.

objects()

# Purge the global environment.

rm(list = ls())

# Confirm that the global session memory is now vacant.

objects()
# Load the tidyverse package for data manipulation and analysis.
library(tidyverse)

# Load readxl for importing Excel spreadsheets.
library(readxl)


# ----------------------------------------------------------------
# SECTION 2: IMPORT DIFFERENT TYPES OF MARINE DATA
# ----------------------------------------------------------------

# The lecturer introduces three common scientific data formats:
#
# CSV  - Comma-separated values
# TSV  - Tab-separated values
# XLSX - Microsoft Excel spreadsheets
#
# The following commands demonstrate how to import each format.


# 2.1 Import reef cover observations from a CSV file.

benthic_cover <- read_csv(
  here::here("data/workshop1/reef_cover_log.csv")
)


# 2.2 Import acoustic telemetry data from a TSV file.

acoustic_stream <- read_tsv(
  here::here("data/workshop1/acoustic_telemetry_stream.txt")
)


# 2.3 Import fisheries catch data from an Excel workbook.
# The workbook specifies the sheet named "Commercial_2026".

fisheries_annual <- read_excel(
  here::here("data/workshop1/fish_catch_data.xlsx"),
  sheet = "Commercial_2026"
)


# ----------------------------------------------------------------
# SECTION 3: IMPORT A MESSY MANGROVE SURVEY DATASET
# ----------------------------------------------------------------

# Environmental field datasets sometimes contain notes above
# the actual data table.
#
# This dataset contains five lines of field information before
# the column headings.
#
# First, import the dataset without correcting the formatting.
# This demonstrates the problem described in the workbook.


mangrove_data <- read_csv(
  file = here::here("data/workshop1/mangrove_survey_raw.csv")
)


# ----------------------------------------------------------------
# SECTION 4: CORRECT THE MANGROVE DATA IMPORT
# ----------------------------------------------------------------

# The lecturer demonstrates two important read_csv arguments:
#
# skip = 5
#   Skips the first five lines containing field survey notes.
#
# na = c(".", "NA", "9999", "ND", "blank")
#   Identifies alternative missing-value codes and converts
#   them into R's standard NA representation.
#
# This prevents missing observations from being interpreted
# as genuine ecological measurements.


mangrove_data <- read_csv(
  here::here("data/workshop1/mangrove_survey_raw.csv"),
  skip = 5,
  na = c(".", "NA", "9999", "ND", "blank")
)


# ----------------------------------------------------------------
# END OF SECTION 1.4 - DATA IMPORTING
# ----------------------------------------------------------------

# The datasets have now been imported into the R environment.
# The next workbook section introduces data structures,
# tibbles and further data exploration.
# ================================================================
# SECTION 1.5: DATA FRAME ARCHITECTURES
# TIBBLES VERSUS LEGACY TABLES
# ================================================================
#
# Objective:
# Compare traditional R data frames with modern tidyverse tibbles.
#
# This exercise demonstrates how different data structures
# display information in the RStudio Console.
#
# Dataset:
# Reef cover observations imported in Section 1.4.
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: CONVERT A TIBBLE INTO A TRADITIONAL DATA FRAME
# ----------------------------------------------------------------

# The benthic_cover dataset was imported using read_csv().
# Therefore, it is stored as a tibble.
#
# The as.data.frame() function converts this tibble into
# a traditional base R data frame.

benthic_cover_df <- as.data.frame(benthic_cover)


# ----------------------------------------------------------------
# STEP 2: DISPLAY THE TRADITIONAL DATA FRAME
# ----------------------------------------------------------------

# Print the old-style data frame structure.
# Observe how R displays the rows and columns.

print(benthic_cover_df)


# ----------------------------------------------------------------
# STEP 3: DISPLAY THE MODERN TIBBLE
# ----------------------------------------------------------------

# Print the original tibble.
#
# Compare its output with the traditional data frame.
# Notice the column data types and the number of rows displayed.

print(benthic_cover)


# ----------------------------------------------------------------
# END OF SECTION 1.5
# ----------------------------------------------------------------
#
# Key concepts:
#
# 1. A tibble is a modern version of a data frame.
#
# 2. Tibbles display column data types automatically.
#
# 3. Tibbles limit the number of rows printed in the Console.
#
# 4. Traditional data frames and tibbles can store the same data
#    but display it differently.
#
# ================================================================
# ================================================================
# SECTION 1.6: WRANGLING OUT ECOLOGICAL SIGNALS
# USING PALMER PENGUINS
# ================================================================
#
# Objective:
# Explore the structure of an ecological dataset using R.
#
# Dataset:
# Palmer Penguins - morphological measurements of penguins
# collected in Antarctica.
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: LOAD THE PALMER PENGUINS DATASET
# ----------------------------------------------------------------

# Load the package containing the ecological dataset.

library(palmerpenguins)

# Load the penguins dataset into the R environment.

data("penguins")


# ----------------------------------------------------------------
# STEP 2: EXAMINE THE DATASET STRUCTURE
# ----------------------------------------------------------------

# Examine the structure using the tidyverse glimpse() function.
# This displays variable names, data types and sample values.

glimpse(penguins)


# Examine the same dataset using the base R str() function.
# Compare its output with glimpse().

str(penguins)


# ----------------------------------------------------------------
# END OF INITIAL DATA EXPLORATION
# ----------------------------------------------------------------
# ----------------------------------------------------------------
# STEP 3: GENERATE AN EXPLORATORY STATISTICAL SUMMARY
# ----------------------------------------------------------------
#
# Objective:
# Examine the statistical characteristics of the penguin dataset.
#
# The summary() function provides:
#
# - Minimum and maximum values
# - Mean and median values
# - First and third quartiles
# - Counts for categorical variables
# - Missing observations (NA)
#
# This helps identify potential issues before data analysis.


# Generate an exploratory summary matrix

summary(penguins)


# ----------------------------------------------------------------
# END OF SECTION 1.6
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.7: FOUNDATIONAL GRAMMAR
# SLICING, FILTERING, SORTING AND TRANSFORMING
# ================================================================
#
# Objective:
# Learn how to manipulate ecological datasets using dplyr.
#
# This section introduces functions used to select columns,
# filter observations and arrange data.
#
# ================================================================


# ----------------------------------------------------------------
# SECTION 1.7.1: ISOLATING ATTRIBUTES WITH select()
# ----------------------------------------------------------------
#
# The select() function allows us to extract specific columns
# from a dataset.
#
# This is useful when we want to focus on particular ecological
# measurements without including unnecessary variables.
#
# ----------------------------------------------------------------


# STEP 1: SELECT SPECIFIC MORPHOLOGICAL MEASUREMENTS
#
# Select penguin species, bill length, bill depth and body mass.
#
# This creates a new dataset called morphology_metrics.


morphology_metrics <- select(
  penguins,
  species,
  bill_length_mm,
  bill_depth_mm,
  body_mass_g
)


# Examine the structure of the selected dataset.

glimpse(morphology_metrics)


# ----------------------------------------------------------------
# STEP 2: SELECT A CONTINUOUS BLOCK OF COLUMNS
# ----------------------------------------------------------------
#
# The colon (:) operator selects a range of columns.
#
# Here, species:island selects all columns between
# species and island, including both columns.


spatial_block <- select(penguins, species:island)


# ----------------------------------------------------------------
# STEP 3: REMOVE AN UNNECESSARY COLUMN
# ----------------------------------------------------------------
#
# The minus (-) symbol removes a specified column.
#
# Here, the year variable is excluded while retaining
# all other variables.


clean_scientific_fields <- select(penguins, -year)


# ----------------------------------------------------------------
# END OF SECTION 1.7.1
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.7.2: SIFTING ROWS WITH filter()
# ================================================================
#
# Objective:
# Learn how to filter ecological observations based on
# categorical and numerical conditions.
#
# The filter() function selects rows that satisfy
# specific conditions.
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: FILTER BY PENGUIN SPECIES
# ----------------------------------------------------------------
#
# Select observations belonging to Adelie penguins.
#
# The == operator checks whether the species matches "Adelie".


adelie_cohort <- filter(penguins, species == "Adelie")


# ----------------------------------------------------------------
# STEP 2: FILTER BY BODY MASS
# ----------------------------------------------------------------
#
# Select penguins with body mass greater than 4500 grams.
#
# The > operator means greater than.


heavy_penguins <- filter(penguins, body_mass_g > 4500)


# ----------------------------------------------------------------
# STEP 3: FILTER USING TWO CONDITIONS
# ----------------------------------------------------------------
#
# Select Gentoo penguins observed on Biscoe Island.
#
# The & operator means both conditions must be TRUE.


biscoe_gentoo <- filter(
  penguins,
  species == "Gentoo" & island == "Biscoe"
)


# ----------------------------------------------------------------
# STEP 4: FILTER USING MULTIPLE VALUES
# ----------------------------------------------------------------
#
# Select penguins observed on Dream or Torgersen Island.
#
# The %in% operator checks whether a value belongs
# to a specified group.


sub_islands <- filter(
  penguins,
  island %in% c("Dream", "Torgersen")
)


# ----------------------------------------------------------------
# END OF SECTION 1.7.2
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.7.3: ORDERING SEQUENCES WITH arrange()
# ================================================================
#
# Objective:
# Learn how to sort ecological observations using arrange().
#
# The arrange() function changes the order of rows in a dataset
# without changing the values stored in individual cells.
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: SORT PENGUINS BY ASCENDING BODY MASS
# ----------------------------------------------------------------
#
# Arrange penguins from the smallest body mass to the largest.
#
# By default, arrange() sorts numerical values in ascending order.
#
# The result is stored in a new object called lightest_first.


lightest_first <- arrange(penguins, body_mass_g)


# ----------------------------------------------------------------
# STEP 2: SORT PENGUINS BY DESCENDING BODY MASS
# ----------------------------------------------------------------
#
# Arrange penguins from the largest body mass to the smallest.
#
# The desc() function reverses the sorting order.


heaviest_first <- arrange(penguins, desc(body_mass_g))


# ----------------------------------------------------------------
# STEP 3: SORT BY SPECIES AND BILL LENGTH
# ----------------------------------------------------------------
#
# First, arrange observations by penguin species.
#
# Within each species, arrange penguins by bill length
# from longest to shortest.
#
# This demonstrates sorting using multiple variables.


stratified_morphology <- arrange(
  penguins,
  species,
  desc(bill_length_mm)
)


# ----------------------------------------------------------------
# END OF SECTION 1.7.3
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.7.4: INTRODUCING THE PIPE OPERATOR (|>)
# ================================================================
#
# Objective:
# Understand how to combine multiple data manipulation
# operations using the native R pipe operator.
#
# The pipe operator (|>) passes the output of one operation
# directly into the next operation.
#
# This improves code readability and reduces the need
# to create multiple intermediate datasets.
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: DATA MANIPULATION WITHOUT USING A PIPE
# ----------------------------------------------------------------
#
# First, calculate a new morphological measurement called
# bill_ratio.
#
# Bill ratio is calculated by dividing bill length by bill depth.
#
# The result is stored in a new object called penguins_subset.


penguins_subset <- mutate(penguins, bill_ratio = bill_length_mm / bill_depth_mm)


# Next, filter the dataset to retain only Adelie penguins.
#
# The result is stored in penguins_final.


penguins_final <- filter(penguins_subset, species == "Adelie")


# ----------------------------------------------------------------
# STEP 2: DATA MANIPULATION USING THE PIPE OPERATOR
# ----------------------------------------------------------------
#
# The following code performs the same operations
# using the native R pipe operator (|>).
#
# First:
#   Start with the original penguins dataset.
#
# Second:
#   Calculate the bill_ratio variable using mutate().
#
# Third:
#   Filter the dataset to retain only Adelie penguins.
#
# The result is stored in penguins_final.


penguins_final <- penguins |>
  mutate(bill_ratio = bill_length_mm / bill_depth_mm) |>
  filter(species == "Adelie")


# ----------------------------------------------------------------
# END OF SECTION 1.7.4
# ----------------------------------------------------------------
#
# Key concepts:
#
# 1. The pipe operator connects multiple functions.
#
# 2. Data manipulation operations are performed sequentially.
#
# 3. Pipes make R scripts easier to read and maintain.
#
# 4. The same results can be achieved with or without pipes.
#
# ================================================================
# ================================================================
# SECTION 1.7.5: COMPUTING NEW ATTRIBUTES WITH mutate()
# ================================================================
#
# Objective:
# Learn how to calculate new variables using existing
# morphological measurements.
#
# The mutate() function creates new columns or modifies
# existing columns within a dataset.
#
# Dataset: Palmer Penguins
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: CALCULATE NEW MORPHOLOGICAL VARIABLES
# ----------------------------------------------------------------
#
# The following code creates two new variables:
#
# body_mass_kg:
# Converts body mass from grams into kilograms.
#
# bill_ratio:
# Calculates the ratio between bill length and bill depth.
#
# The results are stored in a new dataset called penguin_ratios.


# Calculate a new morphological ratio in our environment

penguin_ratios <- penguins |>
  mutate(
    body_mass_kg = body_mass_g / 1000,  # Convert grams to kilograms
    bill_ratio = bill_length_mm / bill_depth_mm  # Bill ratio
  )


# ----------------------------------------------------------------
# STEP 2: EXAMINE THE NEW VARIABLES
# ----------------------------------------------------------------
#
# The glimpse() function displays the dataset structure.
#
# Check that the new variables body_mass_kg and bill_ratio
# have been added to the original dataset.


# View your newly engineered variables appended to the far-right columns

glimpse(penguin_ratios)


# ----------------------------------------------------------------
# END OF SECTION 1.7.5
# ----------------------------------------------------------------
# ================================================================
# SECTION 1.8: DATA AGGREGATION AND ECOLOGICAL SUMMARISATION
# ================================================================
#
# Objective:
# Learn how to group ecological observations and calculate
# summary statistics using group_by() and summarise().
#
# Dataset: Palmer Penguins
#
# ================================================================


# ----------------------------------------------------------------
# STEP 1: GROUP PENGUINS BY SPECIES
# ----------------------------------------------------------------
#
# The group_by() function groups observations according
# to the selected variable.
#
# Here, penguins are grouped by species.


# Grouping our active memory penguins by species

grouped_penguins <- group_by(penguins, species)


# ----------------------------------------------------------------
# STEP 2: EXAMINE THE GROUPED DATASET
# ----------------------------------------------------------------
#
# The dataset still contains the original observations.
#
# However, R now recognises three groups:
# Adelie, Chinstrap and Gentoo.


# Notice that the table looks identical, but metadata
# notes 'Groups: species [3]'

print(grouped_penguins)


# ----------------------------------------------------------------
# STEP 3: CALCULATE MEAN BODY MASS BY SPECIES
# ----------------------------------------------------------------
#
# The summarise() function calculates summary statistics
# for each group.
#
# Here, we calculate mean body mass for each penguin species.
#
# IMPORTANT:
# Missing observations can cause mean() to return NA.


# Collapsing the buckets into explicit summary metrics

species_mass_summary <- summarise(
  grouped_penguins,
  mean_mass_g = mean(body_mass_g)
)


# Display the summary results.

print(species_mass_summary)


# ----------------------------------------------------------------
# STEP 4: OVERCOME THE MISSING VALUE PROBLEM
# ----------------------------------------------------------------
#
# The na.rm = TRUE argument tells R to ignore missing
# observations when calculating statistics.
#
# Here, penguins are grouped by species and sex.
#
# The following statistics are calculated:
#
# sample_size:
# Number of observations in each group.
#
# mean_mass_g:
# Mean body mass in grams.
#
# sd_mass_g:
# Standard deviation of body mass.
#
# The %>% operator is the magrittr pipe used in the workbook.


# Overcoming the missing value trap using na.rm = TRUE

biological_signal <- penguins %>%
  group_by(species, sex) %>%
  summarise(
    sample_size = n(),
    mean_mass_g = mean(body_mass_g, na.rm = TRUE),
    sd_mass_g = sd(body_mass_g, na.rm = TRUE)
  )


# Display the biological summary.

print(biological_signal)


# ----------------------------------------------------------------
# END OF SECTION 1.8
# ----------------------------------------------------------------

# ================================================================
# SECTION 1.10 - SAVING, EXPORTING AND VERSION MILESTONES
# ================================================================

# ----------------------------------------------------------------
# 1.10.1 - CREATE OUTPUT DIRECTORIES
# ----------------------------------------------------------------

# Create a directory for saving figures if it does not exist.

if (!dir.exists("outputs/figures")) dir.create("outputs/figures")

# Create a directory for saving tables if it does not exist.

if (!dir.exists("outputs/tables")) dir.create("outputs/tables")

# Create a directory for storing native R data objects.

if (!dir.exists("Rdata")) dir.create("Rdata")

# ----------------------------------------------------------------
# 1.10.2 - EXPORT SUMMARY TABLES
# ----------------------------------------------------------------

# Export the biological summary table as a universal CSV file.
# CSV files can be shared with collaborators who do not use R.

write_csv(biological_signal, "outputs/penguin_species_mass_summary.csv")


# Save the summary table as a native R binary file.
# RDS files preserve the original R data structure and column types.

saveRDS(biological_signal, "outputs/penguin_species_mass_summary.rds")

# ----------------------------------------------------------------
# 1.10.3 - EXPORT SCIENTIFIC FIGURES
# ----------------------------------------------------------------
# Create the mean body mass comparison plot
# Original example from Section 1.9.2 of the workbook

mass_compare_plot <- penguins |>
  group_by(species, island) |>
  summarise(
    mean_mass = mean(body_mass_g, na.rm = TRUE),
    sd_mass = sd(body_mass_g, na.rm = TRUE),
    n = n(),
    .groups = "drop"
  ) |>
  ggplot(aes(x = species, y = mean_mass, colour = island)) +
  geom_point(size = 3) +
  geom_errorbar(
    aes(ymin = mean_mass - sd_mass,
        ymax = mean_mass + sd_mass),
    width = 0.2
  ) +
  labs(
    title = "Mean Body Mass by Species and Island",
    subtitle = "Error bars represent standard deviation",
    y = "Mean Body Mass (g)",
    x = "Species"
  ) +
  theme_minimal()

# Display the plot

mass_compare_plot

# Export the plot as a high-resolution PNG

ggsave("outputs/mass_compare_plot.png",
       plot = mass_compare_plot,
       width = 120, height = 120,
       units = "mm", dpi = 300)

# ================================================================
# END OF SECTION 1.10
# END OF WORKSHOP 1 - FOUNDATIONS OF MARINE DATA SCIENCE
# ================================================================