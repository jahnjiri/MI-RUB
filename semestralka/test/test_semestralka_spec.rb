require_relative "../lib/semestralka"
describe "Semestralka - ", "testy" do

require 'stringio'

module Kernel

  def capture_stdout
    out = StringIO.new
    $stdout = out
    yield
    return out
  ensure
    $stdout = STDOUT
  end

  def define_stdin(vstup)
    input = StringIO.new
    input.string = vstup
    $stdin = input
    yield
  ensure
    $stdin = STDIN
  end

end

#Test, ktery proveri, ze udaje vypsane na obrazovku jsou spravne
  it "Vypis na obrazovku" do
    vstup = "mo\n2\n"
    define_stdin(vstup) do
      fw = FW.new(["mo"])
      fw.nacti
      fw.spocti_mat_vzdalenosti
      fw.najdi_excentricity
      fw.otestuj_uzel(2)
      fw.najdi_excentricitu(2)
      fw.najdi_prumer
      fw.najdi_polomer
      fw.najdi_stredy
      out = capture_stdout do
        fw.vypis_mat_sousednosti
        fw.vypis_mat_vzdalenosti
        fw.vypis_excentricitu
        fw.vypis_prumer
        fw.vypis_polomer
        fw.vypis_stredy
      end
      out.string.should == "\nMatice sousednosti grafu je:\n    1  2  3  4  5 \n  ----------------\n1|  0  3  8  4  4 \n2|  3  0  6  1  7 \n3|  7  4  0  5 11 \n4|  2  5  5  0  6 \n5|  8 11 11  6  0 \n\nMatice vzdalenosti grafu je:\n    1  2  3  4  5 \n  ----------------\n1|  0  3  8  4  4 \n2|  3  0  6  1  7 \n3|  7  4  0  5 11 \n4|  2  5  5  0  6 \n5|  8 11 11  6  0 \n\n\nExcentricita uzlu 2 je:\n7\n\nPrumer grafu je:\n11\n\nPolomer grafu je:\n6\n\nStred grafu je uzel:\n4\n"
    end
  end

#Test, ktery proveri, ze jsou do souboru vypsany spravne udaje
  it "Vypis do souboru" do
      fw = FW.new(["mo"])
      fw.nacti
      fw.spocti_mat_vzdalenosti
      fw.najdi_excentricity
      fw.najdi_prumer
      fw.najdi_polomer
      fw.najdi_stredy
      out = capture_stdout do
        fw.vypis_mat_sousednosti
        fw.vypis_mat_vzdalenosti
        fw.vypis_excentricity
        fw.vypis_prumer
        fw.vypis_polomer
        fw.vypis_stredy
      end
      fw.data_vystup.should == "\nMatice sousednosti grafu je: \n    1  2  3  4  5 \n  ----------------\n1|  0  3  8  4  4 \n2|  3  0  6  1  7 \n3|  7  4  0  5 11 \n4|  2  5  5  0  6 \n5|  8 11 11  6  0 \n\nMatice vzdalenosti grafu je: \n    1  2  3  4  5 \n  ----------------\n1|  0  3  8  4  4 \n2|  3  0  6  1  7 \n3|  7  4  0  5 11 \n4|  2  5  5  0  6 \n5|  8 11 11  6  0 \n\n\nExcentricity uzlu jsou:\nu: 1 - exc: 8, u: 2 - exc: 7, u: 3 - exc: 11, u: 4 - exc: 6, u: 5 - exc: 11\n\nPrumer grafu je:\n11\n\nPolomer grafu je:\n6\n\nStred grafu je uzel:\n4\n"
  end

#Test, ktery proveri, zda je spravne nactena matice sousednosti
  it "Nacteni matice sousednosti" do
    fw = FW.new(["mo"])
    fw.nacti
    pole = [[0, 3, 8, 0, 4], [0, 0, 0, 1, 7], [0, 4, 0, 0, 0], [2, 0, 5, 0, 0], [0, 0, 0, 6, 0]]
    fw.mat_sousednosti.should == pole
  end

#Test, ktery proveri, zda je matice spravne pretvorena do formatu, se kterym pocita Floyd - Warshalluv algoritmus
  it "Pripraveni matice" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.priprav_matici
    pole = [[0, 3, 8, 999, 4], [999, 0, 999, 1, 7], [999, 4, 0, 999, 999], [2, 999, 5, 0, 999], [999, 999, 999, 6, 0]]
    fw.mat_vzdalenosti.should == pole
  end

