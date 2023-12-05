require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlpermission',
  dscmeta_resource_friendly_name: 'SqlPermission',
  dscmeta_resource_name: 'SqlPermission',
  dscmeta_resource_implementation: 'Class',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlPermission resource type.
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
    dsc_permission: {
      type: "Optional[Array[Struct[{
              permission => Array[Enum['AdministerBulkOperations', 'AlterAnyServerAudit', 'AlterAnyCredential', 'AlterAnyConnection', 'AlterAnyDatabase', 'AlterAnyEventNotification', 'AlterAnyEndpoint', 'AlterAnyLogin', 'AlterAnyLinkedServer', 'AlterResources', 'AlterServerState', 'AlterSettings', 'AlterTrace', 'AuthenticateServer', 'ControlServer', 'ConnectSql', 'CreateAnyDatabase', 'CreateDdlEventNotification', 'CreateEndpoint', 'CreateTraceEventNotification', 'Shutdown', 'ViewAnyDefinition', 'ViewAnyDatabase', 'ViewServerState', 'ExternalAccessAssembly', 'UnsafeAssembly', 'AlterAnyServerRole', 'CreateServerRole', 'AlterAnyAvailabilityGroup', 'CreateAvailabilityGroup', 'AlterAnyEventSession', 'SelectAllUserSecurables', 'ConnectAnyDatabase', 'ImpersonateAnyLogin', 'administerbulkoperations', 'alteranyserveraudit', 'alteranycredential', 'alteranyconnection', 'alteranydatabase', 'alteranyeventnotification', 'alteranyendpoint', 'alteranylogin', 'alteranylinkedserver', 'alterresources', 'alterserverstate', 'altersettings', 'altertrace', 'authenticateserver', 'controlserver', 'connectsql', 'createanydatabase', 'createddleventnotification', 'createendpoint', 'createtraceeventnotification', 'shutdown', 'viewanydefinition', 'viewanydatabase', 'viewserverstate', 'externalaccessassembly', 'unsafeassembly', 'alteranyserverrole', 'createserverrole', 'alteranyavailabilitygroup', 'createavailabilitygroup', 'alteranyeventsession', 'selectallusersecurables', 'connectanydatabase', 'impersonateanylogin']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'ServerPermission[]',
      mof_is_embedded: true,
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
    dsc_permissiontoexclude: {
      type: "Optional[Array[Struct[{
              permission => Array[Enum['AdministerBulkOperations', 'AlterAnyServerAudit', 'AlterAnyCredential', 'AlterAnyConnection', 'AlterAnyDatabase', 'AlterAnyEventNotification', 'AlterAnyEndpoint', 'AlterAnyLogin', 'AlterAnyLinkedServer', 'AlterResources', 'AlterServerState', 'AlterSettings', 'AlterTrace', 'AuthenticateServer', 'ControlServer', 'ConnectSql', 'CreateAnyDatabase', 'CreateDdlEventNotification', 'CreateEndpoint', 'CreateTraceEventNotification', 'Shutdown', 'ViewAnyDefinition', 'ViewAnyDatabase', 'ViewServerState', 'ExternalAccessAssembly', 'UnsafeAssembly', 'AlterAnyServerRole', 'CreateServerRole', 'AlterAnyAvailabilityGroup', 'CreateAvailabilityGroup', 'AlterAnyEventSession', 'SelectAllUserSecurables', 'ConnectAnyDatabase', 'ImpersonateAnyLogin', 'administerbulkoperations', 'alteranyserveraudit', 'alteranycredential', 'alteranyconnection', 'alteranydatabase', 'alteranyeventnotification', 'alteranyendpoint', 'alteranylogin', 'alteranylinkedserver', 'alterresources', 'alterserverstate', 'altersettings', 'altertrace', 'authenticateserver', 'controlserver', 'connectsql', 'createanydatabase', 'createddleventnotification', 'createendpoint', 'createtraceeventnotification', 'shutdown', 'viewanydefinition', 'viewanydatabase', 'viewserverstate', 'externalaccessassembly', 'unsafeassembly', 'alteranyserverrole', 'createserverrole', 'alteranyavailabilitygroup', 'createavailabilitygroup', 'alteranyeventsession', 'selectallusersecurables', 'connectanydatabase', 'impersonateanylogin']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'ServerPermission[]',
      mof_is_embedded: true,
    },
    dsc_instancename: {
      type: 'String',
      desc: ' ',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_servername: {
      type: 'Optional[String]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_name: {
      type: 'String',
      desc: ' ',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_credential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_permissiontoinclude: {
      type: "Optional[Array[Struct[{
              permission => Array[Enum['AdministerBulkOperations', 'AlterAnyServerAudit', 'AlterAnyCredential', 'AlterAnyConnection', 'AlterAnyDatabase', 'AlterAnyEventNotification', 'AlterAnyEndpoint', 'AlterAnyLogin', 'AlterAnyLinkedServer', 'AlterResources', 'AlterServerState', 'AlterSettings', 'AlterTrace', 'AuthenticateServer', 'ControlServer', 'ConnectSql', 'CreateAnyDatabase', 'CreateDdlEventNotification', 'CreateEndpoint', 'CreateTraceEventNotification', 'Shutdown', 'ViewAnyDefinition', 'ViewAnyDatabase', 'ViewServerState', 'ExternalAccessAssembly', 'UnsafeAssembly', 'AlterAnyServerRole', 'CreateServerRole', 'AlterAnyAvailabilityGroup', 'CreateAvailabilityGroup', 'AlterAnyEventSession', 'SelectAllUserSecurables', 'ConnectAnyDatabase', 'ImpersonateAnyLogin', 'administerbulkoperations', 'alteranyserveraudit', 'alteranycredential', 'alteranyconnection', 'alteranydatabase', 'alteranyeventnotification', 'alteranyendpoint', 'alteranylogin', 'alteranylinkedserver', 'alterresources', 'alterserverstate', 'altersettings', 'altertrace', 'authenticateserver', 'controlserver', 'connectsql', 'createanydatabase', 'createddleventnotification', 'createendpoint', 'createtraceeventnotification', 'shutdown', 'viewanydefinition', 'viewanydatabase', 'viewserverstate', 'externalaccessassembly', 'unsafeassembly', 'alteranyserverrole', 'createserverrole', 'alteranyavailabilitygroup', 'createavailabilitygroup', 'alteranyeventsession', 'selectallusersecurables', 'connectanydatabase', 'impersonateanylogin']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'ServerPermission[]',
      mof_is_embedded: true,
    },
    dsc_reasons: {
      type: 'Optional[Array[Struct[{
              phrase => Optional[String],
              code => Optional[String],
            }]]]',
      desc: ' ',
      behaviour: :read_only,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Reason[]',
      mof_is_embedded: true,
    },
  },
)
