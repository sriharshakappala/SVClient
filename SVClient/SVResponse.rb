#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'net/http'
require 'cgi'
require 'pry'

# =Overview
# Class that contains the response data received from QwikCilver Server for all SVClient Operations.
#
# SVRequest.execute() method  returns an SVResponse object.
#
# Call SVResponse.geterrorcode() method to determine if SVRequest.execute() method completed successfully or failed.
# 1. if return value of SVResponse.geterrorcode() is equal to SVStatus.SUCCESS then read the desired  attributes/properties using the appropriate getters
# 2. if return value of SVResponse.geterrorcode() is not equal to SVStatus.SUCCESS then get the detailed error message by calling SVResponse.getErrorMessage()
class SVResponse < SVQcsData
  private
  @errorcode = SVStatus::SUCCESS
  @errormessage = ''

  def parsehttpresponse(httpresponse)
    @httpstatus = httpresponse.code.to_i
    if(@httpstatus != SVStatus::HTTP_OK)
      @errorcode = SVStatus::SERVICE_UNAVAILABLE_ERROR
      @errormessage = SVStatus::gethttpmessage(httpresponse)
      return
    end

    @respbody = httpresponse.body
    if (@respbody == nil || @respbody.length <= 0)
      @errorcode = SVStatus::OPERATION_FAILED_ERROR
      @errormessage = SVStatus::getmessage(@errorcode)
      return
    end

    begin
      @@params = CGI.parse(@respbody)
    rescue StandardError => error
      print "Error from SVResponse::parsehttpresponse @{#{error}}"
    end
    @errorcode = getvalue(SVTags::RESPONSE_CODE)
    @errormessage = getvalue(SVTags::RESPONSE_MESSAGE)
  end

  public
  def initialize(resultcode, message = nil, httpresponse = nil)
    super()
    @errorcode = resultcode
    @errormessage = message
    parsehttpresponse(httpresponse) if (httpresponse != nil)
  end

  # Method for getting the status of @link  SVRequest.execute() method.
  #
  # ===return
  # int - The error code
  # returns SVStatus.SUCCESS (zero) if the execution of SVRequest.execute() method is successful.
  #
  # returns a non-zero integer value if there is any failure in the execution of SVRequest.execute() method.
  def geterrorcode()
    if(@errorcode.is_a? Integer)
      return @errorcode
    else
      return @errorcode[0].to_i
    end
  end

  # Method for getting the error message if the execute method returns failure.
  #
  # ===return
  # String - The error message
  def geterrormessage()
    return @errormessage
  end

  # Method for getting the Card Number.
  # This method will return a valid value only if execute method returns SUCCESS
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - The cardNumber, returns null if execute method returns an error or if response does not contain the value.
  def getcardnumber()
    return getvalue(SVTags::CARD_NUMBER)
  end

  # Method for getting the Card Pin.
  # This method will return a valid value only if execute method returns SUCCESS
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - The Card Pin, returns null if execute method returns an error or if response does not contain the value.
  def getcardpin()
    return getvalue(SVTags::CARD_PIN)
  end

  # Method for getting the Current Batch Number.
  # This method will return a valid value only if execute method returns SUCCESS
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Fixnum - The Current Batch Number, returns null if execute method returns an error or if response does not contain the value.
  def getcurrentbatchnumber()
    return getvalue(SVTags::CURRENT_BATCH_NUMBER)
  end

  # Method for getting the Transaction ID.
  # This method will return a valid value only if execute method returns SUCCESS
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Fixnum - The transaction ID, returns null if execute method returns an error or if response does not contain the value.
  def gettransactionid()
    return getvalueasint(SVTags::TRANSACTION_ID)
  end

  # Method for getting the Terminal ID.
  # This method will return a valid value only if execute method returns SUCCESS
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Terminal Id
  # returns null if execute method returns an error
  def getterminalid()
    return getvalue(SVTags::TERMINAL_ID)
  end

  # Method for getting the Track Data.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Track Data
  # returns null if execute method returns an error or if response does not contain the value
  def gettrackdata()
    return getvalue(SVTags::TRACK_DATA)
  end

  # Method for getting the Phone Number.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Phone Number
  # returns null if execute method returns an error or if response does not contain the value
  def getphonenumber()
    return getvalue(SVTags::PHONE_NUMBER)
  end

  # Method for getting the Approval Code.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the approval code.
  # returns null if execute method returns an error or if response does not contain the value
  def getapprovalcode()
    return getvalue(SVTags::APPROVAL_CODE)
  end

  # Method for getting the Transaction Type ID.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the transaction type id.
  # returns null if execute method returns an error or if response does not contain the value
  def gettransactiontypeid()
    return getvalue(SVTags::TRANSACTION_TYPE_ID)
  end

  # Method for getting the First Name.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the First Name.
  # returns null if execute method returns an error or if response does not contain the value
  def getfirstname()
    return getvalue(SVTags::FIRST_NAME)
  end

  # Method for getting the Last Name.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Last Name.
  # returns null if execute method returns an error or if response does not contain the value
  def getlastname()
    return getvalue(SVTags::LAST_NAME)
  end

  # Method for getting the expiry date of the card.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Date - the value for Expiry
  # returns null if execute method returns an error or if response does not contain the value
  def getcardexpiry()
    return getvalue(SVTags::EXPIRY)
  end

  # Method for getting the date at QwikCilver Server.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Date - the date at QwikCilver Server
  # returns null if execute method returns an error or if response does not contain the value
  def getdateatserver()
    return getdate(SVTags::DATE_AT_SERVER, SVUtils::QC_SERVER_DATE_FORMAT)
  end

  # Method for getting the balance amount on a card.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Float - the balance amount for the given card
  # returns null if execute method returns an error or if response does not contain the value
  def getcardbalance()
    return getvalueasfloat(SVTags::CARD_BALANCE)
  end

  # Method for getting the amount used in an operation on a card.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # double - the amount specified for this operation
  # returns null if execute method returns an error or if response does not contain the value
  def getamount()
    return getvalueasfloat(SVTags::AMOUNT)
  end

  # Method for getting the Card Type.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - the Card Type.
  # returns null if execute method returns an error or if response does not contain the value
  def getcardtype()
    return getvalue(SVTags::CARD_TYPE)
  end

  # Method for getting the Corporate Name.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - the Corporate Name.
  # returns null if execute method returns an error or if response does not contain the value
  def getcorporatename()
    return getvalue(SVTags::CORPORATE_NAME)
  end

  # Method for getting the Card Program Group Name.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - the Card Program Group Name.
  # returns null if execute method returns an error or if response does not contain the value
  def getcardprogramgroupname()
    return getvalue(SVTags::CARD_PROGRAM_GROUP_NAME)
  end

  # Method for getting the Invoice Number specified for an operation on a card.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - the Invoice Number specified for this operation.
  # returns null if execute method returns an error or if response does not contain the value
  def getinvoicenumber()
    return getvalue(SVTags::INVOICE_NUMBER)
  end

  # Method for getting the Transfer Card Number.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - the Transfer Card Number.
  # returns null if execute method returns an error or if response does not contain the value
  def gettransfercardnumber()
    return getvalue(SVTags::TRANSFER_CARD_NUMBER)
  end

  # Method for getting the Transfer Card Expiry date.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Date - the Transfer Card Expiry date.
  # returns null if execute method returns an error or if response does not contain the value
  def gettransfercardexpiry()
    return getvalue(SVTags::TRANSFER_CARD_EXPIRY)
  end

  # Method for getting the balance amount on a transfer card.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the balance amount
  # returns null if execute method returns an error or if response does not contain the value
  def gettransfercardbalance()
    return getvalueasfloat(SVTags::TRANSFER_CARD_BALANCE)
  end

  # Method for getting the EmbossingFileRecord.
  # EmbossingFileRecord contains multiple tracks with trackdata in each track
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # String - EmbossingFileRecord contains multiple tracks with trackdata in each track
  # returns null if execute method returns an error or if response does not contain the value
  def getembossingrecord()
    return getvalue(SVTags::EMBOSSING_RECORD)
  end

  # Method for getting the Settlement Date.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Date - the Settlement Date.
  # returns null if execute method returns an error or if response does not contain the value
  def getsettlementdate()
    return getvalue(SVTags::SETTLEMENT_DATE, SVUtils.QC_SERVER_DATE_FORMAT)
  end

  # Method for getting the Activation Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Activation Amount
  # returns null if execute method returns an error or if response does not contain the value
  def getactivationamount()
    return getvalueasfloat(SVTags::ACTIVATION_AMOUNT)
  end

  # Method for getting the Activation Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Activation Count
  # returns null if execute method returns an error or if response does not contain the value
  def getactivationcount()
    return getvalueasint(SVTags::ACTIVATION_COUNT)
  end

  # Method for getting the Redemption Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Redemption Count
  # returns null if execute method returns an error or if response does not contain the value
  def getredemptioncount()
    return getvalueasfloat(SVTags::REDEEM_COUNT)
  end

  # Method for getting the Redemption Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Redemption Amount
  # returns null if execute method returns an error or if response does not contain the value
  def getredemptionamount()
    return getvalueasfloat(SVTags::REDEEM_AMOUNT)
  end

  # Method for getting the Cancel Activation Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Cancel Activation Amount
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelactivationamount()
    return getvalueasfloat(SVTags::CANCEL_ACTIVATION_AMOUNT)
  end

  # Method for getting the Cancel Activation Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Cancel Activation Count
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelactivationcount()
    return getvalueasint(SVTags::CANCEL_ACTIVATION_COUNT)
  end

  # Method for getting the Reload Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Reload amount
  # returns null if execute method returns an error or if response does not contain the value
  def getreloadamount()
    return getvalueasfloat(SVTags::RELOAD_AMOUNT)
  end

  # Method for getting the Reload Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Reload Count
  # returns null if execute method returns an error or if response does not contain the value
  def getreloadcount()
    return getvalueasint(SVTags::RELOAD_COUNT)
  end

  # Method for getting the Cancel Load Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Cancel Load amount
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelloadamount()
    return getvalueasfloat(SVTags::CANCEL_LOAD_AMOUNT)
  end

  # Method for getting the Cancel Load Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Cancel Load Count
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelloadcount()
    return getvalueasint(SVTags::CANCEL_LOAD_COUNT)
  end

  # Method for getting the Redeem Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Redeem amount
  # returns null if execute method returns an error or if response does not contain the value
  def getredeemamount()
    return getvalueasfloat(SVTags::REDEEM_AMOUNT)
  end

  # Method for getting the Redeem Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Redeem Count
  # returns null if execute method returns an error or if response does not contain the value
  def getredeemcount()
    return getvalueasint(SVTags::REDEEM_COUNT)
  end

  # Method for getting the Cancel Redeem Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Float - the Cancel Redeem amount
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelredeemamount()
    return getvalueasfloat(SVTags::CANCEL_REDEEM_AMOUNT)
  end

  # Method for getting the Cancel Redeem Count.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # if execute method returns an error or
  # if response does not contain a value
  #
  # ===return
  # Bignum - the Cancel Redeem Count
  # returns null if execute method returns an error or if response does not contain the value
  def getcancelredeemcount()
    return getvalueasint(SVTags::CANCEL_REDEEM_COUNT)
  end

  # Method for getting the new batch number.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Bignum - the new batch number
  # returns null if execute method returns an error or if response does not contain the value
  def getnewbatchnumber()
    return getvalueasint(SVTags::NEW_BATCH_NUMBER)
  end
  # Method for getting the previous balance.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the previous balance
  # returns null if execute method returns an error or if response does not contain the value
  def getpreviousbalance()
    return getvalue(SVTags::PREV_BALANCE)
  end

  # Method for getting the promotional value.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the promotional value
  # returns null if execute method returns an error or if response does not contain the value
  def getpromotionalvalue()
    return getvalue(SVTags::PROMOTIONAL_VALUE)
  end

  # Method for getting the transaction amount converted value.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the transaction amount converted value
  # returns null if execute method returns an error or if response does not contain the value
  def gettransactionamountconvertedvalue()
    return getvalue(SVTags::TRANSACTION_AMOUNT_CONVERTED_VALUE)
  end

  # Method for getting the card currency.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the currency symbol
  # returns null if execute method returns an error or if response does not contain the value
  def getcardcurrencysymbol()
    return getvalue(SVTags::CARD_CURRENCY_SYMBOL)
  end

  # Method for getting the currency conversion rate.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the currency conversion rate
  # returns null if execute method returns an error or if response does not contain the value
  def getcurrencyconversionrate()
    return getvalue(SVTags::CURRENCY_CONVERSION_RATE)
  end

  # Method for getting the currency converted amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the currency converted amount
  # returns null if execute method returns an error or if response does not contain the value
  def getcurrencyconvertedamount()
    return getvalue(SVTags::CURRENCY_CONVERTED_AMOUNT)
  end

  # Method for getting the Card Holder Name.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Card Holder Name
  # returns null if execute method returns an error or if response does not contain the value
  def getcardholdername()
    return getvalue(SVTags::CARD_HOLDER_NAME)
  end

  # Method for getting the Employee Id.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Employee Id
  # returns null if execute method returns an error or if response does not contain the value
  def getemployeeid()
    return getvalue(SVTags::EMPLOYEE_ID)
  end

  # Method for getting the SVType.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the SVType
  # returns null if execute method returns an error or if response does not contain the value
  def getsvtype()
    return getvalue(SVTags::SV_TYPE)
  end

  # Method for getting the SV Converted Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the SV Converted Amount
  # returns null if execute method returns an error or if response does not contain the value
  def getsvconvertedamount()
    return getvalue(SVTags::SV_CONVERTED_AMOUNT)
  end

  # Method for getting the Transaction Amount.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Transaction Amount
  # returns null if execute method returns an error or if response does not contain the value
  def gettransactionamount()
    return getvalue(SVTags::XACTION_AMOUNT)
  end

  # Method for getting the Earned Value.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Earned Value
  # returns null if execute method returns an error or if response does not contain the value
  def getearnedvalue()
    return getvalue(SVTags::EARNED_VALUE)
  end

  # Method for getting the Salutation.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Salutation
  # returns null if execute method returns an error or if response does not contain the value
  def getsalutation()
    return getvalue(SVTags::SALUTATION)
  end

  # Method for getting the Address1.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Address1
  # returns null if execute method returns an error or if response does not contain the value
  def getaddress1()
    return getvalue(SVTags::ADDRESS1)
  end

  # Method for getting the Address2.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Address2
  # returns null if execute method returns an error or if response does not contain the value
  def getaddress2()
    return getvalue(SVTags::ADDRESS2)
  end

  # Method for getting the Area.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Area
  # returns null if execute method returns an error or if response does not contain the value
  def getarea()
    return getvalue(SVTags::AREA)
  end

  # Method for getting the City.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the City
  # returns null if execute method returns an error or if response does not contain the value
  def getcity()
    return getvalue(SVTags::CITY)
  end

  # Method for getting the State.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the State
  # returns null if execute method returns an error or if response does not contain the value
  def getstate()
    return getvalue(SVTags::STATE)
  end

  # Method for getting the Country.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Country
  # returns null if execute method returns an error or if response does not contain the value
  def getcountry()
    return getvalue(SVTags::COUNTRY)
  end

  # Method for getting the PinCode.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the PinCode
  # returns null if execute method returns an error or if response does not contain the value
  def getpincode()
    return getvalue(SVTags::PIN_CODE)
  end

  # Method for getting the Alternate Phone Number.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Alternate Phone Number
  # returns null if execute method returns an error or if response does not contain the value
  def getalternatephonenumber()
    return getvalue(SVTags::PHONE_ALTERNATE)
  end

  # Method for getting the Email.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Email
  # returns null if execute method returns an error or if response does not contain the value
  def getemail()
    return getvalue(SVTags::EMAIL)
  end

  # Method for getting the Date Of Birth.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Date Of Birth
  # returns null if execute method returns an error or if response does not contain the value
  def getdob()
    return getvalue(SVTags::DOB)
  end

  # Method for getting the Anniversary Date.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Anniversary Date
  # returns null if execute method returns an error or if response does not contain the value
  def getanniversary()
    return getvalue(SVTags::ANNIVERSARY)
  end

  # Method for getting the Gender.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Gender
  # returns null if execute method returns an error or if response does not contain the value
  def getgender()
    return getvalue(SVTags::GENDER)
  end

  # Method for getting the Marital Status.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Marital Status
  # returns null if execute method returns an error or if response does not contain the value
  def getmaritalstatus()
    return getvalue(SVTags::MARITAL_STATUS)
  end

  # Method for getting the Enrolled Store.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Enrolled Store
  # returns null if execute method returns an error or if response does not contain the value
  def getenrolledstore()
    return getvalue(SVTags::ENROLLED_STORE)
  end

  # Method for getting the Enrolled Since.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Enrolled Since
  # returns null if execute method returns an error or if response does not contain the value
  def getenrolledsince()
    return getvalue(SVTags::ENROLLED_SINCE)
  end

  # Method for getting the Card Status.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Card Status
  # returns null if execute method returns an error or if response does not contain the value
  def getcardstatus()
    return getvalue(SVTags::CARD_STATUS)
  end

  # Method for getting the Outstanding Balance.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Outstanding Balance
  # returns null if execute method returns an error or if response does not contain the value
  def getoutstandingbalance()
    return getvalue(SVTags::OUTSTANDING_BALANCE)
  end

  # Method for getting the Card Expiry Date.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Card Expiry Date
  # returns null if execute method returns an error or if response does not contain the value
  def getcardexpirydate()
    return getvalue(SVTags::CARD_EXPIRY_DATE)
  end

  # Method for getting the Customer Validation For Redemption.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Customer Validation For Redemption
  # returns null if execute method returns an error or if response does not contain the value
  def getcustomervalidationforredemption()
    return getvalue(SVTags::CUSTOMER_VALIDATION_FOR_REDEMPTION)
  end

  # Method for getting the Meets Minimum Redemption Criteria.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Meets Minimum Redemption Criteria
  # returns null if execute method returns an error or if response does not contain the value
  def getmeetsminimumredemptioncriteria()
    return getvalue(SVTags::MEETS_MINIMUM_REDEMPTION_CRITERIA)
  end

  # Method for getting the Ready For Redemption.
  # This method will return a valid value only if execute method returns SUCCESS.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # String - the Ready For Redemption
  # returns null if execute method returns an error or if response does not contain the value
  def getreadyforredemption()
    return getvalue(SVTags::READY_FOR_REDEMPTION)
  end

  def getposname()  return getvalue(SVTags::POS_NAME) end
  def getpostypeid()  return getvalue(SVTags::POS_TYPE_ID) end
  def getposentrymode()  return getvalue(SVTags::POS_ENTRY_MODE) end
  def getmerchantoutletname()  return getvalue(SVTags::MERCHANT_OUTLET_NAME) end
  def getmerchantname()  return getvalue(SVTags::MERCHANT_NAME) end
  def getorganizationname()  return getvalue(SVTags::ORGANIZATION_NAME) end
  def getacquirerid()  return getvalue(SVTags::ACQUIRER_ID) end

  def self.getparams()
    return @@params
  end

  # Method for getting the Last N Transactions.
  # This method will return an array of SVGiftRecentTransactions objects which has that last N transactions data.
  # This method will return null
  # 1. if execute method returns an error or
  # 2. if response does not contain a value
  #
  # ===return
  # Array(SVGiftRecentTransactions) - the Last N Transactions data.
  # returns null if execute method returns an error or if response does not contain the value
  def getgiftrecenttransactions()
    recenttransactions = getvalue(SVTags::RECENT_TRANSACTIONS)
    if (recenttransactions[0] != nil)
      parsedrecenttransactions = SVUtils::parsegiftrecenttransactions(recenttransactions)
    end
    return parsedrecenttransactions
  end
end
