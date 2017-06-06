#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'net/http'
require 'uri'
require 'pry'

require_relative './SVQcsData'
require_relative './SVStatus'
require_relative './SVResponse'

# Abstract base class for all SVClient Operations.
#
# Currently Supported operations (Direct Known Subclasses) are:
# 1. SVBalanceEnquiry - Class for Balance Enquiry operation
# 2. SVRedeem - Class for Redeem operation
# 3. SVCancelRedeem - Class for Load Card operation
#
# To perform a desired operation:
# 1. instantiate the appropriate operation class
# 2. set all the required attributes/properties
# 3. call SVRequest.execute() method
# 4. SVRequest.execute() method returns a SVResponse object
# 5. check the execution status of SVRequest.execute() method by calling SVResponse.geterrorcode() method
# 6. if return value is SVStatus.SUCCESS then read the desired attributes/properties using the appropriate getters in SVResponse object
# 7. if return value is not equal to SVStatus::SUCCESS then get the error message by calling SVResponse.getErrorMessage()
#
# *NOTE:*
# If the value of any key/attribute is set to null then that key/attribute
# will not be sent to QwikCilver Server as part of the Request data. Only keys/attributes
# that have a value will be sent to QwikCilver Server as part of the Request data.
class SVRequest < SVQcsData
  protected
  attr_accessor :requestURL, :txnTimeOut, :requestType, :connectionTimeOut

  def gettransactiontypeid()  return 0 end

  public
  def initialize(svProps)
    binding.pry
    super()
    @requestType = svProps.getsvtype
    @txnTimeOut = svProps.gettransactiontimeout
    @connectionTimeOut = svProps.getconnectiontimeout
    @requestURL = svProps.getserverurl

    case @requestType
    when SVType::WEBPOS_GIFTCARD
      populatewebposgiftcardparams(svProps)
      #when SVType::WEBPOS_LOYALTY
      #  populatewebposloyaltyparams(svProps)
      #else
      #  populateallparams(svProps)
    end
  end

  # ===return
  # String - Card number
  def getcardnumber
    return getvalue(SVTags::CARD_NUMBER)
  end

  # ===return
  # String - Current batch number
  def getcurrentbatchnumber
    return getvalue(SVTags::CURRENT_BATCH_NUMBER)
  end

  # ===return
  # String - Transaction ID
  def gettransactionid
    return getvalue(SVTags::TRANSACTION_ID)
  end

  # ===return
  # String - Original Transaction ID
  def getoriginaltransactionid
    return getvalue(SVTags::ORIGINAL_TRANSACTION_ID)
  end

  # ===return
  # String - Original Invoice Number
  def getoriginalinvoicenumber
    return getvalue(SVTags::ORIGINAL_INVOICE_NUMBER)
  end

  # ===return
  # String - Terminal ID
  def getterminalid
    return getvalue(SVTags::TERMINAL_ID)
  end

  # ===return
  # String - Track Data
  def gettrackdata
    return getvalue(SVTags::TRACK_DATA)
  end

  # Method for getting the Phone Number.
  #
  # ===return
  # String - Phone number
  def getphonenumber
    return getvalue(SVTags::PHONE_NUMBER)
  end

  # Method for getting the original approval code.
  #
  # ===return
  # String - Original Approval code
  def getoriginalapprovalcode
    return getvalue(SVTags::ORIGINAL_APPROVAL_CODE)
  end

  # Method for getting the approval code.
  #
  # ===return
  # String - Approval code
  def getapprovalcode
    return getvalue(SVTags::APPROVAL_CODE)
  end

  # Method for getting the amount used in an operation on a card.
  #
  # ===return
  # Float - Amount
  def getamount
    return getvalue(SVTags::AMOUNT)
  end

  # Method for getting the original amount used in an operation on a card.
  #
  # ===return
  # String - Original Amount
  def getoriginalamount
    return getvalue(SVTags::ORIGINAL_AMOUNT)
  end

  # Method for getting the Corporate Name.
  #
  # ===return
  # String - The Corporate Name.
  def getcorporatename
    return getvalue(SVTags::CORPORATE_NAME)
  end

  # Method for getting the Card Program Group Name.
  #
  # ===return
  # String - The Card Program Group Name.
  def getcardprogramgroupname
    return getvalue(SVTags::CARD_PROGRAM_GROUP_NAME)
  end

  # Method for getting the Invoice Number specified for an operation on a card
  #
  # ===return
  # String - the Invoice Number specified for this operation.
  def getinvoicenumber
    return getvalue(SVTags::INVOICE_NUMBER)
  end

  # Method for getting the Transfer Card Number.
  #
  # ===return
  # String - The Transfer Card Number.
  def gettransfercardnumber
    return getvalue(SVTags::TRANSFER_CARD_NUMBER)
  end

  # Method for getting the Track Data of the Transfer card
  #
  # ===return
  # String - the Track Data of the Transfer card
  def gettransfertrackdata
    return getvalue(SVTags::TRACK_DATA)
  end

  # Method for getting the First Name
  #
  # ===return
  # String - The First Name
  def getfirstname
    return getvalue(SVTags::FIRST_NAME)
  end

  # Method for getting the Last Name
  #
  # ===return
  # String - The Last Name
  def getlastname
    return getvalue(SVTags::LAST_NAME)
  end

  # Method for getting the AdditionalTxnRef1
  #
  # ===return
  # String - The AdditionalTxnRef1
  #

  def getadditionaltxnref1
    return getvalue(SVTags::ADDITIONAL_TXN_REF_1)
  end

  # Method for getting the IIN
  #
  # ===return
  # String - The IIN
  def getiin
    return getvalue(SVTags::IIN)
  end

  # Method for getting the Settlement Date.
  #
  # ===return
  # Date - The Settlement Date.
  def getsettlementdate
    return getdate(SVTags::SETTLEMENT_DATE, SVUtils::QC_SERVER_DATE_FORMAT)
  end

  # Method for getting the Activation Amount
  #
  # ===return
  # Float - The Activation amount specified for this operation
  def getactivationamount
    return getvalue(SVTags::ACTIVATION_AMOUNT)
  end

  # Method for getting the Activation Count
  #
  # ===return
  # Bignum - The Activation Count specified for this operation
  def getactivationcount
    return getvalue(SVTags::ACTIVATION_COUNT)
  end

  # Method for getting the Cancel Activation Amount
  #
  # ===return
  # Float - The Cancel Activation amount specified for this operation
  def getcancelactivationamount
    return getvalue(SVTags::CANCEL_ACTIVATION_AMOUNT)
  end

  # Method for getting the Cancel Activation Count
  #
  # ===return
  # Bignum - The Cancel Activation Count specified for this operation
  def getcancelactivationcount
    return getvalue(SVTags::CANCEL_ACTIVATION_COUNT)
  end

  # Method for getting the Reload Amount
  #
  # ===return
  # Float - The Reload amount specified for this operation
  def getreloadamount
    return getvalue(SVTags::RELOAD_AMOUNT)
  end

  # Method for getting the Reload Count
  #
  # ===return
  # Bignum - The Reload Count specified for this operation
  def getreloadcount
    return getvalue(SVTags::RELOAD_COUNT)
  end

  # Method for getting the Cancel Load Amount
  #
  # ===return
  # Float - The Cancel Load amount specified for this operation
  def getcancelloadamount
    return getvalue(SVTags::CANCEL_LOAD_AMOUNT)
  end

  # Method for getting the Cancel Load Count
  #
  # ===return
  # Bignum - The Cancel Load Count specified for this operation
  def getcancelloadcount
    return getvalue(SVTags::CANCEL_LOAD_COUNT)
  end

  # Method for getting the Redeem Amount
  #
  # ===return
  # Float - The Redeem amount specified for this operation
  def getredeemamount
    return getvalue(SVTags::REDEEM_AMOUNT)
  end

  # Method for getting the Redeem Count
  #
  # ===return
  # Bignum - The Redeem Count specified for this operation
  def getredeemcount
    return getvalue(SVTags::REDEEM_COUNT)
  end

  # Method for getting the Cancel Redeem Amount
  #
  # ===return
  # Float - The Cancel Redeem amount specified for this operation
  def getcancelredeemamount
    return getvalue(SVTags::CANCEL_REDEEM_AMOUNT)
  end

  # Method for getting the Cancel Redeem Count
  #
  # ===return
  # Bignum - The Cancel Redeem Count specified for this operation
  def getnotes
    return getvalue(SVTags::NOTES)
  end

  # Method for getting the Notes
  #
  # ===return
  # String - The Notes specified for this operation
  def getcancelredeemcount
    return getvalue(SVTags::CANCEL_REDEEM_COUNT)
  end

  # Method to get the Bill Amount
  #
  # ===return
  # Float - The Bill Amount for this operation.
  def getbillamount
    return getvalue(SVTags::BILL_AMOUNT)
  end

  def setterminalid(value) setvalue(SVTags::TERMINAL_ID, value) end
  def setuserid(value)  setvalue(SVTags::USER_ID, value) end
  def setpassword(value)  setvalue(SVTags::PASSWORD, value) end
  def setforwardingentityid(value)  setvalue(SVTags::FORWARDING_ENTITY_ID, value) end
  def setforwardingentitypassword(value)  setvalue(SVTags::FORWARDING_ENTITY_PASSWORD, value) end
  def setmerchantoutletname(value)  setvalue(SVTags::MERCHANT_OUTLET_NAME, value) end
  def setacquirerid(value)  setvalue(SVTags::ACQUIRER_ID, value) end
  def setorganizationname(value)  setvalue(SVTags::ORGANIZATION_NAME, value) end
  def setcorporatename(value) setvalue(SVTags::CORPORATE_NAME, value)end
  def setposname(value)  setvalue(SVTags::POS_NAME, value) end
  def setterminalappversion(value)  setvalue(SVTags::TERMINAL_APP_VERSION, value) end
  def setcurrentbatchnumber(value)  setvalue(SVTags::CURRENT_BATCH_NUMBER, value) end
  def settransactionid(value)  setvalue(SVTags::TRANSACTION_ID, value) end
  def setposentrymode(value)  setvalue(SVTags::POS_ENTRY_MODE, value) end
  def setpostypeid(value)  setvalue(SVTags::POS_TYPE_ID, value) end
  def settrackdata(value)  setvalue(SVTags::TRACK_DATA, value) end
  def setcardnumber(value)  setvalue(SVTags::CARD_NUMBER, value) end
  def setcardpin(value)  setvalue(SVTags::CARD_PIN, value) end
  def setinvoicenumber(value)  setvalue(SVTags::INVOICE_NUMBER, value) end
  def setamount(value)  setvalue(SVTags::AMOUNT, value) end
  def setoriginalinvoicenumber(value)  setvalue(SVTags::ORIGINAL_INVOICE_NUMBER, value) end
  def setoriginaltransactionid(value)  setvalue(SVTags::ORIGINAL_TRANSACTION_ID, value) end
  def setoriginalbatchnumber(value)  setvalue(SVTags::ORIGINAL_BATCH_NUMBER, value) end
  def setoriginalapprovalcode(value)  setvalue(SVTags::ORIGINAL_APPROVAL_CODE, value) end
  def setoriginalamount(value)  setvalue(SVTags::ORIGINAL_AMOUNT, value) end
  def setcardprogramgroupname(value)  setvalue(SVTags::CARD_PROGRAM_GROUP_NAME, value) end
  def setfirstname(value)  setvalue(SVTags::FIRST_NAME, value) end
  def setlastname(value)  setvalue(SVTags::LAST_NAME, value) end
  def setphonenumber(value)  setvalue(SVTags::PHONE_NUMBER, value) end
  def setadditionaltxnref1(value)  setvalue(SVTags::ADDITIONAL_TXN_REF_1, value) end
  def setusername(value)  setvalue(SVTags::USER_ID, value) end
  def setactivationcount(value)  setvalue(SVTags::ACTIVATION_COUNT, value) end
  def setcancelactivationcount(value)  setvalue(SVTags::CANCEL_ACTIVATION_COUNT, value) end
  def setredeemcount(value)  setvalue(SVTags::REDEEM_COUNT, value) end
  def setcancelredeemcount(value)  setvalue(SVTags::CANCEL_REDEEM_COUNT, value) end
  def setreloadcount(value)  setvalue(SVTags::RELOAD_COUNT, value) end
  def setcancelloadcount(value)  setvalue(SVTags::CANCEL_LOAD_COUNT, value) end
  def setactivationamount(value)  setvalue(SVTags::ACTIVATION_AMOUNT, value) end
  def setredeemamount(value)  setvalue(SVTags::REDEEM_AMOUNT, value) end
  def setreloadamount(value)  setvalue(SVTags::RELOAD_AMOUNT, value) end
  def setcancelactivationamount(value)  setvalue(SVTags::CANCEL_ACTIVATION_AMOUNT, value) end
  def setcancelredeemamount(value)  setvalue(SVTags::CANCEL_REDEEM_AMOUNT, value) end
  def setcancelloadamount(value)  setvalue(SVTags::CANCEL_LOAD_AMOUNT, value) end
  def setaddoncardnumber(value)  setvalue(SVTags::ADDON_CARD_NUMBER,value) end
  def setaddoncardtrackdata(value)  setvalue(SVTags::ADDON_CARD_TRACK_DATA,value) end
  def settransfercardnumber(value)  setvalue(SVTags::TRANSFER_CARD_NUMBER,value) end
  def setnotes(value)  setvalue(SVTags::NOTES,value) end
  def setemployeeid(value)  setvalue(SVTags::EMPLOYEE_ID,value) end
  def setsalutation(value)  setvalue(SVTags::SALUTATION,value) end
  def setaddress1(value)  setvalue(SVTags::ADDRESS1,value) end
  def setaddress2(value)  setvalue(SVTags::ADDRESS2,value) end
  def setarea(value)  setvalue(SVTags::AREA,value) end
  def setcity(value)  setvalue(SVTags::CITY,value) end
  def setstate(value)  setvalue(SVTags::STATE,value) end
  def setcountry(value)  setvalue(SVTags::COUNTRY,value) end
  def setpincode(value)  setvalue(SVTags::PIN_CODE,value) end
  def setphonealternate(value)  setvalue(SVTags::PHONE_ALTERNATE,value) end
  def setemail(value)  setvalue(SVTags::EMAIL,value) end
  def setdob(value)  setvalue(SVTags::DOB,value) end
  def setanniversary(value)  setvalue(SVTags::ANNIVERSARY,value) end
  def setgender(value)  setvalue(SVTags::GENDER,value) end
  def setmaritalstatus(value)  setvalue(SVTags::MARITAL_STATUS,value) end
  def setapprovalcode(value)  setvalue(SVTags::APPROVAL_CODE, value) end
  def setbillamount(value) setvalue(SVTags::BILL_AMOUNT, value) end

  def populatewebposgiftcardparams(svProps)
    setvalue(SVTags::DATE_AT_CLIENT, SVUtils::getcurrentdate())
    setvalue(SVTags::FORWARDING_ENTITY_ID, svProps.getforwardingentityid())
    setvalue(SVTags::FORWARDING_ENTITY_PASSWORD, svProps.getforwardingentitypassword())
    setvalue(SVTags::ACQUIRER_ID, svProps.getacquirerid())
    setvalue(SVTags::TERMINAL_APP_VERSION, svProps.getterminalappversion())
    setvalue(SVTags::TRANSACTION_TYPE_ID, gettransactiontypeid())
    setvalue(SVTags::TRANSACTION_ID, svProps.gettransactionid())
    setvalue(SVTags::TERMINAL_ID, svProps.getterminalid())
    setvalue(SVTags::USER_ID, svProps.getusername())
    setvalue(SVTags::PASSWORD, svProps.getpassword())
    setvalue(SVTags::POS_ENTRY_MODE, svProps.getposentrymode())
    setvalue(SVTags::POS_TYPE_ID, svProps.getpostypeid())
    setvalue(SVTags::ORGANIZATION_NAME, svProps.getorganizationname())
    setvalue(SVTags::MERCHANT_NAME, svProps.getmerchantname())
    setvalue(SVTags::MERCHANT_OUTLET_NAME, svProps.getmerchantoutletname())
    setvalue(SVTags::POS_NAME, svProps.getposname())
    setvalue(SVTags::CURRENT_BATCH_NUMBER, svProps.getcurrentbatchnumber())
  end

  #def populatewebposloyaltyparams(svProps)
  #  setvalue(SVTags::DATE_AT_CLIENT, SVUtils::getcurrentdate())
  #  setvalue(SVTags::FORWARDING_ENTITY_ID, svProps.getforwardingentityid())
  #  setvalue(SVTags::FORWARDING_ENTITY_PASSWORD, svProps.getforwardingentitypassword())
  #  setvalue(SVTags::ACQUIRER_ID, svProps.getacquirerid())
  #  setvalue(SVTags::TERMINAL_APP_VERSION, svProps.getterminalappversion())
  #  setvalue(SVTags::TRANSACTION_TYPE_ID, gettransactiontypeid())
  #  setvalue(SVTags::TRANSACTION_ID, svProps.gettransactionid())
  #  setvalue(SVTags::TERMINAL_ID, svProps.getterminalid())
  #  setvalue(SVTags::USER_ID, svProps.getusername())
  #  setvalue(SVTags::PASSWORD, svProps.getpassword())
  #  setvalue(SVTags::POS_ENTRY_MODE, svProps.getposentrymode())
  #  setvalue(SVTags::POS_TYPE_ID, svProps.getpostypeid())
  #  setvalue(SVTags::ORGANIZATION_NAME, svProps.getorganizationname())
  #  setvalue(SVTags::MERCHANT_NAME, svProps.getmerchantname())
  #  setvalue(SVTags::MERCHANT_OUTLET_NAME, svProps.getmerchantoutletname())
  #  setvalue(SVTags::POS_NAME, svProps.getposname())
  #  setvalue(SVTags::CURRENT_BATCH_NUMBER, svProps.getcurrentbatchnumber())
  #end

  #
  def populateallparams(svProps)
    setvalue(SVTags::DATE_AT_CLIENT,  SVUtils::getcurrentdate())
    setvalue(SVTags::FORWARDING_ENTITY_ID, svProps.getforwardingentityid())
    setvalue(SVTags::FORWARDING_ENTITY_PASSWORD, svProps.getforwardingentitypassword())
    setvalue(SVTags::ACQUIRER_ID, svProps.getacquirerid())
    setvalue(SVTags::TERMINAL_APP_VERSION, svProps.getterminalappversion())
    setvalue(SVTags::TRANSACTION_TYPE_ID, gettransactiontypeid())
    setvalue(SVTags::TRANSACTION_ID, svProps.gettransactionid())
    setvalue(SVTags::TERMINAL_ID, svProps.getterminalid())
    setvalue(SVTags::USER_ID, svProps.getusername())
    setvalue(SVTags::PASSWORD, svProps.getpassword())
    setvalue(SVTags::POS_ENTRY_MODE, svProps.getposentrymode())
    setvalue(SVTags::POS_TYPE_ID, svProps.getpostypeid())
    setvalue(SVTags::ORGANIZATION_NAME, svProps.getorganizationname())
    setvalue(SVTags::MERCHANT_NAME, svProps.getmerchantname())
    setvalue(SVTags::MERCHANT_OUTLET_NAME, svProps.getmerchantoutletname())
    setvalue(SVTags::POS_NAME, svProps.getposname())
    setvalue(SVTags::CURRENT_BATCH_NUMBER, svProps.getcurrentbatchnumber())
  end

  # ===return
  # SVResponse SVResponse instance that contains the response data for this operation
  def execute
    url = URI.parse(@requestURL)
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data(@@params)
    @returncode = SVStatus::SUCCESS
    begin
      httpresponse = Net::HTTP.new(url.host, url.port).start {
        |http|
        http.read_timeout = @txnTimeOut
        http.open_timeout = @connectionTimeOut
        http.request(req)
      }
    rescue Timeout::Error
      @returncode = SVStatus::CONNECTION_TIMEOUT_ERROR
    end

    case httpresponse
      when Net::HTTPBadResponse, Net::HTTPBadGateway, Net::HTTPBadRequest, Net::HTTPExceptions, Net::HTTPError then
        @returncode = SVStatus::UNKNOWN_ERROR
      when Net::HTTPSuccess
        @returncode = SVStatus::SUCCESS
      else
        @returncode = SVStatus::UNKNOWN_ERROR
    end

    @returnmessage = SVStatus.getmessage(@returncode) if (@returncode != SVStatus::SUCCESS)
    return SVResponse.new(@returncode, @returnmessage, httpresponse)
  end

  private
  def getcardtype
    return getvalue(SVTags::CARD_TYPE)
  end
end
