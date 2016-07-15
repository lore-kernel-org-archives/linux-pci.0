Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Sat, 16 Jul 2016 01:24:04 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Dave Airlie <airlied@redhat.com>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [Nouveau] [PATCH v3 0/4] nouveau RPM fixes for Optimus (final)
Message-ID: <20160715232404.GA28057@al>
References: <20160715131218.2416-1-peter@lekensteyn.nl>
 <CAKb7UvisjzPs_K1SNdDb7aZjxGQL4AOs05R8CX2xjU4uRpfcfA@mail.gmail.com>
 <20160715163622.GC2632@al>
 <CAKb7Uvg+E_92DF6p_3O0XtzG66qTdDM7Fa=TaesNs2Y6bzTQSA@mail.gmail.com>
 <20160715165427.GD2632@al>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <20160715165427.GD2632@al>
List-ID: <linux-pci.vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 15, 2016 at 06:54:27PM +0200, Peter Wu wrote:
> On Fri, Jul 15, 2016 at 12:41:49PM -0400, Ilia Mirkin wrote:
> > On Fri, Jul 15, 2016 at 12:36 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> > > On Fri, Jul 15, 2016 at 12:10:23PM -0400, Ilia Mirkin wrote:
> > >> On Fri, Jul 15, 2016 at 9:12 AM, Peter Wu <peter@lekensteyn.nl> wrote:
> > >> > Hi,
> > >> >
> > >> > Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
> > >> > due to unchecked function) and a more important fix to fix hanging Optimus
> > >> > machines when runtime PM is enabled (with pm/pci patches).
> > >> >
> > >> > These are the final patches targeting v4.8. Changes compared to v2[1]:
> > >> > collected R-b from Hans and Mika and fixed a minor comment style issue.
> > >> >
> > >> > I recommend it to be merged before the pci/pm patches[2], otherwise there is a
> > >> > window where newer Nvidia Optimus laptops might fail to runtime resume and/or
> > >> > lock up.  Once the pci/pm branch is merged I will propose another patch to
> > >> > improve reliability[3].
> > >> >
> > >> > Known issue with patch 4: when a Nvidia HDMI audio function is present, the
> > >> > bridge will not suspend and hence the Nvidia card will still be powered. Fixing
> > >>
> > >> That's basically all optimus gpu's, right? Anything GT21x+ has a HDMI
> > >> audio subfunction, and prior to that, the nvidia gpu tended to be the
> > >> only gpu, or hard-muxed.
> > >>
> > >> If that's the case, that's pretty much a non-starter, IMO.
> > >
> > > For some reason the audio function tends to disappear/hide, so maybe it
> > > is not as problematic as it appears (see
> > > https://bugs.freedesktop.org/show_bug.cgi?id=75985). For my laptop I
> > 
> > I'm aware of that bug. I believe this is an exceedingly rare scenario
> > or it would have been reported a lot more.
> > 
> > > also had to runtime suspend/resume before lspci -H1 shows the device,
> > > loading with runpm=0 didn't return my HDMI audio device.
> > 
> > Hm ok. Do you have the same laptop as the reporter of that bug?
> 
> Nope, I have a Clevo P651RA (GTX965M). That reporter has a Dell XPS 15,
> but it also seems present for the Lenovo ThinkPad T420s (see comment on
> bug), Asus N56VZ, MSI GT60 2PE, Dell L502x (Launchpad 1377653), Asus
> G46vw (Ask Ubuntu user). There is another AU report for a GT 525M
> (laptop brand/model unknown).
> 
> Maybe there are more affected users, but then they did not notice it
> because they did not use HDMI audio.
> 
> > >
> > > The powered on issue will also only appear on devices produced in 2013
> > > and newer that happen to have this ACPI _PR3 ACPI method (which is quite
> > > common for new machines supporting Windows 8 though).
> > >
> > > For these newer laptops, after the pci/pm merge and after a patch like
> > > http://www.spinics.net/lists/linux-pci/msg52601.html, the user can
> > > revert to the old DSM method by booting with pcie_port_pm=off which will
> > > retain the current behavior.
> > >
> > > The advantage of this patch is that it fixes memory corruption on some
> > > devices. The risk is that the card stays on because the audio subsystem
> > > needs some more work.  FWIW, I was working on some patches that properly
> > > suspended in presence of the HDA controller, but somehow the audio
> > > device was not properly resumed resulting in "no AFG or MFG node found"
> > > and "snd_hda_intel 0000:01:00.1: no codecs initialized".
> > 
> > Does this restriction (runpm being broken in presence of the audio
> > subfunction) only affect devices with _PR3? If so, that's a lot more
> > palatable - I bet Windows 8+ is in an era when the display-less thing
> > became more popular, and thus less likely to affect a ton of people.
> 
> Yes it only affects those devices with _PR3.

I downloaded all .tar.gz files from the big Launchpad bug that collects
DSDTs (and more recently also dmidecode/lspci) and ran an analysis. The
result (limited to files which actually had a lspci and dmidecode file):

 - 111 Nvidia video devices
 - 20 out of these have an audio device.
 - 18 use _PR3, 93 use DSM (or gmux).
 - Exactly zero use _PR3 and have an audio device!

The post-processed data (sorted by BIOS date) and (quick and dirty)
scripts are attached.  Hopefully these results are convincing enough :-)
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nv-devs.txt"

