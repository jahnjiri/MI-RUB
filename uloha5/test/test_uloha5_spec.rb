require_relative "../lib/uloha5"
describe "Uloha5 - ", "testy" do

  it "1 - Prvni sada" do
    usecky = []
    em = 1
    us = Usecka.new(Integer(-1), Integer(0))
    usecky << us
    us = Usecka.new(Integer(-5), Integer(-3))
    usecky << us
    us = Usecka.new(Integer(2), Integer(5))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 0
  end

  it "1 - Druha sada - pocet usecek" do
    usecky = []
    em = 1
    us = Usecka.new(Integer(-1), Integer(0))
    usecky << us
    us = Usecka.new(Integer(0), Integer(1))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 1
  end

  it "1 - Druha sada - spravnost reseni" do
    usecky = []
    em = 1
    us = Usecka.new(Integer(-1), Integer(0))
    usecky << us
    us = Usecka.new(Integer(0), Integer(1))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek[0].l.should == 0 && usecek[0].r.should == 1
  end

  it "2 - Treti sada - pocet usecek" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(-2), Integer(5))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(6))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(3))
    usecky << us
    us = Usecka.new(Integer(0), Integer(4))
    usecky << us
    us = Usecka.new(Integer(1), Integer(5))
    usecky << us
    us = Usecka.new(Integer(2), Integer(6))
    usecky << us
    us = Usecka.new(Integer(3), Integer(7))
    usecky << us
    us = Usecka.new(Integer(7), Integer(8))
    usecky << us
    us = Usecka.new(Integer(8), Integer(10))
    usecky << us
    us = Usecka.new(Integer(8), Integer(9))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 4
  end

    it "2 - Treti sada - spravnost reseni" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(-2), Integer(5))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(6))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(3))
    usecky << us
    us = Usecka.new(Integer(0), Integer(4))
    usecky << us
    us = Usecka.new(Integer(1), Integer(5))
    usecky << us
    us = Usecka.new(Integer(2), Integer(6))
    usecky << us
    us = Usecka.new(Integer(3), Integer(7))
    usecky << us
    us = Usecka.new(Integer(7), Integer(8))
    usecky << us
    us = Usecka.new(Integer(8), Integer(10))
    usecky << us
    us = Usecka.new(Integer(8), Integer(9))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    prava = 0
    for i in 0..usecek.length - 1
        if i == 0
          usecek[0].l.should <= 0
          prava = usecek[0].r
        else
          usecek[i].l.should <= prava
          prava = usecek[i].r
        end
    end
    prava.should >= em
  end

  it "2 - Ctvrta sada" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(-2), Integer(5))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(6))
    usecky << us
    us = Usecka.new(Integer(-1), Integer(3))
    usecky << us
    us = Usecka.new(Integer(0), Integer(4))
    usecky << us
    us = Usecka.new(Integer(1), Integer(5))
    usecky << us
    us = Usecka.new(Integer(2), Integer(6))
    usecky << us
    us = Usecka.new(Integer(3), Integer(7))
    usecky << us
    us = Usecka.new(Integer(8), Integer(10))
    usecky << us
    us = Usecka.new(Integer(8), Integer(9))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 0
  end

  it "2 - Pata sada" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(2), Integer(5))
    usecky << us
    us = Usecka.new(Integer(5), Integer(3))
    usecky << us
    us = Usecka.new(Integer(2), Integer(3))
    usecky << us
    us = Usecka.new(Integer(2), Integer(5))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 0
  end

  it "2 - Sesta sada - pocet usecek" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(0), Integer(10))
    usecky << us
    us = Usecka.new(Integer(0), Integer(10))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 1
  end

  it "2 - Sesta sada - spravnost reseni" do
    usecky = []
    em = 10
    us = Usecka.new(Integer(0), Integer(10))
    usecky << us
    us = Usecka.new(Integer(0), Integer(10))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek[0].l.should == 0 && usecek[0].r.should == 10
  end

  it "2 - Sedma sada - pocet usecek" do
    usecky = []
    em = 6
    us = Usecka.new(Integer(0), Integer(2))
    usecky << us
    us = Usecka.new(Integer(2), Integer(4))
    usecky << us
    us = Usecka.new(Integer(4), Integer(6))
    usecky << us
    us = Usecka.new(Integer(6), Integer(8))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    usecek.length.should == 3
  end

    it "2 - Sedma sada - spravnost reseni" do
    usecky = []
    em = 6
    us = Usecka.new(Integer(0), Integer(2))
    usecky << us
    us = Usecka.new(Integer(2), Integer(4))
    usecky << us
    us = Usecka.new(Integer(4), Integer(6))
    usecky << us
    us = Usecka.new(Integer(6), Integer(8))
    usecky << us
    usecky.sort_by! { |a| [a.l, a.r] }
    u = Usecky.new(usecky, em)
    usecek = u.spocti(u.usecky, u.em, u.kolikata, u.je, u.reseni, u.kolik, u.kde, u.vysledek, u.en)
    usecek.sort_by! { |a| [a.l, a.r] }
    prava = 0
    for i in 0..usecek.length - 1
        if i == 0
          usecek[0].l.should <= 0
          prava = usecek[0].r
        else
          usecek[i].l.should <= prava
          prava = usecek[i].r
        end
    end
    prava.should >= em
  end

end
