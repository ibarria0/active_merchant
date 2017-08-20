require_relative '../Entities/customer'
require_relative '../Gateway/metropago_gateway'
require_relative '../Managers/customer_manager'
require_relative '../Entities/customer_search'
require_relative '../Entities/customer_search_option'
require_relative '../Entities/text_filter'
require_relative '../Entities/transaction'
require_relative '../Entities/transaction_options'
require_relative '../Entities/transaction_response'
require_relative '../Managers/transaction_manager'
require_relative '../Entities/amount_range_filter'
require_relative '../Entities/date_range_filter'
require_relative '../Entities/transaction_search_request'

class TransactionOperations

  def initialize(metropaGatewayObj)
    @metroPagoGateway = metropaGatewayObj
  end

  def PerformSale(customer,amount)

    tranxRequest = Transaction.new

    #Transaction Info
    tranxRequest.CustomerData = customer
    tranxRequest.Amount = amount
    tranxRequest.OrderTrackingNumber = "777AAAAA"

    tranxMgr = TransactionManager.new(@metroPagoGateway)
    responseTranxModel = tranxMgr.Sale(tranxRequest)


    puts 'RESULT - Perform Sale:'
    responseDetails = responseTranxModel.getResponseDetails

    if(responseDetails && responseDetails.getIsSuccess == true)
      puts 'Transaction Processed Successfullly. Transaction Id: ' + responseDetails.getTransactionId

      #example accessing inner models
      #if(responseTranxModel.getCustomerData)
      #  customerCards = responseTranxModel.getCustomerData.getCreditCards
      #  puts customerCards[0].getCardHolder
      #end


    else
      puts responseDetails.getResponseSummary
    end

    if(responseDetails.getValidationErrors)
      vErrors = responseDetails.getValidationErrors
      if(vErrors.getErrorDetails)

        vErrors.getErrorDetails.each do |ed|

          puts "Error Summary:"
          puts ed.getErrorSummary
          puts "Error Description: "
          puts ed.getErrorDescription

        end

      end
    end


  end

  def PerformPreAuthorization(customerId)

    tranxRequest = Transaction.new
    customer = Customer.new

    #card Info
    creditCards = []
    card = CreditCard.new
    card.Token = "d9be6fa6-c60c-4638-88c0-841216e450d6"
    creditCards << card

    #Account Info
    accounts = []
    account = CustomerEntity.new
    account.Id = "9680"
    accounts << account

    #customer Info
    customer.CustomerId = customerId
    customer.CreditCards = creditCards
    customer.CustomerEntities = accounts

    #Transaction Info
    tranxRequest.CustomerData = customer
    tranxRequest.Amount = 1.00
    tranxRequest.OrderTrackingNumber = "777AAAAA"

    tranxMgr = TransactionManager.new(@metroPagoGateway)
    responseTranxModel = tranxMgr.PreAuthorization(tranxRequest)


    puts 'RESULT - PreAuthorization:'
    responseDetails = responseTranxModel.getResponseDetails

    if(responseDetails.getIsSuccess == true)
      puts 'Transaction Processed Successfullly. Transaction Id: ' + responseDetails.getTransactionId
    else
      puts responseDetails.getResponseSummary
    end


  end

  def PerformAdjustment(customerId)

    tranxRequest = Transaction.new
    tranxRequest.TransactionId = "102747845"
    tranxRequest.Amount = 1.00

    tranxMgr = TransactionManager.new(@metroPagoGateway)
    responseTranxModel = tranxMgr.Adjustment(tranxRequest)

    puts 'RESULT - Adjustment:'
    responseDetails = responseTranxModel.getResponseDetails

    if(responseDetails.getIsSuccess == true)
      puts 'Transaction Processed Successfullly. Transaction Id: ' + responseDetails.getTransactionId
    else
      puts responseDetails.getResponseSummary
    end

  end

  def PerformRefund(customerId)

    tranxRequest = Transaction.new
    tranxRequest.TransactionId = "102747819"
    tranxRequest.Amount = 1.00

    tranxMgr = TransactionManager.new(@metroPagoGateway)
    responseTranxModel = tranxMgr.Refund(tranxRequest)

    puts 'RESULT - Refund:'
    responseDetails = responseTranxModel.getResponseDetails

    if(responseDetails.getIsSuccess == true)
      puts 'Transaction Processed Successfullly. Transaction Id: ' + responseDetails.getTransactionId
    else
      puts responseDetails.getResponseSummary
    end

  end

  def SearchTransactions(cutomerId)

    searchRequest = TransactionSearchRequest.new
    searchRequest.Amount = AmountRangeFilter.new.Between(0.00, 2.00)
    searchRequest.CardHolderName = TextFilter.new.StartsWith("ZEE")

    #searchRequest.TransactionId = "102747816"

    searchRequest.CustomerId = cutomerId

    tranxMgr = TransactionManager.new(@metroPagoGateway)
    transactions = tranxMgr.SearchTransaction(searchRequest)

    transactions.each do |tranx|
      puts tranx.getTransactionId + " - " + tranx.getAmount.to_s + " - " + tranx.getCreditCardDetail.to_json
    end

  end


  def PerformUpdateTransaction(customerId)

    tranxRequest = Transaction.new
    tranxRequest.ThirdPartyDescription = "Account Payment ABC123"
    tranxRequest.ThirdPartyStatus = "POSTED"
    tranxRequest.TransactionId = "102747859"


    tranxMgr = TransactionManager.new(@metroPagoGateway)
    responseTranxModel = tranxMgr.UpdateTransaction(tranxRequest)

    puts 'RESULT - Update Transaction:'
    responseDetails = responseTranxModel.getResponseDetails

    if(responseDetails.getIsSuccess == true)
      puts 'Transaction Updated Successfullly. Transaction Id: ' + responseDetails.getTransactionId
    else
      puts responseDetails.getResponseSummary
    end

  end


end
