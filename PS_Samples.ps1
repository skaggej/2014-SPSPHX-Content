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

#*************************************************************************

#Run in any PowerShell Shell

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

#*************************************************************************

#Run in the Windows Azure Active Directory Management Shell

#Connects your PowerShell session to Office 365.  This cmdlet prompts you for your Office 365 admin credentials.
$credO365 = Get-Credential
Connect-MsolService -Credential $credO365

#Lists all unlicensed users
Get-MsolUser -UnlicensedUsersOnly

#Lists all licensed users
Get-MsolUser | Where-Object{$_.islicensed -eq $true}

#*************************************************************************

#Run in the SharePoint Online Management Shell.  
#Connects your PowerShell session to SharePoint Online.  This cmdlet prompts you for your Office 365 admin credentials.
$credO365 = Get-Credential
Connect-SPOService -Url https://TENANTNAME-admin.sharepoint.com -Credential $credO365

#Lists all site collections
Get-SPOSite | select Url

#Lists all web templates
Get-SPOWebTemplate | select name, title | Format-List

#Exports all web templates to a CSV file in the current directory
Get-SPOWebTemplate | select name, title | Export-Csv SPOWebTemplates.csv

#Creates a new site collection at the specified URL - you'll want to update the url, owner, title, and template
New-SPOSite -Url https://TENANTNAME.sharepoint.com/sites/SiteCollectionUrl -Owner admin@TENANTNAME.onmicrosoft.com -StorageQuota 1000 -Title "SiteCollectionTitle" -Template STS#0

#*************************************************************************

#This section provides a script that allows you to provision multiple site collections in SharePoint Online based on a CSV file

#SharePoint Online Url Prefix
$spoUrlPrefix = "https://TENANTNAME.sharepoint.com/sites/"

#Default SharePoint Site Collection Owner
$siteOwner = "admin@TENANTNAME.onmicrosoft.com"

#Default Storage Quota
$storageQuota = 1000

#Path for the CSV import - you'll want to update the path
$sites = import-csv -Path C:\Sample.csv

#Connects your PowerShell session to SharePoint Online.  This cmdlet prompts you for your Office 365 admin credentials.
$credO365 = Get-Credential
Connect-SPOService -Url https://TENANTNAME-admin.sharepoint.com -Credential $credO365

foreach($site in $sites)
{
	#store the comma-separated values in variables
	$siteTitle = $site.Title
	$siteUrl = $site.Url
	$siteTemplate = $site.Template

	#provision the site
	write-host -foregroundcolor blue ============================================================
	write-host -foregroundcolor green Creating Site Collection at $spoUrlPrefix$siteUrl

	New-SPOSite -Url $spoUrlPrefix$siteUrl -Owner $siteOwner -StorageQuota $storageQuota -Title $siteTitle -Template $siteTemplate
	
	write-host -foregroundcolor green DONE!
}

#*************************************************************************