require_relative "../lib/uloha5"

begin

  us = Usecky.new(nil, nil)
  us.nacti_a_vyres()

rescue Exception
  puts "Spatny vstup."
end