#Test, ktery proveri, zda je spravne z matice sousednosti spoctena matice vzdalenosti
  it "Spocteni matice vzdalenosti" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    pole = [[0, 3, 8, 4, 4], [3, 0, 6, 1, 7], [7, 4, 0, 5, 11], [2, 5, 5, 0, 6], [8, 11, 11, 6, 0]]
    fw.mat_vzdalenosti.should == pole
  end

#Test, ktery proveri, zda je spravne otestovano, jestli se uzivatelem zadany uzel v grafu nachazi
  it "Otestovani uzlu" do
    fw = FW.new(["mo"])
    fw.nacti
    for i in 1..3
      if i == 1
        uzel = 6
        chyba = fw.otestuj_uzel(uzel)
        chyba.should == 1
      elsif i == 2
        uzel = -1
        chyba = fw.otestuj_uzel(uzel)
        chyba.should == 1
      else
        kolik = fw.mat_sousednosti[0].length
        for j in 1..kolik
          uzel = j
          chyba = fw.otestuj_uzel(uzel)
          chyba.should == 0
        end
      end
    end
  end

#Test, ktery proveri, zda je spravne spoctena excentricita pro zadany uzel
  it "Nalezeni excentricity" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    kolik = fw.mat_vzdalenosti[0].length
    for i in 1..kolik
      uzel = i
      if uzel == 1
        fw.najdi_excentricitu(uzel)
        exc = 8
        fw.excentricita.should == exc
      elsif uzel == 2
	      fw.najdi_excentricitu(uzel)
        exc = 7
        fw.excentricita.should == exc
      elsif uzel == 3
        fw.najdi_excentricitu(uzel)
        exc = 11
        fw.excentricita.should == exc
      elsif uzel == 4
        fw.najdi_excentricitu(uzel)
        exc = 6
        fw.excentricita.should == exc
      else
        fw.najdi_excentricitu(uzel)
        exc = 11
        fw.excentricita.should == exc
      end
    end
  end

#Test, ktery proveri, zda jsou spravne spocteny excentricity vsech uzlu
  it "Nalezeni excentricit" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    pole = [8, 7, 11, 6, 11]
    fw.excentricity.should == pole
  end

#Test, ktery proveri, zda je nalezen spravny prumer grafu
  it "Nalezeni prumeru" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_prumer
    prum = 11
    fw.prumer.should == prum
  end

#Test, ktery proveri, zda je nalezen spravny polomer grafu
  it "Nalezeni polomeru" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_polomer
    pol = 6
    fw.polomer.should == pol
  end

#Test, ktery proveri, zda je nalezeny polomer spravny vzhledem k prumeru
  it "Spravnost polomeru" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_prumer
    fw.najdi_polomer
    pol = fw.polomer
    pru = fw.prumer
    pol.should <= pru
  end

#Test, ktery proveri, zda je nalezeny prumer spravny vzhledem k polomeru
  it "Spravnost prumeru" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_prumer
    fw.najdi_polomer
    pol = fw.polomer
    pol = 2 * pol
    pru = fw.prumer
    pru.should <= pol
  end

#Test, ktery proveri, zda je spravne spocten pocet stredu
  it "Pocet stredu" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_stredy
    kolik = fw.stredy.length
    kolik.should == 1
  end

#Test, ktery proveri, zda je nalezen spravny stred
  it "Nalezeni stredu" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    fw.najdi_excentricity
    fw.najdi_stredy
    pole = [4]
    fw.stredy.should == pole
  end

#Test, ktery proveri, zda je v matici sousednosti spravne nalezeno cislo s nejvetsim poctem cifer
  it "Nalezeni maxima v matici sousednosti" do
    fw = FW.new(["mo"])
    fw.nacti
    max = fw.najdi_max_matice(fw.mat_sousednosti)
    max.should == 1
  end

#Test, ktery proveri, zda je v matici vzdalenosti spravne nalezeno cislo s nejvetsim poctem cifer
  it "Nalezeni maxima v matici vzdalenosti" do
    fw = FW.new(["mo"])
    fw.nacti
    fw.spocti_mat_vzdalenosti
    max = fw.najdi_max_matice(fw.mat_vzdalenosti)
    max.should == 2
  end

#Test, ktery proveri, zda se spravne zjistuje, kolik ma cislo cifer
  it "Zjisteni poctu cifer" do
    fw = FW.new(["mo"])
    for i in 0..9
      cislo = i
      vys = fw.cifer(cislo)
      vys.should == 1
    end
    for i in 10..99
      cislo = i
      vys = fw.cifer(cislo)
      vys.should == 2
    end
    for i in 100..999
      cislo = i
      vys = fw.cifer(cislo)
      vys.should == 3
    end
    for i in 1000..9999
      cislo = i
      vys = fw.cifer(cislo)
      vys.should == 4
    end
  end

end
