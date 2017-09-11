require_relative '../Helpers/api_helper'
require_relative '../Entities/request_model'
require_relative '../Gateway/metropago_gateway'
require_relative '../Entities/response_model'
require_relative '../Entities/instrument_response'
require_relative '../Entities/service'
require_relative '../Entities/beneficiary'
require_relative '../Entities/customer_entity_response'
require_relative '../Helpers/model_parser'
require 'json'

class CustomerManager
  def initialize(metropagoGatewayObject)
    @metropagoGatewayObject = metropagoGatewayObject
  end

  #Save Customer
  def SaveCustomer(customerObject)

    return SaveCustomerInternal(customerObject)

  end

  #Update Customer
  def UpdateCustomer(customerObject)

    return SaveCustomerInternal(customerObject)

  end

  #Search Customer
  #Returns List of Customer objects
  def SearchCustomer(customerFilters) #CustomerSearch type
    reqData = CreateRequestObject(customerFilters)
    apiHelper = APIHelper.new
    responseModel = ResponseModel.new
    responseModel = apiHelper.SendAPIRequest(reqData, @metropagoGatewayObject.instance_variable_get("@gatewayURL") + "Customer/GetCustomersByFilter")

    #if response object is not nill, and
    # response.ResponseMessage (customer model) is
    # not nill, deserialize it.
    customersList = []
    if (responseModel && responseModel.instance_variable_get("@responseMessage"))
      #puts "RESULT-INSIDE: " + responseModel.instance_variable_get("@responseMessage")
      #Search Customers returns array of customers from API
      responseMsgArr = responseModel.instance_variable_get("@responseMessage")

      modelParsingHelper = ModelParser.new
      objArray = JSON.parse(responseMsgArr)
      objArray.each do |obj|
        buffCustomer = modelParsingHelper.ParseCustomerObject(obj)
        if(buffCustomer)
          customersList << buffCustomer
        end
      end
    end
    return customersList
  end


  #Private Methods
  private

  def SaveCustomerInternal(cutomerObject)

    reqData = CreateRequestObject(cutomerObject)
    apiHelper = APIHelper.new
    responseModel = ResponseModel.new
    responseModel = apiHelper.SendAPIRequest(reqData, @metropagoGatewayObject.instance_variable_get("@gatewayURL") + "Customer/SaveCustomerInformation")

    modelParsingHelper = ModelParser.new

    #if response object is not nill, and
    # response.ResponseMessage (customer model) is
    # not nill, deserialize it.

    if (responseModel && responseModel.instance_variable_get("@responseMessage"))

      #responseCustomerObj.from_json!(responseModel.instance_variable_get("@responseMessage"))


      responseMsg = responseModel.instance_variable_get("@responseMessage")
      responseCustomerHashed = JSON.parse(responseMsg)
      responseCustomerObj = modelParsingHelper.ParseCustomerObject(responseCustomerHashed)

    end

    return responseCustomerObj

  end


  def CreateRequestObject(object)
    requestData = RequestModel.new
    requestData.TerminalId = @metropagoGatewayObject.instance_variable_get("@terminalId")
    requestData.Identification = @metropagoGatewayObject.instance_variable_get("@merchantId")
    requestData.SDKVersion = @metropagoGatewayObject.instance_variable_get("@sdkVersion")
    requestData.Culture = @metropagoGatewayObject.instance_variable_get("@culture")
    requestData.EnableLogs = @metropagoGatewayObject.instance_variable_get("@enableLogs")
    requestData.RequestMessage = JSON.dump object.to_h

    return requestData

  end





end
