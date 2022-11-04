source("R/Methods.R")
library(ROCR)

# This R script is used to reproduce the result of Benchmark test
# Every method was repeated 5 times.

DATA_DIR <- "internal_datasets/PMID33338399/real_datasets/"
datas <- c(
  "cline-ch", 
  "HEK-HMEC-MULTI",
  "HMEC-orig-MULTI",
  "HMEC-rep-MULTI",
  "J293t-dm",
  "mkidney-ch",
  "nuc-MULTI",
  "pbmc-1A-dm",
  "pbmc-1B-dm",
  "pbmc-1C-dm",
  "pbmc-2ctrl-dm",
  "pbmc-2stim-dm",
  "pbmc-ch",
  "pdx-MULTI")

# Benchmark test for SoCube,
# SoCube command was executed out of R script
# and default configs was used
socube_result_dir <- "internal_results/socube/benchmark/"
result_list <- list()
for (idx in seq_len(length(datas))) {
  data_name <- datas[[idx]]
  print(data_name)
  result <- sapply(1:5, function(x){
    score <- read.csv(paste(socube_result_dir, data_name, x, ".csv"), header = F)$V1
    pred <- prediction(score, as.numeric(data[[2]] == "doublet"))
    roc <- performance(pred, measure = "auc")
    prc <- performance(pred, measure = "aucpr")
    cat("Fold:") 
    cat(x)
    cat(" roc: ")
    cat(roc@y.values[[1]])
    cat(" prc: ")
    cat(prc@y.values[[1]])
    cat("\n")
    return(c(prc@y.values[[1]], roc@y.values[[1]]))
  })
  
  prc <- mean(result[1,])
  prc.std <- sd(result[1,])
  roc <- mean(result[2,])
  roc.std <- sd(result[2,])
  cat("Average roc: ")
  cat(roc)
  cat(" std: ")
  cat(roc.std)
  cat(" prc: ")
  cat(prc)
  cat(" std: ")
  cat(prc.std)
  cat("\n")
  result_list[[idx]] <- c(prc, prc.std, roc, roc.std)
}


# Benchmark test for Solo,
# Solo command was executed out of R script
# and default configs was used
solo_result_dir <- "internal_results/solo/benchmark/"
result_list <- list()
for (idx in seq_len(length(datas))) {
  data_name <- datas[[idx]]
  print(data_name)
  result <- sapply(1:5, function(x){
    score <- read.csv(paste(solo_result_dir, data_name, x, ".csv"), header = F)$V1
    pred <- prediction(score, as.numeric(data[[2]] == "doublet"))
    roc <- performance(pred, measure = "auc")
    prc <- performance(pred, measure = "aucpr")
    cat("Fold:") 
    cat(x)
    cat(" roc: ")
    cat(roc@y.values[[1]])
    cat(" prc: ")
    cat(prc@y.values[[1]])
    cat("\n")
    return(c(prc@y.values[[1]], roc@y.values[[1]]))
  })
  
  prc <- mean(result[1,])
  prc.std <- sd(result[1,])
  roc <- mean(result[2,])
  roc.std <- sd(result[2,])
  cat("Average roc: ")
  cat(roc)
  cat(" std: ")
  cat(roc.std)
  cat(" prc: ")
  cat(prc)
  cat(" std: ")
  cat(prc.std)
  cat("\n")
  result_list[[idx]] <- c(prc, prc.std, roc, roc.std)
}

# Benchmark test for DoubletFinder
result_list <- list()
for (idx in seq_len(length(datas))) {
  data_name <- datas[[idx]]
  print(data_name)
  data <- readRDS(paste(DATA_DIR, data_name, ".rds", sep = ""))
  result <- sapply(1:5, function(x){
    score <- preditctByDoubletFinder(data[[1]])
    pred <- prediction(score, as.numeric(data[[2]] == "doublet"))
    roc <- performance(pred, measure = "auc")
    prc <- performance(pred, measure = "aucpr")
    cat("Fold:") 
    cat(x)
    cat(" roc: ")
    cat(roc@y.values[[1]])
    cat(" prc: ")
    cat(prc@y.values[[1]])
    cat("\n")
    return(c(prc@y.values[[1]], roc@y.values[[1]]))
  })
  
  prc <- mean(result[1,])
  prc.std <- sd(result[1,])
  roc <- mean(result[2,])
  roc.std <- sd(result[2,])
  cat("Average roc: ")
  cat(roc)
  cat(" std: ")
  cat(roc.std)
  cat(" prc: ")
  cat(prc)
  cat(" std: ")
  cat(prc.std)
  cat("\n")
  result_list[[idx]] <- c(prc, prc.std, roc, roc.std)
}


# Benchmark test for scDblFinder
library(scDblFinder)
result_list <- list()
for (idx in seq_len(length(datas))) {
  data_name <- datas[[idx]]
  print(data_name)
  data <- readRDS(paste(DATA_DIR, data_name, ".rds", sep = ""))
  result <- sapply(1:5, function(x){
    res <- scDblFinder(data[[1]])
    pred <- prediction(res$scDblFinder.score, as.numeric(data[[2]] == "doublet"))
    roc <- performance(pred, measure = "auc")
    prc <- performance(pred, measure = "aucpr")
    cat("Fold:") 
    cat(x)
    cat(" roc: ")
    cat(roc@y.values[[1]])
    cat(" prc: ")
    cat(prc@y.values[[1]])
    cat("\n")
    return(c(prc@y.values[[1]], roc@y.values[[1]]))
  })
  
  prc <- mean(result[1,])
  prc.std <- sd(result[1,])
  roc <- mean(result[2,])
  roc.std <- sd(result[2,])
  cat("Average roc: ")
  cat(roc)
  cat(" std: ")
  cat(roc.std)
  cat(" prc: ")
  cat(prc)
  cat(" std: ")
  cat(prc.std)
  cat("\n")
  result_list[[idx]] <- c(prc, prc.std, roc, roc.std)
}
