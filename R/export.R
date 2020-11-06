#' Export answers.
#' 
#' @param x object of class `form_answers` or `form`. 
#' @param file file name.
#' @param format So far only YAML is available.
#'
#' @export

export_answer <- function(x, file, format = "yaml") {
    stopifnot(class(x) == "form_answers")
    format <- match.arg(format, c("yaml")) 
    yaml::write_yaml(x, file)
    invisible(0)
}