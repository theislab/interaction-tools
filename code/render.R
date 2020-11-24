#' Make navbar HTML
#'
#' Generate the HTML content for the site navigation bar
#'
#' @param outpath Path to output HTML file
#'
#' @return Writes the HTML to `outpath` but also return it invisibly
make_navbar_html <- function(outpath) {

    tags <- htmltools::tags

    examples <- c(
        CellPhoneDB = "11-CellPhoneDB.html",
        NicheNet    = "12-NicheNet.html",
        COMUNET     = "13-COMUNET.html",
        CellChat    = "14-CellChat.html",
        talklr      = "15-talklr.html",
        CiteFuse    = "16-CiteFuse.html",
        scTHI       = "17-scTHI.html",
        celltalker  = "18-celltalker.html"
    )

    examples_list <- purrr::map(names(examples), function(.example) {
        tags$li(
            tags$a(
                href = examples[.example],
                .example
            )
        )
    })

    html_tags <- tags$div(
        class = "navbar navbar-default navbar-fixed-top",
        role  = "navigation",
        tags$div(
            class = "container",
            tags$div(
                class = "navbar-header",
                tags$button(
                    type          = "button",
                    class         ="navbar-toggle collapsed",
                    `data-toggle` = "collapse",
                    `data-target` = "#navbar",
                    tags$span(class = "icon-bar"),
                    tags$span(class = "icon-bar"),
                    tags$span(class = "icon-bar")
                ),
                tags$a(
                    class = "navbar-brand",
                    href  = "index.html",
                    "Interaction tools"
                )
            ),
            tags$div(
                id    = "navbar",
                class = "navbar-collapse collapse",
                tags$ul(
                    class = "nav navbar-nav",
                    tags$li(tags$a(href = "index.html", "Home")),
                    tags$li(
                        class = "dropdown",
                        tags$a(
                            href            = "#",
                            class           = "dropdown-toggle",
                            `data-toggle`   = "dropdown",
                            role            = "button",
                            `aria-expanded` = "false",
                            "Examples",
                            tags$span(class = "caret")
                        ),
                        tags$ul(
                            class = "dropdown-menu",
                            role  = "menu",
                            examples_list
                        )
                    )
                ),
                tags$ul(
                    class = "nav navbar-nav navbar-right",
                    tags$li(
                        tags$a(
                            href = "https://github.com/theislab/interaction-tools",
                            tags$span(class = "fa fa-github fa-lg")
                        )
                    )
                )
            )
        )
    )

    html_tags <- list(
        tags$link(
            href = "site_libs/font-awesome-5.1.0/css/all.css",
            rel  = "stylesheet"
        ),
        tags$link(
            href = "site_libs/font-awesome-5.1.0/css/v4-shims.css",
            rel  = "stylesheet"
        ),
        html_tags
    )

    html_rendered <- htmltools::renderTags(html_tags)$html

    writeLines(html_rendered, outpath)

    invisible(html_rendered)
}
