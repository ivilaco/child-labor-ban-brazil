	/*
	*________________________________________________________________________________________________________________________________* 
	**
	MASTER do file for Child Labor Ban Paper
	**
	*________________________________________________________________________________________________________________________________* 
	
	Author: Vivian Amorim
	vivianamorim5@gmail.com/vamorim@worldbank.org
	Last Update: July 2021
	
	**
	**
	Short and Long-term Effects of a Child Labor Ban in Brazil. 
	**
	
	**YOU NEED STATA 16 TO REPLICATE THE RESULTS**
	
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	The Policy
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
		On December 15th, 1998, the Brazilian Federal Government increased the minimum age of employment from 14 to 16 years old.
		The law started being applied one day after that. 
		Children that were already employed were not affected. 
		Therefore, if the children turned 14 on December 16th, 1998, or after that, she/he could not start working legally 
		as opposed to before the law changed. 
		
		We work on regression discontinuity design and on a local randomization inference to explore the effects of this policy.
		
		Our Running variable (zw) is the number of weeks between the date of birth and December 16th, 1984. 
			zw = 0	 if the children turned 14 on December 16th 1998, or less than a week after this date.  
			zw = 1   if the children turned 14 one week  after  the law changed.
			zw = 2   if the children turned 14 two weeks after  the law changed, and so on. 
			zw = -1  if the children turned 14 one week  before the law changed,
			zw = -2  if the children turned 14 two weeks before the law changed, and so on. 
			We also defined the running variable (dw) which is the number of days between the date of birth and December 16, 1984. 
		
		We used the Brazilian Household Survey (Pesquisa Nacional por Amostra de Domicílios, PNAD) to assess the effect
		of the policy on the following outcomes:
		
			- Economically Active Children.
			- Share of children in paid jobs.
			- Share of children in unpaid jobs.
			- School attendance. 
			- Wages. 
			
		Use used PNAD waves of 1998, 1999 and 2001; and from 2007 to 2014. 
		
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	This master do file runs the following codes: 
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
		**
		**
		- 1. Importing Household Survey (PNAD).do
		
			-> How long it takes to run? 
				12 minutes. 
	
			-> What it does?
				The code imports the microdata of the Brazilian Household Survey (Pesquisa Nacional por Amostra de Domicílios). 
				This survey was collected annualy on a representative sample of Brazilian households. 
				
					**
					** The .txt files are available in IBGE (Brazilian Institute od Geography and Statistics) website. 
					
						Since  2001 waves, download the microdata in: https://www.ibge.gov.br/estatisticas/sociais/trabalho/19897-sintese-de-indicadores-pnad2.html?=&t=microdados
						Before 2001		 , download the microdata in: https://loja.ibge.gov.br/pnad-1987-a-1999-microdados.html

					**
					** We saved the raw data in our project folder: child-labor-ban-brazil/DataWork/Datasets/Raw

					**
					** The dictionaries to read .txt files: 
					
						Between 1998 to 2014: we used the DataZoom tool created by PUC/RIO University to import the data without having to manually create the dictionary of the variables. 
						For 2015, we created our own dictionary due to an error we identified in the tool. 
				
			-> What it creates? 
				The code creates sixteen .dta files saved in: child-labor-ban-brazil/DataWork/Datasets/Intermediate. 
				Each file is a wave of the household survey. 
				
			
		**
		**	
		- 2. Harmonizing Household Survey (PNAD).do
		
			-> How long does it take to run?
				23 minutes. 
	
			-> What it does?
				The code harmonizes the PNAD waves from 1998 to 2015, creating the dependent and independent variables of our analysis. 			
						
			-> What it creates? 
				One .dta file named Pooled_PNAD saved in child-labor-ban-brazil/DataWork/Datasets/Intermediate.
			
		
		**
		**	
		- 3. Setting up Paper Data.do 
		
			-> How long does it take to run?
				Less than one minute. 
	
			-> What it does?
				The code creates the running variable of our study. 
				The code defines the same covariates used in the Bargain/Boutin Paper (2021) 'Minimum Age Regulation and Child Labor'. 
				Therefore, we can compare our and their sample sizes, as well as explain why some results differ. 
				
						
			-> What it creates? 
				One .dta file named Child Labor Ban saved in: child-labor-ban-brazil/DataWork/Datasets/Final.
		
		
		**
		**	
		- 4. Descriptives.do 
		
			-> How long does it take to run?
				Few minutes. 
	
			-> What it does?
				Creates descriptives statistics and figures used in the paper. 
						
			-> What it creates? 
				Figures saved in child-labor-ban-brazil/DataWork/Output/Figures.
		
		
		**
		**		
			5. RDD using Local Randomization	
		
			-> How long does it take to run?
				
	
			-> What it does?
				Run RDD using local Randomization
						
			-> What it creates? 
				.dta file with estimates 'Regression Results using RD under local randomization.dta' saved in child-labor-ban-brazil/DataWork/Datasets/Final.
				Figures saved in child-labor-ban-brazil/DataWork/Output/Figures.
		
		
		**
		**	
		- Globals. 
		
		The code sets globals with: 
			- The short and long term outcomes of the analysis.
			- The variables used for balance checks between comparison and treatment groups.
			- The covariates used in the regression 	

			
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	Folder Structure
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
		
		It is possible to reproduce all the analysis using only the codes available in GitHub. 
		
		Set up the folder structure:
		
			- Create the folder "child-labor-ban-brazil". 
				- inside this folder, create "DataWork"
					- inside "DataWork", create "Datasets" 
						- inside "Datasets", create 3 folders: "Raw", "Intermediate" and "Final" 
							- inside "Raw", create 16 folders for each PNAD wave. The folders need to be named: 1998, 1999, 2001
							  2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2011, 2012, 2013, 2014, 2015. 
					
					- inside "DataWork", create "Output" 
						- inside "Output", create 2 folders: "Tables" and "Figures". 
						
		For each wave, save the PNAD microdata in the respective folder. For example, for 1999 wave, save the .txt files in the folder:
		child-labor-ban-brazil->DataWork->Datasets->Raw->1999. 
		
		Make sure that the .txt files are saved with the following names:
				- 1998 -> Pessoa98.txt Domicilio98.txt
				- 1999 -> Pessoa99.txt Domicilio99.txt
				- 2001 -> PES2001.txt  DOM2001.txt
				- 2002 -> PES2002.txt  DOM2002.txt			
				- 2003 -> PES2003.txt  DOM2003.txt			
				- 2004 -> PES2004.txt  DOM2004.txt			
				- 2005 -> PES2005.txt  DOM2005.txt			
				- 2006 -> PES2006.txt  DOM2006.txt			
				- 2007 -> PES2007.txt  DOM2007.txt			
				- 2008 -> PES2008.txt  DOM2008.txt			
				- 2009 -> PES2009.txt  DOM2009.txt			
				- 2011 -> PES2011.txt  DOM2011.txt			
				- 2012 -> PES2012.txt  DOM2012.txt			
				- 2013 -> PES2013.txt  DOM2013.txt			
				- 2014 -> PES2014.txt  DOM2014.txt			
				- 2015 -> PES2015.txt  DOM2015.txt			
		
		After setting up the folder structure and saving Household Survey Microdata (in .txt files), 
		you can run the codes and reproduce all the results. 

		
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	*Installing Packages and Standardize Settings
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
	   Installing packages needed to run all dofiles called by this master dofile. */
		*local user_commands ietoolkit labutil   
	   foreach command of local user_commands  {
		   cap which `command'
		   if _rc == 111 {
			   ssc install `command'
		   }
	   }
		/*
		**Local Randomization Inference Package
		net install rdlocrand, from(https://raw.githubusercontent.com/rdpackages/rdlocrand/master/stata) replace
		
		**RD densitity and LP density Packages
		net install rddensity,  from(https://raw.githubusercontent.com/rdpackages/rddensity/master/stata) replace
		net install lpdensity,  from(https://raw.githubusercontent.com/nppackages/lpdensity/master/stata) replace
		
		**MC Crary test
		sysdir  //locations
		copy https://eml.berkeley.edu/~jmccrary/DCdensity/DCdensity.ado  `"`c(sysdir_plus)'/DCdensity.ado"', public replace
		discard // you have to discard to see installed adofiles
		which DCdensity
		
		**DataZoom Package
		net from http://www.econ.puc-rio.br/datazoom/portugues  
		net install datazoom_pnad, replace
		*/ 
		
		**Stata version
		ieboilstart, version(15)          	
		`r(version)' 
		
		**Figure settings
		graph set window fontface "Times"
		set scheme s1mono
		
		**Others
		set matsize 11000
        set level   95
		set seed    108474
		
		
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	*Preparing Folder Paths
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
	   * Users
	   * -------------------------*
	   * Vivian                  1    
	   * Next User               2    

	   *Set this value to the user currently using this file
	   global user  1			

	   **
	   * Root folder globals
	   * -------------------------*
	   if $user == 1 {
		   global dofiles       "/Users/vivianamorim/Documents/GitHub/child-labor-ban-brazil/Do files"
		   global projectfolder	"/Users/vivianamorim/OneDrive/world-bank/Labor/child-labor-ban-brazil"		//Do not use folder's names with spaces, for example "World Bank" 
	   }

	   if $user == 2 {
		   global projectfolder ""  //project file path in your computer
	   }
	   
	   **
	   * Project folder globals
	   * -------------------------*
	   global datawork         	"$projectfolder/DataWork"
	   global datasets         	"$datawork/Datasets"
	   global raw	           	"$datasets/Raw"
	   global inter				"$datasets/Intermediate"
	   global final            	"$datasets/Final" 
	   global tables			"$datawork/Output/Tables"
	   global figures			"$datawork/Output/Figures"
	   
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	*Setting up Globals
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
		do "$dofiles/Globals.do"
		  
	/*
	*--------------------------------------------------------------------------------------------------------------------------------*
	**
	*Run the do-files
	**
	*--------------------------------------------------------------------------------------------------------------------------------*
		do "$dofiles/1. Importing Household Survey (PNAD).do"
		do "$dofiles/2. Harmonizing Household Survey (PNAD).do"
		do "$dofiles/3. Setting up Paper Data.do"
		do "$dofiles/4. Descriptives.do"
	
