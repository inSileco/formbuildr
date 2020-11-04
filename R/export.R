export_form <- function(x, file, format = "yaml") {
    stopifnot(class(x) == "form_answers")
    format <- match.arg(format, c("yaml")) 
    yaml::write_yaml(x, file)
    invisible(0)
}