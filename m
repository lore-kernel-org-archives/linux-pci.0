Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:35567 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993059AbbEEOKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2015 10:10:30 -0400
Received: by widdi4 with SMTP id di4so162557094wid.0
        for <linux-pci@vger.kernel.org>; Tue, 05 May 2015 07:10:28 -0700 (PDT)
Received: from tvenkinys.localnet ([84.15.191.186])
        by mx.google.com with ESMTPSA id yr1sm25765166wjc.37.2015.05.05.07.10.16
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 07:10:17 -0700 (PDT)
From: "Donatas G." <dg@lapas.info>
To: linux-pci@vger.kernel.org
Subject: bug: ExpressCard type USB3.0 adapter does not work on hotplug
Date: Tue, 05 May 2015 17:10:12 +0300
Message-ID: <2934645.mRJ7KPhQhB@tvenkinys>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[1.] One line summary of the problem: 
ExpressCard type USB3.0 adapter does not work on hotplug

[2.] Full description of the problem/report: 
ExpressCard type USB3.0 adapter for laptop does not work on hotplug with the 
current mainline kernel 4.1.0-040100rc2-generic – devices attached to it do 
not get reported by the system as attached and cannot get mounted/function. 
The hotplug does work on an older kernel (giving 3x read spead from an 
external USB 3.0 drive), so it looks like a regression. However, when booted 
with the device attached, the adapter and the attached devices do function 
properly - the attached devices work fine both coldplugged and hotplugged.

The adapter in question: 2 Port USB3.0 expressCard, UNEC UPD720202 Chip see 
here for description http://www.amazon.co.uk/SuperSpeed-compatible-transfer-Notebook-internal/dp/B00K49TNUU

The following outputs are all in a case of hotplug. If I should repeat any of 
these on coldplug, do let me know...

[3.] Keywords 

