require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabasepermission',
  dscmeta_resource_friendly_name: 'SqlDatabasePermission',
  dscmeta_resource_name: 'SqlDatabasePermission',
  dscmeta_resource_implementation: 'Class',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlDatabasePermission resource type.
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
              permission => Array[Enum['Alter', 'AlterAnyAsymmetricKey', 'AlterAnyApplicationRole', 'AlterAnyAssembly', 'AlterAnyCertificate', 'AlterAnyDatabaseAudit', 'AlterAnyDataspace', 'AlterAnyDatabaseEventNotification', 'AlterAnyExternalDataSource', 'AlterAnyExternalFileFormat', 'AlterAnyFulltextCatalog', 'AlterAnyMask', 'AlterAnyMessageType', 'AlterAnyRole', 'AlterAnyRoute', 'AlterAnyRemoteServiceBinding', 'AlterAnyContract', 'AlterAnySymmetricKey', 'AlterAnySchema', 'AlterAnySecurityPolicy', 'AlterAnyService', 'AlterAnyDatabaseDdlTrigger', 'AlterAnyUser', 'Authenticate', 'BackupDatabase', 'BackupLog', 'Control', 'Connect', 'ConnectReplication', 'Checkpoint', 'CreateAggregate', 'CreateAsymmetricKey', 'CreateAssembly', 'CreateCertificate', 'CreateDatabase', 'CreateDefault', 'CreateDatabaseDdlEventNotification', 'CreateFunction', 'CreateFulltextCatalog', 'CreateMessageType', 'CreateProcedure', 'CreateQueue', 'CreateRole', 'CreateRoute', 'CreateRule', 'CreateRemoteServiceBinding', 'CreateContract', 'CreateSymmetricKey', 'CreateSchema', 'CreateSynonym', 'CreateService', 'CreateTable', 'CreateType', 'CreateView', 'CreateXmlSchemaCollection', 'Delete', 'Execute', 'Insert', 'References', 'Select', 'Showplan', 'SubscribeQueryNotifications', 'TakeOwnership', 'Unmask', 'Update', 'ViewDefinition', 'ViewDatabaseState', 'alter', 'alteranyasymmetrickey', 'alteranyapplicationrole', 'alteranyassembly', 'alteranycertificate', 'alteranydatabaseaudit', 'alteranydataspace', 'alteranydatabaseeventnotification', 'alteranyexternaldatasource', 'alteranyexternalfileformat', 'alteranyfulltextcatalog', 'alteranymask', 'alteranymessagetype', 'alteranyrole', 'alteranyroute', 'alteranyremoteservicebinding', 'alteranycontract', 'alteranysymmetrickey', 'alteranyschema', 'alteranysecuritypolicy', 'alteranyservice', 'alteranydatabaseddltrigger', 'alteranyuser', 'authenticate', 'backupdatabase', 'backuplog', 'control', 'connect', 'connectreplication', 'checkpoint', 'createaggregate', 'createasymmetrickey', 'createassembly', 'createcertificate', 'createdatabase', 'createdefault', 'createdatabaseddleventnotification', 'createfunction', 'createfulltextcatalog', 'createmessagetype', 'createprocedure', 'createqueue', 'createrole', 'createroute', 'createrule', 'createremoteservicebinding', 'createcontract', 'createsymmetrickey', 'createschema', 'createsynonym', 'createservice', 'createtable', 'createtype', 'createview', 'createxmlschemacollection', 'delete', 'execute', 'insert', 'references', 'select', 'showplan', 'subscribequerynotifications', 'takeownership', 'unmask', 'update', 'viewdefinition', 'viewdatabasestate']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'DatabasePermission[]',
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
              permission => Array[Enum['Alter', 'AlterAnyAsymmetricKey', 'AlterAnyApplicationRole', 'AlterAnyAssembly', 'AlterAnyCertificate', 'AlterAnyDatabaseAudit', 'AlterAnyDataspace', 'AlterAnyDatabaseEventNotification', 'AlterAnyExternalDataSource', 'AlterAnyExternalFileFormat', 'AlterAnyFulltextCatalog', 'AlterAnyMask', 'AlterAnyMessageType', 'AlterAnyRole', 'AlterAnyRoute', 'AlterAnyRemoteServiceBinding', 'AlterAnyContract', 'AlterAnySymmetricKey', 'AlterAnySchema', 'AlterAnySecurityPolicy', 'AlterAnyService', 'AlterAnyDatabaseDdlTrigger', 'AlterAnyUser', 'Authenticate', 'BackupDatabase', 'BackupLog', 'Control', 'Connect', 'ConnectReplication', 'Checkpoint', 'CreateAggregate', 'CreateAsymmetricKey', 'CreateAssembly', 'CreateCertificate', 'CreateDatabase', 'CreateDefault', 'CreateDatabaseDdlEventNotification', 'CreateFunction', 'CreateFulltextCatalog', 'CreateMessageType', 'CreateProcedure', 'CreateQueue', 'CreateRole', 'CreateRoute', 'CreateRule', 'CreateRemoteServiceBinding', 'CreateContract', 'CreateSymmetricKey', 'CreateSchema', 'CreateSynonym', 'CreateService', 'CreateTable', 'CreateType', 'CreateView', 'CreateXmlSchemaCollection', 'Delete', 'Execute', 'Insert', 'References', 'Select', 'Showplan', 'SubscribeQueryNotifications', 'TakeOwnership', 'Unmask', 'Update', 'ViewDefinition', 'ViewDatabaseState', 'alter', 'alteranyasymmetrickey', 'alteranyapplicationrole', 'alteranyassembly', 'alteranycertificate', 'alteranydatabaseaudit', 'alteranydataspace', 'alteranydatabaseeventnotification', 'alteranyexternaldatasource', 'alteranyexternalfileformat', 'alteranyfulltextcatalog', 'alteranymask', 'alteranymessagetype', 'alteranyrole', 'alteranyroute', 'alteranyremoteservicebinding', 'alteranycontract', 'alteranysymmetrickey', 'alteranyschema', 'alteranysecuritypolicy', 'alteranyservice', 'alteranydatabaseddltrigger', 'alteranyuser', 'authenticate', 'backupdatabase', 'backuplog', 'control', 'connect', 'connectreplication', 'checkpoint', 'createaggregate', 'createasymmetrickey', 'createassembly', 'createcertificate', 'createdatabase', 'createdefault', 'createdatabaseddleventnotification', 'createfunction', 'createfulltextcatalog', 'createmessagetype', 'createprocedure', 'createqueue', 'createrole', 'createroute', 'createrule', 'createremoteservicebinding', 'createcontract', 'createsymmetrickey', 'createschema', 'createsynonym', 'createservice', 'createtable', 'createtype', 'createview', 'createxmlschemacollection', 'delete', 'execute', 'insert', 'references', 'select', 'showplan', 'subscribequerynotifications', 'takeownership', 'unmask', 'update', 'viewdefinition', 'viewdatabasestate']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'DatabasePermission[]',
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
    dsc_databasename: {
      type: 'String',
      desc: ' ',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
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
              permission => Array[Enum['Alter', 'AlterAnyAsymmetricKey', 'AlterAnyApplicationRole', 'AlterAnyAssembly', 'AlterAnyCertificate', 'AlterAnyDatabaseAudit', 'AlterAnyDataspace', 'AlterAnyDatabaseEventNotification', 'AlterAnyExternalDataSource', 'AlterAnyExternalFileFormat', 'AlterAnyFulltextCatalog', 'AlterAnyMask', 'AlterAnyMessageType', 'AlterAnyRole', 'AlterAnyRoute', 'AlterAnyRemoteServiceBinding', 'AlterAnyContract', 'AlterAnySymmetricKey', 'AlterAnySchema', 'AlterAnySecurityPolicy', 'AlterAnyService', 'AlterAnyDatabaseDdlTrigger', 'AlterAnyUser', 'Authenticate', 'BackupDatabase', 'BackupLog', 'Control', 'Connect', 'ConnectReplication', 'Checkpoint', 'CreateAggregate', 'CreateAsymmetricKey', 'CreateAssembly', 'CreateCertificate', 'CreateDatabase', 'CreateDefault', 'CreateDatabaseDdlEventNotification', 'CreateFunction', 'CreateFulltextCatalog', 'CreateMessageType', 'CreateProcedure', 'CreateQueue', 'CreateRole', 'CreateRoute', 'CreateRule', 'CreateRemoteServiceBinding', 'CreateContract', 'CreateSymmetricKey', 'CreateSchema', 'CreateSynonym', 'CreateService', 'CreateTable', 'CreateType', 'CreateView', 'CreateXmlSchemaCollection', 'Delete', 'Execute', 'Insert', 'References', 'Select', 'Showplan', 'SubscribeQueryNotifications', 'TakeOwnership', 'Unmask', 'Update', 'ViewDefinition', 'ViewDatabaseState', 'alter', 'alteranyasymmetrickey', 'alteranyapplicationrole', 'alteranyassembly', 'alteranycertificate', 'alteranydatabaseaudit', 'alteranydataspace', 'alteranydatabaseeventnotification', 'alteranyexternaldatasource', 'alteranyexternalfileformat', 'alteranyfulltextcatalog', 'alteranymask', 'alteranymessagetype', 'alteranyrole', 'alteranyroute', 'alteranyremoteservicebinding', 'alteranycontract', 'alteranysymmetrickey', 'alteranyschema', 'alteranysecuritypolicy', 'alteranyservice', 'alteranydatabaseddltrigger', 'alteranyuser', 'authenticate', 'backupdatabase', 'backuplog', 'control', 'connect', 'connectreplication', 'checkpoint', 'createaggregate', 'createasymmetrickey', 'createassembly', 'createcertificate', 'createdatabase', 'createdefault', 'createdatabaseddleventnotification', 'createfunction', 'createfulltextcatalog', 'createmessagetype', 'createprocedure', 'createqueue', 'createrole', 'createroute', 'createrule', 'createremoteservicebinding', 'createcontract', 'createsymmetrickey', 'createschema', 'createsynonym', 'createservice', 'createtable', 'createtype', 'createview', 'createxmlschemacollection', 'delete', 'execute', 'insert', 'references', 'select', 'showplan', 'subscribequerynotifications', 'takeownership', 'unmask', 'update', 'viewdefinition', 'viewdatabasestate']],
              state => Enum['Grant', 'GrantWithGrant', 'Deny', 'grant', 'grantwithgrant', 'deny']
            }]]]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'DatabasePermission[]',
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