001 Apple_Inc.-MacBookPro6,1
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT216M [GeForce GT 330M] [10de:0a29] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GT216 HDMI Audio Controller [10de:0be2] (rev a1)
Date: bios-release-date     : 07/26/10
Use _DSM!

002 BenQ-Joybook_S42
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G96 [GeForce 9600M GT] [10de:0649] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 04/10/2009
Use _DSM!

003 ASUSTeK_Computer_Inc.-UL50VT
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [GeForce G210M] [10de:0a74] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev a1)
Date: bios-release-date     : 10/23/2009
Use _DSM!

004 Sony_Corporation-VPCZ11V9R
01:00.0 VGA compatible controller [0300]: nVidia Corporation GT216 [GeForce GT 330M] [10de:0a2b] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: nVidia Corporation High Definition Audio Controller [10de:0be2] (rev a1)
Date: bios-release-date     : 02/05/2010
Use _DSM!

005 ASUSTeK_Computer_Inc.-K42Jv
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT215M [GeForce GT 335M] [10de:0caf] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/24/2010
Use _DSM!

006 LENOVO-INVALID
02:00.0 VGA compatible controller [0300]: nVidia Corporation GT218 [GeForce 310M] [10de:0a70] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/29/2010
Use _DSM!

007 TOSHIBA-Satellite_E205
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [GeForce 310M] [10de:0a70] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 08/26/2010
Use _DSM!

008 CLEVO_CO.-B7130
01:00.0 VGA compatible controller [0300]: nVidia Corporation GF108 [GeForce GT 425M] [10de:0df0] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 08/27/2010
Use _DSM!

009 LENOVO-2904HHM
01:00.0 VGA compatible controller [0300]: nVidia Corporation GT218 [NVS 3100M] [10de:0a6c] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 09/16/2010
Use _DSM!

010 LENOVO-2516CTO
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [NVS 3100M] [10de:0a6c] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev a1)
Date: bios-release-date     : 10/25/2010
Use _DSM!

011 Acer-Aspire_5935
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT216 [GeForce GT 240M] [10de:0a34] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be2] (rev a1)
Date: bios-release-date     : 11/03/2010
Use _DSM!

012 Dell_Inc.-XPS_L401X
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0df1] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 12/22/2010
Use _DSM!

013 ASUSTeK_Computer_Inc.-UL80VT
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [GeForce G210M] [10de:0a74] (rev ff) (prog-if ff)
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev ff) (prog-if ff)
Date: bios-release-date     : 01/17/2011
Use _DSM!

014 ASUSTeK_Computer_Inc.-U33Jc
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218M [GeForce 310M] [10de:0a70] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 01/24/2011
Use _DSM!

015 LENOVO-IdeaPad_Y460
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0df0] (rev ff) (prog-if ff)
01:00.1 Audio device [0403]: nVidia Corporation Device [10de:0bea] (rev ff) (prog-if ff)
Date: bios-release-date     : 01/27/2011
Use _DSM!

016 SAMSUNG_ELECTRONICS_CO.,_LTD.-RC512
01:00.0 3D controller [0302]: nVidia Corporation Device [10de:0dec] (rev a1)
(No audio device found)
Date: bios-release-date     : 02/12/2011
Use _DSM!

017 ASUSTeK_Computer_INC.-1015PN
04:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [ION] [10de:0a6f] (rev a2) (prog-if 00 [VGA controller])
04:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev a1)
Date: bios-release-date     : 04/18/2011
Use _DSM!

