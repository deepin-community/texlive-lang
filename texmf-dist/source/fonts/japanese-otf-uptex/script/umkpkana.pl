#!/usr/bin/perl -s

=head1 NOTE

This software is a part of otfbeta-uptex (a.k.a. japanese-otf-uptex).

=cut

use Encode;
use FindBin;
use lib "$FindBin::Bin";
use CheckDVICode;

if ($sp==1) { # supplemental plane
    use MakeSPList;
    &make_sp_char_list('j');
    %exist_char=%{$MakeSPList::r_exist_char->{'j'}};
}

$_=<DATA>;
while(<DATA>) {
	chomp($_);
	my (@data)=split(' ', $_);
	my ($char);
	last if (@data<6);
	$char = shift @data;
	push @character, $char;
	$cid    {$char}=shift @data;
	$min_w3 {$char}=shift @data;
	$min_w6 {$char}=shift @data;
	$goth_w3{$char}=shift @data;
	$goth_w6{$char}=shift @data;
	$maru_w4{$char}=shift @data;
}

@charwidth=({%min_w3}, {%min_w6}, {%goth_w3}, {%goth_w6}, {%maru_w4});
@font_name=("phiraminw3-h", "phiraminw6-h", "phirakakuw3-h", "phirakakuw6-h", "phiramaruw4-h");
@kanji_font_name=("hminr-h", "hminb-h", "hgothr-h", "hgothb-h", "hmgothr-h");
@kana_font_name=("hiramin-w3-h", "hiramin-w6-h", "hirakaku-w3-h", "hirakaku-w6-h", "hiramaru-w4-h");
$font_at=1.0;
$half_width= ($font_at / 2);
$quater_width= ($font_at / 4);
opendir(OVP, "ovp") || mkdir("ovp",0755) || die "cannot mkdir ovp";
opendir(VF, "vf") || mkdir("vf",0755) || die "cannot mkdir vf";
opendir(JPL, "pl") || mkdir("pl",0755) || die "cannot mkdir pl";
opendir(JFM, "tfm") || mkdir("tfm",0755) || die "cannot mkdir tfm";
closedir(OVP);
closedir(VF);
closedir(JPL);
closedir(JFM);

$n_fixed=7; ## type 0..6
$ucs=1; # 1: upphiraXXX or 0: phiraXXX
if ($ucs) {
	$CheckDVICode::is_ucs=1;
	foreach(@font_name, @kanji_font_name) {
		$_="up$_";
	}
	if ($hk) { ## command line option -hk: Enable halfwidth katakana
		$hk_mode=1;
		$n_fixed=8; ## type 0..7
	}
}

