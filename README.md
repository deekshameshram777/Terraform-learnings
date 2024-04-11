Azure DevOps CICD Pipeline -
![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/4363b78b-41bd-4032-8ea8-7a9844143b06)


YAML Code for Build pipeline -

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

Release pipeline -

![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/710c4422-e4d6-4245-bb66-3198e5c4707b)


![image](https://github.com/deekshameshram777/Terraform-learnings/assets/156531844/d13fbb48-5ea1-422a-bf5b-935ec8a570d5)

