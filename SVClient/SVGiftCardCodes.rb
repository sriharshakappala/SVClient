#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#
#=Overview
#   List of Gift card supported transactions and the respective transaction type id's
#

require 'pry'

class SVGiftCardCodes
  PURCHASE_ONLY = 21
  PURCHASE_ONLY_REVERSAL = 105
  ACTIVATE_ONLY = 22
  ACTIVATE_ONLY_REVERSAL = 105
  ACTIVATE = 5
  ACTIVATE_REVERSAL = 105
  CREATE_AND_ISSUE = 5
  CREATE_AND_ISSUE_REVERSAL = 105
  REDEEM = 2
  REDEEM_REVERSAL = 102
  BALANCE = 6
  RELOAD = 3
  RELOAD_REVERSAL = 103
  PARAM_DOWNLOAD = 19
  BATCH_CLOSE = 20
  CANCEL_RELOAD = 13
  CANCEL_RELOAD_REVERSAL = 113
  CANCEL_REDEEM = 12
  CANCEL_REDEEM_REVERSAL = 112
  DEACTIVATE = 4
  CANCEL_ACTIVATE = 28
  CANCEL_ACTIVATE_REVERSAL = 128
  VIEW_LAST_TRANSACTION = 18
  GET_CUSTOMER_INFO = 129
end
