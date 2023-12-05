require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlscriptquery',
  dscmeta_resource_friendly_name: 'SqlScriptQuery',
  dscmeta_resource_name: 'DSC_SqlScriptQuery',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlScriptQuery resource type.
         Automatically generated from version 16.5.0',
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
    dsc_variable: {
      type: 'Optional[Array[String]]',
      desc: 'Specifies, as a string array, a scripting variable for use in the sql script, and sets a value for the variable. Use a _Windows PowerShell_ array to specify multiple variables and their values. For more information how to use this, please go to the help documentation for [Invoke-SqlCmd](https://docs.microsoft.com/en-us/powershell/module/sqlserver/Invoke-SqlCmd).',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_encrypt: {
      type: "Optional[Enum['Mandatory', 'mandatory', 'Optional', 'optional', 'Strict', 'strict']]",
      desc: 'Specifies how encryption should be enforced when using command `Invoke-SqlCmd`. When not specified, the default value is `Mandatory`.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
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
    dsc_disablevariables: {
      type: 'Optional[Boolean]',
      desc: 'Specifies, as a boolean, whether or not PowerShell will ignore `Invoke-SqlCmd` scripting variables that share a format such as `$(variable_name)`. For more information how to use this, please go to the help documentation for [Invoke-SqlCmd](https://docs.microsoft.com/en-us/powershell/module/sqlserver/Invoke-SqlCmd).',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_instancename: {
      type: 'String',
      desc: "Specifies the name of the _SQL Server Database Engine_ instance. For the default instance specify the value `'MSSQLSERVER'`.",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: 'Specifies the host name of the _SQL Server_ to be configured. Default value is the current computer name.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_getquery: {
      type: 'String',
      desc: "Full T-SQL query that will perform _Get_ action. Any values returned by the T-SQL queries will also be returned when calling _Get_ (for example by using the cmdlet `Get-DscConfiguration`) through the `'GetResult'` property.",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_getresult: {
      type: 'Optional[Array[String]]',
      desc: 'Returns the result from the T-SQL script provided in the parameter **GetQuery** when _Get_ was called.',

      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String[]',
      mof_is_embedded: false,
    },
    dsc_credential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: 'The credentials to authenticate with, using _SQL Server Authentication_. To authenticate using _Windows Authentication_, assign the credentials to the built-in parameter **PsDscRunAsCredential**. If neither of the parameters **Credential** and **PsDscRunAsCredential** are assigned then the SYSTEM account will be used to authenticate using _Windows Authentication_.',

      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_querytimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies, as an integer, the number of seconds after which the T-SQL script execution will time out. In some _SQL Server_ versions there is a bug in `Invoke-SqlCmd` where the normal default value `0` (no timeout) is not respected and the default value is incorrectly set to 30 seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_setquery: {
      type: 'String',
      desc: 'Full T-SQL query that will perform _Set_ action.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_testquery: {
      type: 'String',
      desc: 'Full T-SQL query that will perform _Test_ action. Any script that does not throw an error or returns `NULL` is evaluated to `$true`. The cmdlet `Invoke-SqlCmd` treats T-SQL `PRINT` statements as verbose text, and will not cause the test to return `$false`.',

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    ensurable: {
      type: 'Boolean[false]',
      desc: 'Default attribute added to all dsc types without an ensure property. This resource is not ensurable.',
      default: false,

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