[4.] Kernel version (from /proc/version): 
Linux version 4.1.0-040100rc2-generic (kernel@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201505032335 SMP Mon May 4 03:36:35 UTC 2015

[5.] Output of Oops.. message [not applicable]

[6.] A small shell script or example program which triggers the problem [not 
applicable]

[7.] Environment 
$ lsb_release -rd 
Description:    Ubuntu 15.04
Release:        15.04

[7.1.] Software  
$ /usr/src/linux-headers-4.1.0-040100rc2/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
Linux tvenkinys 4.1.0-040100rc2-generic #201505032335 SMP Mon May 4 03:36:35 
UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
Gnu C                  4.9.2
Gnu make               4.0
binutils               2.25
util-linux             2.25.2
mount                  debug
module-init-tools      18
e2fsprogs              1.42.12
pcmciautils            018
PPP                    2.4.6
Linux C Library        2.21
Dynamic linker (ldd)   2.21
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.23
wireless-tools         30
Modules Loaded         rndis_host cdc_ether usbnet mii rfcomm bnep dm_crypt 
uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_core v4l2_common 
videodev media wacom btusb btbcm btintel arc4 intel_rapl bluetooth iosf_mbi 
x86_pkg_temp_thermal intel_powerclamp coretemp iwldvm kvm_intel kvm mac80211 
crct10dif_pclmul snd_hda_codec_hdmi crc32_pclmul ghash_clmulni_intel 
snd_hda_codec_conexant snd_hda_codec_generic aesni_intel aes_x86_64 iwlwifi lrw 
snd_hda_intel gf128mul snd_hda_controller glue_helper snd_hda_codec 
ablk_helper cryptd snd_hda_core snd_hwdep snd_pcm cfg80211 snd_seq_midi 
thinkpad_acpi snd_seq_midi_event joydev snd_rawmidi serio_raw snd_seq 
snd_seq_device nvram snd_timer mei_me lpc_ich snd mei shpchp soundcore mac_hid 
parport_pc ppdev lp parport autofs4 hid_generic usbhid hid i915 psmouse ahci 
i2c_algo_bit sdhci_pci libahci drm_kms_helper sdhci e1000e drm ptp pps_core 
wmi video


[7.2.] Processor information:
$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
stepping        : 7
microcode       : 0x29
cpu MHz         : 962.695
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf 
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr 
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm 
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs            :
bogomips        : 4983.66
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
stepping        : 7$ [7.3.] Module information (from /proc/modules): 
bash: sintaksės klaida prie netikėtos leksemos: „(“
dg@tvenkinys:~$ cat /proc/modules
rndis_host 20480 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
dm_crypt 28672 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
wacom 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwldvm 245760 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mac80211 782336 1 iwldvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
aesni_intel 172032 2301 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwldvm, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 32768 3 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 122880 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 1153 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
snd_hda_core 36864 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec, 
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 114688 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
cfg80211 589824 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
thinkpad_acpi 90112 1 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 86016 18 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 122880 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
i915 1142784 6 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i9$ [7.3.] Module information (from /proc/modules): 
bash: sintaksės klaida prie netikėtos leksemos: „(“
dg@tvenkinys:~$ cat /proc/modules
rndis_host 20480 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
dm_crypt 28672 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
wacom 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwldvm 245760 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mac80211 782336 1 iwldvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
aesni_intel 172032 2301 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwldvm, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 32768 3 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 122880 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 1153 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
snd_hda_core 36864 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec, 
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 114688 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
cfg80211 589824 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
thinkpad_acpi 90112 1 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 86016 18 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 122880 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
i915 1142784 6 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
e1000e 241664 0 - Live 0x0000000000000000
drm 352256 8 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 0 - Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000
15, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
e1000e 241664 0 - Live 0x0000000000000000
drm 352256 8 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 0 - Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000

microcode       : 0x29
cpu MHz         : 979.882
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf 
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr 
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm 
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs            :
bogomips        : 4983.66
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : Genui$ [7.3.] Module information (from /proc/modules): 
bash: sintaksės klaida prie netikėtos leksemos: „(“
dg@tvenkinys:~$ cat /proc/modules
rndis_host 20480 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
dm_crypt 28672 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
wacom 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwldvm 245760 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mac80211 782336 1 iwldvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
aesni_intel 172032 2301 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwldvm, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 32768 3 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 122880 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 1153 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
snd_hda_core 36864 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec, 
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 114688 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
cfg80211 589824 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
thinkpad_acpi 90112 1 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 86016 18 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 122880 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
i915 1142784 6 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
e1000e 241664 0 - Live 0x0000000000000000
drm 352256 8 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 0 - Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000
neIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
stepping        : 7
microcode       : 0x29
cpu MHz         : 1196.093
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf 
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr 
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm 
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs            :
bogomips        : 4983.66
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz
stepping        : 7
microcode       : 0x29
cpu MHz         : 1210.839
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes$ [7.3.] Module information (from /proc/modules): 
bash: sintaksės klaida prie netikėtos leksemos: „(“
dg@tvenkinys:~$ cat /proc/modules
rndis_host 20480 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
dm_crypt 28672 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
wacom 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwldvm 245760 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mac80211 782336 1 iwldvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
aesni_intel 172032 2301 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwldvm, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 32768 3 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 122880 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 1153 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
snd_hda_core 36864 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec, 
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 114688 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
cfg80211 589824 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
thinkpad_acpi 90112 1 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 86016 18 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 122880 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
i915 1142784 6 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
e1000e 241664 0 - Live 0x0000000000000000
drm 352256 8 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 0 - Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm 
constant_tsc arch_perfmon pebs bts nopl xtopology nonstop_tsc aperfmperf 
eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr 
pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm 
ida arat epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid xsaveopt
bugs            :
bogomips        : 4983.66
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:


$ [7.3.] Module information:
$ cat /proc/modules
rndis_host 20480 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
mii 16384 1 usbnet, Live 0x0000000000000000
rfcomm 77824 8 - Live 0x0000000000000000
bnep 24576 2 - Live 0x0000000000000000
dm_crypt 28672 1 - Live 0x0000000000000000
uvcvideo 94208 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 53248 1 uvcvideo, Live 0x0000000000000000
v4l2_common 16384 1 videobuf2_core, Live 0x0000000000000000
videodev 172032 3 uvcvideo,videobuf2_core,v4l2_common, Live 0x0000000000000000
media 24576 2 uvcvideo,videodev, Live 0x0000000000000000
wacom 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
intel_rapl 20480 0 - Live 0x0000000000000000
bluetooth 540672 24 rfcomm,bnep,btusb,btbcm,btintel, Live 0x0000000000000000
iosf_mbi 16384 1 intel_rapl, Live 0x000000000dg@tvenkinys:~0000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 20480 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
iwldvm 245760 0 - Live 0x0000000000000000
kvm_intel 159744 0 - Live 0x0000000000000000
kvm 507904 1 kvm_intel, Live 0x0000000000000000
mac80211 782336 1 iwldvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 53248 1 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_conexant 24576 1 - Live 0x0000000000000000
snd_hda_codec_generic 77824 1 snd_hda_codec_conexant, Live 0x0000000000000000
aesni_intel 172032 2301 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
iwlwifi 217088 1 iwldvm, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_intel 32768 3 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
snd_hda_controller 36864 1 snd_hda_intel, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
snd_hda_codec 122880 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 1153 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0x0000000000000000
snd_hda_core 36864 5 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_controller,snd_hda_codec, 
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 114688 4 
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec, Live 
0x0000000000000000
cfg80211 589824 3 iwldvm,mac80211,iwlwifi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
thinkpad_acpi 90112 1 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 69632 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 
0x0000000000000000
nvram 16384 1 thinkpad_acpi, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
mei_me 24576 0 - Live 0x0000000000000000
lpc_ich 24576 0 - Live 0x0000000000000000
snd 86016 18 
snd_hda_codec_hdmi,snd_hda_codec_conexant,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,thinkpad_acpi,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
shpchp 40960 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mac_hid 16384 0 - Live 0x0000000000000000
parport_pc 36864 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 53248 0 - Live 0x0000000000000000
hid 122880 3 wacom,hid_generic,usbhid, Live 0x0000000000000000
i915 1142784 6 - Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
sdhci_pci 24576 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
drm_kms_helper 126976 1 i915, Live 0x0000000000000000
sdhci 45056 1 sdhci_pci, Live 0x0000000000000000
e1000e 241664 0 - Live 0x0000000000000000
drm 352256 8 i915,drm_kms_helper, Live 0x0000000000000000
ptp 20480 1 e1000e, Live 0x0000000000000000
pps_core 20480 1 ptp, Live 0x0000000000000000
wmi 20480 0 - Live 0x0000000000000000
video 28672 1 i915, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information:
$ cat /proc/ioports 
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0061-0061 : PNP0800:00
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0071 : rtc0$ cat /proc/iomem 
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d3fff : pnp 00:00
000d4000-000d7fff : pnp 00:00
000d8000-000dbfff : pnp 00:00
000dc000-000dffff : pnp 00:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-01808edc : Kernel code
  01808edd-01f3487f : Kernel data
  020a6000-021e8fff : Kernel bss
20000000-201fffff : reserved
20200000-3fffffff : System RAM
40000000-401fffff : reserved
40200000-da99efff : System RAM
da99f000-dae9efff : reserved
dae9f000-daf9efff : ACPI Non-volatile Storage
daf9f000-daffefff : ACPI Tables
dafff000-daffffff : System RAM
db000000-df9fffff : reserved
  dba00000-df9fffff : Graphics Stolen Memory
dfa00000-febfffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
  f0000000-f03fffff : 0000:00:02.0
  f0400000-f0bfffff : PCI Bus 0000:05
  f0c00000-f13fffff : PCI Bus 0000:0d
  f1400000-f1bfffff : PCI Bus 0000:0d
    f1400000-f14000ff : 0000:0d:00.0
      f1400000-f14000ff : mmc0
  f1c00000-f23fffff : PCI Bus 0000:05
    f1c00000-f1c01fff : 0000:05:00.0
      f1c00000-f1c01fff : xhci-hcd
  f2400000-f24fffff : PCI Bus 0000:03
    f2400000-f2401fff : 0000:03:00.0
      f2400000-f2401fff : iwlwifi
  f2500000-f251ffff : 0000:00:19.0
    f2500000-f251ffff : e1000e
  f2520000-f2523fff : 0000:00:1b.0
    f2520000-f2523fff : ICH HD audio
  f2524000-f25240ff : 0000:00:1f.3
  f2525000-f252500f : 0000:00:16.0
    f2525000-f252500f : mei_me
  f2528000-f25287ff : 0000:00:1f.2
    f2528000-f25287ff : ahci
  f2529000-f25293ff : 0000:00:1d.0
    f2529000-f25293ff : ehci_hcd
  f252a000-f252a3ff : 0000:00:1a.0
    f252a000-f252a3ff : ehci_hcd
  f252b000-f252bfff : 0000:00:19.0
    f252b000-f252bfff : e1000e
  f252c000-f252cfff : 0000:00:16.3
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:01
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed08000-fed08fff : reserved
fed10000-fed19fff : reserved
  fed10000-fed13fff : pnp 00:01
  fed18000-fed18fff : pnp 00:01
  fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
fed40000-fed4bfff : PCI Bus 0000:00
  fed45000-fed4bfff : pnp 00:01
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffd20000-ffffffff : reserved
100000000-21e5fffff : System RAM
21e600000-21e7fffff : reserved
21e800000-21fffffff : RAM buffer
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
    00f0-00f0 : PNP0C04:00
  03c0-03df : vesafb
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-042f : ACPI GPE0_BLK
  0430-0433 : iTCO_wdt
  0450-0450 : ACPI PM2_CNT_BLK
  0460-047f : iTCO_wdt
  0500-057f : pnp 00:01
  0800-080f : pnp 00:01
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  15e0-15ef : pnp 00:01
  1600-167f : pnp 00:01
  3000-3fff : PCI Bus 0000:0d
  4000-4fff : PCI Bus 0000:05
  5000-503f : 0000:00:02.0
  5060-507f : 0000:00:1f.2
    5060-507f : ahci
  5080-509f : 0000:00:19.0
  50a0-50a7 : 0000:00:1f.2
    50a0-50a7 : ahci
  50a8-50af : 0000:00:1f.2
    50a8-50af : ahci
  50b0-50b7 : 0000:00:16.3
    50b0-50b7 : serial
  50b8-50bb : 0000:00:1f.2
    50b8-50bb : ahci
  50bc-50bf : 0000:00:1f.2
    50bc-50bf : ahci
  efa0-efbf : 0000:00:1f.3
  

$ cat /proc/iomem 
00000000-00000fff : reserved
00001000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000cbfff : pnp 00:00
000cc000-000cffff : pnp 00:00
000d0000-000d3fff : pnp 00:00
000d4000-000d7fff : pnp 00:00
000d8000-000dbfff : pnp 00:00
000dc000-000dffff : pnp 00:00
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-1fffffff : System RAM
  01000000-01808edc : Kernel code
  01808edd-01f3487f : Kernel data
  020a6000-021e8fff : Kernel bss
20000000-201fffff : reserved
20200000-3fffffff : System RAM
40000000-401fffff : reserved
40200000-da99efff : System RAM
da99f000-dae9efff : reserved
dae9f000-daf9efff : ACPI Non-volatile Storage
daf9f000-daffefff : ACPI Tables
dafff000-daffffff : System RAM
db000000-df9fffff : reserved
  dba00000-df9fffff : Graphics Stolen Memory
dfa00000-febfffff : PCI Bus 0000:00
  e0000000-efffffff : 0000:00:02.0
  f0000000-f03fffff : 0000:00:02.0
  f0400000-f0bfffff : PCI Bus 0000:05
  f0c00000-f13fffff : PCI Bus 0000:0d
  f1400000-f1bfffff : PCI Bus 0000:0d
    f1400000-f14000ff : 0000:0d:00.0
      f1400000-f14000ff : mmc0
  f1c00000-f23fffff : PCI Bus 0000:05
    f1c00000-f1c01fff : 0000:05:00.0
      f1c00000-f1c01fff : xhci-hcd
  f2400000-f24fffff : PCI Bus 0000:03
    f2400000-f2401fff : 0000:03:00.0
      f2400000-f2401fff : iwlwifi
  f2500000-f251ffff : 0000:00:19.0
    f2500000-f251ffff : e1000e
  f2520000-f2523fff : 0000:00:1b.0
    f2520000-f2523fff : ICH HD audio
  f2524000-f25240ff : 0000:00:1f.3
  f2525000-f252500f : 0000:00:16.0
    f2525000-f252500f : mei_me
  f2528000-f25287ff : 0000:00:1f.2
    f2528000-f25287ff : ahci
  f2529000-f25293ff : 0000:00:1d.0
    f2529000-f25293ff : ehci_hcd
  f252a000-f252a3ff : 0000:00:1a.0
    f252a000-f252a3ff : ehci_hcd
  f252b000-f252bfff : 0000:00:19.0
    f252b000-f252bfff : e1000e
  f252c000-f252cfff : 0000:00:16.3
  f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
    f8000000-fbffffff : reserved
      f8000000-fbffffff : pnp 00:01
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed08000-fed08fff : reserved
fed10000-fed19fff : reserved
  fed10000-fed13fff : pnp 00:01
  fed18000-fed18fff : pnp 00:01
  fed19000-fed19fff : pnp 00:01
fed1c000-fed1ffff : reserved
  fed1c000-fed1ffff : pnp 00:01
    fed1f410-fed1f414 : iTCO_wdt
fed40000-fed4bfff : PCI Bus 0000:00
  fed45000-fed4bfff : pnp 00:01
fed90000-fed90fff : dmar0
fed91000-fed91fff : dmar1
fee00000-fee00fff : Local APIC
  fee00000-fee00fff : reserved
ffd20000-ffffffff : reserved
100000000-21e5fffff : System RAM
21e600000-21e7fffff : reserved
21e800000-21fffffff : RAM buffer




[7.5.] PCI information
$ sudo lspci -vvv 
[sudo] password for dg: 
00:00.0 Host bridge: Intel Corporation 2nd Generation Core Processor Family 
DRAM Controller (rev 09)
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation 2nd Generation Core 
Processor Family Integrated Graphics Controller (rev 09) (prog-if 00 [VGA 
controller])
        Subsystem: Lenovo Device 21db
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 28
        Region 0: Memory at f0000000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at e0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at 5000 [size=64]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00018  Data: 0000
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915

00:16.0 Communication controller: Intel Corporation 6 Series/C200 Series 
Chipset Family MEI Controller #1 (rev 04)
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 29
        Region 0: Memory at f2525000 (64-bit, non-prefetchable) [size=16]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00398  Data: 0000
        Kernel driver in use: mei_me

00:16.3 Serial controller: Intel Corporation 6 Series/C200 Series Chipset 
Family KT Controller (rev 04) (prog-if 02 [16550])
        Subsystem: Lenovo Device 21db
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 0: I/O ports at 50b0 [size=8]
        Region 1: Memory at f252c000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: serial

00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network 
Connection (rev 04)
        Subsystem: Lenovo Device 21ce
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 26
        Region 0: Memory at f2500000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at f252b000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 5080 [size=32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00358  Data: 0000
        Capabilities: [e0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: e1000e

00:1a.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family 
USB Enhanced Host Controller #2 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f252a000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family 
High Definition Audio Controller (rev 04)
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 30
        Region 0: Memory at f2520000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee003d8  Data: 0000
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=01
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=1 ArbSelect=Fixed TC/VC=22
                        Status: NegoPending- InProgress-
        Capabilities: [130 v1] Root Complex Link
                Desc:   PortNumber=0f ComponentID=00 EltType=Config
                Link0:  Desc:   TargetPort=00 TargetComponent=00 AssocRCRB- 
LinkType=MemMapped LinkValid+
                        Addr:   00000000fed1c000
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI 
Express Root Port 1 (rev b4) (prog-if 00 [Normal decode])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #0, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- 
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Lenovo Device 21db
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI 
Express Root Port 2 (rev b4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f2400000-f24fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #1, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Lenovo Device 21db
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI 
Express Root Port 4 (rev b4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=05, subordinate=0c, sec-latency=0
        I/O behind bridge: 00004000-00004fff
        Memory behind bridge: f1c00000-f23fffff
        Prefetchable memory behind bridge: 00000000f0400000-00000000f0bfffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet+ LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Lenovo Device 21db
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

00:1c.4 PCI bridge: Intel Corporation 6 Series/C200 Series Chipset Family PCI 
Express Root Port 5 (rev b4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=0d, subordinate=0d, sec-latency=0
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: f1400000-f1bfffff
        Prefetchable memory behind bridge: 00000000f0c00000-00000000f13fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #5, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
                        Slot #4, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range BC, TimeoutDis+, LTR-, OBFF 
Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
                Address: 00000000  Data: 0000
        Capabilities: [90] Subsystem: Lenovo Device 21db
        Capabilities: [a0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation 6 Series/C200 Series Chipset Family 
USB Enhanced Host Controller #1 (rev 04) (prog-if 20 [EHCI])
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at f2529000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation QM67 Express Chipset Family LPC 
Controller (rev 04)
        Subsystem: Lenovo Device 21db
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation 6 Series/C200 Series Chipset Family 
6 port SATA AHCI Controller (rev 04) (prog-if 01 [AHCI 1.0])
        Subsystem: Lenovo Device 21db
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 27
        Region 0: I/O ports at 50a8 [size=8]
        Region 1: I/O ports at 50bc [size=4]
        Region 2: I/O ports at 50a0 [size=8]
        Region 3: I/O ports at 50b8 [size=4]
        Region 4: I/O ports at 5060 [size=32]
        Region 5: Memory at f2528000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee00378  Data: 0000
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
        Capabilities: [b0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation 6 Series/C200 Series Chipset Family SMBus 
Controller (rev 04)
        Subsystem: Lenovo Device 21db
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 11$ dmesg ## after plugging in the 
expressCard adapter:
[  189.077601] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.077618] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 3
[  189.082972] xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100 
quirks 0x00000090
[  189.083409] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[  189.083415] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.083420] usb usb3: Product: xHCI Host Controller
[  189.083425] usb usb3: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.083429] usb usb3: SerialNumber: 0000:05:00.0
[  189.083941] hub 3-0:1.0: USB hub found
[  189.084014] hub 3-0:1.0: 2 ports detected
[  189.084279] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.084290] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 4
[  189.086591] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[  189.086601] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.086607] usb usb4: Product: xHCI Host Controller
[  189.086614] usb usb4: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.086620] usb usb4: SerialNumber: 0000:05:00.0
[  189.087119] hub 4-0:1.0: USB hub found
[  189.087200] hub 4-0:1.0: 2 ports detected

## upon unplugging adapter: no output!

## upon replugging adapter - no output!

$ dmesg ## after plugging in an usb mouse into a usb2.0 port:
[  268.176768] usb 1-1.2: new low-speed USB device number 6 using ehci-pci
[  268.274176] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  268.274187] usb 1-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  268.274192] usb 1-1.2: Product: Optical USB Mouse
[  268.274196] usb 1-1.2: Manufacturer: Logitech
[  268.278017] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0004/input/input22
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0

$ dmesg ## after unplugging the mouse from usb2.0 port:
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0
[  552.697465] usb 1-1.2: USB disconnect, device number 6

## plug in usb mouse into the usb3.0 port of expressCard adapter - no output 
in dmesg

## plug in usb3.0 external drive into another usb3.0 port of the expressCard 
adapter - no output in dmesg

$ dmesg ## after replug the mouse into usb2.0 port: 
[  700.633679] usb 1-1.2: new low-speed USB device number 7 using ehci-pci
[  700.731428] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  700.731439] usb 1-1.2: New USB device strings: Mfr=1, Product=2$ dmesg ## 
after plugging in the expressCard adapter:
[  189.077601] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.077618] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 3
[  189.082972] xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100 
quirks 0x00000090
[  189.083409] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[  189.083415] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.083420] usb usb3: Product: xHCI Host Controller
[  189.083425] usb usb3: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.083429] usb usb3: SerialNumber: 0000:05:00.0
[  189.083941] hub 3-0:1.0: USB hub found
[  189.084014] hub 3-0:1.0: 2 ports detected
[  189.084279] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.084290] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 4
[  189.086591] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[  189.086601] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.086607] usb usb4: Product: xHCI Host Controller
[  189.086614] usb usb4: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.086620] usb usb4: SerialNumber: 0000:05:00.0
[  189.087119] hub 4-0:1.0: USB hub found
[  189.087200] hub 4-0:1.0: 2 ports detected

