require_relative '../Entities/customer'
require_relative '../Gateway/metropago_gateway'
require_relative '../Managers/customer_manager'
require_relative '../Entities/customer_search'
require_relative '../Entities/customer_search_option'
require_relative '../Entities/text_filter'
require_relative '../Entities/validation_error'
require_relative '../Entities/customer_entity_response'
require_relative '../Entities/customer_entity'
require 'json'

class CustomerOperations


  def initialize(metropaGatewayObj)
    @metroPagoGateway = metropaGatewayObj
  end

  def SaveCustomer(email,ident)
    cust = Customer.new
    cust.Created = DateTime.now.strftime('%m/%d/%Y')
    cust.Email = email
    cust.UniqueIdentifier = ident

    custMgr = CustomerManager.new(@metroPagoGateway)
    resModel = Customer.new
    resModel = custMgr.SaveCustomer(cust)

    puts 'RESULT - Save Customer:'
    puts JSON.dump resModel.to_h
  end

  def SearchCustomerByIdentifier(identifier)


    custSearch = CustomerSearch.new
    custSearchOpts = CustomerSearchOption.new

    custSearch.UniqueIdentifier = identifier

    custSearchOpts.IncludeAll = false
    custSearchOpts.IncludeAssociatedEntities = true
    custSearchOpts.IncludeCardInstruments = true
    custSearchOpts.IncludePaymentInstructions = true

    custSearch.SearchOption = custSearchOpts

    custMgr = CustomerManager.new(@metroPagoGateway)
    resModel = Customer.new

    customersList = custMgr.SearchCustomer(custSearch)

    puts 'RESULT - Search Customer By Identifier:'

    customersList.each {

      #Display CustomerModel as JSON
      |x| puts JSON.dump x.to_h

      #response Details
      puts 'Response Details:'
      puts JSON.dump x.getResponseDetails.to_h


      #example for getting other properties

      puts "Is Success:"
      puts x.getResponseDetails.getIsSuccess

      puts 'Response Summary: '
      puts x.getResponseDetails.getResponseSummary

      puts "Validation Errors: "
      puts JSON.dump x.getResponseDetails.getValidationErrors.to_h

      puts "Error Summary: "
      puts x.getResponseDetails.getValidationErrors.getErrorSummary

      puts "Error Details: "
      puts x.getResponseDetails.getValidationErrors.getErrorDescription


    }

  end

  def SearchCustomerByFirstName(firstName)


    custSearch = CustomerSearch.new
    custSearchOpts = CustomerSearchOption.new

    custSearchOpts.IncludeAll = false
    custSearchOpts.IncludeAssociatedEntities = true
    custSearchOpts.IncludeCardInstruments = true
    custSearchOpts.IncludePaymentInstructions = true
    custSearchOpts.IncludeCustomFields = true

    custSearch.SearchOption = custSearchOpts

    custSearch.FirstName = TextFilter.new.StartsWith(firstName)

    #puts 'OP: ' + custSearch.instance_variable_get("@firstName").instance_variable_get("@operation")

    custMgr = CustomerManager.new(@metroPagoGateway)
    resModel = custMgr.SearchCustomer(custSearch)

    puts 'RESULT - Search Customer By First Name:'

    resModel.each {
        |x|

      #example display customer as json
      puts x.to_h

      #example get custom field by name
      if(x.getCustomFields())

        custField = x.getCustomFields()
        puts custField["RACE"]

      end


      #example get services
      if(x.getCustomerEntities[0] && x.getCustomerEntities[0].getEntityBeneficiary)
        firstService = x.getCustomerEntities[0].getEntityBeneficiary.getServices[0]
      end

      if(firstService)
        puts "ServiceName: " + firstService.getName

        if(firstService.getCustomFields)
          puts "Custom Fields: "
          firstService.getCustomFields.each do |k,v|
            puts k + " :" + v
          end
        end

      end

    }

  end

  def UpdateCustomerName(identifier, firstName, lastName)

    cust = Customer.new
    cust.UniqueIdentifier = identifier
    cust.FirstName = firstName
    cust.LastName = lastName

    custMgr = CustomerManager.new(@metroPagoGateway)
    resModel = Customer.new
    resModel = custMgr.UpdateCustomer(cust)

    puts 'RESULT - Update Customer:'
    puts resModel.getFirstName + " " + resModel.getLastName
    puts JSON.dump resModel.to_h

    #response Details
    puts 'Response Details:'
    puts JSON.dump resModel.getResponseDetails.to_h

    puts "Is Success:"
    puts resModel.getResponseDetails.getIsSuccess

    puts 'Response Summary: '
    puts resModel.getResponseDetails.getResponseSummary

    puts "Validation Errors: "
    puts JSON.dump resModel.getResponseDetails.getValidationErrors.to_h

    puts "Error Summary: "
    puts resModel.getResponseDetails.getValidationErrors.getErrorSummary

    puts "Error Details: "
    puts resModel.getResponseDetails.getValidationErrors.getErrorDescription

  end

  def AddCardToCustomer(active_merchant_card,identifier)

    customer = GetCustomerByIdentifier(identifier)

    #puts customer.instance_variable_get("@firstName")

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

    custMgr = CustomerManager.new(@metroPagoGateway)
    resultCustomer = Customer.new
    resultCustomer = custMgr.UpdateCustomer(customer)

    puts 'RESULT - Add Cards To Customer:'
    puts JSON.dump resultCustomer.to_h

  end


  def AddAccountToCustomer(identifier)


    customer = GetCustomerByIdentifier(identifier)

    account = CustomerEntity.new
    account.AccountNumber = "001"
    account.CustomerId = customer.getCustomerId #.instance_variable_get("@customerId")
    account.FriendlyName = "PANADATA"
    account.ServiceTypeName = "PREPAID"
    account.Status = "Active"

    accounts = []
    accounts << account

    customer.CustomerEntities = accounts

    custMgr = CustomerManager.new(@metroPagoGateway)
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

        #puts "Error Summary:"
        #puts validationErrs.getErrorSummary
        #puts "Error Description: "
        #puts validationErrs.getErrorDescription
        #puts "Error Details:"

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

  end

  def UpdateAccount(identifier)

    customer = Customer.new
    customer = GetCustomerByIdentifier(identifier)

    accounts = customer.getCustomerEntities #instance_variable_get("@customerEntities")
    puts 'Updating Account: ' + accounts[0].getAccountNumber #accounts[0].instance_variable_get("@accountNumber")


    accounts[0].FriendlyName = "Friendly Test"
    accounts[0].Status = "Active"

    custoMgr = CustomerManager.new(@metroPagoGateway)
    resultCustomer = Customer.new
    resultCustomer = custoMgr.UpdateCustomer(customer)

    puts 'RESULT - Update Customer Account Update:'
    puts JSON.dump resultCustomer.to_h

  end


  def AddPaymentInstructionToCustomer(identifier)

    customer = Customer.new
    customer = GetCustomerByIdentifier(identifier)

    accounts = customer.getCustomerEntities #instance_variable_get("@customerEntities")
    cards = customer.getCreditCards #instance_variable_get("@creditCards")


    card = CreditCard.new
    card = cards[0]

    account = CustomerEntity.new
    account = accounts[0]

    puts card.getToken                #.instance_variable_get("@token")
    puts account.getAccountNumber       #instance_variable_get("@accountNumber")

    instruction = Instruction.new
    instruction.InstrumentToken = card.getToken                   #.instance_variable_get("@token")
    instruction.CustomerEntityValue = account.getAccountNumber         #.instance_variable_get("@accountNumber")
    instruction.ScheduleDay = "15"
    instruction.ExpirationDate = "08/01/2016 12:00:00"
    instruction.CustomerId = customer.getCustomerId     #instance_variable_get("@customerId")
    instruction.Status = "Active"

    instuctions = []
    instuctions << instruction

    customer.PaymentInstructions = instuctions

    custMgr = CustomerManager.new(@metroPagoGateway)
    resultCustomer = Customer.new
    resultCustomer = custMgr.UpdateCustomer(customer)

    puts 'RESULT - Add Instructions To Customer:'
    puts resultCustomer.to_json

  end

  def GetCustomerByIdentifier(identifer)
    custSearch = CustomerSearch.new
    custSearchOpts = CustomerSearchOption.new

    custSearch.UniqueIdentifier = identifer

    custSearchOpts.IncludeAll = false
    custSearchOpts.IncludeAssociatedEntities = true
    custSearchOpts.IncludeCardInstruments = true
    custSearchOpts.IncludePaymentInstructions = true

    custSearch.SearchOption = custSearchOpts

    custMgr = CustomerManager.new(@metroPagoGateway)

    foundCustomersList = custMgr.SearchCustomer(custSearch)

    customer = Customer.new
    customer = foundCustomersList[0];

    #puts customer.instance_variable_get("@firstName")
    #customer.CreditCards = customer.from_json!(customer.instance_variable_get("@creditCards"))
    #puts customer.instance_variable_get("@creditCards")[0]
    #puts '---------------------------------------------------------------------------'

    #customer.CustomerEntities = customer.from_json!(customer.instance_variable_get("@customerEntities"))
   # puts customer.instance_variable_get("@customerEntities")

   # puts '---------------------------------------------------------------------------'

    return customer
  end


end