018 SAMSUNG_ELECTRONICS_CO.,_LTD.-RF511_RF411_RF711
01:00.0 3D controller [0302]: nVidia Corporation GF106 [GeForce GT 555M] [10de:0df4] (rev a1)
(No audio device found)
Date: bios-release-date     : 04/26/2011
Use _DSM!

019 ASUSTeK_Computer_INC.-1215N
05:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0a76] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 05/05/2011
Use _DSM!

020 Dell_Inc.-Dell_System_Inspiron_N7110
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0df5] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 05/19/2011
Use _DSM!

021 LENOVO-4349WK8
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [NVS 3100M] [10de:0a6c] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/24/2011
Use _DSM!

022 SAMSUNG_ELECTRONICS_CO.,_LTD.-QX311_QX411_QX412_QX511
01:00.0 3D controller [0302]: nVidia Corporation Device [10de:1050] (rev a1)
(No audio device found)
Date: bios-release-date     : 06/22/2011
Use _DSM!

023 ASUSTeK_Computer_Inc.-K73SV
01:00.0 VGA compatible controller [0300]: nVidia Corporation GF106 [GeForce GT 555M] [10de:0df4] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/01/2011
Use _DSM!

024 Acer-Aspire_5750G
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 520M] [10de:0df7] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 07/11/2011
Use _DSM!

025 ASUSTeK_Computer_Inc.-U36SD
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119M [GeForce GT 520M] [10de:1050] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 07/12/2011
Use _DSM!

026 ASUSTeK_Computer_Inc.-K53SV
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 540M] [10de:0df4] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 07/14/2011
Use _DSM!

027 Dell_Inc.-Vostro_360
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0df5] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/19/2011
Use _DSM!

028 LENOVO-20091
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0deb] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 08/01/2011
Use _DSM!

029 Acer-Aspire_8951G
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF106 [GeForce GT 555M] [10de:0dce] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 08/02/2011
Use _DSM!

030 ASUSTeK_Computer_Inc.-K53SC
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119 [GeForce GT 520MX] [10de:1051] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 09/26/2011
Use _DSM!

031 Dell_Inc.-Inspiron_N5110
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0df5] (rev ff) (prog-if ff)
01:00.1 Audio device [0403]: nVidia Corporation GF108 High Definition Audio Controller [10de:0bea] (rev ff) (prog-if ff)
Date: bios-release-date     : 09/30/2011
Use _DSM!

032 SAMSUNG_ELECTRONICS_CO.,_LTD.-300V3Z_300V4Z_300V5Z_200A4Y_200A5Y
01:00.0 3D controller [0302]: nVidia Corporation Device [10de:1051] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 10/12/2011
Use _DSM!

033 LENOVO-HuronRiver_Platform
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108 [GeForce GT 540M] [10de:0df4] (rev ff) (prog-if ff)
01:00.1 Audio device [0403]: NVIDIA Corporation GF108 High Definition Audio Controller [10de:0bea] (rev ff) (prog-if ff)
Date: bios-release-date     : 10/21/2011
Use _DSM!

034 MEDION-P7624
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0de9] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 10/31/2011
Use _DSM!

035 LENOVO-4349PG7
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [NVS 3100M] [10de:0a6c] (rev a2) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev a1)
Date: bios-release-date     : 11/28/2011
Use _DSM!

036 LENOVO-4173W2X
01:00.0 VGA compatible controller [0300]: nVidia Corporation GF108 [Quadro NVS 4200M] [10de:1056] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 11/29/2011
Use _DSM!

037 LENOVO-2912CTO
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GT218 [NVS 3100M] [10de:0a6c] (rev ff) (prog-if ff)
01:00.1 Audio device [0403]: NVIDIA Corporation High Definition Audio Controller [10de:0be3] (rev ff) (prog-if ff)
Date: bios-release-date     : 12/12/2011
Use _DSM!

038 LENOVO-PIQY0
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:0deb] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 01/04/2012
Use _DSM!

039 Sony_Corporation-VPCEG38EC
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119M [GeForce 410M] [10de:1055] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GF119 HDMI Audio Controller [10de:0e08] (rev a1)
Date: bios-release-date     : 01/06/2012
Use _DSM!

040 ASUSTeK_Computer_Inc.-N53SV
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 540M] [10de:0df4] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 01/09/2012
Use _DSM!

