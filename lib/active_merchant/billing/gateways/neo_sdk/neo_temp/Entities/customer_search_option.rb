require_relative '../Helpers/jso_nable'
class CustomerSearchOption < JSONable

  def IncludeAll=(includeAll)
    @includeAll = includeAll
  end

  def IncludeCardInstruments=(includeCardInstruments)
    @includeCardInstruments = includeCardInstruments
  end

  def IncludeACHInstruments=(includeACHInstruments)
    @includeACHInstruments = includeACHInstruments
  end

  def IncludeWallet=(includeWallet)
    @includeWallet = includeWallet
  end

  def IncludeAssociatedEntities=(includeAssociatedEntities)
    @includeAssociatedEntities = includeAssociatedEntities
  end

  def IncludeBillingAddress=(includeBillingAddress)
    @includeBillingAddress = includeBillingAddress
  end

  def IncludeShippingAddress=(includeShippingAddress)
    @includeShippingAddress = includeShippingAddress
  end

  def IncludeCustomFields=(includeCustomFields)
    @includeCustomFields = includeCustomFields
  end

  def UpdateCustomerEntityBalance=(updateCustomerEntityBalance)
    @updateCustomerEntityBalance = updateCustomerEntityBalance
  end

  def IncludePaymentInstructions=(includePaymentInstructions)
    @includePaymentInstructions = includePaymentInstructions
  end

  #private boolean IncludeAll;
  #private boolean IncludeCardInstruments;
  #private boolean IncludeACHInstruments;
  #private boolean IncludeWallet;
  #private boolean IncludeAssociatedEntities;
  #private boolean IncludeBillingAddress;
  #private boolean IncludeShippingAddress;
  #private boolean IncludeCustomFields;
  #private boolean UpdateCustomerEntityBalance;
  #private boolean IncludePaymentInstructions;

end