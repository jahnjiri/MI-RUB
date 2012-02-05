class Ctverce
  attr_accessor :hranaprvni
  attr_accessor :hranadruha
  attr_accessor :x1
  attr_accessor :y1
  attr_accessor :x2
  attr_accessor :y2
  attr_accessor :obsahprvni
  attr_accessor :obsahdruhy
  attr_accessor :obsahspolecny

#Inicializacni metoda
  def initialize(a1, x1, y1, a2, x2, y2)
    @hranaprvni = a1
    @x1 = x1
    @y1 = y1
    @hranadruha = a2
    @x2 = x2
    @y2 = y2
    @obsahprvni = 0
    @obsahdruhy = 0
    @obsahspolecny = 0
  end

  def spocti()
    self.obsahprvni = self.hranaprvni * self.hranaprvni
    self.obsahdruhy = self.hranadruha * self.hranadruha

    xr = self.x1 - self.x2         #rozdil stredu
    if xr < 0
      xr = xr * -1
    end
    yr = self.y1 - self.y2         #rozdil stredu
    if yr < 0
      yr = yr * -1
    end

    xpul1 = self.hranaprvni / 2         #polovina hrany
    ypul1 = self.hranaprvni / 2         #polovina hrany

    xpul2 = self.hranadruha / 2         #polovina hrany
    ypul2 = self.hranadruha / 2         #polovina hrany

    if self.hranaprvni < self.hranadruha       #kterej ctverec je mensi
      mensi = self.hranaprvni
    else
      mensi = self.hranadruha
    end

    xx = (xpul1 + xpul2) - (xr)             #o kolik se prekryvaji
    if xx > mensi
      xx = mensi                            #mensi je uvnitr vetsiho
    end
    yy = (ypul1 + ypul2) - (yr)             #o kolik se prekryvaji
    if yy > mensi
      yy = mensi                            #mensi je uvnitr vetsiho
    end

    if (self.hranaprvni == 0) || (self.hranadruha == 0)
      if (xx >= 0) && (yy >= 0)
        if (self.hranaprvni == 0)
          self.obsahspolecny = self.obsahdruhy
        else
          self.obsahspolecny = self.obsahprvni
        end
      else
        self.obsahspolecny = -1
        end
    else
      if (xx < 0) || (yy < 0)
        self.obsahspolecny = -1
      elsif (xx == 0) || (yy == 0)
        self.obsahspolecny = self.obsahprvni + self.obsahdruhy
      else
        self.obsahspolecny = self.obsahprvni + self.obsahdruhy - (xx * yy)
      end
    end
  end

  def vypis()
    if self.obsahspolecny == -1
      printf "Ctverce se ani nedotykaji."
      return "Ctverce se ani nedotykaji."
    else
      printf "Obsah sjednoceni dvou ctvercu je #{self.obsahspolecny}."
      return "Obsah sjednoceni dvou ctvercu je #{self.obsahspolecny}."
    end
  end

end

#-----------------------------------------------------------------------------------------------------------------------


