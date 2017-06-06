#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#
#=Overview
#   Class used by GCWebPos to perform Redeem transaction
#

require 'pry'

require_relative './SVRequest'
require_relative './SVGiftCardCodes'
require_relative './SVType'

class SVRedeem < SVRequest
  def initialize(type)
    super(type)
  end

  protected
  def gettransactiontypeid
    @txntypeid = 0
    case @requestType
    when SVType::WEBPOS_GIFTCARD
      @txntypeid = SVGiftCardCodes::REDEEM
    end
    return @txntypeid
  end
end