## upon unplugging adapter: no output!

## upon replugging adapter - no output!

$ dmesg ## after plugging in an usb mouse into a usb2.0 port:
[  268.176768] usb 1-1.2: new low-speed USB device number 6 using ehci-pci
[  268.274176] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  268.274187] usb 1-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  268.274192] usb 1-1.2: Product: Optical USB Mouse
[  268.274196] usb 1-1.2: Manufacturer: Logitech
[  268.278017] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0004/input/input22
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0

$ dmesg ## after unplugging the mouse from usb2.0 port:
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0
[  552.697465] usb 1-1.2: USB disconnect, device number 6

## plug in usb mouse into the usb3.0 port of expressCard adapter - no output 
in dmesg

## plug in usb3.0 external drive into another usb3.0 port of the expressCard 
adapter - no output in dmesg

$ dmesg ## after replug the mouse into usb2.0 port: 
[  700.633679] usb 1-1.2: new low-speed USB device number 7 using ehci-pci
[  700.731428] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  700.731439] usb 1-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  700.731444] usb 1-1.2: Product: Optical USB Mouse
[  700.731447] usb 1-1.2: Manufacturer: Logitech
[  700.734939] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0005/input/input23
[  700.735276] hid-generic 0003:046D:C016.0005: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0, 
SerialNumber=0
[  700.731444] usb 1-1.2: Product: Optical USB Mouse
[  700.731447] usb 1-1.2: Manufacturer: Logitech
[  700.734939] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0005/input/input23
[  700.735276] hid-generic 0003:046D:C016.0005: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0
        Region 0: Memory at f2524000 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at efa0 [size=32]

