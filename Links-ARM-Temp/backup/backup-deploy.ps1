
#Connect to Azure User
#Connect-AzureRmAccount

#List Provisioned Subscriptions
#Get-AzureRmSubscription

#Define Targeted Subscription
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

$rg ="rg-callum-ae-backup-dev" 

 New-AzureRmResourceGroupDeployment -Name StandardBackupDeployment `
-TemplateParameterFile '.\backup-params.json' `
-TemplateFile '.\backup-template.json' `
-ResourceGroupName $rg