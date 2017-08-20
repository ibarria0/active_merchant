require 'cgi'
require 'neo_sdk/neo_sdk'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    class NeoSDKGateway < Gateway
      self.test_url = 'https://gateway.merchantprocess.net/api/test-v3/api/'
      self.live_url = 'https://gateway12.merchantprocess.net/sdk/api/'

      self.money_format = :dollars
      self.supported_countries = ['PA']
      self.default_currency = 'USD'
      self.supported_cardtypes = [:visa, :master, :american_express, :discover]

      self.homepage_url = 'http://www.example.net/'
      self.display_name = 'Neo Gateway'

      SUCCESS_MESSAGE = "Success"

      SUCCESS_CODES = [
        "00", "11"
      ]

      STANDARD_ERROR_CODE_MAPPING = {
        #"00" => "Ok , or Approved",
        "01" => STANDARD_ERROR_CODE[:call_issuer],
        "02" => STANDARD_ERROR_CODE[:call_issuer],
        "03" => "Invalid Merchant",
        "04" => STANDARD_ERROR_CODE[:pickup_card],
        "05" => STANDARD_ERROR_CODE[:card_declined],
        "06" => STANDARD_ERROR_CODE[:call_issuer],
        "07" => STANDARD_ERROR_CODE[:pickup_card],
        "08" => "Error in File ISOBMP",
        "09" => STANDARD_ERROR_CODE[:card_declined],
        "10" => STANDARD_ERROR_CODE[:card_declined],
        #"11" => "Ok , or Approved",
        "12" => "Invalid Transaction",
        "13" => "Invalid Amount",
        "14" => STANDARD_ERROR_CODE[:invalid_number],#"Invalid Card",
        "15" => "Non Existent Issuer",
        "16" => STANDARD_ERROR_CODE[:card_declined],
        "17" => "Invalid Date Capture",
        "18" => STANDARD_ERROR_CODE[:card_declined],
        "19" => "Retry Transaction later. Processor timed out.",
        "20" => STANDARD_ERROR_CODE[:card_declined],
        "21" => "Invalid Reverse. Reference transaction does not exist.",
        "22" => STANDARD_ERROR_CODE[:card_declined],
        "23" => STANDARD_ERROR_CODE[:card_declined],
        "24" => STANDARD_ERROR_CODE[:card_declined],
        "25" => STANDARD_ERROR_CODE[:card_declined],
        "26" => STANDARD_ERROR_CODE[:card_declined],
        "27" => STANDARD_ERROR_CODE[:card_declined],
        "28" => STANDARD_ERROR_CODE[:card_declined],
        "29" => STANDARD_ERROR_CODE[:card_declined],
        "30" => "Format Error",
        "31" => "Bank not Allowed",
        "32" => STANDARD_ERROR_CODE[:card_declined],
        "33" => STANDARD_ERROR_CODE[:card_declined],
        "34" => STANDARD_ERROR_CODE[:card_declined],
        "35" => STANDARD_ERROR_CODE[:card_declined],
        "36" => STANDARD_ERROR_CODE[:card_declined],
        "37" => STANDARD_ERROR_CODE[:card_declined],
        "38" => STANDARD_ERROR_CODE[:card_declined],
        "39" => "Invalid Transaction.",
        "40" => STANDARD_ERROR_CODE[:card_declined],
        "41" => STANDARD_ERROR_CODE[:pickup_card],
        "42" => STANDARD_ERROR_CODE[:card_declined],
        "43" => STANDARD_ERROR_CODE[:pickup_card],
        "44" => STANDARD_ERROR_CODE[:card_declined],
        "45" => STANDARD_ERROR_CODE[:card_declined],
        "46" => STANDARD_ERROR_CODE[:card_declined],
        "47" => STANDARD_ERROR_CODE[:card_declined],
        "48" => STANDARD_ERROR_CODE[:card_declined],
        "49" => STANDARD_ERROR_CODE[:card_declined],
        "50" => STANDARD_ERROR_CODE[:card_declined],
        "51" => "Insufficient Funds",
        "52" => "Invalid Account",
        "53" => "Invalid Account",
        "54" => "Expired Card",
        "55" => "Invalid PIN",
        "56" => STANDARD_ERROR_CODE[:card_declined],
        "57" => STANDARD_ERROR_CODE[:card_declined],
        "58" => "Invalid Transaction",
        "59" => STANDARD_ERROR_CODE[:card_declined],
        "60" => STANDARD_ERROR_CODE[:card_declined],
        "61" => STANDARD_ERROR_CODE[:card_declined],
        "62" => STANDARD_ERROR_CODE[:card_declined],
        "63" => "Error MAC Key",
        "64" => STANDARD_ERROR_CODE[:card_declined],
        "65" => STANDARD_ERROR_CODE[:card_declined],
        "66" => STANDARD_ERROR_CODE[:card_declined],
        "67" => STANDARD_ERROR_CODE[:pickup_card],
        "68" => "Error, Slow Response",
        "69" => STANDARD_ERROR_CODE[:card_declined],
        "70" => "Declined. Transaction previously approved. If you are trying to submit an ",
        "71" => STANDARD_ERROR_CODE[:card_declined],
        "72" => STANDARD_ERROR_CODE[:card_declined],
        "73" => STANDARD_ERROR_CODE[:card_declined],
        "74" => STANDARD_ERROR_CODE[:card_declined],
        "75" => STANDARD_ERROR_CODE[:card_declined],
        "76" => "Declined. An approved preauthorization does not exist.",
        "77" => "Error in Close",
        "78" => "Trace Not Found",
        "79" => "Error in Key",
        "80" => "# Batch not Found",
        "81" => "TC not DB/CR",
        "82" => "REF. doesn't Exist",
        "83" => "Direct TX Doesn't Exist",
        "84" => "Invalid Life Cycle",
        "85" => STANDARD_ERROR_CODE[:card_declined],
        "86" => STANDARD_ERROR_CODE[:card_declined],
        "87" => STANDARD_ERROR_CODE[:incorrect_pin],#"Error en llave del PIN",
        "88" => "Error, Sync MAC",
        "89" => "Error, in TID",
        "90" => "Service not Available",
        "91" => "Issuer out of Service",
        "92" => "Invalid Issuer",
        "93" => STANDARD_ERROR_CODE[:card_declined],
        "94" => "Duplicate transmission",
        "95" => "Start Sending Batch",
        "96" => STANDARD_ERROR_CODE[:call_issuer],
        "97" => STANDARD_ERROR_CODE[:card_declined],
        "98" => "Error, Duplicate REV.",
        "A0" => "Monthly Volumen Exceded.",
        "A1" => "Highest Ticket Exceded",
        "N7" => STANDARD_ERROR_CODE[:invalid_cvc], #STANDARD_ERROR_CODE[:card_declined] for cvv2 failure."
        "XX" => "ActiveMerchant: Response failed to be decoded" # Custom error.
      }

      PROCESS_CODES = {
        :sale               => '000000',
        :preauthorization   => '300000',
        :adjustment         => '290000',
        :void               => '220000',
        :credit             => '200000',
        :rebill             => '100000'
      }

      # secret_key => AccCode
      def initialize(options={})
        requires!(options, :secret_key, :merchant, :terminal_id)
        super
      end

      def purchase(money, payment=nil, options={})
        NeoSDK.build_sdk
        customer = NeoSDK.get_customer_id(options['user_id'])
        NeoSDK.perform_sale(customer,money)
      end

      def store(creditcard, options = {})
        NeoSDK.build_sdk
        customer = NeoSDK.get_customer_id(options['user_id'])
        if not customer then
            customer = NeoSDK.save_customer(options['user_email'],options['user_id'])
            customer = NeoSDK.add_account_to_customer(customer)
        end
        return NeoSDK.add_card_to_customer(creditcard,customer)
      end

      def success_from(response)
        SUCCESS_CODES.include? response[:response_code]
      end

      def message_from(response)
        success_from(response) ? SUCCESS_MESSAGE : error_code_from(response)
      end

      def authorization_from(response)

        # Ballot number is the id one must repost to modify verified payments
        response[:ballot_number]
      end

      def error_code_from(response)
        unless success_from(response)
          STANDARD_ERROR_CODE_MAPPING[response[:response_code]]
        end
      end
    end
  end
end
