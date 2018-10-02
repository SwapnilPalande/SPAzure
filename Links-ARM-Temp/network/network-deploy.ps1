
#Connect to Azure User
#Connect-AzureRmAccount

#List Provisioned Subscriptions
#Get-AzureRmSubscription

#Define Targeted Subscription
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

$networkrg = (Get-AzureRmDeployment -Name StandardResourceGroup).Outputs.networkingrg.value 

New-AzureRmResourceGroupDeployment -Name StandardNetworkDeployment `
-TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\parameters-standard.json' `
-TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\network\network-template.json' `
-ResourceGroupName $networkrg