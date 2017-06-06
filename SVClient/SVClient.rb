#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#

require 'pry'

require_relative './SVParamDownload'

class SVClient
  public
  def self.initlibrary(svprops)
    return SVClient::getparamsfromserver(svprops)
  end

  private
  def self.getparamsfromserver(svprops)
    if(svprops == nil)
      @retprops = SVProperties.new()
      @retprops.seterrorcode(SVStatus::INVALID_PARAM)
      @retprops.seterrormessage(SVStatus::getmessage(SVStatus::INVALID_PARAM))
      return @retprops
    end

    case svprops.getsvtype
    when SVType::WEBPOS_GIFTCARD
      @svrequest = SVClient::getwebposgiftcardparamdownload(svprops)
    else
      return SVStatus::UNSUPPORTED_TYPE_ERROR
    end

    @svresponse = @svrequest.execute()
    @retval = @svresponse.geterrorcode()
    if (@retval != SVStatus::SUCCESS.to_i)
      @retprops = SVProperties.new()
      @retprops.seterrorcode(@retval)
      @retprops.seterrormessage(@svresponse.geterrormessage())
      return @retprops
    end

    @serverprops = SVProperties.new(svprops)
    @serverprops.settransactionid(@svresponse.gettransactionid)
    @serverprops.setposentrymode(@svresponse.getposentrymode)
    @serverprops.setpostypeid(@svresponse.getpostypeid)
    @serverprops.setacquirerid(@svresponse.getacquirerid)
    @serverprops.setorganizationname(@svresponse.getorganizationname)
    @serverprops.setmerchantname(@svresponse.getmerchantname)
    @serverprops.setmerchantoutletname(@svresponse.getmerchantoutletname)
    @serverprops.setposname(@svresponse.getposname)
    @serverprops.setcurrentbatchnumber(@svresponse.getcurrentbatchnumber)
    @serverprops.seterrorcode(@svresponse.geterrorcode)
    @serverprops.seterrormessage(@svresponse.geterrormessage)
    return @serverprops
  end

  def self.getwebposgiftcardparamdownload(svprops)
    @svrequest = SVParamDownload.new(svprops)
    @svrequest.setforwardingentityid(svprops.getforwardingentityid())
    @svrequest.setforwardingentitypassword(svprops.getforwardingentitypassword())
    @svrequest.setterminalid(svprops.getterminalid())
    @svrequest.setusername(svprops.getusername())
    @svrequest.setpassword(svprops.getpassword())
    @svrequest.settransactionid(1)
    return @svrequest
  end
end
