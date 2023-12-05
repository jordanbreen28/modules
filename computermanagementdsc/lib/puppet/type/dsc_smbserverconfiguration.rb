require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_smbserverconfiguration',
  dscmeta_resource_friendly_name: 'SmbServerConfiguration',
  dscmeta_resource_name: 'DSC_SmbServerConfiguration',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'ComputerManagementDsc',
  dscmeta_module_version: '9.0.0',
  docs: 'The DSC SmbServerConfiguration resource type.
         Automatically generated from version 9.0.0',
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
    dsc_autodisconnecttimeout: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the auto disconnect time-out.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_smbservernamehardeninglevel: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the SMB Service name hardening level.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_announceserver: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether this server announces itself by using browser announcements.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enableoplocks: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the opportunistic locks are enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_irpstacksize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the default IRP stack size.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_encryptdata: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the sessions established on this server are encrypted.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_rejectunencryptedaccess: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the client that does not support encryption is denied access if it attempts to connect to an encrypted share.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_validatesharescopenotaliased: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the share scope being aliased is validated.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_cachedopenlimit: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum number of cached open files.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_smb2creditsmin: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the minimum SMB2 credits.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_validatetargetname: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the target name is validated.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enablesecuritysignature: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the security signature is enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_issingleinstance: {
      type: "Enum['Yes', 'yes']",
      desc: "Specifies the resource is a single instance, the value must be 'Yes'",

      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_enableauthenticateusersharing: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether authenticate user sharing is enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_pendingclienttimeoutinseconds: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the pending client time-out period, in seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_autoshareserver: {
      type: 'Optional[Boolean]',
      desc: 'Specifies that the default server shares are shared out.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enablestrictnamechecking: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the server should perform strict name checking on incoming connects.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_smb2creditsmax: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum SMB2 credits.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_enabledownleveltimewarp: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether down-level timewarp support is disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_durablehandlev2timeoutinseconds: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the durable handle v2 time-out period, in seconds.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_maxworkitems: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum SMB1 work items.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_enablesmb1protocol: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the SMB1 protocol is enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_nullsessionpipes: {
      type: 'Optional[String]',
      desc: 'Specifies the null session pipes.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_enableleasing: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether leasing is disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enablesmb2protocol: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the SMB2 protocol is enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_keepalivetime: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the keep alive time.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_maxthreadsperqueue: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum threads per queue.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_nullsessionshares: {
      type: 'Optional[String]',
      desc: 'Specifies the null session shares.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_asynchronouscredits: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the asynchronous credits.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_treathostasstablestorage: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the host is treated as the stable storage.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enablemultichannel: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether multi-channel is disabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_oplockbreakwait: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies how long the create caller waits for an opportunistic lock break.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_requiresecuritysignature: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the security signature is required.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_announcecomment: {
      type: 'Optional[String]',
      desc: 'Specifies the announce comment string.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_validatesharescope: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the existence of share scopes is checked during share creation.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_autoshareworkstation: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the default workstation shares are shared out.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
    dsc_maxsessionperconnection: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum sessions per connection.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_auditsmb1access: {
      type: 'Optional[Boolean]',
      desc: 'Enables auditing of SMB version 1 protocol in Windows Event Log.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_maxchannelpersession: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum channels per session.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_serverhidden: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the server announces itself.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_enableforcedlogoff: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether forced logoff is enabled.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_maxmpxcount: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the maximum MPX count for SMB1.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_validatealiasnotcircular: {
      type: 'Optional[Boolean]',
      desc: 'Specifies whether the aliases that are not circular are validated.',


      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
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
