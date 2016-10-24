param(

 [Parameter(Mandatory=$True)]
 [string]
 $srNumber
  
)

Login-AzureRmAccount
Set-AzureRmContext -SubscriptionID e7bc5085-d0bf-464f-aa5c-adb09f9d8fba

$resourceGroupName = 'RG-sp' + $srNumber
$location = 'east us'

$deploymentName = 'sp-' + $srNumber
$storageAccountNamePrefix  = 'storage' + $srNumber

$sharepointFarmName = 'spfarm' + $srNumber
$virtualNetworkName = 'spfarmVNET'+ $srNumber
$sppuplicIP = 'sppuplicIP'
$parameters=@{


sharepointFarmName = $sharepointFarmName
location ='east us'
virtualNetworkName= $virtualNetworkName
virtualNetworkAddressRange='10.0.0.0/16'
adSubnet='10.0.0.0/24'
sqlSubnet='10.0.1.0/24'
spSubnet= '10.0.2.0/24'
adNicIPAddress='10.0.0.4'
adminUsername = 'ahabda'
adminPassword='WSX5edc@'
adVMSize = 'Standard_D2_v2'
sqlVMSize = 'Standard_D2_v2'
spVMSize='Standard_D5_V2'
domainName= 'ahabda.local' 
sqlServerServiceAccountUserName='ahabdasql'
sqlServerServiceAccountPassword='wsx5EDC@'
sharePointSetupUserAccountUserName='ahabdasp'
sharePointSetupUserAccountPassword= 'wsx5EDC@'
sharePointFarmAccountUserName='sp_farm'
sharePointFarmAccountPassword= 'wsx5EDC@'
sharePointFarmPassphrasePassword='wsx5EDC@'
spSiteTemplateName='STS#0'
spDNSPrefix='sp-unique'
baseUrl='https://raw.githubusercontent.com/aayad/sharepoint-three-vm/master'
#baseUrl = 'https://raw.githubusercontent.com/razar-msft/SharePoint-Non-HA-FARM/master'
spPublicIPNewOrExisting='new'
spPublicIPRGName=''
sppublicIPAddressName= $sppuplicIP
storageAccountNamePrefix= $storageAccountNamePrefix
storageAccountType='Standard_LRS'

}

New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $Location `
    -Verbose -Force



New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile C:\Data\Work\armtemplates\azuredeploy.json -TemplateParameterObject $parameters