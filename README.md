## Spotify user library
Spotify API client for Powerhsell as a module. Several functions for extracting current user's library.


### Install a Powershell module

  1. Create a local repository for Powershell modules
     ```powershell
        Register-PSRepository -Name repo_name -SourceLocation local_path_to_module_packages -InstallationPolicy Trusted
     ```

  3. Publish a custom module in the local repository. It will create a nuget pacakage in the repo's SourceLocation folder
     ```powershell
       Publish-Module -Path local_path_to_ps_module_folder -Repository repo_name
    ```
  5. Install the module with its Nuget package
     ```powershell
        Install-Package -name module_name -Source local_path_to_nuget_package
     ```
