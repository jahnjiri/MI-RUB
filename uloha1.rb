pocetgrafu = 0
pocetuzlu = 0
poleuzlu = []

class Uzel
  attr_accessor :nazev
  attr_accessor :pocetsousedu
  attr_accessor :sousedi
  attr_accessor :stav
  def initialize(nazev, pocetsousedu)
    @nazev = nazev
    @pocetsousedu = pocetsousedu
    @sousedi = []
    @stav = :FRESH
  end
end

class Fronta
  attr_accessor :fronta
  attr_accessor :pocetprvku
  attr_accessor :ukazovatko
  def initialize()
     @fronta = []
     @pocetprvku = 0
     @ukazovatko = 0
  end
  def push(uzel)
     @fronta << uzel
     @pocetprvku = @pocetprvku + 1
  end
  def pop()
     @ukazovatko = @ukazovatko + 1
     return @fronta[@ukazovatko-1]
  end

end

def najdi(nazev, poleuzlu, pocetuzlu)
  for i in 0..pocetuzlu-1
    if poleuzlu[i].nazev == nazev
      #puts "Hledany uzel je na indexu #{i}"
      return i
    end
  end
end

def BFS(u)
  u.stav = :OPEN
  navypis = []
  fronta = Fronta.new()
  fronta.push(u)
  rozdil = fronta.pocetprvku - fronta.ukazovatko
  while rozdil > 0
    uzel = fronta.pop()
    pocet = uzel.sousedi.length
    for i in 0..pocet-1
      if uzel.sousedi[i].stav == :FRESH
        uzel.sousedi[i].stav = :OPEN
        fronta.push(uzel.sousedi[i])
      end
    end
    navypis << uzel.nazev
    uzel.stav = :CLOSED
    rozdil = fronta.pocetprvku - fronta.ukazovatko
  end
  for i in 0..navypis.length-2
    print navypis[i]
    print " "
  end
  print navypis[navypis.length-1]
  print "\n"
end

def DFS(u, navypis)
  u.stav = :OPEN
  navypis << u.nazev
  pocet = u.sousedi.length
  for i in 0..pocet-1
    if u.sousedi[i].stav == :FRESH
      DFS(u.sousedi[i], navypis)
    end
  end
  u.stav = :CLOSED
end

#-------------------------------------------------------------------

#print "Zadej pocet grafu:"
pocetgrafu = Integer(gets)

for i in 1..pocetgrafu
  puts "graph #{i}"
  #print "Zadej pocet uzlu:"
  pocetuzlu = Integer(gets)

  uzel = ""
  poleuzliku = []
  for j in 1..pocetuzlu
    #print "Zadej uzel se seusedy:"
    uzel = gets
    pomoc = uzel.split(' ')
    poleuzliku << pomoc
  end

  poleuzlu = []

  poleuzliku.each{ |u|
     uz = Uzel.new(u[0], u[1])
     poleuzlu << uz
  }
  kam = -1
  poleuzliku.each{ |u|
     kam = kam + 1
     for i in 0..Integer(u[1])-1
       #puts "Hledam uzel s nazvem #{u[i+2]}"
       index = najdi(u[i+2], poleuzlu, pocetuzlu)
       poleuzlu[kam].sousedi << poleuzlu[index]
       #puts "Index je #{index}"
     end
  }
  #p poleuzlu

  oper = ""
  #print "Zadej operaci:"
  oper = gets
  operace = oper.split(' ')
  stav = false
  if operace[0] == "0"
    if operace[1] == "0"
      stav = true
    end
  end

  while(stav == false)
    if operace[1] == "0"
       #puts "Delam DFS"
       ind = najdi(operace[0], poleuzlu, pocetuzlu)
       navypis = []
       DFS(poleuzlu[ind], navypis)
       for i in 0..navypis.length-2
          print navypis[i]
          print " "
       end
       print navypis[navypis.length-1]
       print "\n"
    elsif operace[1] == "1"
       #puts "Delam BFS"
       ind = najdi(operace[0], poleuzlu, pocetuzlu)
       BFS(poleuzlu[ind])
    end

    #print "Zadej operaci:"
    oper = gets
    operace = oper.split(' ')
    if operace[0] == "0"
      if operace[1] == "0"
        stav = true
      end
    end
    for i in 0..pocetuzlu-1
      poleuzlu[i].stav = :FRESH
    end
  end

end




