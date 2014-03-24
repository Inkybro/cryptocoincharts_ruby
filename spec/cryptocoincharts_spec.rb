require_relative '../lib/cryptocoincharts_ruby'

describe "CryptoCoinCharts" do
  it "provides a method to get a list of coins" do
    CryptoCoinCharts.should respond_to(:list_coins)
  end
  
  it "provides a method to get detailed information on a single coin" do
    CryptoCoinCharts.should respond_to(:coin_info)
  end
  
  it "provides a method to get detailed information on multiple coins" do
    CryptoCoinCharts.should respond_to(:coins_info)
  end
  
  it "gets a list of coins" do
    coin_list = CryptoCoinCharts.list_coins
    coin_list.should be_instance_of(Array)
    coin_list[0].should be_instance_of(CryptoCoinCharts::CoinSummary)
    coin_list[0].should respond_to(:code)
    coin_list[0].should respond_to(:name)
    coin_list[0].should respond_to(:website)
    coin_list[0].should respond_to(:btc_value)
    coin_list[0].should respond_to(:btc_volume_24h)
  end
  
  it "gets detailed information on a single coin" do
    coin = CryptoCoinCharts.coin_info(:ltc_btc)
    coin.should be_instance_of(CryptoCoinCharts::CoinDetail)
    coin.should respond_to(:code)
    coin.should respond_to(:best_market)
    coin.should respond_to(:latest_trade)
    coin.should respond_to(:btc_value)
    coin.should respond_to(:btc_value_24h_ago)
    coin.should respond_to(:btc_volume)
    coin.should respond_to(:volume_first)
    coin.should respond_to(:volume_second)
  end
  
  it "gets detailed information on multiple coins" do
    coins = CryptoCoinCharts.coins_info(:ltc_btc, :dgb_btc)
    coins.should be_instance_of(Array)
    coins.count.should eq 2
    coins[0].should be_instance_of(CryptoCoinCharts::CoinDetail)
    coins[0].should respond_to(:code)
    coins[0].should respond_to(:best_market)
    coins[0].should respond_to(:latest_trade)
    coins[0].should respond_to(:btc_value)
    coins[0].should respond_to(:btc_value_24h_ago)
    coins[0].should respond_to(:btc_volume)
    coins[0].should respond_to(:volume_first)
    coins[0].should respond_to(:volume_second)
  end
  
  #it "does not allow invalid currency pairs" do
  #  #expect { CryptoCoinCharts.coin_info(:bob_kathy) }.to raise_error(ArgumentError)
  #  #expect { CryptoCoinCharts.coins_info(:bob_kathy, :dog_cat) }.to raise_error(ArgumentError)
  #end
  
end
