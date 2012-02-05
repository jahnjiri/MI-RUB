require_relative "../lib/semestralka"

puts "Semestralni prace MI-RUB"
puts "Jiri Jahn (jahnjiri@fit.cvut.cz)"
puts "14. Hledani prumeru, polomeru, stredu a excentricit jednotlivych uzlu v grafu"
puts "-----------------------------------------------------------------------------"

puts "Zadejte nazev souboru s matici sousednosti:"
s = gets
po = String.try_convert(s)
soubor = po.split("\n")
fw = FW.new(soubor)
fw.data_vystup << "Zadejte nazev souboru s matici sousednosti:\n"
fw.data_vystup << String(soubor[0])
fw.data_vystup << "\n"

begin

  fw.nacti
  fw.vypis_mat_sousednosti

  fw.spocti_mat_vzdalenosti
  fw.vypis_mat_vzdalenosti

  while(true)
    puts "Zadejte uzel pro ktery se ma urcit excentricita (0 pro vsechny uzly):"
    fw.data_vystup << "Zadejte uzel pro ktery se ma urcit excentricita (0 pro vsechny uzly):\n"

    begin

      uze = String(gets)
      uz = Integer(uze)
      fw.data_vystup << String(uz)
      fw.data_vystup << "\n"
      if uz == 0
        fw.najdi_excentricity
        fw.vypis_excentricity
        break
      else
        chyba = fw.otestuj_uzel(uz)
        if chyba == 1
          puts "Byl zadan neexistujici uzel!"
          fw.data_vystup << "Byl zadan neexistujici uzel!\n\n"
          puts
        else
          fw.najdi_excentricity
          fw.najdi_excentricitu(uz)
          fw.vypis_excentricitu
          break
        end
      end

    rescue Exception

      fw.data_vystup << String(uze)
      puts "Uzel musi byt cele cislo!"
      fw.data_vystup << "Uzel musi byt cele cislo!\n\n"
      puts

    end

  end

  fw.najdi_prumer
  fw.vypis_prumer

  fw.najdi_polomer
  fw.vypis_polomer

  fw.najdi_stredy
  fw.vypis_stredy

rescue Exception

  puts "Tento soubor neexistuje!"
  fw.data_vystup << "Tento soubor neexistuje!"
  fw.data_vystup << "\n"

end

fw.uloz_do_souboru
fw.vypis_ulozeni
