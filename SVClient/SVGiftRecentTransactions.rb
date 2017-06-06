#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'pry'

require_relative './SVRecentTransactions'

# =Overview
# This class contains values of Recent Transaction attributes which is returned from the server.
#
# SVResponse.getgiftrecenttransactions() method would return the Array of objects of this class type.
# If server responds with any recent transactions in the response.
class SVGiftRecentTransactions < SVRecentTransactions

  # ===return
  # String - the Card Number of the selected recent transaction.
  def getcardnumber
    @cardnumber
  end

  # ===return
  # DateTime - the transaction date at which the selected recent transaction happened.
  def gettransactiondate
    SVUtils::getdate(@transactiondate, SVUtils::QC_DATE_FORMAT)
  end

  # ===return
  # DateTime - the transaction date at server on which the selected recent transaction happened.
  # If this date differs from Transaction Date then the transaction might have happened offline.
  def gettransactiondateatserver
    @transactiondateatserver
  end

  # ===return
  # String - the descriptive Outlet Name on which the selected recent transaction happened.
  def getoutletname
    @outletname
  end

  # ===return
  # String - the descriptive Outlet Code on which the selected recent transaction happened.
  def getoutletcode
    @outletcode
  end

  # ===return
  # String - the Invoice Number of the selected recent transaction.
  def getinvoicenumber
    @invoicenumber
  end

  # ===return
  # String - the Transaction Type of the selected recent transaction.
  def gettransactiontype
    @transactiontype
  end

  # ===return
  # Float - the Transaction Amount of the selected recent transaction.
  def gettransactionamount
    @transactionamount
  end

  # ===return
  # Float - the Card Balance of the selected recent transaction.
  def getcardbalance
    @cardbalance
  end

  def setvalue(keypaircollection)
    tempcoll = keypaircollection.split(/~/)
    key = tempcoll[0]
    value = tempcoll[1]
    case key
    when "CardNumber"
      @cardnumber = value
    when "TransactionDate"
      @transactiondate = value
    when "TransactionDateAtServer"
      @transactiondateatserver = value
    when "OutletName"
      @outletname = value
    when "OutletCode"
      @outletcode = value
    when "InvoiceNumber"
      @invoicenumber = value
    when "TransactionType"
      @transactiontype = value
    when "TransactionAmount"
      @transactionamount = value
    when "CardBalance"
      @cardbalance = value
    end
  end
end
