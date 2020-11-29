#' @importFrom crayon blue red green yellow
#' @importFrom cli style_bold style_underline
#' @importFrom glue glue
#' @keywords internal 

NULL


# Message functions 

msgInfo <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$info, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}

msgError <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$cross, ...)
  message(red(txt), appendLF = appendLF)
  invisible(txt)
}

msgSuccess <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$tick, ...)
  message(green(txt), appendLF = appendLF)
  invisible(txt)
}

msgWarning <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$warning, ...)
  message(yellow(txt), appendLF = appendLF)
  invisible(txt)
}

msgQuestion <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$fancy_question_mark, ...)
  message(txt, appendLF = appendLF)
  invisible(txt)
}

msgSection <- function(..., appendLF = TRUE) {
  txt <- paste(cli::symbol$menu, ...)
  message(blue(txt), appendLF = appendLF)
  invisible(txt)
}



valid <- function() msgSuccess('validated!')

not_valid <- function() msgWarning('Validation failed, try again!')

get_confirmed <- function() {
  msgWarning('Confirmed?')
  x <- readline("[Y]es or [N]o: ")
  grepl("^Y$|^YES$", toupper(x))
}

not_confirmed <- function() msgWarning('Not confirmed!')


commaAnd <- function(x, and = "and") {
  if (length(x) > 1) {
    paste(paste(x[-length(x)], collapse = ", "), and, x[length(x)])
  } else x
}