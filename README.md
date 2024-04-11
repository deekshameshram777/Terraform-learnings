# Azure DevOps CICD Pipeline -
![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/bba1670d-5c3c-4a1d-bbd9-a401efda41aa)


# YAML Code for Build pipeline -

```
trigger:
- main
stages:
  - stage: Build
    jobs: 
     - job: Build
       pool:
        name: default
       steps:
        - task: TerraformInstaller@1
          displayName: Terraform install
          inputs:
            terraformVersion: 'latest'
        - task: TerraformTaskV4@4
          displayName: Terraform init
          inputs:
            provider: 'azurerm'
            command: 'init'
            backendServiceArm: 'Azure subscription 1(20333911-b4be-4918-ae1a-118ecbf3b1cb)'
            backendAzureRmResourceGroupName: 'test-rg'
            backendAzureRmStorageAccountName: 'teststorage12345777'
            backendAzureRmContainerName: 'dev-tfstate'
            backendAzureRmKey: 'dev.terraform.tfstate'
        - task: TerraformTaskV4@4
          displayName: Terraform validate
          inputs:
            provider: 'azurerm'
            command: 'validate'
        - task: TerraformTaskV4@4
          displayName: Terraform fmt
          inputs:
            provider: 'azurerm'
            command: 'custom'
            customCommand: 'fmt'
            outputTo: 'console'
            environmentServiceNameAzureRM: 'Azure subscription 1(20333911-b4be-4918-ae1a-118ecbf3b1cb)'
        - task: TerraformTaskV4@4
          displayName: Terraform plan
          inputs:
            provider: 'azurerm'
            command: 'plan'
            commandOptions: '-out $(Build.SourcesDirectory)/tfplanfile'
            environmentServiceNameAzureRM: 'Azure subscription 1(20333911-b4be-4918-ae1a-118ecbf3b1cb)'
        - task: CopyFiles@2
          displayName: Copy Files
          inputs:
            Contents: '**'
            TargetFolder: '$(Build.ArtifactStagingDirectory)'
        - task: PublishBuildArtifacts@1
          displayName: Publish Build Artifacts
          inputs:
            PathtoPublish: '$(Build.ArtifactStagingDirectory)'
            ArtifactName: 'drop'
            publishLocation: 'Container'
```

# Release pipeline -

![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/8686f3c4-3a90-40b9-aae7-1c7082d8a810)



![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/18cc5546-8650-4265-846f-8ea17f9f94a6)


