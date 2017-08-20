require_relative '../Entities/instrument'
class ACH < Instrument

  def initialize(h = nil)

    if(h != nil)
      h.each {
          |k,v|

        propNameFormatted = k.to_s + "="

        #passing true because we also need to check if property exists in parent class. as it inherits Instrument
        if(ACH.instance_methods(true).include?(propNameFormatted.to_sym))
          public_send("#{k}=",v)
        end
      }
    end

  end

  def AccountNumber=(accountNumber)
    @accountNumber = accountNumber
  end

  def AccountHolder=(accountHolder)
    @accountHolder = accountHolder
  end

  def ChequeNumber=(chequeNumber)
    @chequeNumber = chequeNumber
  end

  #private String AccountNumber;
  #private String AccountHolder;
  #private String ChequeNumber;

end