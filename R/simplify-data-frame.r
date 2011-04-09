#' List to data frame.
#' Reduce/simplify a list of homogenous objects to a data frame.
#' All \code{NULL} entries are removed. Remaining entries must be all atomic
#' or all data frames.
#' 
#' 
#' @param res list of input data
#' @param labels a data frame of labels, one row for each element of res
#' @keywords internal
list_to_dataframe <- function(res, labels = NULL) {
  null <- vapply(res, is.null, logical(1))
  res <- res[!null]
  if (length(res) == 0) return(data.frame())

  atomic <- unlist(lapply(res, is.atomic))
  df <- unlist(lapply(res, is.data.frame))

  if (all(atomic)) {
    nrow <- length(res)
    ncol <- unique(unlist(lapply(res, length)))
    if (length(ncol) != 1) stop("Results do not have equal lengths")
    
    vec <- unname(do.call("c", res))
    
    resdf <- quickdf(unname(split(vec, rep(seq_len(ncol), nrow))))
    names(resdf) <- make_names(res[[1]], "V")
    
    rows <- rep(ncol, length(nrow))
  } else if (all(df)) {
    resdf <- rbind.fill(res)
    rows <- unlist(lapply(res, NROW))
  } else {
    stop("Results must be all atomic, or all data frames")
  }

  # If no labels supplied, use list names
  if (is.null(labels) && !is.null(names(res))) {
    labels <- data.frame(.id = names(res), stringsAsFactors = FALSE)
  }
  
  if (!is.null(labels) && nrow(labels) == length(null)) {
    names(labels) <- make_names(labels, "X")
    
    cols <- setdiff(names(labels), names(resdf))
    labels <- labels[!null, cols, drop = FALSE]
    resdf <- cbind(labels[rep(1:nrow(labels), rows), , drop = FALSE], resdf)
  }
  
  unrowname(resdf)
}

