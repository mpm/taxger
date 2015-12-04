module Taxger
  module Lohnsteuer
    class Lohnsteuer2008
      # CONSTANTS

      # Tabelle fuer die Vomhundertsaetze des Versorgungsfreibetrags
      TAB1            = [BigDecimal.value_of(0.0), BigDecimal.value_of(0.4), BigDecimal.value_of(0.384), BigDecimal.value_of(0.368),
                    BigDecimal.value_of(0.352), BigDecimal.value_of(0.336), BigDecimal.value_of(0.32), BigDecimal.value_of(0.304),
                    BigDecimal.value_of(0.288), BigDecimal.value_of(0.272), BigDecimal.value_of(0.256), BigDecimal.value_of(0.24),
                    BigDecimal.value_of(0.224), BigDecimal.value_of(0.208), BigDecimal.value_of(0.192), BigDecimal.value_of(0.176),
                    BigDecimal.value_of(0.16), BigDecimal.value_of(0.152), BigDecimal.value_of(0.144), BigDecimal.value_of(0.136),
                    BigDecimal.value_of(0.128), BigDecimal.value_of(0.12), BigDecimal.value_of(0.112), BigDecimal.value_of(0.104),
                    BigDecimal.value_of(0.096), BigDecimal.value_of(0.088), BigDecimal.value_of(0.08), BigDecimal.value_of(0.072),
                    BigDecimal.value_of(0.064), BigDecimal.value_of(0.056), BigDecimal.value_of(0.048), BigDecimal.value_of(0.04),
                    BigDecimal.value_of(0.032), BigDecimal.value_of(0.024), BigDecimal.value_of(0.016), BigDecimal.value_of(0.008),
                    BigDecimal.value_of(0.0)]

      # Tabelle fuer die Hoechstbetrage des Versorgungsfreibetrags
      TAB2            = [BigDecimal.value_of(0), BigDecimal.value_of(3000), BigDecimal.value_of(2880), BigDecimal.value_of(2760),
                    BigDecimal.value_of(2640), BigDecimal.value_of(2520), BigDecimal.value_of(2400), BigDecimal.value_of(2280),
                    BigDecimal.value_of(2160), BigDecimal.value_of(2040), BigDecimal.value_of(1920), BigDecimal.value_of(1800),
                    BigDecimal.value_of(1680), BigDecimal.value_of(1560), BigDecimal.value_of(1440), BigDecimal.value_of(1320),
                    BigDecimal.value_of(1200), BigDecimal.value_of(1140), BigDecimal.value_of(1080), BigDecimal.value_of(1020),
                    BigDecimal.value_of(960), BigDecimal.value_of(900), BigDecimal.value_of(840), BigDecimal.value_of(780),
                    BigDecimal.value_of(720), BigDecimal.value_of(660), BigDecimal.value_of(600), BigDecimal.value_of(540),
                    BigDecimal.value_of(480), BigDecimal.value_of(420), BigDecimal.value_of(360), BigDecimal.value_of(300),
                    BigDecimal.value_of(240), BigDecimal.value_of(180), BigDecimal.value_of(120), BigDecimal.value_of(60),
                    BigDecimal.value_of(0)]

      # Tabelle fuer die Zuschlaege zum Versorgungsfreibetrag
      TAB3            = [BigDecimal.value_of(0), BigDecimal.value_of(900), BigDecimal.value_of(864), BigDecimal.value_of(828),
                    BigDecimal.value_of(792), BigDecimal.value_of(756), BigDecimal.value_of(720), BigDecimal.value_of(684),
                    BigDecimal.value_of(648), BigDecimal.value_of(612), BigDecimal.value_of(576), BigDecimal.value_of(540),
                    BigDecimal.value_of(504), BigDecimal.value_of(468), BigDecimal.value_of(432), BigDecimal.value_of(396),
                    BigDecimal.value_of(360), BigDecimal.value_of(342), BigDecimal.value_of(324), BigDecimal.value_of(306),
                    BigDecimal.value_of(288), BigDecimal.value_of(270), BigDecimal.value_of(252), BigDecimal.value_of(234),
                    BigDecimal.value_of(216), BigDecimal.value_of(198), BigDecimal.value_of(180), BigDecimal.value_of(162),
                    BigDecimal.value_of(144), BigDecimal.value_of(126), BigDecimal.value_of(108), BigDecimal.value_of(90),
                    BigDecimal.value_of(72), BigDecimal.value_of(54), BigDecimal.value_of(36), BigDecimal.value_of(18),
                    BigDecimal.value_of(0)]

      # Tabelle fuer die Vomhundertsaetze des Altersentlastungsbetrags
      TAB4            = [BigDecimal.value_of(0.0), BigDecimal.value_of(0.4), BigDecimal.value_of(0.384), BigDecimal.value_of(0.368),
                    BigDecimal.value_of(0.352), BigDecimal.value_of(0.336), BigDecimal.value_of(0.32), BigDecimal.value_of(0.304),
                    BigDecimal.value_of(0.288), BigDecimal.value_of(0.272), BigDecimal.value_of(0.256), BigDecimal.value_of(0.24),
                    BigDecimal.value_of(0.224), BigDecimal.value_of(0.208), BigDecimal.value_of(0.192), BigDecimal.value_of(0.176),
                    BigDecimal.value_of(0.16), BigDecimal.value_of(0.152), BigDecimal.value_of(0.144), BigDecimal.value_of(0.136),
                    BigDecimal.value_of(0.128), BigDecimal.value_of(0.12), BigDecimal.value_of(0.112), BigDecimal.value_of(0.104),
                    BigDecimal.value_of(0.096), BigDecimal.value_of(0.088), BigDecimal.value_of(0.08), BigDecimal.value_of(0.072),
                    BigDecimal.value_of(0.064), BigDecimal.value_of(0.056), BigDecimal.value_of(0.048), BigDecimal.value_of(0.04),
                    BigDecimal.value_of(0.032), BigDecimal.value_of(0.024), BigDecimal.value_of(0.016), BigDecimal.value_of(0.008),
                    BigDecimal.value_of(0.0)]

      # Tabelle fuer die Hoechstbetraege des Altersentlastungsbetrags
      TAB5            = [BigDecimal.value_of(0), BigDecimal.value_of(1900), BigDecimal.value_of(1824), BigDecimal.value_of(1748),
                    BigDecimal.value_of(1672), BigDecimal.value_of(1596), BigDecimal.value_of(1520), BigDecimal.value_of(1444),
                    BigDecimal.value_of(1368), BigDecimal.value_of(1292), BigDecimal.value_of(1216), BigDecimal.value_of(1140),
                    BigDecimal.value_of(1064), BigDecimal.value_of(988), BigDecimal.value_of(912), BigDecimal.value_of(836),
                    BigDecimal.value_of(760), BigDecimal.value_of(722), BigDecimal.value_of(684), BigDecimal.value_of(646),
                    BigDecimal.value_of(608), BigDecimal.value_of(570), BigDecimal.value_of(532), BigDecimal.value_of(494),
                    BigDecimal.value_of(456), BigDecimal.value_of(418), BigDecimal.value_of(380), BigDecimal.value_of(342),
                    BigDecimal.value_of(304), BigDecimal.value_of(266), BigDecimal.value_of(228), BigDecimal.value_of(190),
                    BigDecimal.value_of(152), BigDecimal.value_of(114), BigDecimal.value_of(76), BigDecimal.value_of(38),
                    BigDecimal.value_of(0)]

      # Zahlenkonstanten fuer im Plan oft genutzte BigDecimal Werte
      ZAHL1           = BigDecimal.ONE
      ZAHL2           = BigDecimal.new(2)
      ZAHL3           = BigDecimal.new(3)
      ZAHL4           = BigDecimal.new(4)
      ZAHL5           = BigDecimal.new(5)
      ZAHL6           = BigDecimal.new(6)
      ZAHL7           = BigDecimal.new(7)
      ZAHL8           = BigDecimal.new(8)
      ZAHL9           = BigDecimal.new(9)
      ZAHL10          = BigDecimal.TEN
      ZAHL11          = BigDecimal.new(11)
      ZAHL12          = BigDecimal.new(12)
      ZAHL100         = BigDecimal.new(100)
      ZAHL360         = BigDecimal.new(360)
      ZAHL700         = BigDecimal.new(700)

      attr_accessor :bk
      attr_accessor :bks
      attr_accessor :bkv
      attr_accessor :lstlzz
      attr_accessor :solzlzz
      attr_accessor :solzs
      attr_accessor :solzv
      attr_accessor :sts
      attr_accessor :stv

      INPUT_VARS = [:ajahr, :alter1, :jfreib, :jhinzu, :jre4, :jvbez, :krv, :lzz, :lzzfreib, :lzzhinzu, :r, :re4, :sonstb, :sterbe, :stkl, :vbez, :vbezm, :vbezs, :vbs, :vjahr, :vkapa, :vmt, :zkf, :zmvb]
      OUTPUT_VARS = [:bk, :bks, :bkv, :lstlzz, :solzlzz, :solzs, :solzv, :sts, :stv]
      def initialize(params)
        raise "Unknown parameters: #{params.keys - INPUT_VARS}" if params.keys - INPUT_VARS != []
        # INPUTS

        # Auf die Vollendung des 64. Lebensjahres folgende
        # Kalenderjahr (erforderlich, wenn ALTER1=1)
        @ajahr          = 0                    # int

        # 1, wenn das 64. Lebensjahr zu Beginn des Kalenderjahres vollendet wurde, in dem
        # der Lohnzahlungszeitraum endet (Â§ 24 a EStG), sonst = 0
        @alter1         = 0                    # int

        # Jahresfreibetrag nach Ma&szlig;gabe der Eintragungen auf der
        # Lohnsteuerkarte in Cents (ggf. 0)
        @jfreib         = BigDecimal.new(0)    # BigDecimal

        # Jahreshinzurechnungsbetrag in Cents (ggf. 0)
        @jhinzu         = BigDecimal.new(0)    # BigDecimal

        # Voraussichtlicher Jahresarbeitslohn ohne sonstige Bezuege und
        # ohne Verguetung fuer mehrjaehrige Taetigkeit in Cents (ggf. 0)
        # Anmerkung: Die Eingabe dieses Feldes ist erforderlich bei Eingabe
        # â€žsonstiger Bezuegeâ€œ (Feld SONSTB) oder bei Eingabe der â€žVerguetung
        # fuer mehrjaehrige Taetigkeitâ€œ (Feld VMT).
        @jre4           = BigDecimal.new(0)    # BigDecimal

        # In JRE4 enthaltene Versorgungsbezuege in Cents (ggf. 0)
        @jvbez          = BigDecimal.new(0)    # BigDecimal

        # 2 = fÃ¼r den Arbeitnehmer wird die gekÃ¼rzte Vorsorgepauschale nach dem Recht 2008 angesetzt
        # (Â§ 10c Abs. 3 EStG n.F.), jedoch bei der GÃ¼nstigerprÃ¼fung die ungekÃ¼rzte Vorsorgepauschale
        # nach dem Recht bis 2004 berÃ¼cksichtigt (Â§ 10c Abs. 2 EStG a.F.); Ã„nderung durch das JStG 2008.
        # 1 = fÃ¼r den Arbeitnehmer wird die gekÃ¼rzte Vorsorgepauschale angewandt (Â§ 10c Abs. 3 EStG),
        # soweit nicht Arbeitnehmer der Fallgruppe 2.
        # 0 = andere Arbeitnehmer.
        # FÃ¼r die Zuordnung sind allein die dem Arbeitgeber ohnehin bekannten Tatsachen maÃŸgebend;
        # zusÃ¤tzliche Ermittlungen braucht der Arbeitgeber nicht anzustellen.
        @krv            = 0                    # int

        # Lohnzahlungszeitraum:
        # 1 = Jahr
        # 2 = Monat
        # 3 = Woche
        # 4 = Tag
        @lzz            = 0                    # int

        # In der Lohnsteuerkarte des Arbeitnehmers eingetragener Freibetrag fÃ¼r
        # den Lohnzahlungszeitraum in Cent
        @lzzfreib       = BigDecimal.new(0)    # BigDecimal

        # In der Lohnsteuerkarte des Arbeitnehmers eingetragener Hinzurechnungsbetrag
        # fÃ¼r den Lohnzahlungszeitraum in Cent
        @lzzhinzu       = BigDecimal.new(0)    # BigDecimal

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

        # Altersentlastungsbetrag nach AlterseinkÃ¼nftegesetz in â‚¬,
        # Cent (2 Dezimalstellen)
        @alte           = BigDecimal.new(0)

        # Arbeitnehmer-Pauschbetrag in EURO
        @anp            = BigDecimal.new(0)

        # Auf den Lohnzahlungszeitraum entfallender Anteil von Jahreswerten
        # auf ganze Cents abgerundet
        @anteil1        = BigDecimal.new(0)

        # Auf den Lohnzahlungszeitraum entfallender Anteil von Jahreswerten
        # auf ganze Cents aufgerundet
        @anteil2        = BigDecimal.new(0)

        # Bemessungsgrundlage fÃ¼r Altersentlastungsbetrag in â‚¬, Cent
        # (2 Dezimalstellen)
        @bmg            = BigDecimal.new(0)

        # Differenz zwischen ST1 und ST2 in EURO
        @diff           = BigDecimal.new(0)

        # Entlastungsbetrag fuer Alleinerziehende in EURO
        @efa            = BigDecimal.new(0)

        # Versorgungsfreibetrag in â‚¬, Cent (2 Dezimalstellen)
        @fvb            = BigDecimal.new(0)

        # Versorgungsfreibetrag in â‚¬, Cent (2 Dezimalstellen) fÃ¼r die Berechnung
        # der Lohnsteuer fÃ¼r den sonstigen Bezug
        @fvbso          = BigDecimal.new(0)

        # Zuschlag zum Versorgungsfreibetrag in EURO
        @fvbz           = BigDecimal.new(0)

        # Zuschlag zum Versorgungsfreibetrag in EURO fuer die Berechnung
        # der Lohnsteuer beim sonstigen Bezug
        @fvbzso         = BigDecimal.new(0)

        # Sicherungsfeld fÃ¼r den Zuschlag zum Versorgungsfreibetrag in â‚¬ fÃ¼r
        # die Berechnung der Lohnsteuer fÃ¼r die VergÃ¼tung fÃ¼r mehrjÃ¤hrige
        # TÃ¤tigkeit
        @fvbzoso        = BigDecimal.new(0)

        # Maximaler Altersentlastungsbetrag in â‚¬
        @hbalte         = BigDecimal.new(0)

        # MaÃŸgeblicher maximaler Versorgungsfreibetrag in â‚¬
        @hfvb           = BigDecimal.new(0)

        # MaÃŸgeblicher maximaler Zuschlag zum Versorgungsfreibetrag in â‚¬,Cent
        # (2 Dezimalstellen)
        @hfvbz          = BigDecimal.new(0)

        # MaÃŸgeblicher maximaler Zuschlag zum Versorgungsfreibetrag in â‚¬, Cent
        # (2 Dezimalstellen) fÃ¼r die Berechnung der Lohnsteuer fÃ¼r den
        # sonstigen Bezug
        @hfvbzso        = BigDecimal.new(0)

        # Nummer der Tabellenwerte fuer Versorgungsparameter
        @j              = 0

        # Jahressteuer nach Â§ 51a EStG, aus der Solidaritaetszuschlag und
        # Bemessungsgrundlage fuer die Kirchenlohnsteuer ermittelt werden in EURO
        @jbmg           = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechneter LZZFREIB in â‚¬, Cent
        # (2 Dezimalstellen)
        @jlfreib        = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnete LZZHINZU in â‚¬, Cent
        # (2 Dezimalstellen)
        @jlhinzu        = BigDecimal.new(0)

        # Jahreswert, dessen Anteil fuer einen Lohnzahlungszeitraum in
        # UPANTEIL errechnet werden soll in Cents
        @jw             = BigDecimal.new(0)

        # Nummer der Tabellenwerte fuer Parameter bei Altersentlastungsbetrag
        @k              = 0

        # Merker fÃ¼r Berechnung Lohnsteuer fÃ¼r mehrjÃ¤hrige TÃ¤tigkeit.
        # 0 = normale Steuerberechnung
        # 1 = Steuerberechnung fÃ¼r mehrjÃ¤hrige TÃ¤tigkeit
        # 2 = Steuerberechnung fÃ¼r mehrjÃ¤hrige TÃ¤tigkeit Sonderfall nach Â§ 34 Abs. 1 Satz 3 EStG
        @kennvmt        = 0

        # Summe der Freibetraege fuer Kinder in EURO
        @kfb            = BigDecimal.new(0)

        # Kennzahl fuer die Einkommensteuer-Tabellenart:
        # 1 = Grundtabelle
        # 2 = Splittingtabelle
        @kztab          = 0

        # Jahreslohnsteuer in EURO
        @lstjahr        = BigDecimal.new(0)

        # Zwischenfelder der Jahreslohnsteuer in Cent
        @lst1           = BigDecimal.new(0)
        @lst2           = BigDecimal.new(0)
        @lst3           = BigDecimal.new(0)
        @lstoso         = BigDecimal.new(0)
        @lstso          = BigDecimal.new(0)

        # Mindeststeuer fuer die Steuerklassen V und VI in EURO
        @mist           = BigDecimal.new(0)

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

        # Bemessungsgrundlage fÃ¼r den Versorgungsfreibetrag in Cent fÃ¼r
        # den sonstigen Bezug
        @vbezbso        = BigDecimal.new(0)

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

        # Hoechstbetrag der Vorsorgepauschale nach Â§ 10c Abs. 3 EStG in EURO
        @vspkurz        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach Â§ 10c Abs. 2 Nr. 2 EStG in EURO
        @vspmax1        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach Â§ 10c Abs. 2 Nr. 3 EStG in EURO
        @vspmax2        = BigDecimal.new(0)

        # Vorsorgepauschale nach Â§ 10c Abs. 2 Satz 2 EStG vor der Hoechstbetragsberechnung
        # in EURO, C (2 Dezimalstellen)
        @vspo           = BigDecimal.new(0)

        # Fuer den Abzug nach Â§ 10c Abs. 2 Nrn. 2 und 3 EStG verbleibender
        # Rest von VSPO in EURO, C (2 Dezimalstellen)
        @vsprest        = BigDecimal.new(0)

        # Hoechstbetrag der Vorsorgepauschale nach Â§ 10c Abs. 2 Nr. 1 EStG
        # in EURO, C (2 Dezimalstellen)
        @vspvor         = BigDecimal.new(0)

        # Zu versteuerndes Einkommen gem. Â§ 32a Abs. 1 und 2 EStG â‚¬, C
        # (2 Dezimalstellen)
        @x              = BigDecimal.new(0)

        # gem. Â§ 32a Abs. 1 EStG (6 Dezimalstellen)
        @y              = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes RE4 in â‚¬, C (2 Dezimalstellen)
        # nach Abzug der FreibetrÃ¤ge nach Â§ 39 b Abs. 2 Satz 3 und 4.
        @zre4           = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes RE4 in â‚¬, C (2 Dezimalstellen)
        @zre4j          = BigDecimal.new(0)

        # Sicherungsfeld von ZRE4 bei der Berechnung der Lohnsteuer fÃ¼r
        # die VergÃ¼tung fÃ¼r mehrjÃ¤hrige TÃ¤tigkeit in â‚¬, C (2 Dezimalstellen)
        @zre4oso        = BigDecimal.new(0)

        # 1/5 des mehrjÃ¤hriger Bezugs abzÃ¼glich der auf diesen Lohnbestandteil
        # entfallenden festen TabellenfreibetrÃ¤ge in â‚¬, C (2 Dezimalstellen)
        @zre4vmt        = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes RE4 in â‚¬, C (2 Dezimalstellen)
        # nach Abzug des Versorgungsfreibetrags und des Alterentlastungsbetrags
        # zur Berechnung der Vorsorgepauschale in â‚¬, Cent (2 Dezimalstellen)
        @zre4vp         = BigDecimal.new(0)

        # Feste TabellenfreibetrÃ¤ge (ohne Vorsorgepauschale) in â‚¬, Cent
        # (2 Dezimalstellen)
        @ztabfb         = BigDecimal.new(0)

        # Sicherungsfeld von ZTABFB bei der Berechnung fÃ¼r die VergÃ¼tung
        # fÃ¼r mehrjÃ¤hrige TÃ¤tigkeit in â‚¬, Cent (2 Dezimalstellen)
        @ztabfboso      = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes (VBEZ abzueglich FVB) in
        # EURO, C (2 Dezimalstellen)
        @zvbez          = BigDecimal.new(0)

        # Auf einen Jahreslohn hochgerechnetes VBEZ in â‚¬, C (2 Dezimalstellen)
        @zvbezj         = BigDecimal.new(0)

        # Zu versteuerndes Einkommen in â‚¬, C (2 Dezimalstellen)
        @zve            = BigDecimal.new(0)

        # Zwischenfelder zu X fuer die Berechnung der Steuer nach Â§ 39b
        # Abs. 2 Satz 8 EStG in EURO.
        @zx             = BigDecimal.new(0)
        @zzx            = BigDecimal.new(0)
        @hoch           = BigDecimal.new(0)
        @vergl          = BigDecimal.new(0)

        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        mre4jl
        mre4
        mre4abz
        mztabfb
        @kennvmt = 0
        mlstjahr
        @lstjahr = @st
        @jw = @lstjahr.multiply(ZAHL100)
        upanteil
        @lstlzz = @anteil1
        if @zkf.compare_to(BigDecimal.ZERO) == 1
          @ztabfb = (@ztabfb.add(@kfb)).set_scale(2, BigDecimal.ROUND_DOWN)
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

      def mre4jl
        if @lzz == 1
          @zre4j = @re4.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          @zvbezj = @vbez.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          @jlfreib = @lzzfreib.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          @jlhinzu = @lzzhinzu.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
        else
          if @lzz == 2
            @zre4j = (@re4.multiply(ZAHL12)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
            @zvbezj = (@vbez.multiply(ZAHL12)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
            @jlfreib = (@lzzfreib.multiply(ZAHL12)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
            @jlhinzu = (@lzzhinzu.multiply(ZAHL12)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
          else
            if @lzz == 3
              @zre4j = (@re4.multiply(ZAHL360)).divide(ZAHL700, 2, BigDecimal.ROUND_DOWN)
              @zvbezj = (@vbez.multiply(ZAHL360)).divide(ZAHL700, 2, BigDecimal.ROUND_DOWN)
              @jlfreib = (@lzzfreib.multiply(ZAHL360)).divide(ZAHL700, 2, BigDecimal.ROUND_DOWN)
              @jlhinzu = (@lzzhinzu.multiply(ZAHL360)).divide(ZAHL700, 2, BigDecimal.ROUND_DOWN)
            else
              @zre4j = (@re4.multiply(ZAHL360)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
              @zvbezj = (@vbez.multiply(ZAHL360)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
              @jlfreib = (@lzzfreib.multiply(ZAHL360)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
              @jlhinzu = (@lzzhinzu.multiply(ZAHL360)).divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
            end
          end
        end
      end

      def mre4
        if @zvbezj.compare_to(BigDecimal.ZERO) == 0
          @fvbz = BigDecimal.ZERO
          @fvb = BigDecimal.ZERO
          @fvbzso = BigDecimal.ZERO
          @fvbso = BigDecimal.ZERO
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
            @vbezb = (@vbezm.multiply(BigDecimal.value_of(@zmvb))).add(@vbezs)
            @hfvb = TAB2[@j].divide(ZAHL12).multiply(BigDecimal.value_of(@zmvb))
            @fvbz = TAB3[@j].divide(ZAHL12).multiply(BigDecimal.value_of(@zmvb)).set_scale(0, BigDecimal.ROUND_UP)
          else
            @vbezb = ((@vbezm.multiply(ZAHL12)).add(@vbezs)).set_scale(2, BigDecimal.ROUND_DOWN)
            @hfvb = TAB2[@j]
            @fvbz = TAB3[@j]
          end
          @fvb = ((@vbezb.multiply(TAB1[@j]))).divide(ZAHL100).set_scale(2, BigDecimal.ROUND_UP)
          if @fvb.compare_to(@hfvb) == 1
            @fvb = @hfvb
          end
          @vbezbso = @sterbe.add(@vkapa)
          @fvbso = (@fvb.add((@vbezbso.multiply(TAB1[@j])).divide(ZAHL100))).set_scale(2, BigDecimal.ROUND_UP)
          if @fvbso.compare_to(TAB2[@j]) == 1
            @fvbso = TAB2[@j]
          end
          @hfvbzso = (((@vbezb.add(@vbezbso)).divide(ZAHL100)).subtract(@fvbso)).set_scale(2, BigDecimal.ROUND_DOWN)
          if (TAB3[3]).compare_to(@hfvbzso) == 1
            @fvbzso = @hfvbzso.set_scale(0, BigDecimal.ROUND_UP)
          else
            @fvbzso = TAB3[@j]
          end
          @hfvbz = ((@vbezb.divide(ZAHL100)).subtract(@fvb)).set_scale(2, BigDecimal.ROUND_DOWN)
          if @fvbz.compare_to(@hfvbz) == 1
            @fvbz = @hfvbz.set_scale(0, BigDecimal.ROUND_UP)
          end
        end
        mre4alte
      end

      def mre4alte
        if @alter1 == 0
          @alte = BigDecimal.ZERO
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
          @bmg = @zre4j.subtract(@zvbezj)
          @alte = (@bmg.multiply(TAB4[@k])).set_scale(2, BigDecimal.ROUND_UP)
          @hbalte = TAB5[@k]
          if @alte.compare_to(@hbalte) == 1
            @alte = @hbalte
          end
        end
      end

      def mre4abz
        @zre4 = (@zre4j.subtract(@fvb).subtract(@alte).subtract(@jlfreib).add(@jlhinzu)).set_scale(2, BigDecimal.ROUND_DOWN)
        if @zre4.compare_to(BigDecimal.ZERO) == -1
          @zre4 = BigDecimal.ZERO
        end
        @zre4vp = (@zre4j.subtract(@fvb).subtract(@alte)).set_scale(2, BigDecimal.ROUND_DOWN)
        if @zre4vp.compare_to(BigDecimal.ZERO) == -1
          @zre4vp = BigDecimal.ZERO
        end
        @zvbez = (@zvbezj.subtract(@fvb)).set_scale(2, BigDecimal.ROUND_DOWN)
        if @zvbez.compare_to(BigDecimal.ZERO) == -1
          @zvbez = BigDecimal.ZERO
        end
      end

      def mztabfb
        @anp = BigDecimal.ZERO
        if @zvbez.compare_to(BigDecimal.ZERO) >= 0
          if @zvbez.compare_to(@fvbz) == -1
            @fvbz = @zvbez.set_scale(0, BigDecimal.ROUND_DOWN)
          end
        end
        if @stkl < 6
          if @zvbez.compare_to(BigDecimal.ZERO) == 1
            if (@zvbez.subtract(@fvbz)).compare_to(BigDecimal.value_of(102)) == -1
              @anp = (@zvbez.subtract(@fvbz)).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              @anp = BigDecimal.value_of(102)
            end
          end
        else
          @fvbz = BigDecimal.value_of(0)
          @fvbzso = BigDecimal.value_of(0)
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
                @kfb = BigDecimal.ZERO
              end
            end
          end
        end
        @ztabfb = (@efa.add(@anp).add(@sap).add(@fvbz)).set_scale(2, BigDecimal.ROUND_DOWN)
      end

      def mlstjahr
        if @stkl < 5
          upevp
        else
          @vsp = BigDecimal.ZERO
        end
        if @kennvmt == 0
          @zve = (@zre4.subtract(@ztabfb).subtract(@vsp)).set_scale(2, BigDecimal.ROUND_DOWN)
        else
          if @kennvmt == 1
            @zve = @zre4oso.subtract(@ztabfboso).add(@zre4vmt).subtract(@vsp).set_scale(2, BigDecimal.ROUND_DOWN)
          else
            @zve = (((@zre4.subtract(@ztabfb)).divide(ZAHL5)).subtract(@vsp)).set_scale(2, BigDecimal.ROUND_DOWN)
          end
        end
        if @zve.compare_to(ZAHL1) == -1
          @zve = BigDecimal.ZERO
          @x = BigDecimal.ZERO
        else
          @x = @zve.divide(BigDecimal.value_of(@kztab), 0, BigDecimal.ROUND_DOWN)
        end
        if @stkl < 5
          uptab07
        else
          mst5_6
        end
      end

      def upevp
        if @krv > 0
          @vsp1 = BigDecimal.ZERO
        else
          if @zre4vp.compare_to(BigDecimal.value_of(63600)) == 1
            @zre4vp = BigDecimal.value_of(63600)
          end
          @vsp1 = (@zre4vp.multiply(BigDecimal.value_of(0.32))).set_scale(2, BigDecimal.ROUND_DOWN)
          @vsp1 = (@vsp1.multiply(BigDecimal.value_of(0.0995))).set_scale(2, BigDecimal.ROUND_DOWN)
        end
        @vsp2 = (@zre4vp.multiply(BigDecimal.value_of(0.11))).set_scale(2, BigDecimal.ROUND_DOWN)
        @vhb = (BigDecimal.value_of(@kztab).multiply(BigDecimal.value_of(1500))).set_scale(2, BigDecimal.ROUND_DOWN)
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
        @vspo = (@zre4vp.multiply(BigDecimal.value_of(0.2))).set_scale(2, BigDecimal.ROUND_DOWN)
        @vspvor = (BigDecimal.value_of(@kztab).multiply(BigDecimal.value_of(3068))).set_scale(2, BigDecimal.ROUND_DOWN)
        @vspmax1 = BigDecimal.value_of(@kztab).multiply(BigDecimal.value_of(1334))
        @vspmax2 = BigDecimal.value_of(@kztab).multiply(BigDecimal.value_of(667))
        @vspkurz = BigDecimal.value_of(@kztab).multiply(BigDecimal.value_of(1134))
        if @krv == 1
          if @vspo.compare_to(@vspkurz) == 1
            @vsp = @vspkurz
          else
            @vsp = @vspo.set_scale(0, BigDecimal.ROUND_DOWN)
          end
        else
          umvsp
        end
      end

      def umvsp
        @vspvor = (@vspvor.subtract(@zre4vp.multiply(BigDecimal.value_of(0.16)))).set_scale(2, BigDecimal.ROUND_DOWN)
        if @vspvor.compare_to(BigDecimal.ZERO) == -1
          @vspvor = BigDecimal.ZERO
        end
        if @vspo.compare_to(@vspvor) == 1
          @vsp = @vspvor
          @vsprest = @vspo.subtract(@vspvor)
          if @vsprest.compare_to(@vspmax1) == 1
            @vsp = @vsp.add(@vspmax1)
            @vsprest = (@vsprest.subtract(@vspmax1)).divide(ZAHL2, 2, BigDecimal.ROUND_UP)
            if @vsprest.compare_to(@vspmax2) == 1
              @vsp = (@vsp.add(@vspmax2)).set_scale(0, BigDecimal.ROUND_DOWN)
            else
              @vsp = (@vsp.add(@vsprest)).set_scale(0, BigDecimal.ROUND_DOWN)
            end
          else
            @vsp = (@vsp.add(@vsprest)).set_scale(0, BigDecimal.ROUND_DOWN)
          end
        else
          @vsp = @vspo.set_scale(0, BigDecimal.ROUND_DOWN)
        end
      end

      def mst5_6
        @zzx = @x
        if @zzx.compare_to(BigDecimal.value_of(25812)) == 1
          @zx = BigDecimal.value_of(25812)
          up5_6
          if @zzx.compare_to(BigDecimal.value_of(200000)) == 1
            @st = (@st.add(BigDecimal.value_of(73158.96))).set_scale(0, BigDecimal.ROUND_DOWN)
            @st = (@st.add((@zzx.subtract(BigDecimal.value_of(200000))).multiply(BigDecimal.value_of(0.45)))).set_scale(0, BigDecimal.ROUND_DOWN)
          else
            @st = (@st.add((@zzx.subtract(BigDecimal.value_of(25812))).multiply(BigDecimal.value_of(0.42)))).set_scale(0, BigDecimal.ROUND_DOWN)
          end
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
        @x = (@zx.multiply(BigDecimal.value_of(1.25))).set_scale(2, BigDecimal.ROUND_DOWN)
        uptab07
        @st1 = @st
        @x = (@zx.multiply(BigDecimal.value_of(0.75))).set_scale(2, BigDecimal.ROUND_DOWN)
        uptab07
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
          @solzj = (@jbmg.multiply(BigDecimal.value_of(5.5))).divide(ZAHL100).set_scale(2, BigDecimal.ROUND_DOWN)
          @solzmin = (@jbmg.subtract(@solzfrei)).multiply(BigDecimal.value_of(20)).divide(ZAHL100).set_scale(2, BigDecimal.ROUND_DOWN)
          if @solzmin.compare_to(@solzj) == -1
            @solzj = @solzmin
          end
          @jw = @solzj.multiply(ZAHL100).set_scale(0, BigDecimal.ROUND_DOWN)
          upanteil
          @solzlzz = @anteil1
        else
          @solzlzz = BigDecimal.ZERO
        end
        if @r > 0
          @jw = @jbmg.multiply(ZAHL100)
          upanteil
          @bk = @anteil1
        else
          @bk = BigDecimal.ZERO
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
        @lzz = 1
        if @zmvb == 0
          @zmvb = 12
        end
        if @sonstb.compare_to(BigDecimal.ZERO) == 0
          @lstso = BigDecimal.ZERO
          @sts = BigDecimal.ZERO
          @solzs = BigDecimal.ZERO
          @bks = BigDecimal.ZERO
        else
          mosonst
          @zre4j = ((@jre4.add(@sonstb)).divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
          @zvbezj = ((@jvbez.add(@vbs)).divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
          mre4sonst
          mlstjahr
          @lstso = @st.multiply(ZAHL100)
          @sts = @lstso.subtract(@lstoso)
          if @sts.compare_to(BigDecimal.ZERO) == -1
            @sts = BigDecimal.ZERO
          end
          @solzs = @sts.multiply(BigDecimal.value_of(5.5)).divide(ZAHL100, 0, BigDecimal.ROUND_DOWN)
          if @r > 0
            @bks = @sts
          else
            @bks = BigDecimal.ZERO
          end
        end
      end

      def mvmt
        if @vkapa.compare_to(BigDecimal.ZERO) == -1
          @vkapa = BigDecimal.ZERO
        end
        if (@vmt.add(@vkapa)).compare_to(BigDecimal.ZERO) == 1
          if @lstso.compare_to(BigDecimal.ZERO) == 0
            mosonst
            @lst1 = @lstoso
          else
            @lst1 = @lstso
          end
          @zre4oso = @zre4
          @ztabfboso = @ztabfb
          @fvbzoso = @fvbz
          @zre4j = ((@jre4.add(@sonstb).add(@vmt).add(@vkapa)).divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
          @zvbezj = ((@jvbez.add(@vbs).add(@vkapa)).divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
          mre4sonst
          mlstjahr
          @lst3 = @st.multiply(ZAHL100)
          @ztabfb = (@ztabfb.subtract(@fvbz).add(@fvbzoso)).set_scale(2, BigDecimal.ROUND_DOWN)
          @kennvmt = 1
          if (@jre4.add(@sonstb).subtract(@jfreib).add(@jhinzu)).compare_to(BigDecimal.ZERO) == -1
            @kennvmt = 2
            mlstjahr
            @lst2 = @st.multiply(ZAHL100)
            @stv = @lst2.multiply(ZAHL5)
          else
            @zre4vmt = (((@vmt.divide(ZAHL100)).add(@vkapa.divide(ZAHL100)).subtract(@ztabfb).add(@ztabfboso)).divide(ZAHL5)).set_scale(2, BigDecimal.ROUND_DOWN)
            mlstjahr
            @lst2 = @st.multiply(ZAHL100)
            @stv = (@lst2.subtract(@lst1)).multiply(ZAHL5)
          end
          @lst3 = @lst3.subtract(@lst1)
          if @lst3.compare_to(@stv) == -1
            @stv = @lst3
          end
          if @stv.compare_to(BigDecimal.ZERO) == -1
            @stv = BigDecimal.ZERO
          end
          @solzv = (@stv.multiply(BigDecimal.value_of(5.5))).divide(ZAHL100, 0, BigDecimal.ROUND_DOWN)
          if @r > 0
            @bkv = @stv
          else
            @bkv = BigDecimal.ZERO
          end
        else
          @stv = BigDecimal.ZERO
          @solzv = BigDecimal.ZERO
          @bkv = BigDecimal.ZERO
        end
      end

      def mosonst
        @zre4j = (@jre4.divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
        @zvbezj = (@jvbez.divide(ZAHL100)).set_scale(2, BigDecimal.ROUND_DOWN)
        @jlfreib = @jfreib.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
        @jlhinzu = @jhinzu.divide(ZAHL100, 2, BigDecimal.ROUND_DOWN)
        mre4
        mre4abz
        mztabfb
        mlstjahr
        @lstoso = @st.multiply(ZAHL100)
      end

      def mre4sonst
        mre4
        @fvb = @fvbso
        mre4abz
        @fvbz = @fvbzso
        mztabfb
      end

      def uptab07
        if @x.compare_to(BigDecimal.value_of(7665)) == -1
          @st = BigDecimal.ZERO
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
              if @x.compare_to(BigDecimal.value_of(250001)) == -1
                @st = ((@x.multiply(BigDecimal.value_of(0.42))).subtract(BigDecimal.value_of(7914))).set_scale(0, BigDecimal.ROUND_DOWN)
              else
                @st = ((@x.multiply(BigDecimal.value_of(0.45))).subtract(BigDecimal.value_of(15414))).set_scale(0, BigDecimal.ROUND_DOWN)
              end
            end
          end
        end
        @st = @st.multiply(BigDecimal.value_of(@kztab))
      end

    end
  end
end
