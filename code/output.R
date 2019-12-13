#' Get download markdown link
#'
#' Convert an output file name and location to a URL that can be used to
#' download the file.
#'
#' @param file name of the output file
#' @param folder name of the directory in the output directory containing the
#' output file
#'
#' @return Markdown URL link to the file
download_link <- function(file, folder = NULL) {
    remote <- workflowr::wflow_git_remote(verbose = FALSE)["origin"]

    url <- gsub(":", "/", remote)
    url <- gsub("git@", "http://", url)
    url <- gsub(".git", "", url, fixed = TRUE)
    url <- paste(url, "raw/master", sep = "/")

    if (is.null(folder)) {
        url <- paste(url, file, sep = "/")
    } else {
        url <- paste(url, fs::path_rel(folder, here::here()), file, sep = "/")
    }

    link <- glue::glue("[{file}]({url})")

    return(link)
}
