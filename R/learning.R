# Section 7, datamanagement and wrangling
# Load packages

library(tidyverse)
library(NHANES)

# Looking at data
glimpse(NHANES)

# selecting columns
select(NHANES, Age)

select(NHANES, Age, Weight, BMI)

select(NHANES, -HeadCirc)

select(NHANES, starts_with("BP"))

select(NHANES, ends_with("Day"))

select(NHANES, contains("Age"))

# Creating smaller NHANES dataset
nhanes_small <- select(NHANES, Age, Gender, BMI, Diabetes, PhysActive, BPSysAve, BPDiaAve, Education)

# Renaming columns snake case removes capital letters, and puts underscore if they are in the middle of a word

nhanes_small <- rename_with(
  nhanes_small,
  snakecase::to_snake_case
)

# Renaming specific columns rename(dataset, new name = old name)
nhanes_small <- rename(nhanes_small, sex = gender)

# trying out the pipe (do ctrl + shift + m to make %>%) it is assignment 7.8
colnames(nhanes_small)

nhanes_small %>%
  colnames()

nhanes_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

nhanes_small %>%
  select(bp_sys_ave, education)

nhanes_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

nhanes_small %>%
  select(bmi, contains("age"))

nhanes_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)


# Filtering

nhanes_small %>%
  filter(phys_active == "No")

nhanes_small %>%
  filter(bmi >= 25)


# Combining logical operators
nhanes_small %>%
  filter(phys_active == "No" & bmi >= 25)

nhanes_small %>%
  filter(bmi >= 25 | phys_active == "No")

# Arranging some data   (arrange(desc)) for descending order
nhanes_small %>%
  arrange(desc(age))

nhanes_small %>%
  arrange(age, bmi)

# Transform data with mutate. You can make a new column
# by doing mutate(NAME OF COLUMN = What it is)
# you can do more columns by mutate(1st colum = xx , 2nd colum = egogoa)

nhanes_small %>%
  mutate(
    age = age * 12,
    log_bmi = log(bmi)
  )



nhanes_small %>%
  mutate(old = if_else(age >= 30, "Yes", "No"))


#Starting exercise 7.12

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_pressure = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age < 6, "Yes", "No")
    )

nhanes_modified
# Exercise 7.12 -----------------------------------------------------------


