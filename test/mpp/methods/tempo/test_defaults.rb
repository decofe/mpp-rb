# frozen_string_literal: true

require "test_helper"

class TestTempoDefaults < Minitest::Test
  D = Mpp::Methods::Tempo::Defaults

  def test_resolve_currency_mainnet_default
    assert_equal D::USDC, D.resolve_currency
  end

  def test_resolve_currency_testnet
    assert_equal D::PATH_USD, D.resolve_currency(testnet: true)
  end

  def test_resolve_currency_explicit_testnet_chain
    assert_equal D::PATH_USD, D.resolve_currency(chain_id: 42_431)
  end

  def test_resolve_currency_explicit_mainnet_chain
    assert_equal D::USDC, D.resolve_currency(chain_id: 4217)
  end

  def test_resolve_currency_unknown_chain_falls_back
    assert_equal D::PATH_USD, D.resolve_currency(chain_id: 99_999)
  end

  def test_default_fee_tokens_include_ousd_only_on_mainnet
    assert_equal [D::USDC, D::OUSD], D.default_allowed_fee_tokens(4217)
    assert_equal [D::PATH_USD], D.default_allowed_fee_tokens(42_431)
    assert_equal [D::PATH_USD], D.default_allowed_fee_tokens(99_999)
    assert_equal [D::PATH_USD], D.default_allowed_fee_tokens(nil)
  end
end
