#' Add a section.
#'
#' @param msg a character string that will be displayed. 
#' 
#' @return one integer.
#' @export

fob_section <- function(msg) {
  structure(
    function() {
      msgSection(msg)
      invisible(msgSection)
    },
    class = "section",
    name_field = "section"
  )
}