#main
for ($i=0; $i<=4; $i++){
	open (JPL, ">pl/$font_name[$i].pl");
	&tfm_head_h;
	&chars_in_type_jis;
	&chars_in_type_prop;
	&print_type_jis;
	&print_type_prop;
	&glue_kern;
	close(JPL);
}
for ($i=0; $i<=4; $i++){
	@cpm_h=(0x29E, 0x29F, 0x2A0, 0x2A1);
	open (OVP, ">ovp/$font_name[$i].ovp");
	&fonthead;
	&write_char;
	close(OVP);
}
#
#sub rtn
#
sub tfm_head_h {
	print  JPL "(FAMILY PROP KANA)\n";
	print  JPL "(FACE F MRR)\n";
	print  JPL "(CODINGSCHEME TEX KANJI TEXT)\n";
	print  JPL "(DESIGNSIZE R 10.0)\n";
	print  JPL "(CHECKSUM O 0)\n";
	print  JPL "(SEVENBITSAFEFLAG TRUE)\n";
	print  JPL "(FONTDIMEN\n";
	print  JPL "   (SLANT R 0.0)\n";
	print  JPL "   (SPACE R 0.0)\n";
	printf JPL "   (STRETCH R %f)\n", $font_at/10;
	print  JPL "   (SHRINK R 0.0)\n";
	printf JPL "   (XHEIGHT R %f)\n", $font_at;
	printf JPL "   (QUAD R %f)\n", $font_at;
	printf JPL "   (EXTRASPACE R %f)\n", $font_at/4;
	printf JPL "   (EXTRASTRETCH R %f)\n", $font_at/5;
	printf JPL "   (EXTRASHRINK R %f)\n", $font_at/8;
	print  JPL "   )\n";
}
sub char_foot_h {
	printf JPL "   (CHARHT R %f)\n", $font_at*0.88;
	printf JPL "   (CHARDP R %f)\n", $font_at*0.12;
	print  JPL "   )\n";
}
sub glue_kern{
	print  JPL "(GLUEKERN\n";
	print  JPL "   (LABEL O 5)\n";
	print  JPL "   (KRN O 5 R 0.0)\n";
	print  JPL "   (LABEL O 0)\n";
	for ($char=0; $char<=$#uniq_char_width_array; $char++){
		printf JPL "   (LABEL H %X)\n",($char+$n_fixed);
	}
	printf JPL "   (GLUE O 1 R %f R 0.0 R %f)\n", $half_width, $half_width;
	print  JPL "   (LABEL O 1)\n";
	printf JPL "   (GLUE O 3 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	print  JPL "   (STOP)\n";
	print  JPL "   (LABEL O 2)\n";
	printf JPL "   (GLUE O 5 R %f R 0.0 R %f)\n", $half_width, $half_width;
	printf JPL "   (GLUE O 6 R %f R 0.0 R %f)\n", $half_width, $half_width;
	printf JPL "   (GLUE O 7 R %f R 0.0 R %f)\n", $half_width, $half_width if $hk_mode;
	print  JPL "   (STOP)\n";
	if ($hk_mode) {
		print  JPL "   (LABEL O 7)\n";
		printf JPL "   (GLUE O 1 R %f R 0.0 R %f)\n", $half_width, $half_width;
		printf JPL "   (GLUE O 3 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
		print  JPL "   (STOP)\n";
	}
	print  JPL "   (LABEL O 6)\n";
	printf JPL "   (GLUE O 0 R %f R 0.0 R %f)\n", $half_width, $half_width;
	printf JPL "   (GLUE O 1 R %f R 0.0 R %f)\n", $half_width, $half_width;
	printf JPL "   (GLUE O 3 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	for ($char=0; $char<=$#uniq_char_width_array; $char++){
		printf JPL "   (GLUE H %X R %f R 0.0 R %f)\n",($char+$n_fixed), $half_width, $half_width;
	}
	print  JPL "   (STOP)\n";
	print  JPL "   (LABEL O 4)\n";
	printf JPL "   (GLUE O 0 R %f R 0.0 R 0.0)\n", $half_width;
	printf JPL "   (GLUE O 1 R %f R 0.0 R 0.0)\n", $half_width;
	printf JPL "   (GLUE O 3 R %f R 0.0 R %f)\n", $half_width+$quater_width, $quater_width;
	printf JPL "   (GLUE O 5 R %f R 0.0 R 0.0)\n", $half_width;
	printf JPL "   (GLUE O 6 R %f R 0.0 R 0.0)\n", $half_width;
	printf JPL "   (GLUE O 7 R %f R 0.0 R %f)\n", $half_width, $half_width if $hk_mode;
	for ($char=0; $char<=$#uniq_char_width_array; $char++){
		printf JPL "   (GLUE H %X R %f R 0.0 R 0.0)\n",($char+$n_fixed), $half_width;
	}
	print  JPL "   (STOP)\n";
	print  JPL "   (LABEL O 3)\n";
	printf JPL "   (GLUE O 0 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 1 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 2 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 3 R %f R 0.0 R %f)\n", $half_width, $quater_width;
	printf JPL "   (GLUE O 4 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 5 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 6 R %f R 0.0 R %f)\n", $quater_width, $quater_width;
	printf JPL "   (GLUE O 7 R %f R 0.0 R %f)\n", $half_width, $half_width if $hk_mode;
	for ($char=0; $char<=$#uniq_char_width_array; $char++){
		printf JPL "   (GLUE H %X R %f R 0.0 R %f)\n",($char+$n_fixed), $quater_width, $quater_width;
	}
	print  JPL "   (STOP)\n";
	print  JPL "   )\n";
}
sub chars_in_type_jis{
	my ($type1add, $type2add, $type3add, $type5, $type6add)=();
	if ($ucs) {
		$type1add = "UFF5F U3018 U3016 U301D U00AB U2329 U301A";
		$type2add = "UFF60 U3019 U3017 U301F U00BB U232A U301B U301E";
		$type3add = "U00B7";
		$type5 = "??? ??? ??? ???";
		$type6add = "U203C U2047 U2048 U2049";
	} else {
		$type5 = "??? ??? ???";
	}
print JPL <<END_OF_DATA;
(CHARSINTYPE O 1
   ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? 
   $type1add 
   )
(CHARSINTYPE O 2
   ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? 
   $type2add 
   )
(CHARSINTYPE O 3
   ??? ??? ??? 
   $type3add 
   )
(CHARSINTYPE O 4
   ??? ??? 
   )
(CHARSINTYPE O 5
   $type5 
   )
(CHARSINTYPE O 6
   ??? ??? 
   $type6add 
   )
END_OF_DATA
print JPL <<END_OF_DATA if ($hk_mode) ; ## Halfwidth Katakana
(CHARSINTYPE O 7
   UFF61 UFF62 UFF63 UFF64 UFF65 UFF66 UFF67
   UFF68 UFF69 UFF6A UFF6B UFF6C UFF6D UFF6E UFF6F
   UFF70 UFF71 UFF72 UFF73 UFF74 UFF75 UFF76 UFF77
   UFF78 UFF79 UFF7A UFF7B UFF7C UFF7D UFF7E UFF7F
   UFF80 UFF81 UFF82 UFF83 UFF84 UFF85 UFF86 UFF87
   UFF88 UFF89 UFF8A UFF8B UFF8C UFF8D UFF8E UFF8F
   UFF90 UFF91 UFF92 UFF93 UFF94 UFF95 UFF96 UFF97
   UFF98 UFF99 UFF9A UFF9B UFF9C UFF9D UFF9E UFF9F
   )
END_OF_DATA
}
sub print_type_jis{
	@type_width=($font_at, $half_width, $half_width, $half_width, $half_width, $font_at, $font_at);
	if ($hk_mode) { push @type_width, $half_width; }
	for ($k=0; $k<$n_fixed; $k++){
		printf  JPL "(TYPE H %x\n", $k;
		printf  JPL "   (CHARWD R %f)\n", $type_width[$k];
		&char_foot_h;
	}
}
sub fonthead {
	print  OVP "(VTITLE Prop Kana)\n";
	print  OVP "(OFMLEVEL D 0)\n";
	print  OVP "(DESIGNSIZE R 10.000000)\n";
	print  OVP "(CHECKSUM O 0)\n";
	print  OVP "(MAPFONT D 1\n";
	print  OVP "   (FONTNAME $kanji_font_name[$i])\n";
	print  OVP "   (FONTCHECKSUM O 0)\n";
	printf OVP "   (FONTAT R %f)\n", $font_at;
	print  OVP "   (FONTDSIZE R 10.000000)\n";
	print  OVP "   )\n";
	print  OVP "(MAPFONT D 2\n";
	print  OVP "   (FONTNAME $kana_font_name[$i])\n";
	print  OVP "   (FONTCHECKSUM O 0)\n";
	printf OVP "   (FONTAT R %f)\n", $font_at;
	print  OVP "   (FONTDSIZE R 10.000000)\n";
	print  OVP "   )\n";
}
sub write_char {
    if (!$ucs) {
	for ($ku=1; $ku<=94; $ku++){
		for ($ten=1; $ten<=94; $ten++){
			$dvicode=($ku+32)*256+($ten+32);
			if ($ku==1){&print_kigo_char;}elsif($ku==4){&print_kana_char;}
			elsif($ku==5){&print_kana_char;}else{&print_char;}
		}
	}
    } else { # ucs
	$max_ucs= $sp ? 0x2FA1F : 0xFFFF;  # U+2FA1F: max of CJK Compatibility Ideographs Supplement
	for ($ucscode=0; $ucscode<=$max_ucs; $ucscode++){
		$CheckDVICode::dvicode=$dvicode=$ucscode;
		next unless (&is_ucs_jpn_range);
		if ($sp==1 && $ucscode>0xFFFF) {
			next unless ($exist_char{sprintf("%X",$ucscode)});
		}
		if   (&is_ucs_kigo){&print_kigo_char;}
		elsif(&is_ucs_hira || &is_dvicode('hira-yori')){&print_kana_char;}
		elsif(&is_ucs_kata || &is_dvicode('kata-koto')){&print_kana_char;}
		elsif(&is_ucs_hankana && $hk_mode){&print_hankana_char;}
		else{&print_char;}
	}
    }
}
sub print_char{
	return if ($omitfw);
	printf OVP "(CHARACTER H %X\n", $dvicode;
	printf OVP "   (CHARWD R %f)\n", $font_at;
	print  OVP "   (MAP\n";
	printf OVP "      (SETCHAR H %X)\n",$dvicode;
	print  OVP "      )\n";
	print  OVP "   )\n";
}
sub print_kigo_char{
	my ($width,$cid);
	printf OVP "(CHARACTER H %X\n", $dvicode;
	if (&is_dvicode('quote') || &is_dvicode('kakko')){#Kakko
		$width=$half_width;
	} elsif (&is_dvicode('kutouten')){#Kutouten
		$width=$half_width;
	} elsif (&is_dvicode('odoriji')){#odoriji
		($width,$cid)=&get_charwidth($i,$dvicode);
		$width/=10;
	} else{
		$width=$font_at;
	}
	printf OVP "   (CHARWD R %f)\n", $width;
	print  OVP "   (MAP\n";
	if (&is_dvicode('odoriji')){#odoriji
		print  OVP "      (SELECTFONT D 2)\n";
	} elsif ($ucs && &is_dvicode('quote')){#Quote
		print  OVP "      (SELECTFONT D 2)\n";
	}
	if (&is_dvicode('nakaten') || &is_dvicode('colon') || &is_dvicode('semicolon')){#colon, semicolon, nakaten
		printf OVP "      (MOVERIGHT R -%f)\n",$quater_width;}
	if ((&is_dvicode('quote') || &is_dvicode('kakko')) && &is_dvicode('open')){#Kakko
		printf OVP "      (MOVERIGHT R -%f)\n",$half_width;
	}
	if (&is_dvicode('odoriji')){#odoriji
		printf OVP "      (SETCHAR H %X)\n",$cid;
	} elsif ($ucs && &is_dvicode('quote')){#Quote
		$cpmcode= shift(@cpm_h);
		printf OVP "      (SETCHAR H %X)\n",$cpmcode;
	} else {
		printf OVP "      (SETCHAR H %X)\n",$dvicode;
	}
	print  OVP "      )\n";
	print  OVP "   )\n";
}
sub print_kana_char{
	my ($width,$cid)=&get_charwidth($i,$dvicode);
	if ($width==0) {
		return &print_char;
	}
	$width/=10;
	printf OVP "(CHARACTER H %X\n", $dvicode;
	printf OVP "   (CHARWD R %f)\n", $width;
	print  OVP "   (MAP\n";
	print  OVP "      (SELECTFONT D 2)\n";
	printf OVP "      (SETCHAR H %X)\n",$cid;
	print  OVP "      )\n";
	print  OVP "   )\n";
}
sub print_hankana_char{
	printf OVP "(CHARACTER H %X\n", $dvicode;
	printf OVP "   (CHARWD R %f)\n", $half_width;
	print  OVP "   (MAP\n";
	printf OVP "      (SETCHAR H %X)\n",$dvicode;
	print  OVP "      )\n";
	print  OVP "   )\n";
}
sub chars_in_type_prop{
	%char_width_hash=();
	for ($j=0; $j<@character; $j++){
		my ($c0, $c1);
		$c0=$c1=$character[$j];
		if (!$ucs) {
			if (!Encode::from_to($c1,'utf-8','euc-jp', Encode::FB_QUIET)
			    || $c0 eq "???"
			    || $c0 eq "???") { next; }
		}
		$char_width_hash{$c0}=$charwidth[$i]{$c0}/10;
	}
	$x = '-';
	@uniq_char_width_array = grep( $_ ne $x && ($x = $_), sort values(%char_width_hash));
	for ($j=0; $j<=$#uniq_char_width_array; $j++){
		printf JPL "(CHARSINTYPE H %X\n",($j+$n_fixed);
		print  JPL "   ";
		@char_in_this_type = ();
		while (($name, $value) = each(%char_width_hash)) {
			if ($value == $uniq_char_width_array[$j]){
				push(@char_in_this_type, $name);
			}
		}
		@char_in_this_type = sort @char_in_this_type;
		foreach $char_in_this(@char_in_this_type){
			print  JPL "$char_in_this ";#character
		}
		print  JPL "\n";
		print  JPL "   )\n";
	}
}
sub print_type_prop{
	for ($j=0; $j<=$#uniq_char_width_array; $j++){
		$char_width=$uniq_char_width_array[$j];
		printf JPL "(TYPE H %X\n", ($j+$n_fixed);
		printf JPL "   (CHARWD R %f)\n", $char_width;
		&char_foot_h;
	}
}

