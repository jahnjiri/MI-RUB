require_relative "../lib/uloha4"

begin

  puts "Zadejte o kolik znaku se ma posunout pri desifrovani (kladne nebo zaporne cele cislo):"
  posun = Integer(gets)

  des = Desifrator.new()
  des.nacti("zasifrovano")
  des.nactiascii("ascii")
  des.desifruj(posun)
  des.vypis()

rescue Exception

  puts "Spatny vstup."

end