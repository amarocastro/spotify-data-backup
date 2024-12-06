
#Create a local repository for Powershell modules
Register-PSRepository -Name repo_name -SourceLocation local_path_to_module_packages -InstallationPolicy Trusted

#Publish a custom module in the local repository. It will create a nuget pacakage in the repo's SourceLocation folder
Publish-Module -Path local_path_to_ps_module_folder -Repository repo_name

#Install the module with its Nuget package
Install-Package -name module_name -Source local_path_to_nuget_package