03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6205 [Taylor 
Peak] (rev 34)
        Subsystem: Intel Corporation Centrino Advanced-N 6205 AGN
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 31
        Region 0: Memory at f2400000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee003f8  Data: 0000
        Capabilities: [e0] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, 
L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <32us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- 
ChkEn-
        Capabilities: [140 v1] Device Serial Number 8c-70-5a-ff-ff-24-1a-24
        Kernel driver in use: iwlwifi

05:00.0 USB controller: Renesas Technology Corp. uPD720202 USB 3.0 Host 
Controller (rev 02) (prog-if 30 [XHCI])
        Physical Slot: 1
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop+ ParErr+ 
Stepping+ SERR+ FastB2B+ DisINTx+
        Status: Cap+ 66MHz+ UDF+ FastB2B+ ParErr+ DEVSEL=?? >TAbort+ <TAbort+ 
<MAbort+ >SERR+ <PERR+ INTx+
        Latency: 0
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f1c00000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [90] MSI-X: Enable- Count=8 Masked-
                Vector table: BAR=0 offset=00001000
                PBA: BAR=0 offset=00001080
        Capabilities: [a0] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, 
OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- 
ChkEn-
        Capabilities: [150 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Kernel driver in use: xhci_hcd

0d:00.0 System peripheral: Ricoh Co Ltd MMC/SD Host Controller (rev 07) (prog-
if 01)
        Subsystem: Lenovo Device 21db
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f1400000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=2 PME-
        Capabilities: [80] Express (v1) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                        ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
                LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [800 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-
        Kernel driver in use: sdhci-pci



        
        
[7.6.] SCSI information 
$ cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: CT500BX100SSD1   Rev: MU01
  Type:   Direct-Access                    ANSI  SCSI revision: 05
  
  
  
[7.7.] Other information that might be relevant to the problem 

No idea what else might be relevant. Here is dmesg output when manipulating 
(inserting and detaching) the expressCard adapter and devices to it:

$ dmesg ## after plugging in the expressCard adapter:
[  189.077601] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.077618] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 3
[  189.082972] xhci_hcd 0000:05:00.0: hcc params 0x014051cf hci version 0x100 
quirks 0x00000090
[  189.083409] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002
[  189.083415] usb usb3: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.083420] usb usb3: Product: xHCI Host Controller
[  189.083425] usb usb3: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.083429] usb usb3: SerialNumber: 0000:05:00.0
[  189.083941] hub 3-0:1.0: USB hub found
[  189.084014] hub 3-0:1.0: 2 ports detected
[  189.084279] xhci_hcd 0000:05:00.0: xHCI Host Controller
[  189.084290] xhci_hcd 0000:05:00.0: new USB bus registered, assigned bus 
number 4
[  189.086591] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003
[  189.086601] usb usb4: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[  189.086607] usb usb4: Product: xHCI Host Controller
[  189.086614] usb usb4: Manufacturer: Linux 4.1.0-040100rc2-generic xhci-hcd
[  189.086620] usb usb4: SerialNumber: 0000:05:00.0
[  189.087119] hub 4-0:1.0: USB hub found
[  189.087200] hub 4-0:1.0: 2 ports detected

