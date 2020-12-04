#' Add an output.
#'
#' @param FUN a function a character string that will be displayed. 
#' @param field_name Field name.
#'
#' @return An object of class `output`.
#' @export

fob_output <- function(FUN, field_name = NULL) {
  structure(
    function(...) do.call(FUN, ...),
    class = "output",
    field_name = NULL
  )
}

