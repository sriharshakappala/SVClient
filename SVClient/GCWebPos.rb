#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'pry'

require_relative './SVUtils'
require_relative './SVClient'
require_relative './SVProperties'
require_relative './SVBalanceEnquiry'
require_relative './SVRedeem'
require_relative './SVCancelRedeem'

#
# This Class provides the Gift Card related API for a QwikCilver WebPos Client to interface with QwikCilver Server.
#
# This class provides:
# - A method to initialize this library
# - A set of factory methods to get/create an SVRequest instance pertaining to the operation that needs to be performed
#
# *NOTE:* The caller must first initialize this library by calling GCWebPos::initlibrary method
# before any operation can be performed by this library. This method needs to be called after starting
# the web server and needs to be called only once.
#
# After this library has been initialized the caller calls the appropriate factory method to create
# an instance of SVRequest that will be used to perform the desired operation.
#
# Once an SVRequest instance has been created/obtained the caller can
# set any optional attributes, as desired, by calling the SVRequest.setvalue() method
#
# Once the desired attributes have been set the caller must call
# SVRequest.execute() method to perform the operation.
# SVRequest.execute() method will return SVResponse object.
#
# To check if the operation was performed successfully by QwikCilver Server
# call SVResponse.getErrorCode() method.
#
# If the return  value of SVResponse.geterrorcode() method is NOT EQUAL TO SVStatus.SUCCESS then the caller should call
# SVResponse.geterrormessage() to get a detailed error message on why the operation failed.
#
# If the return  value of SVResponse.geterrorcode() method
# is EQUAL TO SVStatus.SUCCESS then the caller should call
# the appropriate getters in SVResponse object to get the
# data returned by QwikCilver Server after successful execution of this operation.
class GCWebPos

  # This method is used to initialize the SVClient Library.
  # This method needs to be called once before using this library.
  #
  # The required/mandatory attributes for initializing this library are pre-assigned
  # by QwikCilver and provided to the Caller.
  #
  # The list of mandatory and optional
  # attributes are:
  # * serverURL (Mandatory) - Server URL provided by QwikCilver
  # * forwardingEntityId (Mandatory) - Forwarding Entity Id provided by QwikCilver
  # * forwardingEntityPassword (Mandatory) - Forwarding Entity Password provided by QwikCilver
  # * terminalId (Mandatory) - TerminalId is provided by QwikCilver
  # * username (Mandatory) - username provided by QwikCilver
  # * password (Mandatory) - password provided by QwikCilver
  # * connectionTimeout (Optional) - default value is 17 seconds (17000 milliseconds). Actual value is provided by QwikCilver
  # * transactionTimeout (Optional) - default value is 17 seconds (17000 milliseconds). Actual value is provided by QwikCilver
  #
  # To initialize this library the caller needs to create an instance of SVProperties and set the Mandatory attributes and optional
  # attributes, as needed, and call this method by passing the SVProperties instance as a parameter to this method.
  #
  # ===params
  # SVProperties - SVProperties instance that contains the attributes for initializing
  # this library
  #
  # ===return
  # SVProperties which contains QwikCilver server specific data
  # to check if the GCWebPos.initlibrary() operation was performed successfully by QwikCilver Server
  # call SVProperties.geterrorcode() method and check its return value.
  # If the return  value of SVProperties.geterrorcode() method
  # is NOT EQUAL TO SVStatus.SUCCESS then the caller should call
  # SVProperties.geterrormessage() to get a detailed error message on why the operation failed.
  # If the return value is EQUAL TO SVStatus.SUCCESS then save this object
  # as it needs to be passed to subsequent calls to perform card related operations.
  #
  # ===raises
  # Exception  If input parameter is nil or if any of the *Mandatory*
  # attributes are nil or empty.
  def self.initlibrary(webposprops)

    if(webposprops == nil)
      raise "Input is null"
    end
    if( (SVUtils::isnullorempty(webposprops.getserverurl())) ||
          (SVUtils::isnullorempty(webposprops.getforwardingentityid())) ||
          (SVUtils::isnullorempty(webposprops.getforwardingentitypassword())) ||
          (SVUtils::isnullorempty(webposprops.getterminalid())) ||
          (SVUtils::isnullorempty(webposprops.getusername())) ||
          (SVUtils::isnullorempty(webposprops.getpassword())))
      raise "One or More of the Mandatory attributes does not have a valid value"
    end

    webposprops.setsvtype(SVType::WEBPOS_GIFTCARD)
    return SVClient::initlibrary(webposprops)
  end

  # Use this factory method to create an instance of SVRequest
  # that can be used to perform *BalanceEnquiry* operation.
  #
  # After the caller gets the SVRequest instance, the caller
  # may set any of the optional attributes using the SVRequest.setvalue() method
  #
  # Then call SVRequest.execute() method.
  # SVRequest.execute() method returns an instance of SVResponse.
  # To check if the operation was performed successfully by QwikCilver Server
  # call SVResponse.geterrorcode() method and check its return value.
  #
  # If the return value is EQUAL TO SVStatus.SUCCESS
  # then read the values of the following attributes returned by QwikCilver Server
  # using the appropriate getters
  #
  # * SVResponse.gettransactionid()
  # * SVResponse.getcardbalance()
  # * SVResponse.getcardexpiry()
  # * SVResponse.getapprovalcode()
  #
  # ===params
  # SVProperties - *Mandatory* - Data returned by QwikCilver Server in the GCWebPos.initlibrary() call.
  #
  # String - *Mandatory* - Card Number
  #
  # String  - *Mandatory* - Card Pin
  #
  # Fixnum  - *Mandatory* - Transaction ID
  #
  # String - *Optional* - Track Data. Can be nil
  #
  # String -  *Optional* - Notes use as any unique cross-reference, e.g. ApprovalCode, RRN etc. Can be nil
  #
  # ===return
  # SVRequest instance that should be used to perform <B>BalanceEnquiry</B> operation
  #
  # ===raises
  # Exception  If any input parameter that is *Mandatory* is nil or empty
  def self.balanceenquiry(
      serverproperties,   #mandatory
      cardnumber,         #mandatory
      cardpin,            #mandatory
      transactionid,      #mandatory
      trackdata = nil,    #optional
      notes = nil )       #optional, Use as any unique cross-reference, e.g. ApprovalCode, RRN etc, can also be nil

    #Validate Mandatory attributes
    if( ( (serverproperties == nil) ) ||
          ( SVUtils::isnullorempty(cardnumber) ) ||
          ( SVUtils::isnullorempty(cardpin) ) ||
          ( SVUtils::isnullorempty(transactionid) )
      )
      raise "One or More of the Mandatory attributes does not have a valid value"
    end

    serverproperties.setsvtype(SVType::WEBPOS_GIFTCARD)
    @svrequest = SVBalanceEnquiry.new(serverproperties)
    @svrequest.setcardnumber(cardnumber)
    @svrequest.setcardpin(cardpin)
    @svrequest.settransactionid(transactionid)
    @svrequest.settrackdata(trackdata)
    @svrequest.setnotes(notes)
    return @svrequest
  end

  # Use this factory method to create an instance of @link  SVRequest  SVRequestend
  # that can be used to perform <B>Redeem</B> operation.
  #
  # After the caller gets the SVRequest instance, the caller
  # may set any of the optional attributes using the SVRequest.setvalue method
  #
  # Then call SVRequest.execute() method.
  # SVRequest.execute() method returns an instance of SVResponse
  # to check if the operation was performed successfully by QwikCilver Server
  # call SVResponse.geterrorcode() method and check its return value.
  #
  # If the return value is EQUAL TO SVStatus.SUCCESS
  # then read the values of the following attributes returned by QwikCilver Server
  # using the appropriate getters
  # * SVResponse.gettransactionid()
  # * SVResponse.getcardbalance()
  # * SVResponse.getcardexpiry()
  # * SVResponse.getapprovalcode()
  # * SVResponse.getterminalid()
  # * SVResponse.gettransfercardnumber()
  # * SVResponse.gettransfercardbalance()
  # * SVResponse.gettransfercardexpiry()
  #
  # ===params
  # SVProperties  [Mandatory] Data returned by QwikCilver Server in the initLibrary call
  #
  # String - *Mandatory* - Card Number
  #
  # String - *Mandatory* - Card Pin
  #
  # Fixnum - *Mandatory* - Transaction ID
  #
  # String - *Mandatory* - Invoice Number
  #
  # Float - *Mandatory* - Amount to redeem on the Card
  #
  # String - *Optional* - Track Data
  #
  # String - *Optional* - Notes use as any unique cross-reference, e.g. ApprovalCode, RRN etc. Can be nil
  #
  # Float - *Optional* Total Bill Amount
  #
  # ===return
  # SVRequest SVRequest instance that should be used to perform <B>Redeem</B> operation
  #
  # ===raises
  # Exception  If any input parameter that is *Mandatory* is nil or empty
  def self.redeem(
      serverproperties,   #mandatory
      cardnumber,         #mandatory
      cardpin,            #mandatory
      invoicenumber,      #mandatory
      amount,             #mandatory
      transactionid,      #mandatory
      trackdata = nil,    #optional
      notes = nil,         #optional, Use as any unique cross-reference, e.g. ApprovalCode, RRN etc, can also be nil
      billamount = nil)   #optional

    #Validate Mandatory attributes
    if( ( (serverproperties == nil) ) ||
          ( SVUtils::isnullorempty(cardnumber) ) ||
          ( SVUtils::isnullorempty(cardpin) ) ||
          ( SVUtils::isnullorempty(transactionid) ) ||
          ( SVUtils::isnullorempty(invoicenumber) ) ||
          ( amount <= 0 )
      )
      raise "One or More of the Mandatory attributes does not have a valid value"
    end

    serverproperties.setsvtype(SVType::WEBPOS_GIFTCARD)
    @svrequest = SVRedeem.new(serverproperties)
    @svrequest.setcardnumber(cardnumber)
    @svrequest.setcardpin(cardpin)
    @svrequest.settransactionid(transactionid)
    @svrequest.setinvoicenumber(invoicenumber)
    @svrequest.setamount(amount)
    @svrequest.setbillamount(billamount) if ( billamount != nil )
    @svrequest.settrackdata(trackdata)
    @svrequest.setnotes(notes)
    return @svrequest
  end

  # Use this factory method to create an instance of SVRequest
  # that can be used to perform <B>CancelRedeem</B> operation.
  #
  # After the caller gets the SVRequest instance, the caller
  # may set any of the optional attributes using the SVRequest.setvalue method
  #
  # Then call SVRequest.execute() method.
  # SVRequest.execute() method returns an instance of SVResponse
  # to check if the operation was performed successfully by QwikCilver Server
  # call SVResponse.geterrorcode() method and check its return value.
  #
  # If the return value is EQUAL TO SVStatus.SUCCESS
  # then read the values of the following attributes returned by QwikCilver Server
  # using the appropriate getters
  #
  # * SVResponse.gettransactionid
  # * SVResponse.getcardbalance
  # * SVResponse.getcardexpiry
  # * SVResponse.getapprovalcode
  # * SVResponse.getterminalid
  # * SVResponse.gettransfercardnumber
  # * SVResponse.gettransfercardbalance
  # * SVResponse.gettransfercardexpiry
  #
  # ===param
  # SVProperties - *Mandatory* - Data returned by QwikCilver Server in the GCWebPos.initlibrary call
  #
  # String - *Mandatory* - Card Number
  #
  # String - *Mandatory* - Original Invoice Number
  #
  # Bignum - *Mandatory* - Original Transaction Id of the Redeem operation we are trying to Cancel
  #
  # Bignum - *Mandatory* - Original Batch Number
  #
  # Float - *Mandatory* - Original Amount
  #
  # Bignum - *Mandatory* - Transaction Id of the Redeem operation we are trying to Cancel
  #
  # String - *Optional* - Original Approval Code of the Redeem operation we are trying to Cancel. Can be nil
  #
  # String - *Optional* - Track Data. Can be nil
  #
  # String - *Optional* - Use as any unique cross-reference, e.g. ApprovalCode, RRN etc. Can be nil
  #
  # ===return
  # SVRequest instance that should be used to perform <B>CancelRedeem</B> operation
  #
  # ===raises
  # Exception If any input parameter that is *Mandatory* is nil or empty
  #
  def self.cancelredeem(
      serverproperties,               #mandatory
      cardnumber,                     #mandatory
      originalinvoicenumber,          #mandatory
      originaltransactionid,          #mandatory
      originalbatchno,                #mandatory
      originalamount,                 #mandatory
      transactionid,                  #mandatory
      cardpin = nil,                  #optional
      originalapprovalcode = nil,     #Optional
      trackdata = nil,                #Optional
      notes = nil )                   #optional, Use as any unique cross-reference, e.g. ApprovalCode, RRN etci, can also be nil

    #Validate Mandatory attributes
    if( ( (serverproperties == nil) ) ||
          ( SVUtils::isnullorempty(cardnumber) ) ||
          ( SVUtils::isnullorempty(originalinvoicenumber) ) ||
          ( originaltransactionid <= 0 ) ||
          ( originalbatchno <= 0 ) ||
          ( originalamount <= 0 ) ||
          ( SVUtils::isnullorempty(transactionid) )
      )
      raise "One or More of the Mandatory attributes does not have a valid value"
    end

    serverproperties.setsvtype(SVType::WEBPOS_GIFTCARD)
    @svrequest = SVCancelRedeem.new(serverproperties)
    @svrequest.setcardnumber(cardnumber)
    @svrequest.setoriginalinvoicenumber(originalinvoicenumber)
    @svrequest.setoriginaltransactionid(originaltransactionid)
    @svrequest.setoriginalbatchnumber(originalbatchno)
    @svrequest.setoriginalapprovalcode(originalapprovalcode)
    @svrequest.setoriginalamount(originalamount)
    @svrequest.settransactionid(transactionid)
    @svrequest.setcardpin(cardpin)
    @svrequest.setnotes(notes)
    return @svrequest
  end
end
