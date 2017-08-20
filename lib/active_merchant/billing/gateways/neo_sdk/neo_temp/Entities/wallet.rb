require_relative '../Entities/instrument'
class Wallet < Instrument

  def WalletNumber=(walletNumber)
    @walletNumber = walletNumber
  end

  def WalletHolder=(walletHolder)
    @walletHolder = walletHolder
  end

  def WalletBalance=(walletBalance) #double type
    @walletBalance = walletBalance
  end

  #private String WalletNumber;
  #private String WalletHolder;
  #private double WalletBalance;

end