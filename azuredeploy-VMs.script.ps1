#param(

 #[Parameter(Mandatory=$True)]
 #[string]
 #$srNumber
  
#)

Login-AzureRmAccount
Set-AzureRmContext -SubscriptionID 3a4af7b3-b7ac-463d-9940-1d80445961a8


$srNumber = '2016w'
$resourceGroupName = 'RGsp' + $srNumber
$location = 'east us'

$deploymentName = 'sp-' + $srNumber
$storageAccountNamePrefix  = 'storage' + $srNumber

$sharepointFarmName = 'spfarm' + $srNumber
$virtualNetworkName = 'spfarmVNET'+ $srNumber
$sppuplicIP = 'sppuplicIP' + $srNumber
$parameters=@{


sharepointFarmName = $sharepointFarmName
location ='east us'
virtualNetworkName= $virtualNetworkName
virtualNetworkAddressRange='10.0.0.0/16'
adSubnet='10.0.0.0/24'
sqlSubnet='10.0.1.0/24'
spSubnet= '10.0.2.0/24'
adNicIPAddress='10.0.0.4'
adminUsername = 'adiy'
adminPassword='P@ssw0rd1234'
adVMSize = 'Standard_D2_v2'
sqlVMSize = 'Standard_D2_v2'
spVMSize='Standard_D5_V2'
domainName= 'adiy.local' 
sqlServerServiceAccountUserName='adiysql'
sqlServerServiceAccountPassword='P@ssw0rd1234'
sharePointSetupUserAccountUserName='adiysp'
sharePointSetupUserAccountPassword= 'P@ssw0rd1234'
sharePointFarmAccountUserName='sp_farm'
sharePointFarmAccountPassword= 'P@ssw0rd1234'
sharePointFarmPassphrasePassword='P@ssw0rd1234'
spSiteTemplateName='STS#0'
spDNSPrefix='sp-unique'
baseUrl='https://raw.githubusercontent.com/aqasrawi/sp2016/master'
#baseUrl = 'https://raw.githubusercontent.com/razar-msft/SharePoint-Non-HA-FARM/master'
spPublicIPNewOrExisting='new'
spPublicIPRGName=''
sppublicIPAddressName= $sppuplicIP
storageAccountNamePrefix= $storageAccountNamePrefix
storageAccountType='Standard_LRS'

}

New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile C:\Users\aqasrawi\Documents\GitHub\sp2016\azuredeploy-vms.json -TemplateParameterObject $parameters