041 Acer-TravelMate_8481TG
01:00.0 VGA compatible controller [0300]: nVidia Corporation Device [10de:1050] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: nVidia Corporation HDMI Audio stub [10de:0e08] (rev ff) (prog-if ff)
Date: bios-release-date     : 02/07/2012
Use _DSM!

042 Dell_Inc.-Dell_System_Vostro_3750
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 525M] [10de:0df5] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 02/22/2012
Use _DSM!

043 ASUSTeK_Computer_Inc.-K53SM
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 630M] [10de:0de9] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 03/06/2012
Use _DSM!

044 CLEVO_CO.-W150ER
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107 [GeForce GT 650M] [10de:0fd1] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 03/14/2012
Use _DSM!

045 Micro-Star_International_Co.,_Ltd.-GT70_0NC_GT70_0NC
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:1213] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 03/20/2012
Use _DSM!

046 TOSHIBA-SATELLITE_P870
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0de9] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 03/21/2012
Use _DSM!

047 LENOVO-Lenovo_IdeaPad_Y480
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 630M] [10de:0de9] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 03/22/2012
Use _DSM!

048 Dell_Inc.-XPS_L412Z
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119M [GeForce GT 520M] [10de:1050] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 04/20/2012
Use _DSM!

049 LENOVO-814UG01
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [GeForce GT 630M] [10de:0de9] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 04/23/2012
Use _DSM!

050 LENOVO-Lenovo_G580
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 04/24/2012
Use _DSM!

051 CLEVO_CO.-W110ER
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0fd1] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 04/26/2012
Use _DSM!

052 Acer-Aspire_M3-581TG
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0fd2] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 05/12/2012
Use _DSM!

053 Sony_Corporation-SVS13A1C5E
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0fd3] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/17/2012
Use _DSM!

054 LENOVO-2436CTO
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0ffb] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/25/2012
Use _DSM!

055 Dell_Inc.-Dell_System_XPS_L502X
01:00.0 VGA compatible controller [0300]: nVidia Corporation GF106 [GeForce GT 555M SDDR3] [10de:0df4] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/29/2012
Use _DSM!

056 LENOVO-2093
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0fd1] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 06/26/2012
Use _DSM!

057 Alienware-M18xR2
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:11a0] (rev a1) (prog-if 00 [VGA controller])
07:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:11a0] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK104 HDMI Audio Controller [10de:0e0a] (rev a1)
Date: bios-release-date     : 06/29/2012
Use _DSM!

058 SAMSUNG_ELECTRONICS_CO.,_LTD.-700Z7C
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107 [GeForce GT 650M] [10de:0fd1] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 08/02/2012
Use _DSM!

059 Apple_Inc.-MacBookPro9,1
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 650M Mac Edition] [10de:0fd5] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK107 HDMI Audio Controller [10de:0e1b] (rev a1)
Date: bios-release-date     : 08/08/2012
Use _DSM!

060 Dell_Inc.-Inspiron_5720
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 08/16/2012
Use _DSM!

061 Sony_Corporation-SVS13A190X
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 640M LE] [10de:0fd3] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 08/22/2012
Use _DSM!

062 LENOVO-3351CTO
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 08/27/2012
Use _DSM!

063 Gigabyte_Technology_Co.,_Ltd.-To_be_filled_by_O.E.M.
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation G94 [GeForce 9600 GT] [10de:0622] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 10/24/2012
Use _DSM!

064 FUJITSU-LIFEBOOK_NH532
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0fd3] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 11/08/2012
Use _DSM!

065 Dell_Inc.-XPS_L421X
01:00.0 3D controller [0302]: NVIDIA Corporation GF117M [GeForce 610M/710M/820M / GT 620M/625M/630M/720M] [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 12/07/2012
Use _DSM!

066 ASUSTeK_COMPUTER_INC.-N56VB
01:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 740M] [10de:0fdf] (rev a1)
(No audio device found)
Date: bios-release-date     : 01/21/2013
Use _DSM!

067 LENOVO-2359CTO
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108 [Quadro NVS 5400M] [10de:0def] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 02/01/2013
Use _DSM!

068 Notebook-P15SM
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106M [GeForce GTX 770M] [10de:11e0] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 04/09/2013
Use _DSM!

069 Notebook-W350STQ_W370ST
01:00.0 3D controller [0302]: NVIDIA Corporation GK106M [GeForce GTX 765M] [10de:11e2] (rev a1)
(No audio device found)
Date: bios-release-date     : 04/11/2013
Use _DSM!

