## [9.0.0] - 2023-02-22

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


