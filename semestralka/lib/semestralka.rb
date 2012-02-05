#Nazev tridy je FW, protoze hlavni vypocetni algoritmus je Floyd - Warshalluv algoritmus
class FW
#Zadana matice sousednosti
  attr_accessor :mat_sousednosti
#Vypoctena matice vzdalenosti
  attr_accessor :mat_vzdalenosti
#Zadany vstupni soubor
  attr_accessor :soubor
#Vypocteny polomer
  attr_accessor :polomer
#Vypocteny prumer
  attr_accessor :prumer
#Vypoctene stredy
  attr_accessor :stredy
#Vypoctena excentricita uzlu
  attr_accessor :excentricita
#Zadany uzel, pro ktery se pocita excentricita
  attr_accessor :uzel_exc
#Vypoctene excentricity vsech uzlu
  attr_accessor :excentricity
#Soubor, do ktereho se uklada cely beh programu
  attr_accessor :vystup
#Retezec, ktery se ulozi do souboru
  attr_accessor :data_vystup

#Inicializacni metoda
  def initialize(s)
    @soubor = s[0]
    @mat_sousednosti = nil
    @mat_vzdalenosti = nil
    @polomer = 0
    @prumer = 0
    @stredy = []
    @excentricita = 0
    @excentricity = []
    @uzel_exc = 0
    @vystup = "out"
    @data_vystup = ""
  end

#Metoda ze zadaneho vstupniho souboru nacte matici sousednosti
  def nacti
    pole = []
    File.open(self.soubor, "r"){
      |f| f.each{
        |d| pole = pole + d.split(' ')
      }
    }
    kolik = pole.length
    kol = -1
    odmocnina = kolik**0.5
    odm = Integer(odmocnina)
    matice = []
    odm.times do |i|
      matice << []
      odm.times do |j|
        kol = kol + 1
        matice[i][j] = Integer(pole[kol])
      end
    end
    self.mat_sousednosti = matice
    self.mat_vzdalenosti = matice
  end

#Metoda ulozi do souboru cely beh programu
  def uloz_do_souboru
    kam_ulozit = self.vystup
    f = File.open(kam_ulozit, "w")
    f << self.data_vystup
    f.close
  end

#Metoda, ktera pripravi nactenou matici sousednosti do tvaru, se kterym pocita Floyd - Warshalluv algoritmus
  def priprav_matici
    kolik = self.mat_vzdalenosti[0].length
    for i in 0..kolik - 1
      for j in 0..kolik - 1
        if self.mat_vzdalenosti[i][j] == 0
          self.mat_vzdalenosti[i][j] = 999
        end
        if i == j
           self.mat_vzdalenosti[i][j] = 0
        end
      end
    end
  end

#Metoda pocitajici matici vzdalenosti z matice sousednosti, tedy Floyd - Warshalluv algoritmus
  def spocti_mat_vzdalenosti
    self.priprav_matici
    kolik = self.mat_vzdalenosti[0].length
    for k in 0..kolik - 1
      for i in 0..kolik - 1
        for j in 0..kolik - 1
          if self.mat_vzdalenosti[i][j] > (self.mat_vzdalenosti[i][k] + self.mat_vzdalenosti[k][j])
            self.mat_vzdalenosti[i][j] = (self.mat_vzdalenosti[i][k] + self.mat_vzdalenosti[k][j])
          end
        end
      end
    end
  end

#Metoda testujici zda se uzivatelem zadany uzel v grafu vyskytuje
  def otestuj_uzel(uzel)
    self.uzel_exc = uzel
    kolik = self.mat_vzdalenosti[0].length
    if (uzel > kolik) || (uzel < 0)
      return 1
    else
      return 0
    end
  end

#Metoda, ktera pro zadany uzel spocte excentricitu
  def najdi_excentricitu(uzel)
    kolik = self.mat_vzdalenosti[0].length
    max = -999
    radka = uzel - 1
    for i in 0..kolik - 1
      hodnota = self.mat_vzdalenosti[radka][i]
      if hodnota > max
        max = hodnota
      end
    end
    self.excentricita = max
  end

#Metoda urcujici excentricity vsech uzlu nachazejicich se v grafu
  def najdi_excentricity
    kolik = self.mat_vzdalenosti[0].length
    for i in 1..kolik
      self.najdi_excentricitu(i)
      self.excentricity << self.excentricita
    end
  end