070 LENOVO-33643EG
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation Device [10de:0de8] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 04/24/2013
Use _DSM!

071 Dell_Inc.-Inspiron_5421
02:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 730M] [10de:0fe1] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/18/2013
Use _DSM!

072 Razer-_
01:00.0 3D controller [0302]: NVIDIA Corporation GK106M [GeForce GTX 765M] [10de:11e2] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/20/2013
Use _DSM!

073 Micro-Star_International_Co.,_Ltd.-GT60_2OC_2OD
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106M [GeForce GTX 770M] [10de:11e0] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 05/22/2013
Use _DSM!

074 LENOVO-2394CTO
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108M [NVS 5400M] [10de:0def] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 05/23/2013
Use _DSM!

075 Acer-Aspire_V7-482PG
01:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev a1)
(No audio device found)
Date: bios-release-date     : 06/03/2013
Use _DSM!

076 Acer-Aspire_V5-573G
01:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev a1)
(No audio device found)
Date: bios-release-date     : 06/28/2013
Use _DSM!

077 LENOVO-41786VU
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119 [Quadro NVS 4200M] [10de:1057] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 07/05/2013
Use _DSM!

078 Alienware-Alienware_17
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106M [GeForce GTX 770M] [10de:11e0] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/15/2013
Use _DSM!

079 LENOVO-42395GU
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF119M [Quadro NVS 4200M] [10de:1057] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/26/2013
Use _DSM!

080 ASUSTeK_COMPUTER_INC.-G750JHA
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK104M [GeForce GTX 780M] [10de:119f] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK104 HDMI Audio Controller [10de:0e0a] (rev a1)
Date: bios-release-date     : 07/31/2013
Use _DSM!

081 Alienware-Alienware_14
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106M [GeForce GTX 765M] [10de:11e2] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 08/12/2013
Use _DSM!

082 Dell_Inc.-Inspiron_7720
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 650M / GTX 660M LE] [10de:0fd1] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 08/23/2013
Use _DSM!

083 LENOVO-20270
09:00.0 3D controller [0302]: NVIDIA Corporation GK208M [GeForce GT 730M] [10de:1290] (rev a1)
(No audio device found)
Date: bios-release-date     : 09/06/2013
Use _DSM!

084 SAMSUNG_ELECTRONICS_CO.,_LTD.-550P5C_550P7C
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 650M] [10de:0fd1] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 09/17/2013
Use _DSM!

085 LENOVO-20217
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 755M] [10de:0fcd] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 09/18/2013
Got _PR3!

086 Micro-Star_International_Co.,_Ltd.-CR42_2M_GE40_2OC
01:00.0 3D controller [0302]: NVIDIA Corporation GK106M [GeForce GTX 760M] [10de:11e3] (rev a1)
(No audio device found)
Date: bios-release-date     : 09/24/2013
Use _DSM!

087 Hewlett-Packard-HP_EliteBook_8570w
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107GLM [Quadro K2000M] [10de:0ffb] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK107 HDMI Audio Controller [10de:0e1b] (rev a1)
Date: bios-release-date     : 10/08/2013
Use _DSM!

088 Dell_Inc.-Inspiron_7737
04:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev a1)
(No audio device found)
Date: bios-release-date     : 10/09/2013
Use _DSM!

089 LENOVO-20AWS02A00
02:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208M [GeForce GT 730M] [10de:1290] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 10/27/2013
Got _PR3!

090 Dell_Inc.-Inspiron_7537
04:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev a1)
(No audio device found)
Date: bios-release-date     : 10/31/2013
Use _DSM!

091 Dell_Inc.-XPS_2720
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 12/11/2013
Use _DSM!

092 ASUS-All_Series
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK106 [GeForce GTX 660] [10de:11c0] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK106 HDMI Audio Controller [10de:0e0b] (rev a1)
Date: bios-release-date     : 01/06/2014
Use _DSM!

093 ASUSTeK_COMPUTER_INC.-N750JK
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:1391] (rev a2)
(No audio device found)
Date: bios-release-date     : 01/17/2014
Got _PR3!

094 Novatech_Ltd.-Novatech_15.6_NSPIRE_Laptop
01:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 745M] [10de:0fe3] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 01/20/2014
Got _PR3!

