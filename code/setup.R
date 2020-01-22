#==============================================================================#
# ---- LIBRARIES ----
#==============================================================================#

suppressPackageStartupMessages({
    # Package conflicts
    library("conflicted")
    # File paths
    library("fs")
    library("here")
    # Presentation
    library("knitr")
    library("jsonlite")
    library("skimr")
    # Tidyverse
    library("tidyverse")
})

#==============================================================================#
# ---- CONFLICTS ----
#==============================================================================#

#==============================================================================#
# ---- KNITR ----
#==============================================================================#

DOCNAME <- knitr::current_input()
NOW <- Sys.time()

# Time chunks during knitting
knitr::knit_hooks$set(timeit = function(before) {
    if (before) {
        print(paste("Start:", Sys.time()))
        NOW <<- Sys.time()
    } else {
        print(paste("Stop:", Sys.time()))
        print(Sys.time() - NOW)
    }
})

knitr::opts_chunk$set(
    autodep        = TRUE,
    cache          = FALSE,
    cache.path     = paste0("cache/", DOCNAME, "/"),
    cache.comments = FALSE,
    echo           = TRUE,
    error          = FALSE,
    fig.align      = "center",
    fig.width      = 10,
    fig.height     = 8,
    message        = FALSE,
    warning        = FALSE,
    timeit         = TRUE
)

OUT_DIR <- here("output", DOCNAME)
dir_create(OUT_DIR)

#==============================================================================#
# ---- FUNCTIONS ----
#==============================================================================#

source(here("code", "output.R"))

#==============================================================================#
# ---- THEME ----
#==============================================================================#

theme_set(theme_minimal())

#==============================================================================#
# ---- PATHS ----
#==============================================================================#

PATHS <- list(
    cellphonedb_in = here("data", "cellphonedb")
)