#Metoda pocitajici prumer zadaneho grafu
  def najdi_prumer
    kolik = self.mat_vzdalenosti[0].length
    max = -999
    for i in 0..kolik - 1
      for j in 0..kolik - 1
        hodnota = self.mat_vzdalenosti[i][j]
        if hodnota > max
          max = hodnota
        end
      end
    end
    self.prumer = max
  end

#Metoda, ktera pocita polomer zadaneho grafu
  def najdi_polomer
    kolik = self.excentricity.length
    min = 999
    for i in 0..kolik - 1
      hodnota = self.excentricity[i]
      if hodnota < min
        min = hodnota
      end
    end
    self.polomer = min
  end

#Metoda, ktera najde vsechny stredy v grafu
  def najdi_stredy
    kolik = self.excentricity.length
    min = 999
    for i in 0..kolik - 1
      hodnota = self.excentricity[i]
      if hodnota < min
        min = hodnota
      end
    end
    for i in 0..kolik - 1
      hodnota = self.excentricity[i]
      if hodnota == min
        stred = i + 1
        self.stredy << stred
      end
    end
  end

#Metoda hledajici cislo s nejvetsim poctem cifer
  def najdi_max_matice(matice)
    max = -1
    kolik = matice[0].length
    for i in 0..kolik - 1
      for j in 0..kolik - 1
        if matice[i][j] > max
          max = matice[i][j]
        end
      end
    end
    if (max >= 0) && (max < 10)
      max = 1
      return max
    elsif (max >= 10) && (max < 100)
      max = 2
      return max
    elsif (max >= 100) && (max < 1000)
      max = 3
      return max
    elsif (mx >= 1000) && (max < 10000)
      max = 4
      return max
    end
  end

#Metoda urcujici pocet cifer cisla
  def cifer(cislo)
    max = -1
    if (cislo >= 0) && (cislo < 10)
      max = 1
      return max
    elsif (cislo >= 10) && (cislo < 100)
      max = 2
      return max
    elsif (cislo >= 100) && (cislo < 1000)
      max = 3
      return max
    elsif (cislo >= 1000) && (cislo < 10000)
      max = 4
      return max
    end
  end

#Metoda, ktera vypise zadanou matici sousednosti
  def vypis_mat_sousednosti
    puts
    self.data_vystup << "\n"
    puts "Matice sousednosti grafu je:"
    self.data_vystup << "Matice sousednosti grafu je: \n"
    kolik = self.mat_sousednosti[0].length
    max = najdi_max_matice(self.mat_sousednosti)
    print "   "
    self.data_vystup << "   "
    for j in 1..kolik
      for i in 1..max - 1
        print " "
        self.data_vystup << " "
      end
      print j
      self.data_vystup << String(j)
      print " "
      self.data_vystup << " "
    end
    puts
    self.data_vystup << "\n"
    print "  "
    self.data_vystup << "  "
    for i in 0..kolik - 1
      for j in 1..max
        print "-"
        self.data_vystup << "-"
      end
      print "-"
      self.data_vystup << "-"
    end
    puts "-"
    self.data_vystup << "-\n"
    for i in 0..kolik - 1
      print i + 1
      self.data_vystup << String(i + 1)
      print "| "
      self.data_vystup << "| "
      for j in 0..kolik - 1
        cis = self.mat_sousednosti[i][j]
        cif = self.cifer(cis)
        for k in 1..max - cif
          print " "
          self.data_vystup << " "
        end
        print cis
        self.data_vystup << String(cis)
        print " "
        self.data_vystup << " "
      end
      puts
      self.data_vystup << "\n"
    end
    puts
    self.data_vystup << "\n"
  end

#Metoda, ktera vypisuje spoctenou excentricitu pro zadany uzel
  def vypis_excentricitu
    puts
    self.data_vystup << "\n"
    print "Excentricita uzlu "
    self.data_vystup << "Excentricita uzlu "
    print self.uzel_exc
    self.data_vystup << String(self.uzel_exc)
    puts " je:"
    self.data_vystup << " je:\n"
    puts self.excentricita
    self.data_vystup << String(self.excentricita)
    self.data_vystup << "\n"
  end

