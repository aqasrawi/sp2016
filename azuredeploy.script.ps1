Login-AzureRmAccount
Set-AzureRmContext -SubscriptionID 3a4af7b3-b7ac-463d-9940-1d80445961a8

#$srNumber = Read-Host ("SR Number ") # 'm2016'
$srNumber = 'v2016'
$resourceGroupName = 'RGsp' + $srNumber
$location = 'east us'

$deploymentName = 'sp-' + $srNumber
$storageAccountNamePrefix  = 'storage' + $srNumber

$sharepointFarmName = 'spfarm' + $srNumber
$virtualNetworkName = 'spfarmVNET'+ $srNumber
$sppuplicIPName = 'sppuplicIP' + $srNumber


New-AzureRmResourceGroup -Name $resourceGroupName -Location $Location -Verbose -Force

$sppublicIP = New-AzureRmPublicIpAddress -AllocationMethod Dynamic -ResourceGroupName $resourceGroupName -Name $sppuplicIPName  -Location $location
#$publicip = New-AzureRmPublicIpAddress -ResourceGroupName $fipResrouceGroupName -Name $frontEndpublicIpName -Location $azureRegion -AllocationMethod Dynamic

$parameters=@{

dept = 'Finance'

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
#sharePointFarmAccountUserName='adiy'
sharePointFarmAccountPassword= 'P@ssw0rd1234'
sharePointFarmPassphrasePassword='P@ssw0rd1234'
spSiteTemplateName='STS#0'
spDNSPrefix='sp-unique' + $srNumber
baseUrl='https://raw.githubusercontent.com/aqasrawi/sp2016/master'
#baseUrl = 'https://raw.githubusercontent.com/razar-msft/SharePoint-Non-HA-FARM/master'
spPublicIPNewOrExisting='new'
spPublicIPRGName=''
sppublicIPAddressName= $sppublicIP.Name
storageAccountNamePrefix= $storageAccountNamePrefix

storageAccountType='Standard_LRS'
   


}

#
# Deploy and configure all networking components
#
#New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile $PSScriptRoot\azuredeploy-network.json -TemplateParameterObject $parameters -verbose
#
# Provision the AD and SQL VMs, configure ADDS and SQL Server
#
#clsNew-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile $PSScriptRoot\azuredeploy-vms.json -TemplateParameterObject $parameters -Verbose

#
# Provision the SP2016 VM including domain join and all pre-requisities needed for farm config
#
New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile $PSScriptRoot\azuredeploy-spvm.json -TemplateParameterObject $parameters -Verbose

#
# Configure an SP farm and central admin site
#
#New-AzureRmResourceGroupDeployment -Name $deploymentName -ResourceGroupName $resourceGroupName -TemplateFile $PSScriptRoot\azuredeploy-final-spvm.json -TemplateParameterObject $parameters -Verbose