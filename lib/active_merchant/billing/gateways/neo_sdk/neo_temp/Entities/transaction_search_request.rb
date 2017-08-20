require_relative '../Helpers/jso_nable'
class TransactionSearchRequest < JSONable

  def TransactionId=(transactionId)
    @transactionId = transactionId
  end

  def OrderTrackingNumber=(orderTrackingNumber)
    @orderTrackingNumber = orderTrackingNumber
  end

  def Token=(token)
    @token = token
  end

  def Amount=(amount) #AmountRangeFilter Type
    @amount = amount
  end

  def DateCreated=(dateCreated) #DateRangeFilter type
    @dateCreated = dateCreated
  end

  def SettledDate=(settledDate) #DateRangeFilter type
    @settledDate = settledDate
  end

  def CardNumber=(cardNumber) #TextFilter type
    @cardNumber = cardNumber
  end

  def CardHolderName=(cardHolderName)
    @cardHolderName = cardHolderName
  end

  def CustomerId=(customerId)
    @customerId = customerId
  end


  #private String TransactionId;
  #private String OrderTrackingNumber;
  #private String Token;
  #private AmountRangeFilter Amount;
  #private DateRangeFilter DateCreated;
  #private DateRangeFilter SettledDate;
  #private TextFilter CardNumber;
  #private TextFilter CardHolderName;

end