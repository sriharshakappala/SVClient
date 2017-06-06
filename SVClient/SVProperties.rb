#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'pry'

require_relative './SVTags'
require_relative './SVType'

# =Overview
# This class contains values of parameters required to perform transactions with QwikCilver Server.
# Create an instance of this class, Populate the necessary parameters and pass it as a parameter to GCWebPos.initlibrary() method.
#
# GCWebPos.initlibrary() method returns an instance of this class which contains values of parameters provided by QwikCilver Server.
# The values contained in the returned object MUST be provided to each operation that needs to be performed with the QwikCilver Server
class SVProperties

  protected
  attr_accessor :parameters

  private
  @@DEFAULT_CONNECTION_TIMEOUT = 17000
  @@CONNECTION_TIMEOUT = 'connectionTimeout'
  @@TRANSACTION_TIMEOUT = 'transactionTimeout'
  @@SVTYPE = 'svType'
  @@SERVER_URL = 'serverURL'
  @@ERROR_CODE = 'errorCode'
  @@ERROR_MESSAGE = 'errorMessage'

  def getvalue(key)
    return nil if (key == nil)
    return @parameters[key]
  end

  def setvalue(key, value = nil)
    @parameters[key] = value
  end

  def update(src)
    src.each { |key, value|
      setvalue(key, value)
    }
  end

  public
  def initialize(src = nil)
    @parameters = Hash.new
    setvalue(@@CONNECTION_TIMEOUT, @@DEFAULT_CONNECTION_TIMEOUT)
    setvalue(@@TRANSACTION_TIMEOUT, @@DEFAULT_CONNECTION_TIMEOUT)
    setvalue(SVTags::TERMINAL_APP_VERSION, '0101')
    update(src) if (src != nil)
    setvalue(@@SVTYPE, SVType::WEBPOS_GIFTCARD)
  end

  # ===return
  # String - the Forwarding Entity ID
  def getforwardingentityid
    return getvalue(SVTags::FORWARDING_ENTITY_ID)
  end

  # The value for this is pre-assigned by QwikCilver and provided to the Caller
  #
  # ===param
  # String - Forwarding entity ID
  def setforwardingentityid(value)
    setvalue(SVTags::FORWARDING_ENTITY_ID, value)
  end

  # ===return
  # String - The ForwardingEntityPassword
  def getforwardingentitypassword
    return getvalue(SVTags::FORWARDING_ENTITY_PASSWORD)
  end

  # The value for this is pre-assigned by QwikCilver and provided to the Caller
  #
  # ===param
  # String - Forwarding Entity Password
  def setforwardingentitypassword(value)
    setvalue(SVTags::FORWARDING_ENTITY_PASSWORD, value)
  end

  # ===return
  # String - The Server URL
  def getserverurl
    return getvalue(@@SERVER_URL)
  end

  # The value for this is pre-assigned by QwikCilver and provided to the Caller
  #
  # ===param
  # String - Server URL
  def setserverurl(value)
    setvalue(@@SERVER_URL, value)
  end

  # ===return
  # String - the Connection Timeout
  def getconnectiontimeout()
    return getvalue(@@CONNECTION_TIMEOUT)
  end

  # Set the Time Out value (in seconds) used for connections to QwikCilver Server.
  # The value for this should have been pre-approved by QwikCilver
  #
  # ===param
  # String - The Time Out value (in seconds) used for connections to QwikCilver Server
  def setconnectiontimeout(timeout)
    setvalue(@@CONNECTION_TIMEOUT, timeout)
  end

  # ===return
  # String - The TransactionTimeout
  def gettransactiontimeout()
    return getvalue(@@TRANSACTION_TIMEOUT)
  end

  # Set the Time Out value (in seconds) used for connections to QwikCilver Server.
  # The value for this should have been pre-approved by QwikCilver
  #
  # ===param
  # String - The Time Out value (in seconds) used for connections to QwikCilver Server
  def settransactiontimeout(timeout)
    setvalue(@@TRANSACTION_TIMEOUT, timeout)
  end

  # ===return string - the acquirerId
  def getacquirerid()
    return getvalue(SVTags::ACQUIRER_ID)
  end

  # The value for this is pre-assigned by QwikCilver and provided to the Caller
  #
  # ===param
  # String - Acquirer Id
  def setacquirerid(value)
    setvalue(SVTags::ACQUIRER_ID, value)
  end

  # ===return
  # String - The username
  def getusername()
    return getvalue(SVTags::USER_ID)
  end

  # ===param
  # String - username
  def setusername(value)
    setvalue(SVTags::USER_ID, value)
  end


  # ===return
  # String - the password
  def getpassword()
    return getvalue(SVTags::PASSWORD)
  end

  # ===param
  # String - password
  def setpassword(value)
    setvalue(SVTags::PASSWORD, value)
  end


  # ===return
  # String - The Terminal ID
  def getterminalid()
    return getvalue(SVTags::TERMINAL_ID)
  end

  # ===param
  # String - Terminal ID
  def setterminalid(value)
    setvalue(SVTags::TERMINAL_ID, value)
  end

  # ===return
  # String - The Terminal App Version
  def getterminalappversion()
    return getvalue(SVTags::TERMINAL_APP_VERSION)
  end

  # ===param
  # String - The Terminal App Version
  def setterminalappversion(value)
    setvalue(SVTags::TERMINAL_APP_VERSION, value)
  end

  # ===return
  # String - The Merchant Outlet Name
  def getmerchantoutletname()
    return getvalue(SVTags::MERCHANT_OUTLET_NAME)
  end

  # ===param
  # String - Merchant Outlet Name
  def setmerchantoutletname(value)
    setvalue(SVTags::MERCHANT_OUTLET_NAME, value)
  end

  # ===return
  # String - The Organization Name
  def getorganizationname()
    return getvalue(SVTags::ORGANIZATION_NAME)
  end

  # ===param
  # String - Organization Name
  def setorganizationname(value)
    setvalue(SVTags::ORGANIZATION_NAME, value)
  end

  # ===return
  # String - The Pos Name
  def getposname()
    return getvalue(SVTags::POS_NAME)
  end

  # ===param
  # String - Pos Name
  def setposname(value)
    setvalue(SVTags::POS_NAME, value)
  end

  # ===return
  # String - The Track Data
  def gettrackdata()
    return getvalue(SVTags::TRACK_DATA)
  end

  # ===param
  # String - Track Data
  def settrackdata(value)
    setvalue(SVTags::TRACK_DATA, value)
  end

  # ===return
  # String - The Current Batch Number
  def getcurrentbatchnumber()
    return getvalue(SVTags::CURRENT_BATCH_NUMBER)
  end

  # ===param
  # String - Current Batch Number
  def setcurrentbatchnumber(value)
    setvalue(SVTags::CURRENT_BATCH_NUMBER, value)
  end

  # ===return
  # String - The Transaction ID
  def gettransactionid()
    return getvalue(SVTags::TRANSACTION_ID)
  end

  # ===param
  # String - Transaction ID
  def settransactionid(transactionId)
    setvalue(SVTags::TRANSACTION_ID, transactionId)
  end

  # ===return
  # String - The Pos Type ID
  def getpostypeid()
    return getvalue(SVTags::POS_TYPE_ID)
  end

  # ===param
  # String - POS Type ID
  def setpostypeid(value)
    setvalue(SVTags::POS_TYPE_ID, value)
  end

  # ===return
  # String - The Pos Entry Mode
  def getposentrymode()
    return getvalue(SVTags::POS_ENTRY_MODE)
  end

  # ===param
  # String - POS Entry Mode
  def setposentrymode(value)
    setvalue(SVTags::POS_ENTRY_MODE, value)
  end

  # ===return
  # String - The Merchant Name
  def getmerchantname()
    return getvalue(SVTags::MERCHANT_NAME)
  end

  # ===param
  # String - Merchant Name
  def setmerchantname(value)
    setvalue(SVTags::MERCHANT_NAME, value)
  end

  # ===return
  # Fixnum - The return value which indicates SUCESS or FAILURE
  def geterrorcode()
    return getvalue(@@ERROR_CODE)
  end

  # ===param
  # Fixnum - Error code
  def seterrorcode(value)
    setvalue(@@ERROR_CODE, value)
  end

  # ===return
  # String - The Error message
  def geterrormessage()
    return getvalue(@@ERROR_MESSAGE)
  end

  # ===param
  # String - Error message
  def seterrormessage(value)
    setvalue(@@ERROR_MESSAGE, value)
  end

  def setsvtype(type)
    setvalue(@@SVTYPE, type)
  end

  def getsvtype()
    return getvalue(@@SVTYPE)
  end
end
