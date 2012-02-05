class Usecka
  attr_accessor :l
  attr_accessor :r
  def initialize(l, r)
    @l = l
    @r = r
  end
end

class Usecky
  attr_accessor :em
  attr_accessor :kolikata
  attr_accessor :je
  attr_accessor :reseni
  attr_accessor :kolik
  attr_accessor :kde
  attr_accessor :vysledek
  attr_accessor :en
  attr_accessor :usecky
 def initialize(usecky, em)
    @usecky = usecky
    @em = em
    @kolikata = -1
    @je = true
    @reseni = []
    @kolik = 0
    @kde = 0
    @vysledek = []
    @en = 10000000
  end

  def spocti(usecky, em, kolikata, je, reseni, kolik, kde, vysledek, en)
    kolikusecek = usecky.length
    res = reseni
    if vysledek.empty?
      n = en
    else
      n = vysledek.length
    end
    kol = kolik
    vysl = vysledek
    stav = true
    kdejsem = kde

    if kolikata == -1
      kolikata = kolikata + 1
      vysl = spocti(usecky, em, kolikata, true, res, kol, kdejsem, vysl, n)
      vysl = spocti(usecky, em, kolikata, false, res, kol, kdejsem, vysl, n)
      stav = false
    end
    if ((je == true) && (stav == true))
      if Integer(usecky[kolikata].l) <= kdejsem
        if Integer(usecky[kolikata].r) > kdejsem
          kdejsem = Integer(usecky[kolikata].r)
          kol = kol + 1
          kolikpo = res.length
          for i in kol..kolikpo
            res.delete_at(kol - 1)
          end
          res << usecky[kolikata]
        end
      end

      if kdejsem >= em
        if kol < n
          vysl = res
        end
        return vysl
      end

      if (kolikata + 1) < kolikusecek
        vysl = spocti(usecky, em, kolikata + 1, true, res, kol, kdejsem, vysl, n)
      end
      if (kolikata + 1) < kolikusecek
        vysl = spocti(usecky, em, kolikata + 1, false, res, kol, kdejsem, vysl, n)
      end
    else
      if stav == true
         if (kolikata + 1) < kolikusecek
           vysl = spocti(usecky, em, kolikata + 1, true, res, kol, kdejsem, vysl, n)
         end
         if (kolikata + 1) < kolikusecek
           vysl = spocti(usecky, em, kolikata + 1, false, res, kol, kdejsem, vysl, n)
         end
      end
    end

    if kdejsem >= em
      if kol < n
        vysl = res
      end
   end

    return vysl

  end

  def vypis(usecek)
    kolikjereseni = usecek.length
    puts kolikjereseni
    if kolikjereseni == 0
      puts
    else
      for i in 0..kolikjereseni - 1
        print usecek[i].l
        print " "
        puts usecek[i].r
      end
      puts
    end
  end

  def nacti_a_vyres()
    pocetsad = Integer(gets)
    pocetgetsu = Integer(pocetsad)

    for i in 1..pocetsad
      if pocetgetsu > 0
        bla = gets
        pocetgetsu = pocetgetsu - 1
      end
      em = Integer(gets)

      stav = true
      usecky = []

      while(stav == true)
        usecka = gets
        pomoc = usecka.split(' ')
        s = false
        if (Integer(pomoc[1]) == 0) && (Integer(pomoc[0]) == 0)
          s = true
        end
        if (s == false)
          us = Usecka.new(Integer(pomoc[0]), Integer(pomoc[1]))
          usecky << us
        else
          stav = false
        end
      end

      usecky.sort_by! { |a| [a.l, a.r] }
      self.em = em
      self.usecky = usecky
      usecek = self.res()
      usecek.sort_by! { |a| [a.l, a.r] }
      self.vypis(usecek)

    end

  end

  def res()
    usecek = self.spocti(self.usecky, self.em, self.kolikata, self.je, self.reseni, self.kolik, self.kde, self.vysledek, self.en)
    return usecek
  end

end

#-----------------------------------------------------------------------------------------------------------------------


