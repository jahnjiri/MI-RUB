require_relative "../lib/uloha2"
describe "Uloha2 - ", "testy" do

  it "Prekryvaji se" do
    c = Ctverce.new(4, 0, 0, 2, 2, 2)
    c.spocti()
    c.obsahspolecny.should == 19.0
  end

  it "Prekryvaji se - vypis" do
    c = Ctverce.new(4, 0, 0, 2, 2, 2)
    c.spocti()
    ret = c.vypis()
    ret.should == "Obsah sjednoceni dvou ctvercu je 19."
  end

  it "Jsou vzdalene" do
    c = Ctverce.new(5.23, -10e20, 3e-2, 4.345643225, +3e100, -1)
    c.spocti()
    c.obsahspolecny.should == -1
  end

  it "Jsou vzdalene - vypis" do
    c = Ctverce.new(5.23, -10e20, 3e-2, 4.345643225, +3e100, -1)
    c.spocti()
    ret = c.vypis()
    ret.should == "Ctverce se ani nedotykaji."
  end

  it "Hrana na hrane druheho" do
    c = Ctverce.new(4, 0, 0, 2, 3, 1)
    c.spocti()
    c.obsahspolecny.should == 20.0
  end

  it "Hrana na hrane druheho - vypis" do
    c = Ctverce.new(4, 0, 0, 2, 3, 1)
    c.spocti()
    ret = c.vypis()
    ret.should == "Obsah sjednoceni dvou ctvercu je 20."
  end

end
