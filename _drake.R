#==============================================================================#
# ---- LIBRARIES ----
#==============================================================================#

library("drake")
library("here")
library("tidyverse")

#==============================================================================#
# ---- Functions ----
#==============================================================================#

source(here("code", "output.R"))

#==============================================================================#
# ---- PLAN ----
#==============================================================================#

plan <- drake_plan(
    configs = list(
        workflowr = read_lines(here(file_in("_workflowr.yml"))),
        site      = read_lines(here(file_in("analysis/_site.yml")))
    ),
    about = target(
        workflowr::wflow_build(here(knitr_in("analysis/about.Rmd"))),
        trigger = trigger(change = configs)
    ),
    license = target(
        workflowr::wflow_build(here(knitr_in("analysis/license.Rmd"))),
        trigger = trigger(change = configs)
    ),
    index = target(
        workflowr::wflow_build(here(knitr_in("analysis/index.Rmd"))),
        trigger = trigger(change = TRUE)
    ),
    rmd11_CellPhoneDB = target(
        workflowr::wflow_build(here(knitr_in("analysis/11-CellPhoneDB.Rmd"))),
        trigger = trigger(change = configs)
    )
)

#==============================================================================#
# ---- CONFIG ----
#==============================================================================#

drake_config(plan, verbose = 2)
