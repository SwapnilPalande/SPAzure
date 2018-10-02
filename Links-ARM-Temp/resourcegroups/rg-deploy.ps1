
#Connect to Azure User
#Connect-AzureRmAccount

#List Provisioned Subscriptions
#Get-AzureRmSubscription

#Define Targeted Subscription
#Select-AzureRmSubscription -SubscriptionName "244b3b82-8672-4020-807e-593bf97b1002"

New-AzureRmDeployment -Name StandardResourceGroup -Location "Australia East" `
 -TemplateFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\resourcegroups\rg-template.json' `
 -locationFromTemplate "ae" `
 -TemplateParameterFile 'C:\Users\Callum Robertson\source\repos\links-arm-templates\resourcegroups\rg-params.json'

 # New-AzureRmResourceGroupDeployment -Name StandardNetworkDeployment `
 # -TemplateParameterFile .\parameters-network.json `
 # -TemplateFile .\resources-network.json `
 # -ResourceGroupName "rg-callum-ae-network-dev" 