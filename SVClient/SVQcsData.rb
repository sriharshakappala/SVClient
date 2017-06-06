#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#
#= Overview
#    Class that contains utility methods.
#

require 'pry'
require 'date'

class SVQcsData
  protected
  @@params = Hash.new

  public
  # Method to get the value from the params array
  def getvalue(key)
    return @@params[key] if (key != nil)
    return nil
  end

  def getvalueasfloat(key)
    return SVUtils.getfloat(getvalue(key)[0])
  end

  def getvalueasint(key)
    value = getvalue(key)
    return value[0].to_i if(value != nil && !SVUtils::isnullorempty(value[0]))
    return nil
  end

  # Method to set the value to the params array
  def setvalue(key, value)
    @@params[key] = value
  end

  #Method to get the value in certain date format
  def getdate(key, format)
    @value = getvalue(key)
    return SVUtils::getdate(@value, format)
  end

  # Method to print the parameters
  def printparams
    return if @@params.empty?
    @@params.each {|key, value| puts "#{key} : #{value}" }
  end
end
