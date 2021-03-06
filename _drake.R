#==============================================================================#
# ---- LIBRARIES ----
#==============================================================================#

library("drake")
library("here")
library("tidyverse")

#==============================================================================#
# ---- FUNCTIONS ----
#==============================================================================#

source(here("code", "output.R"))
source(here("code", "render.R"))

#==============================================================================#
# ---- PLAN ----
#==============================================================================#

plan <- drake_plan(
    configs = list(
        workflowr = read_lines(here(file_in("_workflowr.yml"))),
        site      = read_lines(here(file_in("analysis/_site.yml")))
    ),
    navbar_content = target(
        make_navbar_html(
            here(file_out("docs/navbar-content.html"))
        )
    ),
    navbar = readr::read_lines(here(file_in("analysis/_navbar.html"))),
    index = target(
        workflowr::wflow_build(here(knitr_in("analysis/index.Rmd"))),
        trigger = trigger(condition = TRUE)
    ),
    rmd11_CellPhoneDB = target(
        workflowr::wflow_build(here(knitr_in("analysis/11-CellPhoneDB.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd12_NicheNet = target(
        workflowr::wflow_build(here(knitr_in("analysis/12-NicheNet.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd13_COMUNET = target(
        workflowr::wflow_build(here(knitr_in("analysis/13-COMUNET.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd14_CellChat = target(
        workflowr::wflow_build(here(knitr_in("analysis/14-CellChat.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd15_talklr = target(
        workflowr::wflow_build(here(knitr_in("analysis/15-talklr.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd16_CiteFuse = target(
        workflowr::wflow_build(here(knitr_in("analysis/16-CiteFuse.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd17_scTHI = target(
        workflowr::wflow_build(here(knitr_in("analysis/17-scTHI.Rmd"))),
        trigger = trigger(change = configs)
    ),
    rmd18_celltalker = target(
        workflowr::wflow_build(here(knitr_in("analysis/18-celltalker.Rmd"))),
        trigger = trigger(change = configs)
    )
)

#==============================================================================#
# ---- CONFIG ----
#==============================================================================#

drake_config(plan, verbose = 2)
