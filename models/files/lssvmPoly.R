modelInfo <- list(label = "Least Squares Support Vector Machine with Polynomial Kernel",
                  library = "kernlab",
                  type = c("Classification"),
                  parameters = data.frame(parameter = c('degree', 'scale'),
                                          class = c("numeric", "numeric"),
                                          label = c('Polynomial Degree', 'Scale')),
                  grid = function(x, y, len = NULL) {
                    expand.grid(degree = seq(1, min(len, 3)),      
                                scale = 10 ^((1:len) - 4))
                  },
                  loop = NULL,
                  fit = function(x, y, wts, param, lev, last, classProbs, ...) { 
                    lssvm(x = as.matrix(x), y = y,
                          kernel = polydot(degree = param$degree,
                                           scale = param$scale,
                                           offset = 1), ...)         
                  },
                  predict = function(modelFit, newdata, submodels = NULL) {  
                    out <- predict(modelFit, as.matrix(newdata))
                    if(is.matrix(out)) out <- out[,1]
                    out
                  },
                  prob = NULL,
                  predictors = function(x, ...) {
                    if(hasTerms(x) & !is.null(x@terms))
                    {
                      out <- predictors.terms(x@terms)
                    } else {
                      out <- colnames(attr(x, "xmatrix"))
                    }
                    if(is.null(out)) out <- names(attr(x, "scaling")$xscale$`scaled:center`)
                    if(is.null(out)) out <-NA
                    out
                  },
                  tags = c("Kernel Method", "Support Vector Machines", "Polynomial Model"),
                  levels = function(x) lev(x),
                  sort = function(x) x)
