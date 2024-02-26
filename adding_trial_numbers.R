Sys.setenv(LANGUAGE="en")
library(tidyverse)
# Set working directory
setwd("C:\\Users\\siyul\\OneDrive\\Desktop\\Projects\\project_1_SimLearning\\categorization\\80ms_talker_diff\\EXP3_T1T1\\results\\data_exp_144502-v4\\experimental_data")

# Clear the cuurent workspace
rm(list= ls(all = TRUE))

# List all the experiment files and combine them
list.files("C:\\Users\\siyul\\OneDrive\\Desktop\\Projects\\project_1_SimLearning\\categorization\\80ms_talker_diff\\EXP3_T1T1\\results\\data_exp_144502-v4\\experimental_data")
data1 <- read_csv("data_exp_144502-v4_task-6zcw.csv")
data2 <- read_csv("data_exp_144502-v4_task-avkq.csv")
data3 <- read_csv("data_exp_144502-v4_task-fpcx.csv")
data4 <- read_csv("data_exp_144502-v4_task-kqlj.csv")
data5 <- read_csv("data_exp_144502-v4_task-mp94.csv")
data6 <- read_csv("data_exp_144502-v4_task-ohq7.csv")
data7 <- read_csv("data_exp_144502-v4_task-uayc.csv")
data8 <- read_csv("data_exp_144502-v4_task-x6gx.csv")
data <- rbind (data1, data2, data3, data4, data5, data6, data7, data8)

# Process the data
processed_data <- data %>%
  # Exclude rows with 'LOADING DELAY' in 'Reaction Time'
  filter(`Reaction Time` != "LOADING DELAY") %>%
  # Group by 'Participant External Session ID' and 'display'
  group_by(`Participant External Session ID`, display) %>%
  # Add trial numbers for specified tasks, restart counting for each group
  mutate(TrialNumber = if_else(display %in% c("Practice-Categorization-1", "Practice-LD-1", "Task-Categorization-1", "Task-LD-1"),
                               row_number(), 
                               NA_integer_)) %>%
  # Optionally, you might want to ungroup the data here, but it's not strictly necessary
  ungroup()

# Check for rows without "LOADING DELAY" in Reaction Time and count them
row_counts <- processed_data %>%
  filter(display %in% c("Task-LD-1", 
                        "Task-Categorization-1", 
                        "Practice-Categorization-1", 
                        "Practice-LD-1")) %>%
  group_by(Participant_External_Session_ID = `Participant External Session ID`, display) %>%
  summarise(Count = n()) %>%
  ungroup()