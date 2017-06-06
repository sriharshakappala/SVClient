#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#
#= Overview
#    Class that contains utility methods.
#

require 'pry'

require_relative './SVGiftRecentTransactions'

class SVUtils
  QC_DATE_TIME_FORMAT = '%d%m%Y%H%M%S'
  QC_DATE_FORMAT = '%d%m%Y'

  def self.isnullorempty (value)
    return true if (value == nil)
    value = value.to_s
    return ((value.strip.length) <= 0) ? true : false
  end

  require 'date'

  def self.getdate (value, format = nil)
    return nil if isnullorempty(value)
    return nil if isnullorempty(format)
    begin
      return DateTime.strptime(value, format)
    rescue
      return nil
    end
  end

  def self.getcurrentdate
    d = DateTime.now
    return d.strftime(SVUtils::QC_DATE_TIME_FORMAT)
  end

  # Function to format the currency to standard notation which was received from server's locale currency format.
  def self.getfloat(value)
    retval = -1
    value = (value == nil) ? "" : value.to_s.strip()

    return -1 if (value.length <= 0)

    iindex = value.index(/[.]/, 0)
    if (iindex == nil)
      return value.gsub(/[^0-9]/, "").to_f
    else
      decimalpart = value[iindex + 1, value.length]
      wholepart = value[0, iindex]
      ilen = decimalpart.length
      if( (ilen == 1) || (ilen == 2) || (ilen == 3) )
        fullnumber = wholepart.gsub(/[^0-9]/, "")
        fullnumber = fullnumber + "." + decimalpart
      else
        fullnumber = value.gsub(/[^0-9]/, "")
      end
    end

    begin
      retval = fullnumber.to_f
    rescue
      retval = -1
    end
    return retval
  end

  def self.parsegiftrecenttransactions(value)
    arr = Array.new
    value[0].split(/[{]/n).each do |row|
      next if (row == nil || row == "")
      grt = SVGiftRecentTransactions.new
      row.chomp('}').split(/[|]/).each do |keypaircollection|
        grt.setvalue(keypaircollection)
      end
      arr << grt
    end
    return arr
  end
end
