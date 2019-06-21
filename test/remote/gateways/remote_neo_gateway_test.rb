require 'test_helper'

class RemoteNeoGatewayTest < Test::Unit::TestCase
  def setup
    @gateway = NeosdkGateway.new(fixtures(:neosdk))

    @amount = 100
    @credit_card = credit_card('4532111130621539')
    @declined_card = credit_card('4000300011112220')
    @options = {
      user_id: 1,
      user_email: 'test@moo.com'
    }
  end

  def test_successful_purchase
    token = @gateway.store(@credit_card, @options)
    token = token.getCreditCards.last.getToken
    response = @gateway.purchase(@amount, cc_token=token, cc_data=nil, @options)
    assert_success response
    assert_equal NeosdkGateway::SUCCESS_CODES[0], response.getResponseDetails.getResponseCode
  end

  def test_successful_purchase_with_cc_data
    response = @gateway.purchase(@amount, cc_token=nil, cc_data=@credit_card, @options)
    ccd =  response.getCreditCardDetail
    assert_success response
    assert_equal NeosdkGateway::SUCCESS_CODES[0], response.getResponseDetails.getResponseCode
  end


=begin

  def test_failed_purchase
    response = @gateway.purchase(@amount, @declined_card, @options)
    assert_failure response
    assert_equal 'REPLACE WITH FAILED PURCHASE MESSAGE', response.message
  end

  def test_successful_authorize_and_capture
    auth = @gateway.authorize(@amount, @credit_card, @options)
    assert_success auth

    assert capture = @gateway.capture(@amount, auth.authorization)
    assert_success capture
    assert_equal NeoGatewayGateway::SUCCESS_MESSAGE, response.message
  end

  def test_failed_authorize
    response = @gateway.authorize(@amount, @declined_card, @options)
    assert_failure response
    assert_equal 'REPLACE WITH FAILED AUTHORIZE MESSAGE', response.message
  end

  def test_partial_capture
    auth = @gateway.authorize(@amount, @credit_card, @options)
    assert_success auth

    assert capture = @gateway.capture(@amount-1, auth.authorization)
    assert_success capture
  end

  def test_failed_capture
    response = @gateway.capture(@amount, '')
    assert_failure response
    assert_equal 'REPLACE WITH FAILED CAPTURE MESSAGE', response.message
  end

  def test_successful_refund
    purchase = @gateway.purchase(@amount, @credit_card, @options)
    assert_success purchase

    assert refund = @gateway.refund(@amount, purchase.authorization)
    assert_success refund
    assert_equal 'REPLACE WITH SUCCESSFUL REFUND MESSAGE', response.message
  end

  def test_partial_refund
    purchase = @gateway.purchase(@amount, @credit_card, @options)
    assert_success purchase

    assert refund = @gateway.refund(@amount-1, purchase.authorization)
    assert_success refund
  end

  def test_failed_refund
    response = @gateway.refund(@amount, '')
    assert_failure response
    assert_equal 'REPLACE WITH FAILED REFUND MESSAGE', response.message
  end

  def test_successful_void
    auth = @gateway.authorize(@amount, @credit_card, @options)
    assert_success auth

    assert void = @gateway.void(auth.authorization)
    assert_success void
    assert_equal 'REPLACE WITH SUCCESSFUL VOID MESSAGE', response.message
  end

  def test_failed_void
    response = @gateway.void('')
    assert_failure response
    assert_equal 'REPLACE WITH FAILED VOID MESSAGE', response.message
  end

  def test_successful_verify
    response = @gateway.verify(@credit_card, @options)
    assert_success response
    assert_match %r{REPLACE WITH SUCCESS MESSAGE}, response.message
  end

  def test_failed_verify
    response = @gateway.verify(@declined_card, @options)
    assert_failure response
    assert_match %r{REPLACE WITH FAILED PURCHASE MESSAGE}, response.message
  end

  def test_invalid_login
    gateway = NeoGatewayGateway.new(login: '', password: '')

    response = gateway.purchase(@amount, @credit_card, @options)
    assert_failure response
    assert_match %r{REPLACE WITH FAILED LOGIN MESSAGE}, response.message
  end
=end

  def test_dump_transcript
    # This test will run a purchase transaction on your gateway
    # and dump a transcript of the HTTP conversation so that
    # you can use that transcript as a reference while
    # implementing your scrubbing logic.  You can delete
    # this helper after completing your scrub implementation.

    # dump_transcript_and_fail(@gateway, @amount, @credit_card, @options)
  end

  def test_transcript_scrubbing
    transcript = capture_transcript(@gateway) do
      @gateway.purchase(@amount, cc_token=nil,cc_data=@credit_card, @options)
    end
#    transcript = @gateway.scrub(transcript)
#    assert_scrubbed(@credit_card.number, transcript)
#    assert_scrubbed(@credit_card.verification_value, transcript)
#    assert_scrubbed(@gateway.options[:secret_key], transcript)
  end

end
