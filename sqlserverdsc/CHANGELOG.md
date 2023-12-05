## [16.0.0] - 2022-09-06

### Removed

- The deprecated DSC resource SqlDatabaseOwner have been removed _(and replaced_
  _by a property in [**SqlDatabase**](https://github.com/dsccommunity/SqlServerDsc/wiki/sqldatabase))_
  ([issue #1725](https://github.com/dsccommunity/SqlServerDsc/issues/1725)).
- The deprecated DSC resource SqlDatabaseRecoveryModel have been removed _(and_
  _replaced by a property in [**SqlDatabase**](https://github.com/dsccommunity/SqlServerDsc/wiki/sqldatabase))_
  ([issue #1725](https://github.com/dsccommunity/SqlServerDsc/issues/1725)).
- The deprecated DSC resource SqlServerEndpointState have been removed _(and_
  _replaced by a property in [**SqlEndpoint**](https://github.com/dsccommunity/SqlServerDsc/wiki/sqlendpoint))_
  ([issue #1725](https://github.com/dsccommunity/SqlServerDsc/issues/1725)).
- The deprecated DSC resource SqlServerNetwork have been removed _(and replaced by_
  _[**SqlProtocol**](https://github.com/dsccommunity/SqlServerDsc/wiki/sqlprotocol)_
  _and [**SqlProtocolTcpIp**](https://github.com/dsccommunity/SqlServerDsc/wiki/sqlprotocoltcpip))_
  ([issue #1725](https://github.com/dsccommunity/SqlServerDsc/issues/1725)).
- CommonTestHelper
  - Remove the helper function `Wait-ForIdleLcm` since it has been moved
    to the module _DscResource.Test_.
  - Remove the helper function `Get-InvalidOperationRecord` since it has
    been moved to the module _DscResource.Test_.
  - Remove the helper function `Get-InvalidResultRecord` since it has been
    moved to the module _DscResource.Test_.

### Added

- SqlServerDsc
  - Added recommended VS Code extensions.
    - Added settings for VS Code extension _Pester Test Adapter_.
  - Added new Script Analyzer rules from the module _Indented.ScriptAnalyzerRules_
    to help development and review process. The rules that did not contradict
    the existing DSC Community rules and style guideline were added.
  - Added the Visual Studio Code extension _Code Spell Checker_ to the list
    of recommended Visual Studio Code extensions.
  - Added a file `prefix.ps1` which content is placed first in the built module
    (.psm1). This file imports dependent modules, and imports localized strings
    used by private and public commands.
  - The following classes were added to the module:
    - `DatabasePermission` - complex type for the DSC resource SqlDatabasePermission.
    - `Ensure` - Enum to be used for the property `Ensure` in class-based
      resources.
    - `Reason` - Used by method `Get()` to return the reason a property is not
      in desired state.
    - `ResourceBase` - class that can be inherited by class-based resource and
      provides functionality meant simplify the creating of class-based resource.
    - `SqlResourceBase` - class that can be inherited by class-based resource and
      provides default DSC properties and method for get a `[Server]`-object.
    - `ServerPermission` - complex type for the DSC resource SqlPermission.
  - The following private functions were added to the module (see comment-based
    help for more information):
    - `ConvertFrom-CompareResult`
    - `ConvertTo-Reason`
    - `Get-ClassName`
    - `Get-DscProperty`
    - `Get-LocalizedDataRecursive`
    - `Test-ResourceHasDscProperty`
    - `Test-ResourceDscPropertyIsAssigned`
  - The following public functions were added to the module (see comment-based
    help for more information):
    - `Connect-SqlDscDatabaseEngine`
    - `ConvertFrom-SqlDscDatabasePermission`
    - `ConvertTo-SqlDscDatabasePermission`
    - `Get-SqlDscDatabasePermission`
    - `Set-SqlDscDatabasePermission`
    - `Test-SqlDscIsDatabasePrincipal`
    - `Test-SqlDscIsLogin`
    - `ConvertFrom-SqlDscServerPermission`
    - `ConvertTo-SqlDscServerPermission`
    - `Get-SqlDscServerPermission`
    - `Set-SqlDscServerPermission`
    - `Invoke-SqlDscQuery`
    - `Get-SqlDscAudit`
    - `New-SqlDscAudit`
    - `Set-SqlDscAudit`
    - `Remove-SqlDscAudit`
    - `Enable-SqlDscAudit`
    - `Disable-SqlDscAudit`
  - Support for debugging of integration tests in AppVeyor.
    - Only run for pull requests
  - Add new resource SqlAudit.
- CommonTestHelper
  - `Import-SqlModuleStub`
    - Added the optional parameter **PasThru** that, if used, will return the
      name of the stub module.
    - When removing stub modules from the session that is not supposed to
      be loaded, it uses `Get-Module -All` to look for previously loaded
      stub modules.
  - `Remove-SqlModuleStub`
    - Added a new helper function `Remove-SqlModuleStub` for tests to remove
      the PowerShell SqlServer stub module when a test has run.
- SqlWindowsFirewall
  - Added integration tests for SqlWindowsFirewall ([issue #747](https://github.com/dsccommunity/SqlServerDsc/issues/747)).
- `Get-DscProperty`
  - Added parameter `ExcludeName` to exclude property names from being returned.

### Changed

- SqlServerDsc
  - Updated pipeline to use the build worker image 'ubuntu-latest'.
  - Switch to installing GitVersion using 'dotnet tool install' ([issue #1732](https://github.com/dsccommunity/SqlServerDsc/issues/1732)).
  - Bumped Stale task to v5 in the GitHub workflow.
  - Make it possible to publish code coverage on failed test runs, and
    when re-run a fail job.
  - Exclude Script Analyzer rule **TypeNotFound** in the file `.vscode/analyzersettings.psd1`.
  - Update CONTRIBUTING.md describing error handling in commands and class-based
    resources.
  - The QA tests are now run in Windows PowerShell due to a bug in PowerShell 7
    that makes class-based resource using inheritance to not work.
  - The QA test are excluding the rule **TypeNotFound** because it cannot
    run on the source files (there is a new issue that is tracking so this
    rule is only run on the built module).
  - The Pester code coverage has been switched to use the older functionality
    that uses breakpoints to calculate coverage. Newer functionality sometimes
    throw an exception when used in conjunction with class-based resources.Â¨
  - SMO stubs (used in the unit tests)
    - Was updated to remove a bug related to the type `DatabasePermissionInfo`
      when used with the type `DatabasePermissionSet`.
      The stubs suggested that the property `PermissionType` (of type `DatabasePermissionSet`)
      in `DatabasePermissionInfo` should have been a array `DatabasePermissionSet[]`.
      This conflicted with real SMO as it does not pass an array, but instead
      a single `DatabasePermissionSet`. The stubs was modified to mimic the
      real SMO. At the same time some old mock code in the SMO stubs was removed
      as it was no longer in use.
    - Was updated to remove a bug related to the type `ServerPermissionInfo`
      when used with the type `ServerPermissionSet`. The stubs suggested that
      the property `PermissionType` (of type `ServerPermissionSet`)
      in `ServerPermissionInfo` should have been a array `ServerPermissionSet[]`.
      This conflicted with real SMO as it does not pass an array, but instead
      a single `ServerPermissionSet`. The stubs was modified to mimic the
      real SMO. At the same time some old mock code in the SMO stubs was removed
      as it was no longer in use.
  - Updated integration tests README.md to describe how to use Appveyor to
    debug integration tests.
- Wiki
  - add introduction and links to DSC technology
- SqlServerDsc.Common
  - The parameter `SetupCredential` of the function `Connect-SQL` was renamed
    to `Credential` and the parameter name `SetupCredential` was made a
    parameter alias.
- SqlLogin
  - BREAKING CHANGE: The parameters `LoginMustChangePassword`, `LoginPasswordExpirationEnabled`,
    and `LoginPasswordPolicyEnforced` no longer have a default value of `$true`.
    This means that when creating a new login, and not specifically setting
    these parameters to `$true` in the configuration, the login that is created
    will have these properties set to `$false`.
  - BREAKING CHANGE: `LoginMustChangePassword`, `LoginPasswordExpirationEnabled`,
    and `LoginPasswordPolicyEnforced` parameters no longer enforce default
    values ([issue #1669](https://github.com/dsccommunity/SqlServerDsc/issues/1669)).
- SqlServerDsc
  - All tests have been converted to run in Pester 5 (Pester 4 can no
    longer be supported) ([issue #1654](https://github.com/dsccommunity/SqlServerDsc/issues/1654)).
  - Pipeline build and deploy now runs on Ubuntu 18.04, see more information
    in https://github.com/actions/virtual-environments/issues/3287.
  - Update the pipeline file _azure-pipelines.yml_ to use the latest version
    from the Sampler project.
- SqlRs
  - BREAKING CHANGE: Now the Reporting Services is always restarted after
    the call to CIM method `SetDatabaseConnection` when setting up the
    Reporting Services. This so to try to finish the initialization of
    Reporting Services. This was prior only done for _SQL Server Reporting_
    _Services 2019_ ([issue #1721](https://github.com/dsccommunity/SqlServerDsc/issues/1721)).
  - Added some verbose messages to better indicate which CIM methods are run
    and when they are run.
  - Minor refactor to support running unit test with strict mode enabled.
- SqlLogin
  - Only enforces optional parameter `LoginType` when it is specified in the
    configuration.
  - Only enforces optional parameters `LoginPasswordExpirationEnabled` and
    `LoginPasswordPolicyEnforced` for a SQL login when the parameters are
    specified in the configuration.
  - A localized string for an error message was updated to correctly reflect
    the code that says that to use a SQL login the authentication mode must
    be either Mixed or Normal, prio it just stated Mixed.
- SqlSecureConnection
  - BREAKING CHANGE: Now `Get-TargetResource` returns the value `'Empty'`
    f
