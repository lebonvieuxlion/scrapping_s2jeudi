require_relative '../lib/dark_trader'

describe "Create a hash with the currency name and the value from the webpage https://coinmarketcap.com/all/views/all/" do

  it "get the right value for the currency name" do
    expect(get_currency_name_and_value.has_key?("BTC")).to eq(true)
  end


end