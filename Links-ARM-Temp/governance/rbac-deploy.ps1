
#!!Connect to Azure User
#!!Log into your Azure User
#Connect-AzureRmAccount

#!!List Provisioned Subscriptions
#Get-AzureRmSubscription

#!!Define Targeted Subscription
#!!Choose which subscription you want to deploy to
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

#See Targeted Subscription Resource Groups
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

#!!!!!!!!! change resource group as required 
#Get-AzureRmResourceGroup | Select-Object 'ResourceGroupName'

$networkguid1 = [guid]::NewGuid()
$networkguid2 = [guid]::NewGuid()
$networkguid3 = [guid]::NewGuid()
$networkguid4 = [guid]::NewGuid()
$networkguidparams = @{
	'networkguid1' = $networkguid1
	'networkguid2' = $networkguid2
	'networkguid3' = $networkguid3
	'networkguid4' = $networkguid4
}

$computeguid1 = [guid]::NewGuid()
$computeguid2 = [guid]::NewGuid()
$computeguid3 = [guid]::NewGuid()
$computeguid4 = [guid]::NewGuid()
$computeguidparams = @{
	'computeguid1' = $computeguid1
	'computeguid2' = $computeguid2
	'computeguid3' = $computeguid3
	'computeguid4' = $computeguid4
	}

$backupguid1 = [guid]::NewGuid()
$backupguid2 = [guid]::NewGuid()
$backupguid3 = [guid]::NewGuid()
$backupguid4 = [guid]::NewGuid()
$backupguidparams = @{
	'backupguid1' = $backupguid1
	'backupguid2' = $backupguid2
	'backupguid3' = $backupguid3
	'backupguid4' = $backupguid4
	}

$dataguid1 = [guid]::NewGuid()
$dataguid2 = [guid]::NewGuid()
$dataguid3 = [guid]::NewGuid()
$dataguid4 = [guid]::NewGuid()
$dataguidparams = @{
	'dataguid1' = $dataguid1
	'dataguid2' = $dataguid2
	'dataguid3' = $dataguid3
	'dataguid4' = $dataguid4
	}

$networkrg = 'rg-demo-ae-network-prod'
$computerg = 'rg-demo-ae-compute-prod'
$backuprg = 'rg-demo-ae-backup-prod'
$datarg = 'rg-demo-ae-data-prod'


New-AzureRmResourceGroupDeployment -Name StandardGovernanceDeploy `
-TemplateParameterFile .\rbac-network-params.json `
-TemplateFile .\rbac-network-template.json @NetworkTemplateParams `
-ResourceGroupName $networkrg

New-AzureRmResourceGroupDeployment -Name StandardGovernanceDeploy `
-TemplateParameterFile .\rbac-compute-params.json `
-TemplateFile .\rbac-compute-template.json @ComputeTemplateParams `
-ResourceGroupName $computerg

New-AzureRmResourceGroupDeployment -Name StandardGovernanceDeploy `
-TemplateParameterFile '.\rbac-backup-params.json' `
-TemplateFile '.\rbac-backup-template.json' @BackupTemplateParams `
-ResourceGroupName $backuprg

New-AzureRmResourceGroupDeployment -Name StandardGovernanceDeploy `
-TemplateParameterFile .\rbac-data-params.json `
-TemplateFile .\rbac-data-template.json @DataTemplateParams `
-ResourceGroupName $datarg