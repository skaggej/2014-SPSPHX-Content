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

#Lists all available cmdlets.
Get-Command

#Shows cmdlet usage.  Super handy.  Replace "[cmdlet]" below with an actual cmdlet.  For example, Get-Help Connect-MsolService -Examples.
Get-Help [cmdlet] -Examples

#List the modules that are loaded into the current session.
Get-Module

#Loads the modules for Windows Azure Active Directory and SharePoint Online
Import-Module MSONLINE, Microsoft.Online.SharePoint.PowerShell

#Outputs all of the commands available in the MSONLINE module to a CSV file in the current directory.
Get-Command -Module MSONLINE | select Name | Export-csv PS_Mod_MSONLINE_cmdlets.csv

#Outputs all of the commands available in the Microsoft.Online.SharePoint.PowerShell module to a CSV file in the current directory.
Get-Command -Module Microsoft.Online.SharePoint.PowerShell | select Name | Export-csv PS_Mod_Microsoft.Online.SharePoint.PowerShell_cmdlets.csv

#Connects your PowerShell session to Office 365.  This cmdlet prompts you for your Office 365 admin credentials.
$cred = Get-Credential
Connect-MsolService -Credential $cred

