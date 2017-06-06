#
# © 2011 QwikCilver Solutions Private Limited, All Rights Reserved.
#
# @author Nityananda
#
#= Overview
#    Class that contains the different Status Codes.
#

require 'pry'

class SVStatus
  public
  # SUCCESS - Return value that indicates SUCCESS
  SUCCESS = 0

  HTTP_OK = 200

  # TOTALS_MATCH_BATCH_CLOSED - Batch Closed/Settlement Done. Totals at the Client end and QwikCilver Server end match.
  TOTALS_MATCH_BATCH_CLOSED = 0

  # TOTALS_MISMATCH_BATCH_CLOSED - Batch Closed/Settlement Done. Totals at the Client End and QwikCilver Server end do not match.
  TOTALS_MISMATCH_BATCH_CLOSED = 99

  # UNKNOWN_ERROR - Unknown Error (Generic Error code).
  UNKNOWN_ERROR = 801

  # INVALID_PARAM - Invalid Parameters, Usually thrown if there are any invalid or type mismatch parameters found.
  INVALID_PARAM = 802

  # NOT_INITIALIZED_ERROR - If a factory method is called without initializing the SV Client library.
  NOT_INITIALIZED_ERROR = 803

  # SERVICE_UNAVAILABLE_ERROR - If server returns a bad response or if the server is down.
  SERVICE_UNAVAILABLE_ERROR = 804

  # OPERATION_FAILED_ERROR - Describes if the requested operation was failed due to various reasons such as server error, network down time etc.,
  OPERATION_FAILED_ERROR = 805

  # CONNECTION_TIMEOUT_ERROR - Thrown if the connection is timed out for the transaction's response.
  CONNECTION_TIMEOUT_ERROR = 806

  # REQUEST_SEND_ERROR - Unable to send the request to the server.
  REQUEST_SEND_ERROR = 807

  # UNSUPPORTED_TYPE_ERROR - The requested interface or the POSType is currently not supported.
  UNSUPPORTED_TYPE_ERROR = 808

  # MISSING_MANDATORY_ATTRIBUTES - One or more of the required attributes missing.
  MISSING_MANDATORY_ATTRIBUTES = 809

  # UNSUPPORTED_POS_TYPE - The requested POSType is currently not supported by the client.
  UNSUPPORTED_POS_TYPE = 810

  # INVALID_VALUE - Invalid value.
  INVALID_VALUE = -1

  private
  ERROR_MESSAGES = {
    SVStatus::UNKNOWN_ERROR => "Encountered Error(UNKNOWN) while performing this operation",
    SVStatus::INVALID_PARAM => "Invalid Parameter",
    SVStatus::NOT_INITIALIZED_ERROR => "SVClient Library is Not Initialized",
    SVStatus::SERVICE_UNAVAILABLE_ERROR => "Service Unavailable",
    SVStatus::OPERATION_FAILED_ERROR => "Operation Failed. Did not receive any response",
    SVStatus::CONNECTION_TIMEOUT_ERROR => "The Connection for this operation timed out",
    SVStatus::REQUEST_SEND_ERROR => "Unable to send the request data to the Server",
    SVStatus::UNSUPPORTED_TYPE_ERROR => "This API currently does not support the requested interface type",
    SVStatus::MISSING_MANDATORY_ATTRIBUTES => "One or More of the Mandatory attributes does not have a valid value",
    SVStatus::UNSUPPORTED_POS_TYPE => "This API currently does not support the requested POSType",
    SVStatus::INVALID_VALUE => "Invalid Code"
  }

  public
  # Use this function to get the proper error message for the respective error code.
  def self.getmessage(code)
    return nil if code == nil
    return SVStatus::ERROR_MESSAGES[INVALID_VALUE] if ERROR_MESSAGES[code] == nil
    return SVStatus::ERROR_MESSAGES[code]
  end

  def self.gethttpmessage(httpresponse)
    return "HTTP Error [ #{httpresponse}]"
  end
end
