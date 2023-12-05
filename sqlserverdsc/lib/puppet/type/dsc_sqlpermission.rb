require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlpermission',
  dscmeta_resource_friendly_name: 'SqlPermission',
  dscmeta_resource_name: 'SqlPermission',
  dscmeta_resource_implementation: 'Class',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlPermission resource type.
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
    dsc_permission: {
      type: "Optional[Array[Struct[{
              permission => Array[Enum['AdministerBulkOperations', 'administerbulkoperations', 'AlterAnyServerAudit', 'alteranyserveraudit', 'AlterAnyCredential', 'alteranycredential', 'AlterAnyConnection', 'alteranyconnection', 'AlterAnyDatabase', 'alteranydatabase', 'AlterAnyEventNotification', 'alteranyeventnotification', 'AlterAnyEndpoint', 'alteranyendpoint', 'AlterAnyLogin', 'alteranylogin', 'AlterAnyLinkedServer', 'alteranylinkedserver', 'AlterResources', 'alterresources', 'AlterServerState', 'alterserverstate', 'AlterSettings', 'altersettings', 'AlterTrace', 'altertrace', 'AuthenticateServer', 'authenticateserver', 'ControlServer', 'controlserver', 'ConnectSql', 'connectsql', 'CreateAnyDatabase', 'createanydatabase', 'CreateDdlEventNotification', 'createddleventnotification', 'CreateEndpoint', 'createendpoint', 'CreateTraceEventNotification', 'createtraceeventnotification', 'Shutdown', 'shutdown', 'ViewAnyDefinition', 'viewanydefinition', 'ViewAnyDatabase', 'viewanydatabase', 'ViewServerState', 'viewserverstate', 'ExternalAccessAssembly', 'externalaccessassembly', 'UnsafeAssembly', 'unsafeassembly', 'AlterAnyServerRole', 'alteranyserverrole', 'CreateServerRole', 'createserverrole', 'AlterAnyAvailabilityGroup', 'alteranyavailabilitygroup', 'CreateAvailabilityGroup', 'createavailabilitygroup', 'AlterAnyEventSession', 'alteranyeventsession', 'SelectAllUserSecurables', 'selectallusersecurables', 'ConnectAnyDatabase', 'connectanydatabase', 'ImpersonateAnyLogin', 'impersonateanylogin']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
              permission => Array[Enum['AdministerBulkOperations', 'administerbulkoperations', 'AlterAnyServerAudit', 'alteranyserveraudit', 'AlterAnyCredential', 'alteranycredential', 'AlterAnyConnection', 'alteranyconnection', 'AlterAnyDatabase', 'alteranydatabase', 'AlterAnyEventNotification', 'alteranyeventnotification', 'AlterAnyEndpoint', 'alteranyendpoint', 'AlterAnyLogin', 'alteranylogin', 'AlterAnyLinkedServer', 'alteranylinkedserver', 'AlterResources', 'alterresources', 'AlterServerState', 'alterserverstate', 'AlterSettings', 'altersettings', 'AlterTrace', 'altertrace', 'AuthenticateServer', 'authenticateserver', 'ControlServer', 'controlserver', 'ConnectSql', 'connectsql', 'CreateAnyDatabase', 'createanydatabase', 'CreateDdlEventNotification', 'createddleventnotification', 'CreateEndpoint', 'createendpoint', 'CreateTraceEventNotification', 'createtraceeventnotification', 'Shutdown', 'shutdown', 'ViewAnyDefinition', 'viewanydefinition', 'ViewAnyDatabase', 'viewanydatabase', 'ViewServerState', 'viewserverstate', 'ExternalAccessAssembly', 'externalaccessassembly', 'UnsafeAssembly', 'unsafeassembly', 'AlterAnyServerRole', 'alteranyserverrole', 'CreateServerRole', 'createserverrole', 'AlterAnyAvailabilityGroup', 'alteranyavailabilitygroup', 'CreateAvailabilityGroup', 'createavailabilitygroup', 'AlterAnyEventSession', 'alteranyeventsession', 'SelectAllUserSecurables', 'selectallusersecurables', 'ConnectAnyDatabase', 'connectanydatabase', 'ImpersonateAnyLogin', 'impersonateanylogin']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
              permission => Array[Enum['AdministerBulkOperations', 'administerbulkoperations', 'AlterAnyServerAudit', 'alteranyserveraudit', 'AlterAnyCredential', 'alteranycredential', 'AlterAnyConnection', 'alteranyconnection', 'AlterAnyDatabase', 'alteranydatabase', 'AlterAnyEventNotification', 'alteranyeventnotification', 'AlterAnyEndpoint', 'alteranyendpoint', 'AlterAnyLogin', 'alteranylogin', 'AlterAnyLinkedServer', 'alteranylinkedserver', 'AlterResources', 'alterresources', 'AlterServerState', 'alterserverstate', 'AlterSettings', 'altersettings', 'AlterTrace', 'altertrace', 'AuthenticateServer', 'authenticateserver', 'ControlServer', 'controlserver', 'ConnectSql', 'connectsql', 'CreateAnyDatabase', 'createanydatabase', 'CreateDdlEventNotification', 'createddleventnotification', 'CreateEndpoint', 'createendpoint', 'CreateTraceEventNotification', 'createtraceeventnotification', 'Shutdown', 'shutdown', 'ViewAnyDefinition', 'viewanydefinition', 'ViewAnyDatabase', 'viewanydatabase', 'ViewServerState', 'viewserverstate', 'ExternalAccessAssembly', 'externalaccessassembly', 'UnsafeAssembly', 'unsafeassembly', 'AlterAnyServerRole', 'alteranyserverrole', 'CreateServerRole', 'createserverrole', 'AlterAnyAvailabilityGroup', 'alteranyavailabilitygroup', 'CreateAvailabilityGroup', 'createavailabilitygroup', 'AlterAnyEventSession', 'alteranyeventsession', 'SelectAllUserSecurables', 'selectallusersecurables', 'ConnectAnyDatabase', 'connectanydatabase', 'ImpersonateAnyLogin', 'impersonateanylogin']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
      mof_type: 'SqlReason[]',
      mof_is_embedded: true,
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
