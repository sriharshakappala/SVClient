#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'pry'

require_relative './SVRequest'
require_relative './SVGiftCardCodes'

class SVParamDownload < SVRequest
  def initialize(type)
    super(type)
  end

  protected
  def gettransactiontypeid
    @txntypeid = 0
    case @requestType
    when SVType::WEBPOS_GIFTCARD
      @txntypeid = SVGiftCardCodes::PARAM_DOWNLOAD
    end
    return @txntypeid
  end
end
