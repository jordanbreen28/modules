@{
    # Script module or binary module file associated with this manifest.
    RootModule           = 'ComputerManagementDsc.psm1'

    # Version number of this module.
    moduleVersion        = '9.0.0'

    # ID used to uniquely identify this module
    GUID                 = 'B5004952-489E-43EA-999C-F16A25355B89'

    # Author of this module
    Author               = 'DSC Community'

    # Company or vendor of this module
    CompanyName          = 'DSC Community'

    # Copyright statement for this module
    Copyright            = 'Copyright the DSC Community contributors. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'DSC resources for configuration of a Windows computer. These DSC resources allow you to perform computer management tasks, such as renaming the computer, joining a domain and scheduling tasks as well as configuring items such as virtual memory, event logs, time zones and power settings.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.0'

    # Minimum version of the common language runtime (CLR) required by this module
    CLRVersion           = '4.0'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = @()

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = @()

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # DSC resources to export from this module
    DscResourcesToExport = @('PSResourceRepository','Computer','IEEnhancedSecurityConfiguration','OfflineDomainJoin','PendingReboot','PowerPlan','PowerShellExecutionPolicy','RemoteDesktopAdmin','ScheduledTask','SmbServerConfiguration','SmbShare','SystemLocale','TimeZone','UserAccountControl','VirtualMemory','WindowsCapability','WindowsEventLog')

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{
            # Set to a prerelease string value if the release should be a prerelease.
            Prerelease   = ''

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('DesiredStateConfiguration', 'DSC', 'DSCResource')

            # A URL to the license for this module.
            LicenseUri   = 'https://github.com/dsccommunity/ComputerManagementDsc/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri   = 'https://github.com/dsccommunity/ComputerManagementDsc'

            # A URL to an icon representing this module.
            IconUri      = 'https://dsccommunity.org/images/DSC_Logo_300p.png'

            # ReleaseNotes of this module
            ReleaseNotes = '## [9.0.0] - 2023-02-22

### Fixed

- ScheduledTask
  - No longer conflates resource parameter `BuiltInAccount` and `*-ScheduledTask` parameter `user` - Fixes [Issue #385](https://github.com/dsccommunity/ComputerManagementDsc/issues/385)

### Added

- PSResourceRepository
  - New class-based resource to manage PowerShell Resource Repositories - Fixes [Issue #393](https://github.com/dsccommunity/ComputerManagementDsc/issues/393)
- Computer
  - Support Options Parameter for domain join - Fixes [Issue #234](https://github.com/dsccommunity/ComputerManagementDsc/issues/234).
  - When joining a computer to a domain, existing AD computer objects will be deleted - Fixes [Issue #55](https://github.com/dsccommunity/ComputerManagementDsc/issues/55), [Issue #58](https://github.com/dsccommunity/ComputerManagementDsc/issues/58).

### Changed

- BREAKING CHANGE: Windows Management Framework 5.0 is required.
- ComputerManagementDsc
  - The resource names were removed from the property `DscResourcesToExport`
    in the module manifest in the source folder as the built module is
    automatically updated with this information by the pipeline - Fixes [Issue #396](https://github.com/dsccommunity/ComputerManagementDsc/issues/396).
  - Moved the build step of the pipeline to a Windows build worker when running in Azure DevOps.

'
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
