@{
    # Script module or binary module file associated with this manifest.
    RootModule           = 'SqlServerDsc.psm1'

    # Version number of this module.
    ModuleVersion        = '16.5.0'

    # ID used to uniquely identify this module
    GUID                 = '693ee082-ed36-45a7-b490-88b07c86b42f'

    # Author of this module
    Author               = 'DSC Community'

    # Company or vendor of this module
    CompanyName          = 'DSC Community'

    # Copyright statement for this module
    Copyright            = 'Copyright the DSC Community contributors. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Module with DSC resources for deployment and configuration of Microsoft SQL Server.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.0'

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion           = '4.0'

    # Functions to export from this module
    FunctionsToExport    = @('Add-SqlDscNode','Add-SqlDscTraceFlag','Complete-SqlDscFailoverCluster','Complete-SqlDscImage','Connect-SqlDscDatabaseEngine','ConvertFrom-SqlDscDatabasePermission','ConvertFrom-SqlDscServerPermission','ConvertTo-SqlDscDatabasePermission','ConvertTo-SqlDscServerPermission','Disable-SqlDscAudit','Disconnect-SqlDscDatabaseEngine','Enable-SqlDscAudit','Get-SqlDscAudit','Get-SqlDscConfigurationOption','Get-SqlDscDatabasePermission','Get-SqlDscManagedComputer','Get-SqlDscManagedComputerService','Get-SqlDscPreferredModule','Get-SqlDscServerPermission','Get-SqlDscStartupParameter','Get-SqlDscTraceFlag','Import-SqlDscPreferredModule','Initialize-SqlDscRebuildDatabase','Install-SqlDscServer','Invoke-SqlDscQuery','New-SqlDscAudit','Remove-SqlDscAudit','Remove-SqlDscNode','Remove-SqlDscTraceFlag','Repair-SqlDscServer','Set-SqlDscAudit','Set-SqlDscDatabasePermission','Set-SqlDscServerPermission','Set-SqlDscStartupParameter','Set-SqlDscTraceFlag','Test-SqlDscIsDatabasePrincipal','Test-SqlDscIsLogin','Test-SqlDscIsSupportedFeature','Uninstall-SqlDscServer')

    # Cmdlets to export from this module
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = @()

    # Aliases to export from this module
    AliasesToExport      = @()

    DscResourcesToExport = @('SqlAudit','SqlDatabasePermission','SqlPermission','SqlAG','SqlAGDatabase','SqlAgentAlert','SqlAgentFailsafe','SqlAgentOperator','SqlAGListener','SqlAGReplica','SqlAlias','SqlAlwaysOnService','SqlConfiguration','SqlDatabase','SqlDatabaseDefaultLocation','SqlDatabaseMail','SqlDatabaseObjectPermission','SqlDatabaseRole','SqlDatabaseUser','SqlEndpoint','SqlEndpointPermission','SqlLogin','SqlMaxDop','SqlMemory','SqlProtocol','SqlProtocolTcpIp','SqlReplication','SqlRole','SqlRS','SqlRSSetup','SqlScript','SqlScriptQuery','SqlSecureConnection','SqlServiceAccount','SqlSetup','SqlTraceFlag','SqlWaitForAG','SqlWindowsFirewall')

    RequiredAssemblies   = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{
            # Set to a prerelease string value if the release should be a prerelease.
            Prerelease   = ''

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('DesiredStateConfiguration', 'DSC', 'DSCResourceKit', 'DSCResource')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/dsccommunity/SqlServerDsc/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/dsccommunity/SqlServerDsc'

            # A URL to an icon representing this module.
            IconUri      = 'https://dsccommunity.org/images/DSC_Logo_300p.png'

            # ReleaseNotes of this module
            ReleaseNotes = '## [16.5.0] - 2023-10-03

### Fixed

- SqlDatabase
  - Add Version160 to CompatibilityLevel ValidateSet

### Added

- SqlServerDsc
  - Updated pipeline files to support ModuleFast and PSResourceGet.
  - `Get-SqlDscPreferredModule`
    - Optionally specify what version of the the SQL preferred module to
      be imported using the SMODefaultModuleVersion environment variable
      ([issue #1965](https://github.com/dsccommunity/SqlServerDsc/issues/1965)).
  - Now package the Wiki content and adds it as a GitHub Release asset so it
    is simpler to get the documentation for a specific version.
  - CODEOWNERS file was added to support automatically set reviewer.
- New private command:
  - Get-SMOModuleCalculatedVersion - Returns the version of the SMO module
    as a string. SQLPS version 120 and 130 do not have the correct version set,
    so the file path is used to calculate the version.
- SqlSetup
  - Added the parameter `SqlVersion` that can be used to set the SQL Server
    version to be installed instead of it looking for version in the setup
    executable of the SQL Server media. This parameter is not allowed for
    the setup action `Upgrade`, if specified it will throw an exception
    ([issue #1946](https://github.com/dsccommunity/SqlServerDsc/issues/1946)).

### Changed

- SqlRs
  - Updated examples to use xPSDesiredStateConfiguration instead of PSDScResources.
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlScript
  - Updated examples to use xPSDesiredStateConfiguration instead of PSDScResources.
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlScriptQuery
  - Updated examples to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlSetup
  - Updated examples to use xPSDesiredStateConfiguration instead of PSDScResources.
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlAlwaysOnService
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlLogin
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlReplication
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlRSSetup
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlServiceAccount
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlWindowsFirewall
  - Updated integration tests to use xPSDesiredStateConfiguration instead of PSDScResources.
- SqlServerDsc
  - `Get-SqlDscPreferredModule`
    - Now returns a PSModuleInfo object instead of just the module name.
  - `Import-SqlDscPreferredModule`
    - Handles PSModuleInfo objects from `Get-SqlDscPreferredModule` instead of strings.
    - Sets -ErrorAction ''Stop'' on Get-SqlDscPreferredModule to throw an error if
      no SQL module is found. The script-terminating error is caught and made into
      a statement-terminating error.
  - Bump GitHub Action Checkout to v4.
- SqlAGListener
  - Made the resource cluster aware. When ProcessOnlyOnActiveNode is specified,
    the resource will only determine if a change is needed if the target node
    is the active host of the SQL Server instance ([issue #871](https://github.com/dsccommunity/SqlServerDsc/issues/871)).

### Remove

- SqlServerDsc
  - Removed PreferredModule_ModuleFound string in favor for more verbose PreferredModule_ModuleVersionFound.

'

        } # End of PSData hashtable

    } # End of PrivateData hashtable
}
