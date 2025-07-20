source("renv/activate.R")
# .Rprofile for this project

# Only run in interactive sessions (skip when running scripts or R CMD)
if (interactive()) {

  # Load commonly used packages quietly
  suppressPackageStartupMessages({
    library(dplyr)
    library(ggplot2)
    library(tidyr)
    library(plotrix)
    library(lmerTest)
    library(emmeans)
    library(rstudioapi)
    library(ggpubr)
    library(lme4)
  })

  # Print a welcome message
  message("✔ Welcome to the project! Package loaded are specified in the .Rprofile.")

}

# Set general options
options(
  stringsAsFactors = FALSE,         # Don't auto-convert strings to factors
  dplyr.summarise.inform = FALSE,  # Suppress summarise info messages
  repos = c(CRAN = "https://cloud.r-project.org")  # Set CRAN mirror
)

# You can define helper functions here if needed
