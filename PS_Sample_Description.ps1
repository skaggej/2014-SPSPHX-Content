<#
	PowerShell for Office 365 - Sample Scripts
	SharePoint Saturday Phoenix November 2014

	Speaker:	Eric Skaggs
	Website:	http://www.skaggej.com
	Twitter:		@skaggej
	Email:	  	eskaggs@outlook.com
	Company:	Catapult Systems - http://www.CatapultSystems.com
	Courses:	Pluralsight - http://pluralsight.com/author/eric-skaggs

	If anything is missing, please let me know via email.
#>

#List the modules that are loaded into the current window.
Get-Module

#Lists all available cmdlets.
Get-Command

#Shows cmdlet usage.  Super handy.  Replace "[cmdlet]" below with an actual cmdlet.  For example, Get-Help Connect-MsolService -Examples.
Get-Help [cmdlet] -Examples

#Outputs all of the commands available in the MSONLINE module to a CSV file in the current directory.
Get-Command -Module MSONLINE | select Name | Export-csv PS_Mod_MSONLINE_cmdlets.csv