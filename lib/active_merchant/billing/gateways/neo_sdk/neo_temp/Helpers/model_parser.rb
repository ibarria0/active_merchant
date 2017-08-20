require_relative '../Entities/request_model'
require_relative '../Gateway/metropago_gateway'
require_relative '../Entities/response_model'
require_relative '../Entities/instrument_response'
require_relative '../Entities/service'
require_relative '../Entities/beneficiary'
require_relative '../Entities/customer_entity_response'
require 'json'

class ModelParser


  def ParseCustomerObject(objHashed)


    #puts objHashed
    buffCustomer = Customer.new(objHashed)

    #Parse and populate CreditCards
    if(buffCustomer.instance_variable_get("@creditCards"))
      #puts 'Has Creditcards'

      cardsArr = buffCustomer.instance_variable_get("@creditCards")
      cardsList = []

      cardsArr.each do |c|

        buffCard = CreditCard.new(c)
        cardsList << buffCard
      end

      buffCustomer.CreditCards = cardsList

    end

    #Parse and populate Accounts
    if(buffCustomer.instance_variable_get("@customerEntities"))
      #puts 'Has Accounts'

      accountsArr = buffCustomer.instance_variable_get("@customerEntities")
      accountsList = []

      accountsArr.each do |acc|

        buffAccount = CustomerEntity.new(acc)

        #parse beneficiary and services
        benificHashed = buffAccount.instance_variable_get("@entityBeneficiary")
        accBeneficiary = ParseCustomerBeneficiary(benificHashed)

        buffAccount.EntityBeneficiary = accBeneficiary

        entityRespHashed = buffAccount.instance_variable_get("@responseDetails")
        custEntResponse = ParseCustomerEntityResponse(entityRespHashed)

        buffAccount.ResponseDetails = custEntResponse

        accountsList << buffAccount

      end
      buffCustomer.CustomerEntities = accountsList
    end

    #Parse and populate paymentInstructions
    if(buffCustomer.instance_variable_get("@paymentInstructions"))

      instructionsArr = buffCustomer.instance_variable_get("@paymentInstructions")
      instructionsList = []

      instructionsArr.each do |inst|

        buffInstruction = Instruction.new(inst)
        instructionsList << buffInstruction

      end
      buffCustomer.PaymentInstructions = instructionsList
    end

    #Parse and populate ACHs
    if(buffCustomer.instance_variable_get("@aCHs"))
      #puts 'Has ACHs'

      achsArr = buffCustomer.instance_variable_get("@aCHs")
      achsList = []

      achsArr.each do |ach|

        buffAch = ACH.new(ach)

        resDetail = buffAch.instance_variable_get("@responseDetails")
        instrumentResp = InstrumentResponse.new(resDetail)

        #parse instrumentResp.ValidationErrors
        valErrs = instrumentResp.instance_variable_get("@validationErrors")
        instrumentResp.ValidationErrors = ValidationError.new(valErrs)


        buffAch.ResponseDetails = instrumentResp

        achsList << buffAch

      end
      buffCustomer.ACHs = achsList
    end

    #Parse and populate billing Addresses
    if(buffCustomer.instance_variable_get("@billingAddress"))


      billingAddressArr = buffCustomer.instance_variable_get("@billingAddress")
      billingAddressArrList = []

      billingAddressArr.each do |ba|

        buffBillAddr = Address.new(ba)
        billingAddressArrList << buffBillAddr

      end
      buffCustomer.BillingAddress = billingAddressArrList
    end

    #Parse and populate shipping Addresses
    if(buffCustomer.instance_variable_get("@shippingAddress"))

      shippingAddressArr = buffCustomer.instance_variable_get("@shippingAddress")
      shippingAddressList = []

      shippingAddressArr.each do |sa|

        buffShipAddr = Address.new(sa)
        shippingAddressList << buffShipAddr

      end

      buffCustomer.ShippingAddress = shippingAddressList
    end

    #Parse and populate ResponseDetails
    if(buffCustomer.instance_variable_get("@responseDetails"))
      #puts 'HAS RESPONSE DETAILS'

      responseDetails = buffCustomer.instance_variable_get("@responseDetails")
      buffResponseDet = CustomerResponse.new(responseDetails)

      #parse inner model as well
      validationErrors = buffResponseDet.instance_variable_get("@validationErrors")
      buffValisationErrors = ValidationError.new(validationErrors)
      buffResponseDet.ValidationErrors = buffValisationErrors

      buffCustomer.ResponseDetails = buffResponseDet


    end

    #Parse and populate Options
    if(buffCustomer.instance_variable_get("@options"))
      #puts 'HAS OPTIONS'

      options = buffCustomer.instance_variable_get("@options")
      buffOptions = CustomerResponse.new(options)

      #parse inner model as well
      validationErrors = buffOptions.instance_variable_get("@validationErrors")
      buffValisationErrors = ValidationError.new(validationErrors)
      buffOptions.ValidationErrors = buffValisationErrors

      buffCustomer.Options = buffOptions


    end

    return buffCustomer

  end



  def ParseCustomerBeneficiary(benificiaryHashed)

    beneficiary = Beneficiary.new(benificiaryHashed)

    #parse Services
    if(beneficiary)

      servicesArr = beneficiary.instance_variable_get("@services")

      servicesLst = []
      if(servicesArr)
        servicesArr.each do |ser|

          buffService = Service.new(ser)
          servicesLst << buffService

        end
      end
      beneficiary.Services = servicesLst
    end

    return beneficiary
  end

  def ParseCustomerEntityResponse(entityResponseHashed)

    custEntResp = CustomerEntityResponse.new(entityResponseHashed)

    validationErrs = custEntResp.instance_variable_get("@validationErrors")

    respValidationErrs = ValidationError.new(validationErrs)

    if(respValidationErrs.instance_variable_get("@errorDetails"))

      errDetailsArr = respValidationErrs.instance_variable_get("@errorDetails")
      if(errDetailsArr)

        validationErrsList = []
        errDetailsArr.each do |ed|

          vErr = ValidationError.new(ed)
          validationErrsList << vErr

        end

        respValidationErrs.ErrorDetails = validationErrsList

      end

    end

    custEntResp.ValidationErrors = respValidationErrs

    return custEntResp

  end

end