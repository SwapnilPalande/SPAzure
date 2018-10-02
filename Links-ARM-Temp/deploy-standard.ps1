#Connect to Azure User
#Connect-AzureRmAccount

#List Provisioned Subscriptions
#Get-AzureRmSubscription

#Define Targeted Subscription
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

#Invokes the deployment of the resource groups
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmDeployment -Name StandardResourceGroup -Location "Australia East" `
 -TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\resourcegroups\rg-template.json' `
 -locationFromTemplate "ae" `
 -TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\resourcegroups\rg-params.json'

#Get a list of resource groups from the outputs section of the resource group template file
$networkrg = (Get-AzureRmDeployment -Name StandardResourceGroup).Outputs.networkingrgname.value 
$computerg = (Get-AzureRmDeployment -Name StandardResourceGroup).Outputs.computingrgname.value
$datarg = (Get-AzureRmDeployment -Name StandardResourceGroup).Outputs.datargname.value
$backuprg = (Get-AzureRmDeployment -Name StandardResourceGroup).Outputs.backuprgname.value

$Parameters = (Get-AzureRmDeployment -Name StandardResourceGroup).Parameters
$generalparams = @{
	'deploymentregion' = $Parameters.deploymentregion.Value
	'tier' = $Parameters.tier.Value
	'customerid' = $Parameters.customerid.Value
	'location' = $Parameters.location.Value
	'environment' = $Parameters.environment.Value
}

#Invokes the deployment of the network rg components
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmResourceGroupDeployment -Name StandardNetworkDeployment `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\network\network-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\network\network-template.json' @generalparams `
-ResourceGroupName $networkrg

#Invokes the deployment of the backup rg components
#!Ensure that the template and parameter file or URi locations are correct
 New-AzureRmResourceGroupDeployment -Name StandardBackupDeployment `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\backup\backup-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\backup\backup-template.json' @generalparams `
-ResourceGroupName $backuprg

#Creates require guids for RBAC deploy
$networkguid1 = [guid]::NewGuid()
$networkguid2 = [guid]::NewGuid()
$networkguid3 = [guid]::NewGuid()
$networkguid4 = [guid]::NewGuid()
$NetworkTemplateParams = @{
	'networkguid1' = $networkguid1
	'networkguid2' = $networkguid2
	'networkguid3' = $networkguid3
	'networkguid4' = $networkguid4
}

$computeguid1 = [guid]::NewGuid()
$computeguid2 = [guid]::NewGuid()
$computeguid3 = [guid]::NewGuid()
$computeguid4 = [guid]::NewGuid()
$ComputeTemplateParams = @{
	'computeguid1' = $computeguid1
	'computeguid2' = $computeguid2
	'computeguid3' = $computeguid3
	'computeguid4' = $computeguid4
	}

$backupguid1 = [guid]::NewGuid()
$backupguid2 = [guid]::NewGuid()
$backupguid3 = [guid]::NewGuid()
$backupguid4 = [guid]::NewGuid()
$BackupTemplateParams = @{
	'backupguid1' = $backupguid1
	'backupguid2' = $backupguid2
	'backupguid3' = $backupguid3
	'backupguid4' = $backupguid4
	}

$dataguid1 = [guid]::NewGuid()
$dataguid2 = [guid]::NewGuid()
$dataguid3 = [guid]::NewGuid()
$dataguid4 = [guid]::NewGuid()
$DataTemplateParams = @{
	'dataguid1' = $dataguid1
	'dataguid2' = $dataguid2
	'dataguid3' = $dataguid3
	'dataguid4' = $dataguid4
	}


#Invokes the deployment of the backup rg components
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmResourceGroupDeployment -Name StandardNetworkGovernanceDeploy `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-network-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-network-template.json' @NetworkTemplateParams @generalparams `
-ResourceGroupName $networkrg

#Invokes the deployment of the backup rg components
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmResourceGroupDeployment -Name StandardComputeGovernanceDeploy `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-compute-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-compute-template.json' @ComputeTemplateParams @generalparams `
-ResourceGroupName $computerg

#Invokes the deployment of the backup rg components
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmResourceGroupDeployment -Name StandardBackupGovernanceDeploy `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-backup-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-backup-template.json' @BackupTemplateParams @generalparams `
-ResourceGroupName $backuprg

#Invokes the deployment of the backup rg components
#!Ensure that the template and parameter file or URi locations are correct
New-AzureRmResourceGroupDeployment -Name StandardDataGovernanceDeploy `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-data-params.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\governance\rbac-data-template.json' @DataTemplateParams @generalparams `
-ResourceGroupName $datarg



#Invokes the deployment of the networking components
#!Ensure that the template and parameter file or URi locations are correct
#Invoke-expression -command  '.\network\network-deploy.ps1' `

# Invoke-Item -Path '.\backup\backup-deploy.ps1' `

# Invoke-Item -Path '.\governance\rbac-deploy.ps1'
