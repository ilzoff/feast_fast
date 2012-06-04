module FeastFast
  module DB

    def self.hash
      @hash ||= begin
        
        hash = Hash.new do |h, day|
          h[day] = {
            :feast => [],
            :fast => [3,5].include?(day.wday) ? Fast.new(:status => Fast::STATUS[:COMMON]) : Fast.new(:status => Fast::STATUS[:NO])
          }
        end

        year = Date.today.year

        # Пасха

        hash[easter(year)][:feast]           << Feast.new(:status => 1, :text => "Воскресение Христово. Пасха")

        # Непереходящие праздники

        hash[Date.new(year, 1, 7)][:feast]   << Feast.new(:status => 1, :text => "Рождество Христово (двунадесятый)")
        hash[Date.new(year, 1, 14)][:feast]  << Feast.new(:status => 2, :text => "Обрезание Господне (великий)")
        hash[Date.new(year, 1, 19)][:feast]  << Feast.new(:status => 2, :text => "Крещение Господне (двунадесятый)")
        hash[Date.new(year, 2, 15)][:feast]  << Feast.new(:status => 2, :text => "Сретение Господне (двунадесятый)")
        hash[Date.new(year, 4, 7)][:feast]   << Feast.new(:status => 2, :text => "Благовещение Пресвятой Богородицы (двунадесятый)")
        hash[Date.new(year, 5, 21)][:feast]  << Feast.new(:status => 2, :text => "Апостола и евангелиста Иоанна Богослова")
        hash[Date.new(year, 5, 22)][:feast]  << Feast.new(:status => 2, :text => "Святителя Николая, архиепископа Мир Ликийских, чудотворца")
        hash[Date.new(year, 7, 7)][:feast]   << Feast.new(:status => 2, :text => "Рождество Иоанна Предтечи (великий)")
        hash[Date.new(year, 7, 12)][:feast]  << Feast.new(:status => 2, :text => "Святых перв. апостолов Петра и Павла (великий)")
        hash[Date.new(year, 8, 19)][:feast]  << Feast.new(:status => 2, :text => "Преображение Господне (двунадесятый)")
        hash[Date.new(year, 8, 28)][:feast]  << Feast.new(:status => 2, :text => "Успение Пресвятой Богородицы (двунадесятый)")
        hash[Date.new(year, 9, 11)][:feast]  << Feast.new(:status => 2, :text => "Усекновение главы Иоанна Предтечи (великий)")
        hash[Date.new(year, 9, 21)][:feast]  << Feast.new(:status => 2, :text => "Рождество Пресвятой Богородицы (двунадесятый)")
        hash[Date.new(year, 9, 27)][:feast]  << Feast.new(:status => 2, :text => "Воздвижение Креста Господня (двунадесятый)")
        hash[Date.new(year, 10, 9)][:feast]  << Feast.new(:status => 2, :text => "Апостола и евангелиста Иоанна Богослова")
        hash[Date.new(year, 10, 14)][:feast] << Feast.new(:status => 2, :text => "Покров Пресвятой Богородицы (великий)")
        hash[Date.new(year, 12, 4)][:feast]  << Feast.new(:status => 2, :text => "Введение во храм Пресвятой Богородицы (двунадесятый)")
        hash[Date.new(year, 12, 19)][:feast] << Feast.new(:status => 2, :text => "Святителя Николая, архиепископа Мир Ликийских, чудотворца")

        # Переходящие праздники

        hash[sunday_after(Date.new(year, 2, 7))][:feast] << Feast.new(:status => 2, :text => "Собор новомучеников и исповедников Российских")
    
        hash[sunday_before(easter(year), 11)][:feast] << Feast.new(:status => 2, :text => "Неделя о Закхее-мытаре")
        hash[sunday_before(easter(year), 10)][:feast] << Feast.new(:status => 2, :text => "Неделя о мытаре и фарисее")
        hash[sunday_before(easter(year), 9)][:feast]  << Feast.new(:status => 2, :text => "Неделя о блудном сыне")
        hash[sunday_before(easter(year), 8)][:feast]  << Feast.new(:status => 2, :text => "Неделя о Страшном Суде")
        hash[sunday_before(easter(year), 7)][:feast]  << Feast.new(:status => 2, :text => "Воспоминание Адамова изгнания. Прощеное воскресенье")
        hash[sunday_before(easter(year), 6)][:feast]  << Feast.new(:status => 2, :text => "Торжество Православия")
        hash[sunday_before(easter(year), 5)][:feast]  << Feast.new(:status => 2, :text => "Неделя 2-я Великого поста, свт. Григория Паламы, архиеп. Солунского")
        hash[sunday_before(easter(year), 4)][:feast]  << Feast.new(:status => 2, :text => "Неделя 3-я Великого поста, Крестопоклонная")
        hash[sunday_before(easter(year), 3)][:feast]  << Feast.new(:status => 2, :text => "Неделя 4-я Великого поста, прп. Иоанна Лествичника")
        hash[sunday_before(easter(year), 2)][:feast]  << Feast.new(:status => 2, :text => "Неделя 5-я Великого поста, прп. Марии Египетской")
        hash[sunday_before(easter(year), 1) - 1][:feast]  << Feast.new(:status => 2, :text => "Лазарева суббота")
        hash[sunday_before(easter(year), 1)][:feast]  << Feast.new(:status => 2, :text => "Вход Господень в Иерусалим (двунадесятый)")
        
        hash[day_before(easter(year), 6)][:feast]  << Feast.new(:status => 2, :text => "Великий Понедельник")
        hash[day_before(easter(year), 5)][:feast]  << Feast.new(:status => 2, :text => "Великий Вторник")
        hash[day_before(easter(year), 4)][:feast]  << Feast.new(:status => 2, :text => "Великая Среда")
        hash[day_before(easter(year), 3)][:feast]  << Feast.new(:status => 2, :text => "Великий Четверг. Тайная Вечеря")
        hash[day_before(easter(year), 2)][:feast]  << Feast.new(:status => 2, :text => "Великая Пятница. Распятие Христа")
        hash[day_before(easter(year), 1)][:feast]  << Feast.new(:status => 2, :text => "Великая Суббота. Сошествие Христа во ад")

        hash[sunday_after(easter(year), 1)][:feast]  << Feast.new(:status => 2, :text => "Неделя 2-я по Пасхе (Антипасха). Воспоминание уверения ап. Фомы")
        hash[sunday_after(easter(year), 2)][:feast]  << Feast.new(:status => 2, :text => "Неделя 3-я по Пасхе, святых жен-мироносиц")
        hash[sunday_after(easter(year), 3)][:feast]  << Feast.new(:status => 2, :text => "Неделя 4-я по Пасхе, о расслабленном")
        hash[sunday_after(easter(year), 4)][:feast]  << Feast.new(:status => 2, :text => "Неделя 5-я по Пасхе, о самарянке")
        hash[sunday_after(easter(year), 5)][:feast]  << Feast.new(:status => 2, :text => "Неделя 6-я по Пасхе, о слепом")
        hash[day_after(easter(year), 39)][:feast]  << Feast.new(:status => 2, :text => "Вознесение Господне (40-й день по Пасхе, двунадесятый)")
        hash[sunday_after(easter(year), 6)][:feast]  << Feast.new(:status => 2, :text => "Неделя 7-я по Пасхе, свв. отцев I Вселенского Собора")
        hash[day_after(easter(year), 49)][:feast]  << Feast.new(:status => 2, :text => "Пятидесятница. День Святой Троицы (50-й день по Пасхе, двунадесятый)")
        hash[day_after(easter(year), 50)][:feast]  << Feast.new(:status => 2, :text => "День Святого Духа (первый понедельник по Пятидесятнице)")
        hash[sunday_after(easter(year), 8)][:feast]  << Feast.new(:status => 2, :text => "Неделя 1-я по Пятидесятнице, всех святых")
        hash[sunday_after(easter(year), 9)][:feast]  << Feast.new(:status => 2, :text => "Неделя 2-я по Пятидесятнице, всех святых, в земле Российской просиявших")

        # Дни особого поминовения усопших

        hash[day_before(sunday_before(easter(year), 8))][:feast]  << Feast.new(:status => 2, :text => "Вселенская родительская суббота (суббота перед неделей о Страшном Суде)")
        hash[day_before(sunday_before(easter(year), 5))][:feast]  << Feast.new(:status => 2, :text => "Вселенская родительская суббота 2-й недели Великого поста")
        hash[day_before(sunday_before(easter(year), 4))][:feast]  << Feast.new(:status => 2, :text => "Вселенская родительская суббота 3-й недели Великого поста")
        hash[day_before(sunday_before(easter(year), 3))][:feast]  << Feast.new(:status => 2, :text => "Вселенская родительская суббота 4-й недели Великого поста")
        hash[day_after(sunday_after(easter(year), 1), 2)][:feast]  << Feast.new(:status => 2, :text => "Радоница (вторник 2-й седмицы по Пасхе)")
        hash[day_after(easter(year), 48)][:feast]                 << Feast.new(:status => 2, :text => "Троицкая родительская суббота (суббота перед Троицей)")
        hash[Date.new(year, 5, 9)][:feast]                        << Feast.new(:status => 2, :text => "Поминовение усопших воинов")
        hash[day_before(sunday_before(Date.new(year, 11, 7)))][:feast] << Feast.new(:status => 2, :text => "Дмитриевская родительская суббота (суббота перед 8 ноября)")

        # Контрабанда

        hash[Date.new(year, 11, 12)][:feast] << Feast.new(:status => 2, :text => "День памяти Преподобной Елены Сербской")
        hash[Date.new(year, 1, 21)][:feast]  << Feast.new(:status => 2, :text => "День памяти Преподобного Илии Египетского")

        # ПОСТЫ

        # Рождественский пост
        (Date.new(year, 1, 1)..Date.new(year, 1, 6)).each do |date|
          if date.day == 6
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:STRICT], :text => "Рождественский сочельник")
          elsif date.wday == 3 or date.wday == 5
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:STRICT])
          else
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:COMMON])
          end
        end

        hash[Date.new(year, 12, 4)][:fast]  = Fast.new(:status => Fast::STATUS[:COMMON]) # Введение во храм Пресвятой Богородицы
        hash[Date.new(year, 12, 19)][:fast] = Fast.new(:status => Fast::STATUS[:COMMON]) # Святителя Николая

        # Святки
        (Date.new(year, 1, 7)..Date.new(year, 1, 17)).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:NO])
        end
        hash[Date.new(year, 1, 18)][:fast]  = Fast.new(:status => Fast::STATUS[:STRICT], :text => "Крещенский сочельник")
        hash[Date.new(year, 1, 19)][:fast]  = Fast.new(:status => Fast::STATUS[:NO]) # Крещение Господне или Богоявление

        # Успенский пост
        hash[Date.new(year, 8, 14)][:fast]  = Fast.new(:status => Fast::STATUS[:STRICT], :text => "Начало Успенского поста")
        (Date.new(year, 8, 15)..Date.new(year, 8, 27)).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:STRICT])
        end
        hash[Date.new(year, 8, 19)][:fast]  = Fast.new(:status => Fast::STATUS[:COMMON]) # Преображение Господне

        hash[Date.new(year, 9, 11)][:fast]  = Fast.new(:status => Fast::STATUS[:STRICT]) # Усекновение главы Иоанна Предтечи
        hash[Date.new(year, 9, 27)][:fast]  = Fast.new(:status => Fast::STATUS[:STRICT]) # Воздвижение Креста Господня

        # Седмица после Недели о мытаре и фарисее - сплошная, пост в среду и пятницу отменяется.
        (day_after(sunday_before(easter(year), 10))..day_after(sunday_before(easter(year), 9))).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:NO])
        end

        # Седмица сырная (масленица)
        hash[day_before(easter(year), 55)][:fast] = Fast.new(:status => Fast::STATUS[:LOOSE], :text => "Седмица сырная (масленица)")
        (day_before(easter(year), 54)..day_before(easter(year), 49)).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:LOOSE])
        end

        # Великий пост
        hash[easter(year) - 48][:fast] = Fast.new(:status => Fast::STATUS[:STRICT], :text => "Начало Великого поста")
        ((easter(year) - 47)..easter(year)-1).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:STRICT])
        end

        hash[sunday_before(easter(year), 1)][:fast] = Fast.new(:status => Fast::STATUS[:COMMON]) # Вход Господень в Иерусалим
        
        # Светлая седмица
        (day_after(easter(year))..sunday_after(easter(year), 1)).each do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:NO])
        end

        # Сплошная неделя после пятидесяинцы
        day_after(easter(year), 50)..day_after(easter(year), 57) do |date|
          hash[date][:fast] = Fast.new(:status => Fast::STATUS[:NO])
        end

        # Петров пост
        hash[day_after(easter(year), 57)][:fast] = Fast.new(:status => Fast::STATUS[:STRICT], :text => "Начало Петрова поста")
        (day_after(easter(year), 58)..Date.new(year, 6, 12)).each do |date|
          if date.wday == 3 || date.wday == 5
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:STRICT])
          else
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:COMMON])
          end
        end
        
        # Рождество Иоанна Предтечи
        unless hash[Date.new(year, 7, 7)][:fast].status == Fast::STATUS[:NO]
          hash[Date.new(year, 7, 7)][:fast] = Fast.new(:status => Fast::STATUS[:COMMON])
        end

        # Благовещение Пресвятой Богородицы
        date = Date.new(year, 4, 7)
        unless hash[date][:fast].status == Fast::STATUS[:NO]
          unless (day_before(easter(year), 6)..day_before(easter(year))).include?( date )
            hash[date][:fast] = Fast.new(:status => Fast::STATUS[:COMMON])
          end
        end



        hash
      end
    end

    def self.easter(year)
      year = year.to_i
      a = (19 * (year % 19) + 15) % 30
      b = (2 * (year % 4) + 4 * (year % 7) + 6 * a + 6) % 7
      c = a + b
      if c > 10
        d = c - 9 # day
        m = 4 # month
      else
        d = 22 + c # day
        m = 3 # month
      end
      Date.new(year, m, d) + 13
    end

    def self.sunday_after(date, step=0)
      while date.wday != 0
        date += 1
      end
      date += 7*(step)
      return date
    end

    def self.sunday_before(date, step=0)
      while date.wday != 0
        date -= 1
      end
      date -= 7*(step)
      return date
    end

    def self.day_before(date, step=1)
      date - step
    end

    def self.day_after(date, step=1)
      date + step
    end    
  end
end