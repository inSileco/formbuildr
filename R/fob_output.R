#' Add an output.
#'
#' @param FUN a function a character string that will be displayed. 
#' @param args arguments.
#'
#' @return An object of class `output`.
#' @export

fob_output <- function(FUN, ...) {
  args <- list(...)
  structure(
    function(FUN, args) do.call(FUN, args),
    class = "output",
    field_name = "output"
  )
}

