#' Create a form from a connection. 
#' 
#' @param con a connection object or a character string (see [readLines()]).
#'
#' @details 
#' * q: question  
#' * t: type  
#' * p: prompt message (optional)  
#' * f: field name (optional)
#'  
#' @export

form_from_file <- function(con) {
  do.call(join, lapply(readLines(con), form_from_oneline))
}


form_from_oneline <- function(x) {
  if (grepl("^#", x)) {
    fob_section(trimws(sub("^#(.+)", "\\1", x)))
  } else {
    tmp <- unlist(strsplit(x, ";"))
    # 2 elements minimal
    do.call(fob_any, 
      list(
      question = extract_pars(tmp, "q:"),
      type = extract_pars(tmp, "t:"),
      prompt = extract_pars(tmp, "p:", TRUE),
      field_name = extract_pars(tmp, "f:", TRUE)
    ))
  }
}


extract_pars <- function(x, pat = "q:", optional = FALSE) {
  tmp <- x[grepl(pat, x)]
  if (length(tmp) == 1) {
    return(trimws(sub(paste0(pat, "(.+)"), "\\1", tmp)))
  } else if (length(tmp) > 1) {
    stop(paste0("Several ", pat, " detected."))
  } else {
    if (optional) {
      return(NULL)
    } else stop(paste0(pat, " missing."))
  }
}

