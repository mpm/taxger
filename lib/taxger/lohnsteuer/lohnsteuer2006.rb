module Taxger
  module Lohnsteuer
    class Lohnsteuer2006
      # CONSTANTS

      # Tabelle fuer die Vomhundertsaetze des Versorgungsfreibetrags
      TAB1            = [0.0, 0.400, 0.384, 0.368,
                    0.352, 0.336, 0.320, 0.304,
                    0.288, 0.272, 0.256, 0.240,
                    0.224, 0.208, 0.192, 0.176,
                    0.160, 0.152, 0.144, 0.136,
                    0.128, 0.120, 0.112, 0.104,
                    0.096, 0.088, 0.080, 0.072,
                    0.064, 0.056, 0.048, 0.040,
                    0.032, 0.024, 0.016, 0.008,
                    0.000]

      # Tabelle fuer die Hoechstbetrage des Versorgungsfreibetrags
      TAB2            = [0, 3000, 2880, 2760,
                    2640, 2520, 2400, 2280,
                    2160, 2040, 1920, 1800,
                    1680, 1560, 1440, 1320,
                    1200, 1140, 1080, 1020,
                    960, 900, 840, 780,
                    720, 660, 600, 540,
                    480, 420, 360, 300,
                    240, 180, 120, 60,
                    0]

      # Tabelle fuer die Zuschlaege zum Versorgungsfreibetrag
      TAB3            = [0, 900, 864, 828,
                    792, 756, 720, 684,
                    648, 612, 576, 540,
                    504, 468, 432, 396,
                    360, 342, 324, 306,
                    288, 270, 252, 234,
                    216, 198, 180, 162,
                    144, 126, 108, 90,
                    72, 54, 36, 18,
                    0]

      # Tabelle fuer die Vomhundertsaetze des Altersentlastungsbetrags
      TAB4            = [0.0, 0.400, 0.384, 0.368,
                    0.352, 0.336, 0.320, 0.304,
                    0.288, 0.272, 0.256, 0.240,
                    0.224, 0.208, 0.192, 0.176,
                    0.160, 0.152, 0.144, 0.136,
                    0.128, 0.120, 0.112, 0.104,
                    0.096, 0.088, 0.080, 0.072,
                    0.064, 0.056, 0.048, 0.040,
                    0.032, 0.024, 0.016, 0.008,
                    0.000]

      # Tabelle fuer die Hoechstbetraege des Altersentlastungsbetrags
      TAB5            = [0, 1900, 1824, 1748,
                    1672, 1596, 1520, 1444,
                    1368, 1292, 1216, 1140,
                    1064, 988, 912, 836,
                    760, 722, 684, 646,
                    608, 570, 532, 494,
                    456, 418, 380, 342,
                    304, 266, 228, 190,
                    152, 114, 76, 38,
                    0]

      # Zahlenkonstanten fuer im Plan oft genutzte BigDecimal Werte
      ZAHL0           = BigDecimal.new(0)
      ZAHL1           = BigDecimal.new(1)
      ZAHL2           = BigDecimal.new(2)
      ZAHL3           = BigDecimal.new(3)
      ZAHL4           = BigDecimal.new(4)
      ZAHL5           = BigDecimal.new(5)
      ZAHL6           = BigDecimal.new(6)
      ZAHL7           = BigDecimal.new(7)
      ZAHL8           = BigDecimal.new(8)
      ZAHL9           = BigDecimal.new(9)
      ZAHL10          = BigDecimal.new(10)
      ZAHL11          = BigDecimal.new(11)
      ZAHL12          = BigDecimal.new(12)
      ZAHL100         = BigDecimal.new(100)
      ZAHL360         = BigDecimal.new(360)

      attr_accessor :bk
      attr_accessor :bks
      attr_accessor :bkv
      attr_accessor :lstlzz
      attr_accessor :solzlzz
      attr_accessor :solzs
      attr_accessor :solzv
      attr_accessor :sts
      attr_accessor :stv

      INPUT_VARS = [:ajahr, :alter1, :hinzur, :jfreib, :jhinzu, :jre4, :jvbez, :krv, :lzz, :r, :re4, :sonstb, :sterbe, :stkl, :vbez, :vbezm, :vbezs, :vbs, :vjahr, :vkapa, :vmt, :wfundf, :zkf, :zmvb]
      OUTPUT_VARS = [:bk, :bks, :bkv, :lstlzz, :solzlzz, :solzs, :solzv, :sts, :stv]
      def initialize(params)
        raise "Unknown parameters: #{params.keys - INPUT_VARS}" if params.keys - INPUT_VARS != []
        # INPUTS

        # Auf die Vollendung des 64. Lebensjahres folgende
        # Kalenderjahr (erforderlich, wenn ALTER1=1)
        @ajahr          = 0                    # int

        # 1, wenn das 64. Lebensjahr zu Beginn des Kalenderjahres vollendet wurde, in dem
        # der Lohnzahlungszeitraum endet (§ 24 a EStG), sonst = 0
        @alter1         = 0                    # int

        # In der Lohnsteuerkarte des Arbeitnehmers eingetragener Hinzurechnungsbetrag
        # fuer den Lohnzahlungszeitraum in Cents
        @hinzur         = BigDecimal.new(0)    # BigDecimal

        # Jahresfreibetrag nach Ma&szlig;gabe der Eintragungen auf der
        # Lohnsteuerkarte in Cents (ggf. 0)
        @jfreib         = BigDecimal.new(0)    # BigDecimal

        # Jahreshinzurechnungsbetrag in Cents (ggf. 0)
        @jhinzu         = BigDecimal.new(0)    # BigDecimal

        # Voraussichtlicher Jahresarbeitslohn ohne sonstige Bezuege und
        # ohne Verguetung fuer mehrjaehrige Taetigkeit in Cents (ggf. 0)
        # Anmerkung: Die Eingabe dieses Feldes ist erforderlich bei Eingabe
        # „sonstiger Bezuege“ (Feld SONSTB) oder bei Eingabe der „Verguetung
        # fuer mehrjaehrige Taetigkeit“ (Feld VMT).
        @jre4           = BigDecimal.new(0)    # BigDecimal

        # In JRE4 enthaltene Versorgungsbezuege in Cents (ggf. 0)
        @jvbez          = BigDecimal.new(0)    # BigDecimal

        # 1 = der Arbeitnehmer ist im Lohnzahlungszeitraum in der gesetzlichen
        # Rentenversicherung versicherungsfrei und gehoert zu den in
        # § 10 c Abs. 3 EStG genannten Personen.
        # Bei anderen Arbeitnehmern ist „0“ einzusetzen.
        # Fuer die Zuordnung sind allein die dem Arbeitgeber ohnehin bekannten
        # Tatsachen ma&szlig;gebend; zusaetzliche Ermittlungen braucht
        # der Arbeitgeber nicht anzustellen.
        @krv            = 0                    # int

        # Lohnzahlungszeitraum:
        # 1 = Jahr
        # 2 = Monat
        # 3 = Woche
        # 4 = Tag
        @lzz            = 0                    # int

        # Religionsgemeinschaft des Arbeitnehmers lt. Lohnsteuerkarte (bei
        # keiner Religionszugehoerigkeit = 0)
        @r              = 0                    # int

        # Steuerpflichtiger Arbeitslohn vor Beruecksichtigung der Freibetraege
        # fuer Versorgungsbezuege, des Altersentlastungsbetrags und des auf
        # der Lohnsteuerkarte fuer den Lohnzahlungszeitraum eingetragenen
        # Freibetrags in Cents.
        @re4            = BigDecimal.new(0)    # BigDecimal

        # Sonstige Bezuege (ohne Verguetung aus mehrjaehriger Taetigkeit) einschliesslich
        # Sterbegeld bei Versorgungsbezuegen sowie Kapitalauszahlungen/Abfindungen,
        # soweit es sich nicht um Bezuege fuer mehrere Jahre handelt in Cents (ggf. 0)
        @sonstb         = BigDecimal.new(0)    # BigDecimal

        # Sterbegeld bei Versorgungsbezuegen sowie Kapitalauszahlungen/Abfindungen,
        # soweit es sich nicht um Bezuege fuer mehrere Jahre handelt
        # (in SONSTB enthalten) in Cents
        @sterbe         = BigDecimal.new(0)    # BigDecimal

        # Steuerklasse:
        # 1 = I
        # 2 = II
        # 3 = III
        # 4 = IV
        # 5 = V
        # 6 = VI
        @stkl           = 0                    # int

        # In RE4 enthaltene Versorgungsbezuege in Cents (ggf. 0)
        @vbez           = BigDecimal.new(0)    # BigDecimal

        # Vorsorgungsbezug im Januar 2005 bzw. fuer den ersten vollen Monat
        # in Cents
        @vbezm          = BigDecimal.new(0)    # BigDecimal

        # Voraussichtliche Sonderzahlungen im Kalenderjahr des Versorgungsbeginns
        # bei Versorgungsempfaengern ohne Sterbegeld, Kapitalauszahlungen/Abfindungen
        # bei Versorgungsbezuegen in Cents
        @vbezs          = BigDecimal.new(0)    # BigDecimal

        # In SONSTB enthaltene Versorgungsbezuege einschliesslich Sterbegeld
        # in Cents (ggf. 0)
        @vbs            = BigDecimal.new(0)    # BigDecimal

        # Jahr, in dem der Versorgungsbezug erstmalig gewaehrt wurde; werden
        # mehrere Versorgungsbezuege gezahlt, so gilt der aelteste erstmalige Bezug
        @vjahr          = 0                    # int

        # Kapitalauszahlungen/Abfindungen bei Versorgungsbezuegen fuer mehrere Jahre in Cents (ggf. 0)
        @vkapa          = BigDecimal.new(0)    # BigDecimal

        # Verguetung fuer mehrjaehrige Taetigkeit ohne Kapitalauszahlungen/Abfindungen bei
        # Versorgungsbezuegen in Cents (ggf. 0)
        @vmt            = BigDecimal.new(0)    # BigDecimal

        # In der Lohnsteuerkarte des Arbeitnehmers eingetragener Freibetrag
        # fuer den Lohnzahlungszeitraum in Cents
        @wfundf         = BigDecimal.new(0)    # BigDecimal

        # Zahl der Freibetraege fuer Kinder (eine Dezimalstelle, nur bei Steuerklassen
        # I, II, III und IV)
        @zkf            = BigDecimal.new(0)    # BigDecimal

        # Zahl der Monate, fuer die Versorgungsbezuege gezahlt werden (nur
        # erforderlich bei Jahresberechnung (LZZ = 1)
        @zmvb           = 0                    # int

        # OUTPUTS

        # Bemessungsgrundlage fuer die Kirchenlohnsteuer in Cents
        @bk             = BigDecimal.new(0)    # BigDecimal

        # Bemessungsgrundlage der sonstigen Einkuenfte (ohne Verguetung
        # fuer mehrjaehrige Taetigkeit) fuer die Kirchenlohnsteuer in Cents
        @bks            = BigDecimal.new(0)    # BigDecimal
        @bkv            = BigDecimal.new(0)    # BigDecimal

        # Fuer den Lohnzahlungszeitraum einzubehaltende Lohnsteuer in Cents
        @lstlzz         = BigDecimal.new(0)    # BigDecimal

        # Fuer den Lohnzahlungszeitraum einzubehaltender Solidaritaetszuschlag
        # in Cents
        @solzlzz        = BigDecimal.new(0)    # BigDecimal

        # Solidaritaetszuschlag fuer sonstige Bezuege (ohne Verguetung fuer mehrjaehrige
        # Taetigkeit) in Cents
        @solzs          = BigDecimal.new(0)    # BigDecimal

        # Solidaritaetszuschlag fuer die Verguetung fuer mehrjaehrige Taetigkeit in
        # Cents
        @solzv          = BigDecimal.new(0)    # BigDecimal

        # Lohnsteuer fuer sonstige Einkuenfte (ohne Verguetung fuer mehrjaehrige
        # Taetigkeit) in Cents
        @sts            = BigDecimal.new(0)    # BigDecimal

        # Lohnsteuer fuer Verguetung fuer mehrjaehrige Taetigkeit in Cents
        @stv            = BigDecimal.new(0)    # BigDecimal

        # INTERNALS

        # Altersentlastungsbetrag nach Alterseinkuenftegesetz in Cents
        @alte           = BigDecimal.new(0)

        # Arbeitnehmer-Pauschbetrag in EURO
        @anp            = BigDecimal.new(0)

        # Auf den Lohnzahlungszeitraum entfallender Anteil von Jahreswerten
        # auf ganze Cents abgerundet
        @anteil1        = BigDecimal.new(0)

        # Auf den Lohnzahlungszeitraum entfallender Anteil von Jahreswerten
        # auf ganze Cents aufgerundet
        @anteil2        = BigDecimal.new(0)

        # Bemessungsgrundlage fuer Altersentlastungsbetrag in Cents
        @bmg            = BigDecimal.new(0)

        # Differenz zwischen ST1 und ST2 in EURO
        @diff           = BigDecimal.new(0)

        # Entlastungsbetrag fuer Alleinerziehende in EURO
        @efa            = BigDecimal.new(0)

        # Versorgungsfreibetrag in Cents
        @fvb            = BigDecimal.new(0)

        # Zuschlag zum Versorgungsfreibetrag in EURO
        @fvbz           = BigDecimal.new(0)

        # Massgeblich maximaler Versorgungsfreibetrag in Cents
        @hfvb           = BigDecimal.new(0)

        # Nummer der Tabellenwerte fuer Versorgungsparameter
        @j              = 0

        # Jahressteuer nach § 51a EStG, aus der Solidaritaetszuschlag und
        # Bemessungsgrundlage fuer die Kirchenlohnsteuer ermittelt werden in EURO
        @jbmg           = BigDecimal.new(0)

        # Jahreswert, dessen Anteil fuer einen Lohnzahlungszeitraum in
        # UPANTEIL errechnet werden soll in Cents
        @jw             = BigDecimal.new(0)

        # Nummer der Tabellenwerte fuer Parameter bei Altersentlastungsbetrag
        @k              = 0

        # Kennzeichen bei Verguetung fuer mehrjaehrige Taetigkeit
        # 0 = beim Vorwegabzug ist ZRE4VP zu beruecksichtigen
        # 1 = beim Vorwegabzug ist ZRE4VP1 zu beruecksichtigen
        @kennz          = 0

        # Summe der Freibetraege fuer Kinder in EURO
        @kfb            = BigDecimal.new(0)

        # Kennzahl fuer die Einkommensteuer-Tabellenart:
        # 1 = Grundtabelle
        # 2 = Splittingtabelle
        @kztab          = 0

        # Jahreslohnsteuer in EURO
        @lstjahr        = BigDecimal.new(0)

        # Zwischenfelder der Jahreslohnsteuer in Cents
        @lst1           = BigDecimal.new(0)
        @lst2           = BigDecimal.new(0)
        @lst3           = BigDecimal.new(0)

        # Mindeststeuer fuer die Steuerklassen V und VI in EURO
        @mist           = BigDecimal.new(0)

        # Arbeitslohn des Lohnzahlungszeitraums nach Abzug der Freibetraege
        # fuer Versorgungsbezuege, des Altersentlastungsbetrags und des
        # in der Lohnsteuerkarte eingetragenen Freibetrags und Hinzurechnung
        # eines Hinzurechnungsbetrags in Cents. Entspricht dem Arbeitslohn,
        # fuer den die Lohnsteuer im personellen Verfahren aus der
        # zum Lohnzahlungszeitraum gehoerenden Tabelle abgelesen wuerde
        @re4lzz         = BigDecimal.new(0)

        # Arbeitslohn des Lohnzahlungszeitraums nach Abzug der Freibetraege
        # fuer Versorgungsbezuege und des Altersentlastungsbetrags in
        # Cents zur Berechnung der Vorsorgepauschale
        @re4lzzv        = BigDecimal.new(0)

        # Rechenwert in Gleitkommadarstellung
        @rw             = BigDecimal.new(0)

        # Sonderausgaben-Pauschbetrag in EURO
        @sap            = BigDecimal.new(0)

        # Freigrenze fuer den Solidaritaetszuschlag in EURO
        @solzfrei       = BigDecimal.new(0)

        # Solidaritaetszuschlag auf die Jahreslohnsteuer in EURO, C (2 Dezimalstellen)
        @solzj          = BigDecimal.new(0)

        # Zwischenwert fuer den Solidaritaetszuschlag auf die Jahreslohnsteuer
        # in EURO, C (2 Dezimalstellen)
        @solzmin        = BigDecimal.new(0)

        # Tarifliche Einkommensteuer in EURO
        @st             = BigDecimal.new(0)

        # Tarifliche Einkommensteuer auf das 1,25-fache ZX in EURO
        @st1            = BigDecimal.new(0)

        # Tarifliche Einkommensteuer auf das 0,75-fache ZX in EURO
        @st2            = BigDecimal.new(0)

        # Bemessungsgrundlage fuer den Versorgungsfreibetrag in Cents
        @vbezb          = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach Alterseinkuenftegesetz in EURO, C
        @vhb            = BigDecimal.new(0)

        # Vorsorgepauschale in EURO, C (2 Dezimalstellen)
        @vsp            = BigDecimal.new(0)

        # Vorsorgepauschale nach Alterseinkuenftegesetz in EURO, C
        @vspn           = BigDecimal.new(0)

        # Zwischenwert 1 bei der Berechnung der Vorsorgepauschale nach
        # dem Alterseinkuenftegesetz in EURO, C (2 Dezimalstellen)
        @vsp1           = BigDecimal.new(0)

        # Zwischenwert 2 bei der Berechnung der Vorsorgepauschale nach
        # dem Alterseinkuenftegesetz in EURO, C (2 Dezimalstellen)
        @vsp2           = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach § 10c Abs. 3 EStG in EURO
        @vspkurz        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach § 10c Abs. 2 Nr. 2 EStG in EURO
        @vspmax1        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach § 10c Abs. 2 Nr. 3 EStG in EURO
        @vspmax2        = BigDecimal.new(0)

        # Vorsorgepauschale nach § 10c Abs. 2 Satz 2 EStG vor der Hoechstbetragsberechnung
        # in EURO, C (2 Dezimalstellen)
        @vspo           = BigDecimal.new(0)

        # Fuer den Abzug nach § 10c Abs. 2 Nrn. 2 und 3 EStG verbleibender
        # Rest von VSPO in EURO, C (2 Dezimalstellen)
        @vsprest        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach § 10c Abs. 2 Nr. 1 EStG
        # in EURO, C (2 Dezimalstellen)
        @vspvor         = BigDecimal.new(0)

        # Zu versteuerndes Einkommen gem. § 32a Abs. 1 und 2 EStG
        # (2 Dezimalstellen)
        @x              = BigDecimal.new(0)

        # gem. § 32a Abs. 1 EStG (6 Dezimalstellen)
        @y              = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes RE4LZZ in EURO, C (2 Dezimalstellen)
        @zre4           = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes RE4LZZV zur Berechnung
        # der Vorsorgepauschale in EURO, C (2 Dezimalstellen)
        @zre4vp         = BigDecimal.new(0)

        # Sicherungsfeld von ZRE4VP in EURO,C bei der Berechnung des Vorwegabzugs
        # fuer die Verguetung fuer mehrjaehrige Taetigkeit
        @zre4vp1        = BigDecimal.new(0)

        # Feste Tabellenfreibetraege (ohne Vorsorgepauschale) in EURO
        @ztabfb         = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes (VBEZ abzueglich FVB) in
        # EURO, C (2 Dezimalstellen)
        @zvbez          = BigDecimal.new(0)

        # Zu versteuerndes Einkommen in EURO
        @zve            = BigDecimal.new(0)

        # Zwischenfelder zu X fuer die Berechnung der Steuer nach § 39b
        # Abs. 2 Satz 8 EStG in EURO.
        @zx             = BigDecimal.new(0)
        @zzx            = BigDecimal.new(0)
        @hoch           = BigDecimal.new(0)
        @vergl          = BigDecimal.new(0)

        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        mre4lzz
        @kennz = 0
        @re4lzz = @re4.subtract(@fvb).subtract(@alte).subtract(@wfundf).add(@hinzur)
        @re4lzzv = @re4.subtract(@fvb).subtract(@alte)
        mre4
        mztabfb
        mlstjahr
        @lstjahr = @st
        @jw = @lstjahr.multiply(ZAHL100)
        upanteil
        @lstlzz = @anteil1
        if @zkf.compare_to(ZAHL0) == 1
          @ztabfb = @ztabfb.add(@kfb)
          mlstjahr
          @jbmg = @st
        else
          @jbmg = @lstjahr
        end
        msolz
        msonst
        mvmt
      end

      private

      def mre4lzz
        if @vbez.compare_to(ZAHL0) == 0
          @fvbz = ZAHL0
          @fvb = ZAHL0
        else
          if @vjahr < 2006
            @j = 1
          else
            if @vjahr < 2040
              @j = @vjahr - 2004
            else
              @j = 36
            end
          end
          if @lzz == 1
            if ((@sterbe.add(@vkapa)).compare_to(ZAHL0)) == 1
              @vbezb = (@vbezm.multiply(BigDecimal.value_of(@zmvb))).add(@vbezs)
              @hfvb = BigDecimal.value_of(TAB2[@j] * 100)
              @fvbz = BigDecimal.value_of(TAB3[@j])
            else
              @vbezb = (@vbezm.multiply(BigDecimal.value_of(@zmvb))).add(@vbezs)
              @hfvb = BigDecimal.value_of(TAB2[@j] / 12 * @zmvb * 100)
              @fvbz = (BigDecimal.value_of(TAB3[@j] / 12 * @zmvb)).set_scale(0, BigDecimal.ROUND_UP)
            end
          else
            @vbezb = ((@vbezm.multiply(ZAHL12)).add(@vbezs)).set_scale(2, BigDecimal.ROUND_DOWN)
            @hfvb = BigDecimal.value_of(TAB2[@j] * 100)
            @fvbz = BigDecimal.value_of(TAB3[@j])
          end
          @fvb = (@vbezb.multiply(BigDecimal.value_of(TAB1[@j]))).set_scale(0, BigDecimal.ROUND_UP)
          if @fvb.compare_to(@hfvb) == 1
            @fvb = @hfvb
          end
          @jw = @fvb
          upanteil
          @fvb = @anteil2
        end
        if @alter1 == 0
          @alte = ZAHL0
        else
          if @ajahr < 2006
            @k = 1
          else
            if @ajahr < 2040
              @k = @ajahr - 2004
            else
              @k = 36
            end
          end
          @bmg = @re4.subtract(@vbez)
          @alte = (@bmg.multiply(BigDecimal.value_of(TAB4[@k]))).set_scale(0, BigDecimal.ROUND_UP)
          @jw = BigDecimal.value_of(TAB5[@k] * 100)
          upanteil
          if @alte.compare_to(@anteil2) == 1
            @alte = @anteil2
          end
        end
      end

      def mre4
        if @lzz == 1
          @zre4 = @re4lzz.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          @zre4vp = @re4lzzv.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          @zvbez = (@vbez.subtract(@fvb)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
        else
          if @lzz == 2
            @zre4 = ((@re4lzz.add(BigDecimal.value_of(0.67))).multiply(BigDecimal.value_of(0.12))).set_scale(2, BigDecimal.ROUND_DOWN)
            @zre4vp = ((@re4lzzv.add(BigDecimal.value_of(0.67))).multiply(BigDecimal.value_of(0.12))).set_scale(2, BigDecimal.ROUND_DOWN)
            @zvbez = ((@vbez.subtract(@fvb).add(BigDecimal.value_of(0.67))).multiply(BigDecimal.value_of(0.12))).set_scale(2, BigDecimal.ROUND_DOWN)
          else
            if @lzz == 3
              @zre4 = ((@re4lzz.add(BigDecimal.value_of(0.89))).multiply(BigDecimal.value_of(3.6 / 7.0))).set_scale(2, BigDecimal.ROUND_DOWN)
              @zre4vp = ((@re4lzzv.add(BigDecimal.value_of(0.89))).multiply(BigDecimal.value_of(3.6 / 7.0))).set_scale(2, BigDecimal.ROUND_DOWN)
              @zvbez = ((@vbez.subtract(@fvb).add(BigDecimal.value_of(0.89))).multiply(BigDecimal.value_of(3.6 / 7.0))).set_scale(2, BigDecimal.ROUND_DOWN)
            else
              @zre4 = ((@re4lzz.add(BigDecimal.value_of(0.56))).multiply(BigDecimal.value_of(3.6))).set_scale(2, BigDecimal.ROUND_DOWN)
              @zre4vp = ((@re4lzzv.add(BigDecimal.value_of(0.56))).multiply(BigDecimal.value_of(3.6))).set_scale(2, BigDecimal.ROUND_DOWN)
              @zvbez = ((@vbez.subtract(@fvb).add(BigDecimal.value_of(0.56))).multiply(BigDecimal.value_of(3.6))).set_scale(2, BigDecimal.ROUND_DOWN)
            end
          end
        end
        if @zre4.compare_to(ZAHL0) == -1
          @zre4 = ZAHL0
        end
        if @zvbez.compare_to(ZAHL0) == -1
          @zvbez = ZAHL0
        end
      end

      def mztabfb
        @anp = ZAHL0
        if @zvbez.compare_to(ZAHL0) == 1
          if @zvbez.compare_to(@fvbz) == -1
            @fvbz = @zvbez.set_scale(0, BigDecimal.ROUND_DOWN)
          end
        end
        if @stkl < 6
          if @zvbez.compare_to(ZAHL0) == 1
            if (@zvbez.subtract(@fvbz)).compare_to(BigDecimal.value_of(102)) == -1
              @anp = (@zvbez.subtract(@fvbz)).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              @anp = BigDecimal.value_of(102)
            end
          end
        end
        if @stkl < 6
          if @zre4.compare_to(@zvbez) == 1
            if (@zre4.subtract(@zvbez)).compare_to(BigDecimal.value_of(920)) == -1
              @anp = (@anp.add(@zre4).subtract(@zvbez)).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              @anp = @anp.add(BigDecimal.value_of(920))
            end
          end
        end
        @kztab = 1
        if @stkl == 1
          @sap = BigDecimal.value_of(36)
          @kfb = (@zkf.multiply(BigDecimal.value_of(5808))).set_scale(0, BigDecimal.ROUND_DOWN)
        else
          if @stkl == 2
            @efa = BigDecimal.value_of(1308)
            @sap = BigDecimal.value_of(36)
            @kfb = (@zkf.multiply(BigDecimal.value_of(5808))).set_scale(0, BigDecimal.ROUND_DOWN)
          else
            if @stkl == 3
              @kztab = 2
              @sap = BigDecimal.value_of(72)
              @kfb = (@zkf.multiply(BigDecimal.value_of(5808))).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              if @stkl == 4
                @sap = BigDecimal.value_of(36)
                @kfb = (@zkf.multiply(BigDecimal.value_of(2904))).set_scale(0, BigDecimal.ROUND_DOWN)
              else
                @kfb = ZAHL0
              end
            end
          end
        end
        @ztabfb = @efa.add(@anp).add(@sap).add(@fvbz)
      end

      def mlstjahr
        if @stkl < 5
          upevp
        else
          @vsp = ZAHL0
        end
        @zve = (@zre4.subtract(@ztabfb).subtract(@vsp)).set_scale(0, BigDecimal.ROUND_DOWN)
        if @zve.compare_to(ZAHL1) == -1
          @zve = ZAHL0
          @x = ZAHL0
        else
          @x = @zve.divide(BigDecimal.value_of(@kztab), 0, BigDecimal.ROUND_DOWN)
        end
        if @stkl < 5
          uptab05
        else
          mst5_6
        end
      end

      def upevp
        if @krv == 1
          @vsp1 = ZAHL0
        else
          if @zre4vp.compare_to(BigDecimal.value_of(63000)) == 1
            @zre4vp = BigDecimal.value_of(63000)
          end
          @vsp1 = (@zre4vp.multiply(BigDecimal.value_of(0.24))).set_scale(2, BigDecimal.ROUND_DOWN)
          @vsp1 = (@vsp1.multiply(BigDecimal.value_of(0.0975))).set_scale(2, BigDecimal.ROUND_DOWN)
        end
        @vsp2 = @zre4vp.multiply(BigDecimal.value_of(0.11))
        @vhb = BigDecimal.value_of(1500 * @kztab)
        if @vsp2.compare_to(@vhb) == 1
          @vsp2 = @vhb
        end
        @vspn = (@vsp1.add(@vsp2)).set_scale(0, BigDecimal.ROUND_UP)
        mvsp
        if @vspn.compare_to(@vsp) == 1
          @vsp = @vspn.set_scale(2, BigDecimal.ROUND_DOWN)
        end
      end

      def mvsp
        if @kennz == 1
          @vspo = @zre4vp1.multiply(BigDecimal.value_of(0.2))
        else
          @vspo = @zre4vp.multiply(BigDecimal.value_of(0.2))
        end
        @vspvor = BigDecimal.value_of(@kztab * 3068)
        @vspmax1 = BigDecimal.value_of(@kztab * 1334)
        @vspmax2 = BigDecimal.value_of(@kztab * 667)
        @vspkurz = BigDecimal.value_of(@kztab * 1134)
        if @krv == 1
          if @vspo.compare_to(@vspkurz) == 1
            @vsp = @vspkurz
          else
            @vsp = @vspo.set_scale(2, BigDecimal.ROUND_UP)
          end
        else
          umvsp
        end
      end

      def umvsp
        if @kennz == 1
          @vspvor = @vspvor.subtract(@zre4vp1.multiply(BigDecimal.value_of(0.16)))
        else
          @vspvor = @vspvor.subtract(@zre4vp.multiply(BigDecimal.value_of(0.16)))
        end
        if @vspvor.compare_to(ZAHL0) == -1
          @vspvor = ZAHL0
        end
        if @vspo.compare_to(@vspvor) == 1
          @vsp = @vspvor
          @vsprest = @vspo.subtract(@vspvor)
          if @vsprest.compare_to(@vspmax1) == 1
            @vsp = @vsp.add(@vspmax1)
            @vsprest = (@vsprest.subtract(@vspmax1)).divide(ZAHL2, 2, BigDecimal.ROUND_UP)
            if @vsprest.compare_to(@vspmax2) == 1
              @vsp = (@vsp.add(@vspmax2)).set_scale(0, BigDecimal.ROUND_UP)
            else
              @vsp = (@vsp.add(@vsprest)).set_scale(0, BigDecimal.ROUND_UP)
            end
          else
            @vsp = (@vsp.add(@vsprest)).set_scale(0, BigDecimal.ROUND_UP)
          end
        else
          @vsp = @vspo.set_scale(0, BigDecimal.ROUND_UP)
        end
      end

      def mst5_6
        @zzx = @x
        if @zzx.compare_to(BigDecimal.value_of(25812)) == 1
          @zx = BigDecimal.value_of(25812)
          up5_6
          @st = (@st.add((@zzx.subtract(BigDecimal.value_of(25812))).multiply(BigDecimal.value_of(0.42)))).set_scale(0, BigDecimal.ROUND_DOWN)
        else
          @zx = @zzx
          up5_6
          if @zzx.compare_to(BigDecimal.value_of(9144)) == 1
            @vergl = @st
            @zx = BigDecimal.value_of(9144)
            up5_6
            @hoch = (@st.add((@zzx.subtract(BigDecimal.value_of(9144))).multiply(BigDecimal.value_of(0.42)))).set_scale(0, BigDecimal.ROUND_DOWN)
            if @hoch.compare_to(@vergl) == -1
              @st = @hoch
            else
              @st = @vergl
            end
          end
        end
      end

      def up5_6
        @x = @zx.multiply(BigDecimal.value_of(1.25))
        uptab05
        @st1 = @st
        @x = @zx.multiply(BigDecimal.value_of(0.75))
        uptab05
        @st2 = @st
        @diff = (@st1.subtract(@st2)).multiply(ZAHL2)
        @mist = (@zx.multiply(BigDecimal.value_of(0.15))).set_scale(0, BigDecimal.ROUND_DOWN)
        if @mist.compare_to(@diff) == 1
          @st = @mist
        else
          @st = @diff
        end
      end

      def msolz
        @solzfrei = BigDecimal.value_of(972 * @kztab)
        if @jbmg.compare_to(@solzfrei) == 1
          @solzj = (@jbmg.multiply(BigDecimal.value_of(5.5 / 100))).set_scale(2, BigDecimal.ROUND_DOWN)
          @solzmin = (@jbmg.subtract(@solzfrei)).multiply(BigDecimal.value_of(20.0 / 100.0))
          if @solzmin.compare_to(@solzj) == -1
            @solzj = @solzmin
          end
          @jw = @solzj.multiply(ZAHL100).set_scale(0, BigDecimal.ROUND_DOWN)
          upanteil
          @solzlzz = @anteil1
        else
          @solzlzz = ZAHL0
        end
        if @r > 0
          @jw = @jbmg.multiply(ZAHL100)
          upanteil
          @bk = @anteil1
        else
          @bk = ZAHL0
        end
      end

      def upanteil
        if @lzz == 1
          @anteil1 = @jw
          @anteil2 = @jw
        else
          if @lzz == 2
            @anteil1 = @jw.divide(ZAHL12, 0, BigDecimal.ROUND_DOWN)
            @anteil2 = @jw.divide(ZAHL12, 0, BigDecimal.ROUND_UP)
          else
            if @lzz == 3
              @anteil1 = (@jw.multiply(ZAHL7)).divide(ZAHL360, 0, BigDecimal.ROUND_DOWN)
              @anteil2 = (@jw.multiply(ZAHL7)).divide(ZAHL360, 0, BigDecimal.ROUND_UP)
            else
              @anteil1 = @jw.divide(ZAHL360, 0, BigDecimal.ROUND_DOWN)
              @anteil2 = @jw.divide(ZAHL360, 0, BigDecimal.ROUND_UP)
            end
          end
        end
      end

      def msonst
        if @sonstb.compare_to(ZAHL0) == 1
          @lzz = 1
          @vbez = @jvbez
          @re4 = @jre4
          mre4lzz
          mre4lzz2
          mlstjahr
          @lst1 = @st.multiply(ZAHL100)
          @vbez = @jvbez.add(@vbs)
          @re4 = @jre4.add(@sonstb)
          @vbezs = @vbezs.add(@sterbe)
          mre4lzz
          mre4lzz2
          mlstjahr
          @lst2 = @st.multiply(ZAHL100)
          @sts = @lst2.subtract(@lst1)
          @solzs = @sts.multiply(BigDecimal.value_of(5.5)).divide(ZAHL100, 0, BigDecimal.ROUND_DOWN)
          if @r > 0
            @bks = @sts
          else
            @bks = ZAHL0
          end
        else
          @sts = ZAHL0
          @solzs = ZAHL0
          @bks = ZAHL0
        end
      end

      def mre4lzz2
        @re4lzz = @re4.subtract(@fvb).subtract(@alte).subtract(@jfreib).add(@jhinzu)
        @re4lzzv = @re4.subtract(@fvb).subtract(@alte)
        mre4
        mztabfb
      end

      def mvmt
        if (@vmt.add(@vkapa)).compare_to(ZAHL0) == 1
          @lzz = 1
          @vbez = @jvbez.add(@vbs)
          @re4 = @jre4.add(@sonstb)
          mre4lzz
          mre4lzz2
          mlstjahr
          @lst1 = @st.multiply(ZAHL100)
          @vmt = @vmt.add(@vkapa)
          @vbezs = @vbezs.add(@vkapa)
          @vbez = @vbez.add(@vkapa)
          @re4 = @jre4.add(@sonstb).add(@vmt)
          mre4lzz
          mre4lzz2
          @kennz = 1
          @zre4vp1 = @zre4vp
          mlstjahr
          @lst3 = @st.multiply(ZAHL100)
          @vbez = @vbez.subtract(@vkapa)
          @re4 = @jre4.add(@sonstb)
          mre4lzz
          if (@re4.subtract(@jfreib).add(@jhinzu)).compare_to(ZAHL0) == -1
            @re4 = @re4.subtract(@jfreib).add(@jhinzu)
            @jfreib = ZAHL0
            @jhinzu = ZAHL0
            @re4 = (@re4.add(@vmt)).divide(ZAHL5, 0, BigDecimal.ROUND_DOWN)
            mre4lzz2
            mlstjahr
            @lst2 = @st.multiply(ZAHL100)
            @stv = @lst2.multiply(ZAHL5)
          else
            @re4 = @re4.add(@vmt.divide(ZAHL5, 0, BigDecimal.ROUND_DOWN))
            mre4lzz2
            mlstjahr
            @lst2 = @st.multiply(ZAHL100)
            @stv = (@lst2.subtract(@lst1)).multiply(ZAHL5)
          end
          @lst3 = @lst3.subtract(@lst1)
          if @lst3.compare_to(@stv) == -1
            @stv = @lst3
          end
          @solzv = (@stv.multiply(BigDecimal.value_of(5.5))).divide(ZAHL100, 0, BigDecimal.ROUND_DOWN)
          if @r > 0
            @bkv = @stv
          else
            @bkv = ZAHL0
          end
        else
          @stv = ZAHL0
          @solzv = ZAHL0
          @bkv = ZAHL0
        end
      end

      def uptab05
        if @x.compare_to(BigDecimal.value_of(7665)) == -1
          @st = ZAHL0
        else
          if @x.compare_to(BigDecimal.value_of(12740)) == -1
            @y = (@x.subtract(BigDecimal.value_of(7664))).divide(BigDecimal.value_of(10000), 6, BigDecimal.ROUND_DOWN)
            @rw = @y.multiply(BigDecimal.value_of(883.74))
            @rw = @rw.add(BigDecimal.value_of(1500))
            @st = (@rw.multiply(@y)).set_scale(0, BigDecimal.ROUND_DOWN)
          else
            if @x.compare_to(BigDecimal.value_of(52152)) == -1
              @y = (@x.subtract(BigDecimal.value_of(12739))).divide(BigDecimal.value_of(10000), 6, BigDecimal.ROUND_DOWN)
              @rw = @y.multiply(BigDecimal.value_of(228.74))
              @rw = @rw.add(BigDecimal.value_of(2397))
              @rw = @rw.multiply(@y)
              @st = (@rw.add(BigDecimal.value_of(989))).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              @st = ((@x.multiply(BigDecimal.value_of(0.42))).subtract(BigDecimal.value_of(7914))).set_scale(0, BigDecimal.ROUND_DOWN)
            end
          end
        end
        @st = @st.multiply(BigDecimal.value_of(@kztab))
      end

    end
  end
end