#Metoda, ktera vypise pro vsechny uzly v grafu spoctene excentricity
  def vypis_excentricity
    puts
    self.data_vystup << "\n"
    puts "Excentricity uzlu jsou:"
    self.data_vystup << "Excentricity uzlu jsou:\n"
    kolik = self.excentricity.length
    for i in 0..kolik - 2
       print "u: "
       self.data_vystup << "u: "
       print i + 1
       self.data_vystup << String(i + 1)
       print " - "
       self.data_vystup << " - "
       print "exc: "
       self.data_vystup << "exc: "
       print self.excentricity[i]
       self.data_vystup << String(self.excentricity[i])
       print ", "
       self.data_vystup << ", "
    end
    print "u: "
    self.data_vystup << "u: "
    print kolik
    self.data_vystup << String(kolik)
    print " - "
    self.data_vystup << " - "
    print "exc: "
    self.data_vystup << "exc: "
    print self.excentricity[kolik - 1]
    self.data_vystup << String(self.excentricity[kolik - 1])
    puts
    self.data_vystup << "\n"
  end

#Metoda vypisujici spocteny prumer
  def vypis_prumer
    puts
    self.data_vystup << "\n"
    puts "Prumer grafu je:"
    self.data_vystup << "Prumer grafu je:\n"
    puts self.prumer
    self.data_vystup << String(self.prumer)
    self.data_vystup << "\n"
  end

#Metoda, ktera vypisuje spocteny polomer
  def vypis_polomer
    puts
    self.data_vystup << "\n"
    puts "Polomer grafu je:"
    self.data_vystup << "Polomer grafu je:\n"
    puts self.polomer
    self.data_vystup << String(self.polomer)
    self.data_vystup << "\n"
  end

#Metoda vypisujici vsechny stredy grafu
  def vypis_stredy
    if self.stredy.length == 1
      puts
      self.data_vystup << "\n"
      puts "Stred grafu je uzel:"
      self.data_vystup << "Stred grafu je uzel:\n"
      puts self.stredy[0]
      self.data_vystup << String(self.stredy[0])
      self.data_vystup << "\n"
    else
      puts
      self.data_vystup << "\n"
      puts "Stredy grafu jsou uzly:"
      self.data_vystup << "Stredy grafu jsou uzly:\n"
      kolik = self.stredy.length
      for i in 0..kolik - 2
        print self.stredy[i]
        self.data_vystup << String(self.stredy[i])
        print ", "
        self.data_vystup << ", "
      end
      print self.stredy[kolik - 1]
      self.data_vystup << String(self.stredy[kolik - 1])
      puts
      self.data_vystup << "\n"
    end
  end

#Metoda vypisujici spoctenou matici vzdalenosti s cisly zarovnanymi doprava
  def vypis_mat_vzdalenosti
    puts "Matice vzdalenosti grafu je:"
    self.data_vystup << "Matice vzdalenosti grafu je: \n"
    kolik = self.mat_vzdalenosti[0].length
    max = najdi_max_matice(self.mat_vzdalenosti)
    print "   "
    self.data_vystup << "   "
    for j in 1..kolik
      for i in 1..max - 1
        print " "
        self.data_vystup << " "
      end
      print j
      self.data_vystup << String(j)
      print " "
      self.data_vystup << " "
    end
    puts
    self.data_vystup << "\n"
    print "  "
    self.data_vystup << "  "
    for i in 0..kolik - 1
      for j in 1..max
        print "-"
        self.data_vystup << "-"
      end
      print "-"
      self.data_vystup << "-"
    end
    puts "-"
    self.data_vystup << "-\n"
    for i in 0..kolik - 1
      print i + 1
      self.data_vystup << String(i + 1)
      print "| "
      self.data_vystup << "| "
      for j in 0..kolik - 1
        cis = self.mat_vzdalenosti[i][j]
        cif = self.cifer(cis)
        for k in 1..max - cif
          print " "
          self.data_vystup << " "
        end
        print cis
        self.data_vystup << String(cis)
        print " "
        self.data_vystup << " "
      end
      puts
      self.data_vystup << "\n"
    end
    puts
    self.data_vystup << "\n"
  end

#Metoda, ktera vypise, ze byl beh programu ulozen do souboru
  def vypis_ulozeni
    puts
    print "Beh programu byl ulozen do souboru "
    print "\""
    print self.vystup
    print "\"."
    puts
  end

end

#-----------------------------------------------------------------------------------------------------------------------