095 Notebook-W35xSTQ_370ST
01:00.0 3D controller [0302]: NVIDIA Corporation GK106M [GeForce GTX 765M] [10de:11e2] (rev a1)
(No audio device found)
Date: bios-release-date     : 03/12/2014
Use _DSM!

096 Notebook-P17SM-A
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK104M [GeForce GTX 860M] [10de:119a] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 03/27/2014
Got _PR3!

097 Dell_Inc.-XPS_15_9530
02:00.0 3D controller [0302]: NVIDIA Corporation GK107M [GeForce GT 750M] [10de:0fe4] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 03/28/2014
Got _PR3!

098 ASUSTeK_Computer_INC.-EB1037
01:00.0 3D controller [0302]: NVIDIA Corporation GF117M [GeForce 610M/710M/820M / GT 620M/625M/630M/720M] [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 06/23/2014
Got _PR3!

099 ASUSTeK_COMPUTER_INC.-Q551LN
04:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 840M] [10de:1341] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 06/26/2014
Got _PR3!

100 LENOVO-20BG0011US
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK107GLM [Quadro K1100M] [10de:0ff6] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 07/02/2014
Got _PR3!

101 ASUSTeK_COMPUTER_INC.-X555LD
04:00.0 3D controller [0302]: NVIDIA Corporation GF117M [GeForce 610M/710M/820M / GT 620M/625M/630M/720M] [10de:1140] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 08/14/2014
Got _PR3!

102 Dell_Inc.-Latitude_E6530
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF108GLM [NVS 5200M] [10de:0dfc] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 09/24/2014
Use _DSM!

103 Dell_Inc.-Inspiron_3543
08:00.0 3D controller [0302]: NVIDIA Corporation GF117M [GeForce 610M/710M/820M / GT 620M/625M/630M/720M] [10de:1140] (rev a1)
(No audio device found)
Date: bios-release-date     : 11/04/2014
Got _PR3!

104 Hewlett-Packard-HP_ENVY_TS_15_Notebook_PC
01:00.0 3D controller [0302]: NVIDIA Corporation GK208M [GeForce GT 740M] [10de:1292] (rev a1)
(No audio device found)
Date: bios-release-date     : 11/20/2014
Got _PR3!

105 ASUSTeK_COMPUTER_INC.-UX303LNB
03:00.0 3D controller [0302]: NVIDIA Corporation GM108M [GeForce 840M] [10de:1341] (rev a2)
(No audio device found)
Date: bios-release-date     : 12/10/2014
Got _PR3!

106 Micro-Star_International_Co.,_Ltd.-GS70_2PC_Stealth
01:00.0 3D controller [0302]: NVIDIA Corporation GK104M [GeForce GTX 860M] [10de:119a] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 01/13/2015
Got _PR3!

107 Hewlett-Packard-HP_ZBook_15
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK208GLM [Quadro K610M] [10de:12b9] (rev a1) (prog-if 00 [VGA controller])
01:00.1 Audio device [0403]: NVIDIA Corporation GK208 HDMI/DP Audio Controller [10de:0e0f] (rev a1)
Date: bios-release-date     : 03/31/2015
Use _DSM!

108 CLEVO-P65xSE-A
01:00.0 3D controller [0302]: NVIDIA Corporation Device [10de:13d8] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 10/12/2015
Got _PR3!

109 ASUSTeK_COMPUTER_INC.-G501JW
01:00.0 3D controller [0302]: NVIDIA Corporation GM107M [GeForce GTX 960M] [10de:139b] (rev ff) (prog-if ff)
(No audio device found)
Date: bios-release-date     : 10/28/2015
Got _PR3!

110 Notebook-P65_P67RGRERA
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM204M [GeForce GTX 970M] [10de:13d8] (rev a1) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 12/21/2015
Got _PR3!

111 Notebook-N15_17RD
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GM107M [GeForce GTX 960M] [10de:139b] (rev a2) (prog-if 00 [VGA controller])
(No audio device found)
Date: bios-release-date     : 12/25/2015
Got _PR3!


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="get-urls.awk"

#!/usr/bin/gawk -f
# Example usage to download the files, preserving time and following redirs:
# curl -o 752542.html https://bugs.launchpad.net/lpbugreporter/+bug/752542 &&
# ./get-urls.awk 752542.html |
# awk 'NR<=50{print "-O", $0}' | (cd /tmp/lp/dl/ && time xargs curl -qvRL)
BEGIN {
        FS="\""
        delete entries
}
/portlet-attachments/ { p = 1}
# The few .zip and .tar and .tar.bz2 did not seem interesting. Also ignore plain
# .dsl{,.gz,.bz2}, .txt and .dat files.
p && /+files\/.*\.tar\.gz"/ {
        url = $2
        split(url, parts, "/")
        name = parts[10]
        id = parts[8]

        #print url;
        # Overwrite older names with newer submissions.
        entries[name] = url
        ids[id] = name
}

