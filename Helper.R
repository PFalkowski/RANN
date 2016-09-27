SetupEnvironment <- function(requiredPackages, workingDirectory = NULL) 
{
  if (is.null(workingDirectory)) workingDirectory = getwd()
  options(max.print = 1000)
  GetPackages(requiredPackages)
  RequirePackages(requiredPackages)
  SetWorkingDirectory(workingDirectory)
}

GetPackages <- function(PackageNames, repo = 'http://r.meteo.uni.wroc.pl/')
{
  new.packages <- PackageNames[!(c(PackageNames) %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages, repos=repo)
}

RequirePackages <- function(PackageNames)
{
  lapply(PackageNames, require, character.only = TRUE)
}

SetWorkingDirectory <- function(path)
{
  path = gsub("([\\])","/", path)
  if (path != getwd())
  {
    setwd(path)
  }
}


