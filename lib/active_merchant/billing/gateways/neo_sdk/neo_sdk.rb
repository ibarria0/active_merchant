require 'active_merchant/billing/gateways/neo_sdk/Entities/customer'
require 'active_merchant/billing/gateways/neo_sdk/Gateway/metropago_gateway'
require 'active_merchant/billing/gateways/neo_sdk/Managers/customer_manager'
require 'active_merchant/billing/gateways/neo_sdk/Entities/response_model'
require 'active_merchant/billing/gateways/neo_sdk/TestCases/customer_operations'
require 'active_merchant/billing/gateways/neo_sdk/TestCases/transaction_operations'

module NeoSDK
    def self.build_sdk
        mpago = MetropagoGateway.new("SANDBOX", "100177", "100177001", "AERT99HY")
        puts 'METROPAGO - CLIENT SDK'
        puts 'RUBY VERSION: ' + RUBY_VERSION.to_s
        mpago.Culture = "es"
        return mpago
    end

    def self.perform_sale(mpago,customer,amount)
 
      tranxRequest = Transaction.new
 
      #Transaction Info
      tranxRequest.CustomerData = customer
      tranxRequest.Amount = amount
      tranxRequest.OrderTrackingNumber = "777AAAAA"
  
      tranxMgr = TransactionManager.new(mpago)
      responseTranxModel = tranxMgr.Sale(tranxRequest)
  
      puts 'RESULT - Perform Sale:'
      responseDetails = responseTranxModel.getResponseDetails
  
      if(responseDetails && responseDetails.getIsSuccess == true)
        puts 'Transaction Processed Successfullly. Transaction Id: ' + responseDetails.getTransactionId
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


    def self.save_customer(mpago,email,ident)
      cust = Customer.new
      cust.Created = DateTime.now.strftime('%m/%d/%Y')
      cust.Email = email
      cust.UniqueIdentifier = ident
  
      custMgr = CustomerManager.new(mpago)
      resModel = Customer.new
      resModel = custMgr.SaveCustomer(cust)
  
      puts 'RESULT - Save Customer:'
      puts JSON.dump resModel.to_h
      return resModel
    end

    def self.get_customer_id(mpago,identifier)
      #puts customer.instance_variable_get("@firstName")
      p mpago
      p identifier
      GetCustomerByIdentifier(mpago,identifier)
    end

    def self.add_card_to_customer(mpago,active_merchant_card,customer)
      card = CreditCard.new
      card.CardholderName = active_merchant_card.name
      card.Status = active_merchant_card.valid? ? "Active" : "Inactive"
      card.SetExpiration(active_merchant_card.month.to_s, active_merchant_card.year.to_s)
      card.Number = active_merchant_card.number
  
      #custom Fields for Card
      customFields = {}
      customFields.store("TrustLevel", "5")
      customFields.store("AllowSwipe", "true")
 
      card.CustomFields = customFields
      card.CustomerId = customer.getCustomerId #.instance_variable_get("@customerId")
  
      #add card to list. Becaue customer object holds list of it's associated cards
      creditCards = []
      creditCards << card
  
      #attach cards to customers
      customer.CreditCards = creditCards
 
      custMgr = CustomerManager.new(mpago)
      resultCustomer = Customer.new
      resultCustomer = custMgr.UpdateCustomer(customer)
 
      puts 'RESULT - Add Cards To Customer:'
      puts JSON.dump resultCustomer.to_h
      return resultCustomer
    end

    def self.add_account_to_customer(mpago,customer)
      account = CustomerEntity.new
      account.AccountNumber = "001"
      account.CustomerId = customer.getCustomerId #.instance_variable_get("@customerId")
      account.FriendlyName = "PANADATA"
      account.ServiceTypeName = "PREPAID"
      account.Status = "Active"
  
      accounts = []
      accounts << account
  
      customer.CustomerEntities = accounts
  
      custMgr = CustomerManager.new(mpago)
      resultCustomer = custMgr.UpdateCustomer(customer)
  
      puts 'RESULT - Add Account To Customer:'
      puts JSON.pretty_generate resultCustomer.to_h
  
      puts 'Customer Entity Response:'
      if(resultCustomer.getCustomerEntities[0] && resultCustomer.getCustomerEntities[0].getResponseDetails)
   
        customerEntityResponse = resultCustomer.getCustomerEntities[0].getResponseDetails
        puts "Success: "
        puts customerEntityResponse.getIsSuccess
  
        puts "Response Summary: "
        puts customerEntityResponse.getResponseSummary
  
        if(customerEntityResponse.getValidationErrors)
          validationErrs = customerEntityResponse.getValidationErrors
          if(validationErrs.getErrorDetails)
            validationErrs.getErrorDetails.each do |ed|
              puts "Error Summary:"
              puts ed.getErrorSummary
              puts "Error Description: "
              puts ed.getErrorDescription
            end
          end
        end
      end
      return resultCustomer
    end

   def self.GetCustomerByIdentifier(mpago,identifer)
     custSearch = CustomerSearch.new
     custSearchOpts = CustomerSearchOption.new
 
     custSearch.UniqueIdentifier = identifer
 
     custSearchOpts.IncludeAll = false
     custSearchOpts.IncludeAssociatedEntities = true
     custSearchOpts.IncludeCardInstruments = true
     custSearchOpts.IncludePaymentInstructions = false
 
     custSearch.SearchOption = custSearchOpts
 
     custMgr = CustomerManager.new(mpago)
 
     foundCustomersList = custMgr.SearchCustomer(custSearch)
 
     customer = Customer.new
     customer = foundCustomersList[0];
 
     return customer
   end

 


end
