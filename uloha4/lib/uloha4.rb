class Desifrator
  attr_accessor :pole_znaku
  attr_accessor :pole_ascii
  attr_accessor :vysledek
  def initialize()
    @pole_znaku = []
    @pole_ascii = []
    @vysledek = []
  end

  def nacti(file)
    pole = []
    File.open(file, "r"){
      |f| f.each{
        |d| pole = pole + d.split('')
      }
    }
    self.pole_znaku = pole
  end

  def nactiascii(file)
    pole = []
    File.open(file, "r"){
      |f| f.each{
        |d| pole = pole + d.split("\n")
      }
    }
    self.pole_ascii = pole
  end

  def desifruj(posun)
    sifra = self.pole_znaku
    ascii = self.pole_ascii
    koliks = sifra.length
    kolika = ascii.length
    for i in 0..koliks - 1
       if sifra[i] != "\n"
         for j in 0..kolika - 1
           if sifra[i] == ascii[j]
             vysledek << ascii[(j + posun) % kolika]
             break
           end
         end
       else
          vysledek << "\n"
       end
    end
  end

  def vypis()
     for i in 0..self.vysledek.length - 1
        print vysledek[i]
     end
  end

end

#-----------------------------------------------------------------------------------------------------------------------