sub get_charwidth{
	my ($i,$dvicode)=@_;
	my ($char,$u,$l);

	if (!$ucs) {
		if ($dvicode>=0x2474 && $dvicode<=0x2476) {
			return 0;
		}
		$u = ($dvicode >> 8) & 0xFF | 0x80;
		$l =  $dvicode       & 0xFF | 0x80;
		$char = pack("C*",$u,$l);
		Encode::from_to($char,'euc-jp','utf-8');
	} else {
		$u = ($dvicode >> 8) & 0xFF;
		$l =  $dvicode       & 0xFF;
		$char = pack("C*",$u,$l);
		Encode::from_to($char,'utf-16be','utf-8');
	}
	if (!exists($charwidth[$i]{$char})) {
		return 0;
	}
	return ($charwidth[$i]{$char}, $cid{$char});
}


__DATA__
character  cid  min_w3  min_w6  goth_w3  goth_w6  maru_w4
???  15449  7.11  7.54  7.19  7.49  7.45
???  15450  7.68  7.95  7.69  8  8.15
???  15451  7.17  7.43  7.23  7.53  7.63
???  15452  7.79  7.97  7.72  8.09  8.08
???  15455  9.9  10  10  10  10
???  15517  8.21  8.44  8.56  8.77  8.72
???  15518  8.83  9.17  9.18  9.41  9.32
???  15519  8.56  8.72  8.67  8.95  8.97
???  15520  9.14  9.46  9.3  9.52  9.58
???  15521  7.3  7.65  8.08  8.27  8.32
???  15522  7.68  8.04  8.51  8.74  8.78
???  15523  7.97  8.2  8.34  8.56  8.61
???  15524  8.69  8.95  9.14  9.33  9.36
???  15525  8.59  8.9  8.77  9.02  8.97
???  15526  9.15  9.52  9.37  9.62  9.54
???  15527  9.53  9.81  9.49  9.72  9.58
???  15528  9.69  9.93  9.68  9.82  9.79
???  15529  8.34  8.64  8.87  9.09  9.15
???  15530  9.09  9.42  9.49  9.49  9.66
???  15531  6.76  7.04  7.64  7.92  8.04
???  15532  8.31  8.52  8.34  8.5  8.72
???  15533  9.07  9.35  9.16  9.37  9.39
???  15534  9.56  9.75  9.66  9.82  9.78
???  15535  8.05  8.3  8.37  8.65  8.88
???  15536  8.91  9.08  8.9  9  9.27
???  15537  8.26  8.61  8.71  9.02  9.03
???  15538  9.19  9.53  8.97  9.3  9.34
???  15539  8.07  8.51  8.58  8.84  8.91
???  15540  8.17  8.62  8.65  8.94  9
???  15541  9.16  9.44  9.17  9.33  9.41
???  15542  9.52  9.63  9.53  9.66  9.72
???  15543  9.52  9.76  9.44  9.65  9.61
???  15544  9.79  9.92  9.73  9.86  9.87
???  15545  8.59  8.93  9.27  9.48  9.43
???  15546  9.25  9.49  9.4  9.64  9.69
???  15547  8.94  9.25  9.22  9.45  9.37
???  15548  9.23  9.44  9.28  9.51  9.57
???  15549  8.5  8.77  8.83  9.05  9.11
???  15550  8.98  9.25  8.92  9.16  9.28
???  15551  8.81  8.97  8.66  8.84  8.83
???  15552  9.39  9.71  9.26  9.41  9.44
???  15553  9.65  9.8  9.54  9.68  9.71
???  15554  8.91  9.11  8.93  9.12  9.25
???  15555  9.3  9.5  9.26  9.42  9.5
???  15556  7.62  7.89  8.3  8.62  8.66
???  15557  8.45  8.72  8.56  8.78  8.88
???  15558  9.08  9.42  9.45  9.66  9.55
???  15559  8.94  9.18  9.16  9.42  9.38
???  15560  9.41  9.67  9.51  9.72  9.62
???  15561  9.51  9.73  9.67  9.82  9.83
???  15562  9.29  9.57  9.35  9.69  9.58
???  15563  9.13  9.45  9.44  9.69  9.56
???  15564  9.69  9.79  9.73  9.85  9.8
???  15565  9.58  9.77  9.66  9.8  9.75
???  15566  8.98  9.33  9.26  9.52  9.52
???  15567  9.27  9.49  9.48  9.71  9.62
???  15568  9.33  9.53  9.39  9.63  9.63
???  15569  9.19  9.44  9.4  9.62  9.52
???  15570  9.33  9.59  9.61  9.78  9.74
???  15571  9.36  9.59  9.51  9.73  9.74
???  15572  9.71  9.97  9.69  9.76  9.73
???  15573  9.54  9.84  9.64  9.76  9.72
???  15574  9.51  9.82  9.5  9.73  9.69
???  15575  9.14  9.49  9.48  9.73  9.62
???  15576  9.73  9.9  9.79  9.88  9.93
???  15577  9.77  9.92  9.72  9.9  9.88
???  15578  8.32  8.62  8.98  9.24  9.28
???  15579  9.07  9.38  9.38  9.62  9.57
???  15580  9.22  9.57  9.33  9.52  9.48
???  15581  9.03  9.36  9.27  9.54  9.48
???  15582  8.08  8.34  8.82  9.1  9.15
???  15583  8.68  8.93  8.72  8.9  8.9
???  15584  9.38  9.62  9.25  9.49  9.46
???  15585  8.74  8.95  8.78  8.98  9
???  15586  9.33  9.64  9.41  9.63  9.62
???  15587  7.64  7.85  8.09  8.36  8.45
???  15588  8.1  8.41  8.63  8.95  9.04
???  15589  8.14  8.39  8.59  8.81  8.94
???  15590  7.69  8.09  8.33  8.59  8.71
???  15591  8.2  8.55  8.86  9.11  9.12
???  15592  9.76  9.96  9.62  9.82  9.81
???  15593  8.38  8.63  8.7  8.94  9.09
???  15594  8.58  8.83  8.82  9.07  9.02
???  15595  9.24  9.58  9.46  9.71  9.66
???  15596  8.77  9.12  9.02  9.29  9.35
???  15597  9.14  9.32  9.34  9.53  9.5
???  15598  8.78  9.14  9.05  9.33  9.45
???  15599  9.13  9.39  9.2  9.47  9.39
???  15608  8.01  8.28  8.37  8.61  8.5
???  15609  8.69  9.01  9  9.24  9.17
???  15610  7.6  7.78  8.26  8.44  8.33
???  15611  8.2  8.43  8.91  9.13  8.96
???  15612  7.89  8.24  8.4  8.61  8.72
???  15613  8.4  8.67  8.81  9.06  9.18
???  15614  8.44  8.63  8.63  8.83  8.73
???  15615  9.23  9.5  9.36  9.52  9.36
???  15616  8.34  8.57  8.66  8.88  8.69
???  15617  8.94  9.26  9.18  9.39  9.32
???  15618  8.64  8.9  9.04  9.33  9.23
???  15619  9.39  9.53  9.37  9.53  9.55
???  15620  8.76  9.19  9.27  9.45  9.34
???  15621  9.05  9.4  9.31  9.54  9.55
???  15622  8.25  8.6  8.68  8.96  8.9
???  15623  9.06  9.37  9.55  9.57  9.67
???  15624  8.84  9.05  9.28  9.43  9.41
???  15625  9.28  9.42  9.52  9.66  9.69
???  15626  8.49  8.83  8.88  9.15  9.16
???  15627  9.1  9.3  9.4  9.59  9.55
???  15628  9.16  9.44  9.26  9.42  9.46
???  15629  9.46  9.68  9.62  9.72  9.8
???  15630  9.02  9.22  8.94  9.22  9.32
???  15631  8.99  9.22  9.42  9.5  9.74
???  15632  8.68  8.96  9.06  9.32  9.25
???  15633  9.24  9.48  9.5  9.73  9.67
???  15634  9.02  9.4  9.17  9.36  9.33
???  15635  9.44  9.71  9.54  9.63  9.63
???  15636  8.23  8.49  8.47  8.76  8.8
???  15637  9.13  9.3  9.04  9.19  9.44
???  15638  8.41  8.78  8.75  9  8.95
???  15639  9.32  9.56  9.67  9.65  9.73
???  15640  8.91  9.27  9.25  9.48  9.36
???  15641  9.36  9.64  9.55  9.63  9.61
???  15642  7.86  8.12  8.15  8.4  8.48
???  15643  8.44  8.73  8.86  9.13  9.04
???  15644  9.24  9.43  9.41  9.53  9.57
???  15645  8.85  9.2  9.22  9.38  9.33
???  15646  9.37  9.58  9.64  9.67  9.74
???  15647  7.25  7.6  8.02  8.3  8.57
???  15648  7.95  8.16  8.26  8.48  8.7
???  15649  8.84  9.22  9.13  9.32  9.26
???  15650  9.21  9.52  9.23  9.42  9.22
???  15651  8.11  8.42  8.46  8.7  8.79
???  15652  9  9.27  9.23  9.46  9.4
???  15653  7.81  8.17  8.4  8.7  8.66
???  15654  9.46  9.77  9.45  9.66  9.41
???  15655  9.58  9.76  9.63  9.78  9.56
???  15656  9.45  9.71  9.53  9.75  9.55
???  15657  8.14  8.42  8.6  8.88  8.84
???  15658  8.76  9  9.23  9.41  9.46
???  15659  8.66  8.9  9.15  9.33  9.4
???  15660  8.12  8.46  8.57  8.81  8.91
???  15661  9.05  9.3  9.27  9.42  9.73
???  15662  9.05  9.27  9.11  9.31  9.73
???  15663  9.68  9.95  9.62  9.77  9.66
???  15664  9.44  9.77  9.56  9.73  9.62
???  15665  9.42  9.77  9.56  9.71  9.59
???  15666  8.85  9.19  9.46  9.67  9.52
???  15667  9.14  9.39  9.51  9.71  9.69
???  15668  8.81  9.24  9.5  9.72  9.71
???  15669  8.86  9.17  8.99  9.19  9.17
???  15670  7.57  7.9  8.39  8.64  8.87
???  15671  8.56  8.87  9.2  9.4  9.39
???  15672  8.2  8.55  8.64  8.92  8.81
???  15673  9.09  9.41  9.42  9.61  9.49
???  15674  8.39  8.69  8.49  8.73  8.73
???  15675  8.95  9.24  9.16  9.39  9.31
???  15676  8.38  8.61  8.43  8.65  8.61
???  15677  9.18  9.57  9.22  9.37  9.35
???  15678  7.94  8.23  8.44  8.72  8.74
???  15679  8.37  8.74  8.91  9.19  9.22
???  15680  8.08  8.41  8.71  8.97  8.95
???  15681  7.6  7.91  8.16  8.43  8.63
???  15682  9.27  9.69  9.46  9.64  9.49
???  15683  8.46  8.8  8.61  8.9  9.01
???  15684  8.51  8.95  9.26  9.51  9.54
???  15685  7.77  8.09  8.32  8.51  8.71
???  15686  8.34  8.67  8.71  8.97  9.02
???  15687  9.19  9.5  9.47  9.64  9.57
???  15688  9.19  9.51  9.32  9.52  9.35
???  15689  8.01  8.39  8.49  8.76  8.93
???  15690  8.71  9.03  8.85  9.12  9.04
???  15691  9.06  9.34  9.33  9.51  9.66
???  15692  8.11  8.33  8.51  8.8  8.74
???  15693  8.18  8.39  8.63  8.74  8.73
???  15453  7.69  8.15  8.29  8.62  8.36
???  15454  8.69  9.03  9.09  9.33  9.15
???  15462  8.09  8.42  8.6  8.83  8.87
???  15463  8.03  8.27  8.82  9.19  8.93
???  15600  8.73  9.06  9.27  9.47  9.44
???  15601  8.75  9.02  8.82  9.06  8.95
???  15602  8.36  8.64  8.55  8.78  8.73
???  15702  7.68  8.03  8.02  8.34  8.43
???  15703  8.39  8.58  8.43  8.67  8.66
???  15704  8  8.19  8.3  8.59  8.55
???  15705  7.02  7.29  7.66  7.9  8.16
???  15706  7.65  7.89  8.04  8.35  8.38
???  15707  8.6  8.79  8.61  8.84  8.63
???  15708  7.83  8.02  8.15  8.43  8.41
???  15709  7.61  7.94  8.09  8.3  8.39
???  15710  8.81  9.1  8.78  8.94  8.83
???  15711  8.27  8.53  8.86  9.09  8.97
???  15713  7.92  8.13  8.39  8.61  8.62
???  15714  7.8  8.09  8.32  8.54  8.55
???  15715  7.39  7.66  7.9  8.13  8.31
???  15716  8.59  8.79  8.72  8.9  8.81
???  15717  8.06  8.32  8.18  8.41  8.55
???  15718  8.13  8.44  8.67  8.93  8.98
???  15719  9.2  9.51  9.64  9.6  9.81
???  15720  9.41  9.75  9.6  9.7  9.75
???  15721  9.47  9.7  9.65  9.7  9.8
???  15722  8.91  9.32  9.34  9.39  9.73
end