## upon unplugging adapter: no output!

## upon replugging adapter - no output!

$ dmesg ## after plugging in an usb mouse into a usb2.0 port:
[  268.176768] usb 1-1.2: new low-speed USB device number 6 using ehci-pci
[  268.274176] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  268.274187] usb 1-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  268.274192] usb 1-1.2: Product: Optical USB Mouse
[  268.274196] usb 1-1.2: Manufacturer: Logitech
[  268.278017] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0004/input/input22
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0

$ dmesg ## after unplugging the mouse from usb2.0 port:
[  268.278712] hid-generic 0003:046D:C016.0004: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0
[  552.697465] usb 1-1.2: USB disconnect, device number 6

## plug in usb mouse into the usb3.0 port of expressCard adapter - no output 
in dmesg

## plug in usb3.0 external drive into another usb3.0 port of the expressCard 
adapter - no output in dmesg

$ dmesg ## after replug the mouse into usb2.0 port: 
[  700.633679] usb 1-1.2: new low-speed USB device number 7 using ehci-pci
[  700.731428] usb 1-1.2: New USB device found, idVendor=046d, idProduct=c016
[  700.731439] usb 1-1.2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  700.731444] usb 1-1.2: Product: Optical USB Mouse
[  700.731447] usb 1-1.2: Manufacturer: Logitech
[  700.734939] input: Logitech Optical USB Mouse as 
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C016.0005/input/input23
[  700.735276] hid-generic 0003:046D:C016.0005: input,hidraw0: USB HID v1.10 
Mouse [Logitech Optical USB Mouse] on usb-0000:00:1a.0-1.2/input0


-- 

Donatas Glodenis