END {
        # Sort by attachment ID
        asorti(ids, ids_sorted)
        # Print attachments in reverse (newest first)
        for (i = length(ids_sorted); i > 0; i--) {
                id = ids_sorted[i]
                name = ids[id]
                if (entries[name]) {
                        url = entries[name]
                        print url
                        # Do not print duplicates
                        delete entries[name]
                }
        }
}

--pf9I7BMVVzbSWLtt
Content-Type: application/x-sh
Content-Disposition: attachment; filename="has-audio-problem.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# Summarize the Nvidia devices from DSDT/dmidecode/lspci tarbal=
ls from=0A# https://bugs.launchpad.net/bugs/752542=0A#=0A# Invoke with ./ha=
s-audio-problems.sh */=0A# where the subdirs are extracted tarballs (having=
 dmidecode.txt and lspci.txt).=0A# Had to manually fix one dmidecode.txt an=
d folder name for Notebook-N15_17RD,=0A# it reported "# SMBIOS implementati=
ons newer than version 2.8 are not".=0A=0Aset -u=0A=0Awarn() {=0A    printf=
 'WARNING: %s\n' "$1"=0A}=0A=0A=0Aget_audio() {=0A    grep -i 'Audio device=
=2E*NVIDIA' lspci.txt=0A}=0A=0Aget_video() {=0A    grep -iE '(VGA compatibl=
e|3D controller).*NVIDIA' lspci.txt=0A}=0A=0Abios_date() {=0A    grep bios-=
release-date dmidecode.txt=0A}=0A=0Ahas_pr3() {=0A    local i=0A    if ls |=
 grep -q '\.dsl$'; then=0A        grep -q _PR3 -w *.dsl=0A    elif [ -e acp=
idump.txt ]; then=0A        grep -q _PR3 -w acpidump.txt=0A    else=0A     =
   warn "No ACPI info available!"=0A    fi=0A}=0A=0A=0Acheck_bad() {=0A    =
printf "%03d %s\n" $((1+count)) "${PWD##*/}"=0A    #vdev=3D$(get_video) || =
warn "No video device found"=0A    adev=3D$(get_audio) # || warn "No audio =
device found"=0A    date=3D$(bios_date) || warn "No bios date found"=0A    =
echo "$vdev"=0A    echo "${adev:-(No audio device found)}"=0A    echo "Date=
: $date"=0A    has_pr3 && echo "Got _PR3!" || echo "Use _DSM!"=0A    echo=
=0A}=0A=0A# hacks for sorted output=0Atmpdir=3D$(mktemp -d)=0Aoutfile=3D"$t=
mpdir/.out"=0Atrap 'rm -rf "$tmpdir"' EXIT=0A# Without sorting=0A#post_move=
() { cat "$outfile"; }=0Apost_move() {=0A    # Assume mm/dd/yyyy=0A    sede=
xpr=3D'/^Date: /{s,.* ([0-9]+)/([0-9]+)/([0-9]+),\3-\1-\2,;p}'=0A    name=
=3D$(sed -r -n "$sedexpr" "$outfile")=0A    [ -n "$name" ] || return=0A    =
cat "$outfile" > "$tmpdir/$name"=0A}=0A=0A=0Acheck_dir() {=0A    local dir=
=3D"$1"=0A=0A    #(cd "$dir" && adev=3D$(get_audio) && check_bad)=0A    (cd=
 "$dir" && vdev=3D$(get_video) && check_bad) >"$outfile" && post_move=0A}=
=0A=0Acount=3D0=0Afor dir; do=0A    check_dir "$dir" && ((count++))=0Adone=
=0A=0A=0A# With sorting=0Anr=3D1=0Afor i in "$tmpdir"/[0-9]*; do=0A    seqn=
o=3D$(printf %03d $nr)=0A    sed -r "1s/^[0-9]+ /$seqno /" "$i"=0A    ((nr+=
+))=0Adone=0A=0A=0Aecho Done >&2=0A
--pf9I7BMVVzbSWLtt--
