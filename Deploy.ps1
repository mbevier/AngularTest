
Add-AzureRmAccount
# Deployment settings
$hostingPlanName = "ArmAngularSampleHostingPlan"
$resourceGroupName = "ArmAngularSample"
$storageAccountName = "armangularsamplesa"
$location = "West US"
$siteName = "ArmAngularSampleWebsite"

New-AzureRmResourceGroup -Name $resourceGroupName -Location $location -Force

# Deploy storage
New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName `
                                 -Name AzmSampleStorageDeployment `
                                 -TemplateFile "storagedeploy.json" `
                                 -StorageAccountName "testStorage"				 
$storageAccountKey = (Get-AzureStorageAccountKey -ResourceGroupName $resourceGroupName -Name $storageAccountName).Key1

# Build deployment package
grunt build
cp .\website.publishproj .\dist\website.publishproj
C:\"Program Files (x86)"\MSBuild\14.0\bin\msbuild.exe .\dist\website.publishproj /T:Package /P:PackageLocation="." /P:_PackageTempDir="packagetmp"
$websitePackage = ".\dist\website.zip"

New-AzureRmResourceGroupDeployment -Name AngularJSDeploy -ResourceGroupName ExampleResourceGroup -TemplateFile c:\MyTemplates\example.json