## [16.5.0] - 2023-10-03

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
    - Sets -ErrorAction 'Stop' on Get-SqlDscPreferredModule to throw an error if
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


