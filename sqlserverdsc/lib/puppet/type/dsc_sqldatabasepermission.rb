require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqldatabasepermission',
  dscmeta_resource_friendly_name: 'SqlDatabasePermission',
  dscmeta_resource_name: 'SqlDatabasePermission',
  dscmeta_resource_implementation: 'Class',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.5.0',
  docs: 'The DSC SqlDatabasePermission resource type.
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
              permission => Array[Enum['AdministerDatabaseBulkOperations', 'administerdatabasebulkoperations', 'Alter', 'alter', 'AlterAnyApplicationRole', 'alteranyapplicationrole', 'AlterAnyAssembly', 'alteranyassembly', 'AlterAnyAsymmetricKey', 'alteranyasymmetrickey', 'AlterAnyCertificate', 'alteranycertificate', 'AlterAnyColumnEncryptionKey', 'alteranycolumnencryptionkey', 'AlterAnyColumnMasterKey', 'alteranycolumnmasterkey', 'AlterAnyContract', 'alteranycontract', 'AlterAnyDatabaseAudit', 'alteranydatabaseaudit', 'AlterAnyDatabaseDdlTrigger', 'alteranydatabaseddltrigger', 'AlterAnyDatabaseEventNotification', 'alteranydatabaseeventnotification', 'AlterAnyDatabaseEventSession', 'alteranydatabaseeventsession', 'AlterAnyDatabaseEventSessionAddEvent', 'alteranydatabaseeventsessionaddevent', 'AlterAnyDatabaseEventSessionAddTarget', 'alteranydatabaseeventsessionaddtarget', 'AlterAnyDatabaseEventSessionDisable', 'alteranydatabaseeventsessiondisable', 'AlterAnyDatabaseEventSessionDropEvent', 'alteranydatabaseeventsessiondropevent', 'AlterAnyDatabaseEventSessionDropTarget', 'alteranydatabaseeventsessiondroptarget', 'AlterAnyDatabaseEventSessionEnable', 'alteranydatabaseeventsessionenable', 'AlterAnyDatabaseEventSessionOption', 'alteranydatabaseeventsessionoption', 'AlterAnyDatabaseScopedConfiguration', 'alteranydatabasescopedconfiguration', 'AlterAnyDataspace', 'alteranydataspace', 'AlterAnyExternalDataSource', 'alteranyexternaldatasource', 'AlterAnyExternalFileFormat', 'alteranyexternalfileformat', 'AlterAnyExternalJob', 'alteranyexternaljob', 'AlterAnyExternalLanguage', 'alteranyexternallanguage', 'AlterAnyExternalLibrary', 'alteranyexternallibrary', 'AlterAnyExternalStream', 'alteranyexternalstream', 'AlterAnyFulltextCatalog', 'alteranyfulltextcatalog', 'AlterAnyMask', 'alteranymask', 'AlterAnyMessageType', 'alteranymessagetype', 'AlterAnyRemoteServiceBinding', 'alteranyremoteservicebinding', 'AlterAnyRole', 'alteranyrole', 'AlterAnyRoute', 'alteranyroute', 'AlterAnySchema', 'alteranyschema', 'AlterAnySecurityPolicy', 'alteranysecuritypolicy', 'AlterAnySensitivityClassification', 'alteranysensitivityclassification', 'AlterAnyService', 'alteranyservice', 'AlterAnySymmetricKey', 'alteranysymmetrickey', 'AlterAnyUser', 'alteranyuser', 'AlterLedger', 'alterledger', 'AlterLedgerConfiguration', 'alterledgerconfiguration', 'Authenticate', 'authenticate', 'BackupDatabase', 'backupdatabase', 'BackupLog', 'backuplog', 'Checkpoint', 'checkpoint', 'Connect', 'connect', 'ConnectReplication', 'connectreplication', 'Control', 'control', 'CreateAggregate', 'createaggregate', 'CreateAnyDatabaseEventSession', 'createanydatabaseeventsession', 'CreateAssembly', 'createassembly', 'CreateAsymmetricKey', 'createasymmetrickey', 'CreateCertificate', 'createcertificate', 'CreateContract', 'createcontract', 'CreateDatabase', 'createdatabase', 'CreateDatabaseDdlEventNotification', 'createdatabaseddleventnotification', 'CreateDefault', 'createdefault', 'CreateExternalLanguage', 'createexternallanguage', 'CreateExternalLibrary', 'createexternallibrary', 'CreateFulltextCatalog', 'createfulltextcatalog', 'CreateFunction', 'createfunction', 'CreateMessageType', 'createmessagetype', 'CreateProcedure', 'createprocedure', 'CreateQueue', 'createqueue', 'CreateRemoteServiceBinding', 'createremoteservicebinding', 'CreateRole', 'createrole', 'CreateRoute', 'createroute', 'CreateRule', 'createrule', 'CreateSchema', 'createschema', 'CreateService', 'createservice', 'CreateSymmetricKey', 'createsymmetrickey', 'CreateSynonym', 'createsynonym', 'CreateTable', 'createtable', 'CreateType', 'createtype', 'CreateUser', 'createuser', 'CreateView', 'createview', 'CreateXmlSchemaCollection', 'createxmlschemacollection', 'Delete', 'delete', 'DropAnyDatabaseEventSession', 'dropanydatabaseeventsession', 'EnableLedger', 'enableledger', 'Execute', 'execute', 'ExecuteAnyExternalEndpoint', 'executeanyexternalendpoint', 'ExecuteAnyExternalScript', 'executeanyexternalscript', 'Insert', 'insert', 'KillDatabaseConnection', 'killdatabaseconnection', 'OwnershipChaining', 'ownershipchaining', 'References', 'references', 'Select', 'select', 'Showplan', 'showplan', 'SubscribeQueryNotifications', 'subscribequerynotifications', 'TakeOwnership', 'takeownership', 'Unmask', 'unmask', 'Update', 'update', 'ViewAnyColumnEncryptionKeyDefinition', 'viewanycolumnencryptionkeydefinition', 'ViewAnyColumnMasterKeyDefinition', 'viewanycolumnmasterkeydefinition', 'ViewAnySensitivityClassification', 'viewanysensitivityclassification', 'ViewCryptographicallySecuredDefinition', 'viewcryptographicallysecureddefinition', 'ViewDatabasePerformanceState', 'viewdatabaseperformancestate', 'ViewDatabaseSecurityAudit', 'viewdatabasesecurityaudit', 'ViewDatabaseSecurityState', 'viewdatabasesecuritystate', 'ViewDatabaseState', 'viewdatabasestate', 'ViewDefinition', 'viewdefinition', 'ViewLedgerContent', 'viewledgercontent', 'ViewPerformanceDefinition', 'viewperformancedefinition', 'ViewSecurityDefinition', 'viewsecuritydefinition']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
              permission => Array[Enum['AdministerDatabaseBulkOperations', 'administerdatabasebulkoperations', 'Alter', 'alter', 'AlterAnyApplicationRole', 'alteranyapplicationrole', 'AlterAnyAssembly', 'alteranyassembly', 'AlterAnyAsymmetricKey', 'alteranyasymmetrickey', 'AlterAnyCertificate', 'alteranycertificate', 'AlterAnyColumnEncryptionKey', 'alteranycolumnencryptionkey', 'AlterAnyColumnMasterKey', 'alteranycolumnmasterkey', 'AlterAnyContract', 'alteranycontract', 'AlterAnyDatabaseAudit', 'alteranydatabaseaudit', 'AlterAnyDatabaseDdlTrigger', 'alteranydatabaseddltrigger', 'AlterAnyDatabaseEventNotification', 'alteranydatabaseeventnotification', 'AlterAnyDatabaseEventSession', 'alteranydatabaseeventsession', 'AlterAnyDatabaseEventSessionAddEvent', 'alteranydatabaseeventsessionaddevent', 'AlterAnyDatabaseEventSessionAddTarget', 'alteranydatabaseeventsessionaddtarget', 'AlterAnyDatabaseEventSessionDisable', 'alteranydatabaseeventsessiondisable', 'AlterAnyDatabaseEventSessionDropEvent', 'alteranydatabaseeventsessiondropevent', 'AlterAnyDatabaseEventSessionDropTarget', 'alteranydatabaseeventsessiondroptarget', 'AlterAnyDatabaseEventSessionEnable', 'alteranydatabaseeventsessionenable', 'AlterAnyDatabaseEventSessionOption', 'alteranydatabaseeventsessionoption', 'AlterAnyDatabaseScopedConfiguration', 'alteranydatabasescopedconfiguration', 'AlterAnyDataspace', 'alteranydataspace', 'AlterAnyExternalDataSource', 'alteranyexternaldatasource', 'AlterAnyExternalFileFormat', 'alteranyexternalfileformat', 'AlterAnyExternalJob', 'alteranyexternaljob', 'AlterAnyExternalLanguage', 'alteranyexternallanguage', 'AlterAnyExternalLibrary', 'alteranyexternallibrary', 'AlterAnyExternalStream', 'alteranyexternalstream', 'AlterAnyFulltextCatalog', 'alteranyfulltextcatalog', 'AlterAnyMask', 'alteranymask', 'AlterAnyMessageType', 'alteranymessagetype', 'AlterAnyRemoteServiceBinding', 'alteranyremoteservicebinding', 'AlterAnyRole', 'alteranyrole', 'AlterAnyRoute', 'alteranyroute', 'AlterAnySchema', 'alteranyschema', 'AlterAnySecurityPolicy', 'alteranysecuritypolicy', 'AlterAnySensitivityClassification', 'alteranysensitivityclassification', 'AlterAnyService', 'alteranyservice', 'AlterAnySymmetricKey', 'alteranysymmetrickey', 'AlterAnyUser', 'alteranyuser', 'AlterLedger', 'alterledger', 'AlterLedgerConfiguration', 'alterledgerconfiguration', 'Authenticate', 'authenticate', 'BackupDatabase', 'backupdatabase', 'BackupLog', 'backuplog', 'Checkpoint', 'checkpoint', 'Connect', 'connect', 'ConnectReplication', 'connectreplication', 'Control', 'control', 'CreateAggregate', 'createaggregate', 'CreateAnyDatabaseEventSession', 'createanydatabaseeventsession', 'CreateAssembly', 'createassembly', 'CreateAsymmetricKey', 'createasymmetrickey', 'CreateCertificate', 'createcertificate', 'CreateContract', 'createcontract', 'CreateDatabase', 'createdatabase', 'CreateDatabaseDdlEventNotification', 'createdatabaseddleventnotification', 'CreateDefault', 'createdefault', 'CreateExternalLanguage', 'createexternallanguage', 'CreateExternalLibrary', 'createexternallibrary', 'CreateFulltextCatalog', 'createfulltextcatalog', 'CreateFunction', 'createfunction', 'CreateMessageType', 'createmessagetype', 'CreateProcedure', 'createprocedure', 'CreateQueue', 'createqueue', 'CreateRemoteServiceBinding', 'createremoteservicebinding', 'CreateRole', 'createrole', 'CreateRoute', 'createroute', 'CreateRule', 'createrule', 'CreateSchema', 'createschema', 'CreateService', 'createservice', 'CreateSymmetricKey', 'createsymmetrickey', 'CreateSynonym', 'createsynonym', 'CreateTable', 'createtable', 'CreateType', 'createtype', 'CreateUser', 'createuser', 'CreateView', 'createview', 'CreateXmlSchemaCollection', 'createxmlschemacollection', 'Delete', 'delete', 'DropAnyDatabaseEventSession', 'dropanydatabaseeventsession', 'EnableLedger', 'enableledger', 'Execute', 'execute', 'ExecuteAnyExternalEndpoint', 'executeanyexternalendpoint', 'ExecuteAnyExternalScript', 'executeanyexternalscript', 'Insert', 'insert', 'KillDatabaseConnection', 'killdatabaseconnection', 'OwnershipChaining', 'ownershipchaining', 'References', 'references', 'Select', 'select', 'Showplan', 'showplan', 'SubscribeQueryNotifications', 'subscribequerynotifications', 'TakeOwnership', 'takeownership', 'Unmask', 'unmask', 'Update', 'update', 'ViewAnyColumnEncryptionKeyDefinition', 'viewanycolumnencryptionkeydefinition', 'ViewAnyColumnMasterKeyDefinition', 'viewanycolumnmasterkeydefinition', 'ViewAnySensitivityClassification', 'viewanysensitivityclassification', 'ViewCryptographicallySecuredDefinition', 'viewcryptographicallysecureddefinition', 'ViewDatabasePerformanceState', 'viewdatabaseperformancestate', 'ViewDatabaseSecurityAudit', 'viewdatabasesecurityaudit', 'ViewDatabaseSecurityState', 'viewdatabasesecuritystate', 'ViewDatabaseState', 'viewdatabasestate', 'ViewDefinition', 'viewdefinition', 'ViewLedgerContent', 'viewledgercontent', 'ViewPerformanceDefinition', 'viewperformancedefinition', 'ViewSecurityDefinition', 'viewsecuritydefinition']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
              permission => Array[Enum['AdministerDatabaseBulkOperations', 'administerdatabasebulkoperations', 'Alter', 'alter', 'AlterAnyApplicationRole', 'alteranyapplicationrole', 'AlterAnyAssembly', 'alteranyassembly', 'AlterAnyAsymmetricKey', 'alteranyasymmetrickey', 'AlterAnyCertificate', 'alteranycertificate', 'AlterAnyColumnEncryptionKey', 'alteranycolumnencryptionkey', 'AlterAnyColumnMasterKey', 'alteranycolumnmasterkey', 'AlterAnyContract', 'alteranycontract', 'AlterAnyDatabaseAudit', 'alteranydatabaseaudit', 'AlterAnyDatabaseDdlTrigger', 'alteranydatabaseddltrigger', 'AlterAnyDatabaseEventNotification', 'alteranydatabaseeventnotification', 'AlterAnyDatabaseEventSession', 'alteranydatabaseeventsession', 'AlterAnyDatabaseEventSessionAddEvent', 'alteranydatabaseeventsessionaddevent', 'AlterAnyDatabaseEventSessionAddTarget', 'alteranydatabaseeventsessionaddtarget', 'AlterAnyDatabaseEventSessionDisable', 'alteranydatabaseeventsessiondisable', 'AlterAnyDatabaseEventSessionDropEvent', 'alteranydatabaseeventsessiondropevent', 'AlterAnyDatabaseEventSessionDropTarget', 'alteranydatabaseeventsessiondroptarget', 'AlterAnyDatabaseEventSessionEnable', 'alteranydatabaseeventsessionenable', 'AlterAnyDatabaseEventSessionOption', 'alteranydatabaseeventsessionoption', 'AlterAnyDatabaseScopedConfiguration', 'alteranydatabasescopedconfiguration', 'AlterAnyDataspace', 'alteranydataspace', 'AlterAnyExternalDataSource', 'alteranyexternaldatasource', 'AlterAnyExternalFileFormat', 'alteranyexternalfileformat', 'AlterAnyExternalJob', 'alteranyexternaljob', 'AlterAnyExternalLanguage', 'alteranyexternallanguage', 'AlterAnyExternalLibrary', 'alteranyexternallibrary', 'AlterAnyExternalStream', 'alteranyexternalstream', 'AlterAnyFulltextCatalog', 'alteranyfulltextcatalog', 'AlterAnyMask', 'alteranymask', 'AlterAnyMessageType', 'alteranymessagetype', 'AlterAnyRemoteServiceBinding', 'alteranyremoteservicebinding', 'AlterAnyRole', 'alteranyrole', 'AlterAnyRoute', 'alteranyroute', 'AlterAnySchema', 'alteranyschema', 'AlterAnySecurityPolicy', 'alteranysecuritypolicy', 'AlterAnySensitivityClassification', 'alteranysensitivityclassification', 'AlterAnyService', 'alteranyservice', 'AlterAnySymmetricKey', 'alteranysymmetrickey', 'AlterAnyUser', 'alteranyuser', 'AlterLedger', 'alterledger', 'AlterLedgerConfiguration', 'alterledgerconfiguration', 'Authenticate', 'authenticate', 'BackupDatabase', 'backupdatabase', 'BackupLog', 'backuplog', 'Checkpoint', 'checkpoint', 'Connect', 'connect', 'ConnectReplication', 'connectreplication', 'Control', 'control', 'CreateAggregate', 'createaggregate', 'CreateAnyDatabaseEventSession', 'createanydatabaseeventsession', 'CreateAssembly', 'createassembly', 'CreateAsymmetricKey', 'createasymmetrickey', 'CreateCertificate', 'createcertificate', 'CreateContract', 'createcontract', 'CreateDatabase', 'createdatabase', 'CreateDatabaseDdlEventNotification', 'createdatabaseddleventnotification', 'CreateDefault', 'createdefault', 'CreateExternalLanguage', 'createexternallanguage', 'CreateExternalLibrary', 'createexternallibrary', 'CreateFulltextCatalog', 'createfulltextcatalog', 'CreateFunction', 'createfunction', 'CreateMessageType', 'createmessagetype', 'CreateProcedure', 'createprocedure', 'CreateQueue', 'createqueue', 'CreateRemoteServiceBinding', 'createremoteservicebinding', 'CreateRole', 'createrole', 'CreateRoute', 'createroute', 'CreateRule', 'createrule', 'CreateSchema', 'createschema', 'CreateService', 'createservice', 'CreateSymmetricKey', 'createsymmetrickey', 'CreateSynonym', 'createsynonym', 'CreateTable', 'createtable', 'CreateType', 'createtype', 'CreateUser', 'createuser', 'CreateView', 'createview', 'CreateXmlSchemaCollection', 'createxmlschemacollection', 'Delete', 'delete', 'DropAnyDatabaseEventSession', 'dropanydatabaseeventsession', 'EnableLedger', 'enableledger', 'Execute', 'execute', 'ExecuteAnyExternalEndpoint', 'executeanyexternalendpoint', 'ExecuteAnyExternalScript', 'executeanyexternalscript', 'Insert', 'insert', 'KillDatabaseConnection', 'killdatabaseconnection', 'OwnershipChaining', 'ownershipchaining', 'References', 'references', 'Select', 'select', 'Showplan', 'showplan', 'SubscribeQueryNotifications', 'subscribequerynotifications', 'TakeOwnership', 'takeownership', 'Unmask', 'unmask', 'Update', 'update', 'ViewAnyColumnEncryptionKeyDefinition', 'viewanycolumnencryptionkeydefinition', 'ViewAnyColumnMasterKeyDefinition', 'viewanycolumnmasterkeydefinition', 'ViewAnySensitivityClassification', 'viewanysensitivityclassification', 'ViewCryptographicallySecuredDefinition', 'viewcryptographicallysecureddefinition', 'ViewDatabasePerformanceState', 'viewdatabaseperformancestate', 'ViewDatabaseSecurityAudit', 'viewdatabasesecurityaudit', 'ViewDatabaseSecurityState', 'viewdatabasesecuritystate', 'ViewDatabaseState', 'viewdatabasestate', 'ViewDefinition', 'viewdefinition', 'ViewLedgerContent', 'viewledgercontent', 'ViewPerformanceDefinition', 'viewperformancedefinition', 'ViewSecurityDefinition', 'viewsecuritydefinition']],
              state => Enum['Grant', 'grant', 'GrantWithGrant', 'grantwithgrant', 'Deny', 'deny']
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
