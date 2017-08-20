require_relative '../Entities/transaction'
require_relative '../Entities/transaction_response'
require_relative '../Entities/request_model'
require_relative '../Entities/response_model'
require_relative '../Entities/address'
require_relative '../Entities/customer_entity'
require_relative '../Entities/credit_card'
require_relative '../Entities/customer'
require_relative '../Helpers/model_parser'
require 'json'
class TransactionManager

  def initialize(metropagoGatewayObject)
    @metropagoGatewayObject = metropagoGatewayObject
  end

  #Sale
  def Sale(transactionRequest)

    tranxOptions = TransactionOptions.new
    tranxOptions.Operation = "Sale"
    transactionRequest.TransactOptions = tranxOptions
    return PerformTransaction(transactionRequest)

  end

  #PreAuthorization
  def PreAuthorization(transactionRequest)

    tranxOptions = TransactionOptions.new
    tranxOptions.Operation = "PreAuthorization"
    transactionRequest.TransactOptions = tranxOptions
    return PerformTransaction(transactionRequest)

  end

  #Adjustment
  def Adjustment(transactionRequest)

    tranxOptions = TransactionOptions.new
    tranxOptions.Operation = "Adjustment"
    transactionRequest.TransactOptions = tranxOptions
    return PerformTransaction(transactionRequest)

  end

  #Refund
  def Refund(transactionRequest)

    tranxOptions = TransactionOptions.new
    tranxOptions.Operation = "Refund"
    transactionRequest.TransactOptions = tranxOptions
    return PerformTransaction(transactionRequest)

  end

  #Search Transactions
  def SearchTransaction(transactionSearchRequest)
    reqData = CreateRequestObject(transactionSearchRequest)
    apiHelper = APIHelper.new
    responseModel = ResponseModel.new

    responseModel = apiHelper.SendAPIRequest(reqData, @metropagoGatewayObject.instance_variable_get("@gatewayURL") + "Transaction/SearchTransaction")
    if (responseModel && responseModel.instance_variable_get("@responseMessage"))
      transactionsLst = ParseTransactionSearchResult(responseModel)
    end

    return transactionsLst
  end

  #Update Transaction
  def UpdateTransaction(transactionRequest)

    reqData = CreateRequestObject(transactionRequest)
    apiHelper = APIHelper.new
    responseModel = ResponseModel.new
    responseModel = apiHelper.SendAPIRequest(reqData, @metropagoGatewayObject.instance_variable_get("@gatewayURL") + "Transaction/UpdateTransactionStatus")

    responseTranxObject = Transaction.new

    if (responseModel && responseModel.instance_variable_get("@responseMessage"))
      responseMsg = responseModel.instance_variable_get("@responseMessage")
      responseMsgParced = JSON.parse(responseMsg)
      responseTranxObject = ParseTransactionObject(responseMsgParced)
    end

    return responseTranxObject

  end

  #Private Methods
  private
  def PerformTransaction(transactionObject)

    reqData = CreateRequestObject(transactionObject)
    apiHelper = APIHelper.new
    responseModel = ResponseModel.new
    responseModel = apiHelper.SendAPIRequest(reqData, @metropagoGatewayObject.instance_variable_get("@gatewayURL") + "Transaction/PerformTransaction")

    responseTranxObject = Transaction.new

    if (responseModel && responseModel.instance_variable_get("@responseMessage"))
      responseMsg = responseModel.instance_variable_get("@responseMessage")
      responseMsgParced = JSON.parse(responseMsg)
      responseTranxObject = ParseTransactionObject(responseMsgParced)
    end

    return responseTranxObject

  end

  def CreateRequestObject(object)
    requestData = RequestModel.new
    requestData.TerminalId = @metropagoGatewayObject.instance_variable_get("@terminalId")
    requestData.Identification = @metropagoGatewayObject.instance_variable_get("@merchantId")
    requestData.SDKVersion = @metropagoGatewayObject.instance_variable_get("@sdkVersion")
    requestData.Culture = @metropagoGatewayObject.instance_variable_get("@culture")
    requestData.MerchantId = @metropagoGatewayObject.instance_variable_get("@merchantId")
    requestData.EnableLogs = @metropagoGatewayObject.instance_variable_get("@enableLogs")
    requestData.RequestMessage = JSON.dump object.to_h

    #puts requestData.instance_variable_get("@requestMessage")

    return requestData

  end

  def ParseTransactionObject(responseMsgParced)

    modelParsingHelper = ModelParser.new

    #puts responseMsgParced
    transaction = Transaction.new(responseMsgParced)


    #parse and populate TransactionResponse
    if(transaction.instance_variable_get("@responseDetails"))
      responseDetails = transaction.instance_variable_get("@responseDetails")
      responseDet = TransactionResponse.new(responseDetails)


      #parse TransactionResponse -> ValidationErrors
      validationErrsHashed = responseDet.getValidationErrors
      validationErrors = ValidationError.new(validationErrsHashed)

      if(validationErrors.instance_variable_get("@errorDetails"))

        errDetailsArr = validationErrors.instance_variable_get("@errorDetails")
        if(errDetailsArr)

          validationErrsList = []
          errDetailsArr.each do |ed|

            vErr = ValidationError.new(ed)
            validationErrsList << vErr

          end

          validationErrors.ErrorDetails = validationErrsList

        end

      end

      responseDet.ValidationErrors = validationErrors

      transaction.ResponseDetails = responseDet
    end



    #Parse and populate CustomerData
    transaction.CustomerData = modelParsingHelper.ParseCustomerObject(transaction.getCustomerData)

    #Parse and populate billing Addresses
    if(transaction.getBillingAddress)

      ba = transaction.getBillingAddress

      buffBillAddr = Address.new(ba)

      transaction.BillingAddress = buffBillAddr
    end

    #Parse and populate shipping Addresses
    if(transaction.getShippingAddress)

      sa = transaction.getShippingAddress
      buffShipAddr = Address.new(sa)

      transaction.ShippingAddress = buffShipAddr
    end

    #Parse and populate CreditCards
    if(transaction.getCreditCardDetail)
      #puts 'Has Creditcards'

      cardDetail = transaction.getCreditCardDetail

      buffCard = CreditCard.new(cardDetail)

      transaction.CreditCardDetail = buffCard

    end


    #Parse and populate Accounts
    if(transaction.getCustomerEntityDetail)
      #puts 'Has Accounts'

      accountsDet = transaction.getCustomerEntityDetail

      buffAccount = CustomerEntity.new(accountsDet)

      #parse beneficiary and services
      benificHashed = buffAccount.instance_variable_get("@entityBeneficiary")
      accBeneficiary = modelParsingHelper.ParseCustomerBeneficiary(benificHashed)

      buffAccount.EntityBeneficiary = accBeneficiary

      entityRespHashed = buffAccount.instance_variable_get("@responseDetails")
      custEntResponse = modelParsingHelper.ParseCustomerEntityResponse(entityRespHashed)

      buffAccount.ResponseDetails = custEntResponse

      transaction.CustomerEntityDetail = buffAccount

    end

    return transaction

  end

  def ParseTransactionSearchResult(responseModel)

    responseMsg = responseModel.instance_variable_get("@responseMessage")
    transactionsArray = JSON.parse(responseMsg)

    transactionsList = []

    modelParsingHelper = ModelParser.new

    transactionsArray.each do |tranx|

      #creatd transaction object with tranx
      transaction = ParseTransactionObject(tranx)

      transactionsList << transaction
    end

    return transactionsList
  end

end