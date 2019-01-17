require_relative '../lib/townhall_road'

describe "scrap the website to get the email of all townhall" do

  it "display a certain email when you enter the corresponding index number" do
    expect(get_all_email[0]).to eq("mairie.ableiges95@wanadoo.fr")
  end


end

