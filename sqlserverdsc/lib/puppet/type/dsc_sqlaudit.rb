require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_sqlaudit',
  dscmeta_resource_friendly_name: 'SqlAudit',
  dscmeta_resource_name: 'SqlAudit',
  dscmeta_resource_implementation: 'Class',
  dscmeta_module_name: 'SqlServerDsc',
  dscmeta_module_version: '16.0.0',
  docs: 'The DSC SqlAudit resource type.
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
    dsc_servername: {
      type: 'Optional[String]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_maximumrolloverfiles: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_logtype: {
      type: "Optional[Enum['SecurityLog', 'ApplicationLog', 'securitylog', 'applicationlog']]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent', 'present', 'absent']]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_maximumfilesizeunit: {
      type: "Optional[Enum['Megabyte', 'Gigabyte', 'Terabyte', 'megabyte', 'gigabyte', 'terabyte']]",
      desc: ' ',

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
    dsc_maximumfiles: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
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
    dsc_queuedelay: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_onfailure: {
      type: "Optional[Enum['Continue', 'FailOperation', 'Shutdown', 'continue', 'failoperation', 'shutdown']]",
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_auditfilter: {
      type: 'Optional[String]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_reservediskspace: {
      type: 'Optional[Boolean]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enabled: {
      type: 'Optional[Boolean]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_path: {
      type: 'Optional[String]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_maximumfilesize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_auditguid: {
      type: 'Optional[String]',
      desc: ' ',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_force: {
      type: 'Optional[Boolean]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
  },
)
