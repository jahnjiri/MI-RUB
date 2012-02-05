require_relative "../lib/uloha2"

begin

  print "Zadejte delku hrany prvniho ctverce: "
  hranaprvni = Float(gets)
  if hranaprvni < 0
    print "Spatny vstup."
  end
  print "Zadejte x-ovou souradnici stredu prvniho ctverce: "
  x1 = Float(gets)
  print "Zadejte y-ovou souradnici stredu prvniho ctverce: "
  y1 = Float(gets)

  print "Zadejte delku hrany druheho ctverce: "
  hranadruha = Float(gets)
  if hranadruha < 0
    print "Spatny vstup."
  end
  print "Zadejte x-ovou souradnici stredu druheho ctverce: "
  x2 = Float(gets)
  print "Zadejte y-ovou souradnici stredu druheho ctverce: "
  y2 = Float(gets)

  c = Ctverce.new(hranaprvni, x1, y1, hranadruha, x2, y2)
  c.spocti()
  c.vypis()

rescue Exception
   puts "Spatny vstup."
end