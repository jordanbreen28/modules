require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlsetup',
  dscmeta_resource_friendly_name: 'SqlSetup',
  dscmeta_resource_name: 'DSC_SqlSetup',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlSetup resource type.
         Automatically generated from version 16.0.0',
  features: ['simple_get_filter', 'canonicalize', 'custom_insync'],
  attributes: {
    name: {
      type:      'String',
      desc:      'Description of the purpose for this resource declaration.',
      behaviour: :namevar,
    },
    validation_mode: {
      type:      'Enum[property, resource]',
      desc:      'Whether to check if the resource is in the desired state by property (default) or using Invoke-DscResource in Test mode (resource).',
      behaviour: :parameter,
      default:   'property',
    },
    dsc_psdscrunascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_assvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for the _SQL Server Analysis Services_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_astempdir: {
      type: 'Optional[String]',
      desc: "Path for _Analysis Services_'s temp files.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_assysadminaccounts: {
      type: 'Optional[Array[String]]',
      desc: 'Array of accounts to be made _Analysis Services_ admins.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_failoverclustergroupname: {
      type: 'Optional[String]',
      desc: "The name of the resource group to create for the clustered _SQL Server_ instance. Default is `'SQL Server (InstanceName)'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_forcereboot: {
      type: 'Optional[Boolean]',
      desc: 'Forces reboot.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_rssvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for _Reporting Services_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_installshareddir: {
      type: 'Optional[String]',
      desc: 'Installation path for shared _SQL Server_ files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqltempdbfilecount: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the number of temporary database data files to be added by setup.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_issvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for the _SQL Server Integration Services_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ascollation: {
      type: 'Optional[String]',
      desc: 'Collation for the _SQL Server Analysis Services_.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_agtsvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for the _SQL Server Agent_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_rsinstallmode: {
      type: "Optional[Enum['SharePointFilesOnlyMode', 'DefaultNativeMode', 'FilesOnlyMode', 'sharepointfilesonlymode', 'defaultnativemode', 'filesonlymode']]",
      desc: 'Specifies the install mode for _SQL Server Report Services_ service.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_action: {
      type: "Optional[Enum['Install', 'Upgrade', 'InstallFailoverCluster', 'AddNode', 'PrepareFailoverCluster', 'CompleteFailoverCluster', 'install', 'upgrade', 'installfailovercluster', 'addnode', 'preparefailovercluster', 'completefailovercluster']]",
      desc: "The action to be performed. Default value is `'Install'`. **NOTE: AddNode is not currently functional.**",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_asconfigdir: {
      type: 'Optional[String]',
      desc: "Path for _Analysis Services_'s config files.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_agtsvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _SQL Agent_'s _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_setupprocesstimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'The timeout, in seconds, to wait for the setup process to finish. Default value is `7200` seconds (2 hours). If the setup process does not finish before this time, an error will be thrown.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_isclustered: {
      type: 'Optional[Boolean]',
      desc: 'Returns a boolean value of `$true` if the instance is clustered, otherwise it returns `$false`.',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_sqltempdblogfilegrowth: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the file growth increment of each temporary database data file in MB.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_sapwd: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Specifies the SA account's password. Only applicable if parameter **SecurityMode** is set to `'SQL'`.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_tcpenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies the state of the _TCP_ protocol for the _SQL Server_ service. The value `$true` will enable the _TCP_ protocol and `$false` will disabled it.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_sqlbackupdir: {
      type: 'Optional[String]',
      desc: 'Path for _SQL Server_ backup files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqltempdbdir: {
      type: 'Optional[String]',
      desc: 'Path for _SQL Server_ temporary database data files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_securitymode: {
      type: "Optional[Enum['SQL', 'Windows', 'sql', 'windows']]",
      desc: "Security mode to apply to the _SQL Server_ instance. The value `'SQL'` indicates mixed-mode authentication while the value `'Windows'` indicates _Windows Authentication_. Default value is `'Windows'`.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqmreporting: {
      type: 'Optional[String]',
      desc: 'Enable customer experience reporting.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_features: {
      type: 'Optional[String]',
      desc: '_SQL Server_ features to be installed.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_assvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for _Analysis Services_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_installsqldatadir: {
      type: 'Optional[String]',
      desc: 'Root path for _SQL Server_ database files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqltempdbfilegrowth: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the file growth increment of each temporary database data file in MB.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_featureflag: {
      type: 'Optional[Array[String]]',
      desc: 'Feature flags are used to toggle DSC resource functionality on or off. See the DSC resource documentation for what additional functionality exist through a feature flag.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_updateenabled: {
      type: 'Optional[String]',
      desc: 'Enabled updates during installation.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqlsvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for the _SQL Server_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_issvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _Integration Services_'s _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_browsersvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for _SQL Server Browser_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_rssvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for the _SQL Server Reporting Services_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqluserdblogdir: {
      type: 'Optional[String]',
      desc: 'Path for _SQL Server_ log files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_assvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _SQL Server Analysis Services_'s _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_useenglish: {
      type: 'Optional[Boolean]',
      desc: 'Specifies to install the English version of _SQL Server_ on a localized operating system when the installation media includes language packs for both English and the language corresponding to the operating system.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_sqlsvcstartuptype: {
      type: "Optional[Enum['Automatic', 'Disabled', 'Manual', 'automatic', 'disabled', 'manual']]",
      desc: "Specifies the startup mode for the _SQL Server Database Engine_'s _Windows_ service.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_failoverclusteripaddress: {
      type: 'Optional[Array[String]]',
      desc: "Specifies an array of IP addresses to be assigned to the clustered _SQL Server_ instance. IP addresses must be in [dotted-decimal notation](https://en.wikipedia.org/wiki/Dot-decimal_notation), for example `'10.0.0.100'`. If no IP address is specified, uses `'DEFAULT'` for this setup parameter.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_sqlsysadminaccounts: {
      type: 'Optional[Array[String]]',
      desc: 'An array of accounts to be made _SQL Server_ administrators.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_asservermode: {
      type: "Optional[Enum['MULTIDIMENSIONAL', 'TABULAR', 'POWERPIVOT', 'multidimensional', 'tabular', 'powerpivot']]",
      desc: "The server mode for _SQL Server Analysis Services_ instance. The default is to install in Multidimensional mode. Valid values in a cluster scenario are `'MULTIDIMENSIONAL'` or `'TABULAR'`. Parameter **ASServerMode** is case-sensitive. **All values must be expressed in upper case**.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_productkey: {
      type: 'Optional[String]',
      desc: 'Product key for licensed installations.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqlcollation: {
      type: 'Optional[String]',
      desc: 'Collation for _SQL Server Database Engine_.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_failoverclusternetworkname: {
      type: 'Optional[String]',
      desc: 'Host name to be assigned to the clustered _SQL Server_ instance.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_asbackupdir: {
      type: 'Optional[String]',
      desc: "Path for _Analysis Services_'s backup files.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_npenabled: {
      type: 'Optional[Boolean]',
      desc: 'Specifies the state of the _Named Pipes_ protocol for the _SQL Server_ service. The value `$true` will enable the _Named Pipes_ protocol and `$false` will disabled it.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_issvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for _Integration Services_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_instanceid: {
      type: 'Optional[String]',
      desc: '_SQL Server_ instance ID (if different from parameter **InstanceName**).',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_updatesource: {
      type: 'Optional[String]',
      desc: 'Path to the source of updates to be applied during installation.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_instancedir: {
      type: 'Optional[String]',
      desc: 'Installation path for _SQL Server_ instance files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_installsharedwowdir: {
      type: 'Optional[String]',
      desc: 'Installation path for x86 shared _SQL Server_ files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_agtsvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for the _SQL Agent_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_ftsvcaccount: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: "Service account for the _Full Text_'s _Windows_ service.",
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_sqltempdblogfilesize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the initial size of each temporary database log file in MB.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_errorreporting: {
      type: 'Optional[String]',
      desc: 'Enable error reporting.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqltempdblogdir: {
      type: 'Optional[String]',
      desc: 'Path for _SQL Server_ temporary database log files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_skiprule: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies optional skip rules during setup.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_sourcecredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'Credentials used to access the path set in the parameter **SourcePath**. See section [Considerations](#considerations) regarding the parameter **SourceCredential**.',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_rssvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _Reporting Services_'s _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ftsvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _Full Text_' _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqluserdbdir: {
      type: 'Optional[String]',
      desc: 'Path for _SQL Server_ database files.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_suppressreboot: {
      type: 'Optional[Boolean]',
      desc: 'Suppresses reboot.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: 'Specifies the name of the instance to be installed.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqlsvcaccountusername: {
      type: 'Optional[String]',
      desc: "Returns the username for the _SQL Server_'s _Windows_ service.",
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sourcepath: {
      type: 'String',
      desc: 'The path to the root of the source files for installation. I.e and UNC path to a shared resource. Environment variables can be used in the path.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_asdatadir: {
      type: 'Optional[String]',
      desc: "Path for _Analysis Services_'s data files.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_aslogdir: {
      type: 'Optional[String]',
      desc: "Path for _Analysis Services_'s log files.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_sqltempdbfilesize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the initial size of each temporary database data file in MB.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
  },
)
