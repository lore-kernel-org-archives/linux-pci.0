Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34734 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932873AbcGENDe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2016 09:03:34 -0400
MIME-Version: 1.0
From: Abhishek Bhatia <abhigenie92@gmail.com>
Date: Tue, 5 Jul 2016 18:33:32 +0530
Message-ID: <CAKM9W1_yy5Sa9wns4pkS=9oV57s69A-jsem7d0tS49CEw4f_vA@mail.gmail.com>
Subject: PCI bus error on startup while booting
To: bhelgaas@google.com
Cc: "Christopher M. Penalver" <christopher.m.penalver@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please cc me on any communication I am not subscribed to the list

[1.] One line summary of the problem:
PCI bus error on startup while booting into login screen (Kubuntu 16.04)

[2.] Full description of the problem/report:
With a HP Pavilion Notebook - 15-ab549tx, and Kubuntu 16.04, the
problem is on startup error messages show up before the login screen
as per attached
screenshot:https://launchpadlibrarian.net/263296837/screenshot.jpg At
times it is just stops at this screen and doesn't move to the login
screen. Or while it shuts down it stops at this screen. WORKAROUND:
Adding kernel boot parameters: pci=nomsi pci=noaer stop the messages
from showing on startup, but it takes 2.5 minutes to boot.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
abhishek ~ $ cat /proc/version
Linux version 4.7.0-040700rc6-generic (kernel@gloin) (gcc version
5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1) ) #201607040332 SMP Mon Jul 4
07:34:26 UTC 2016

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)
abhishek log $ tail /var/log/syslog
Jul 5 11:23:37 hp kernel: [ 1221.858073] pcieport 0000:00:1c.5: device
[8086:9d15] error status/mask=00000001/00002000
Jul 5 11:23:37 hp kernel: [ 1221.858078] pcieport 0000:00:1c.5: [ 0]
Receiver Error
Jul 5 11:23:42 hp kernel: [ 1226.862318] pcieport 0000:00:1c.5: AER:
Corrected error received: id=00e5
Jul 5 11:23:42 hp kernel: [ 1226.862341] pcieport 0000:00:1c.5: PCIe
Bus Error: severity=Corrected, type=Physical Layer, id=00e5(Receiver
ID)
Jul 5 11:23:42 hp kernel: [ 1226.862352] pcieport 0000:00:1c.5: device
[8086:9d15] error status/mask=00000001/00002000
Jul 5 11:23:42 hp kernel: [ 1226.862360] pcieport 0000:00:1c.5: [ 0]
Receiver Error
Jul 5 11:23:47 hp kernel: [ 1231.854458] pcieport 0000:00:1c.5: AER:
Corrected error received: id=00e5
Jul 5 11:23:47 hp kernel: [ 1231.854482] pcieport 0000:00:1c.5: PCIe
Bus Error: severity=Corrected, type=Physical Layer, id=00e5(Receiver
ID)
Jul 5 11:23:47 hp kernel: [ 1231.854493] pcieport 0000:00:1c.5: device
[8086:9d15] error status/mask=00000001/00002000
Jul 5 11:23:47 hp kernel: [ 1231.854500] pcieport 0000:00:1c.5: [ 0]
Receiver Error (First)

[7.] Environment
abhishek ~ $ lsb_release -rd
Description:    Ubuntu 16.04 LTS
Release:        16.04


[7.1.] Software (add the output of the ver_linux script here)
abhishek scripts $ sh ver_linux
If some fields are empty or look unusual you may have an old versi
on.
Compare to the current minimal requirements in Documentation/Chang
es.

Linux hp 4.7.0-040700rc6-generic #201607040332 SMP Mon Jul 4 07:34
:26 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C                   5.3.1
GNU Make                4.1
Binutils                2.26
Util-linux              2.27.1
Mount                   2.27.1
Module-init-tools       22
E2fsprogs               1.42.13
Pcmciautils             018
Quota-tools             4.03
PPP                     2.4.7
Linux C Library         2.23
Dynamic linker (ldd)    2.23
Linux C++ Library       6.0.21
Procps                  3.3.10
Net-tools               1.60
Kbd                     1.15.5
Console-tools           1.15.5
Sh-utils                8.25
Udev                    229
Wireless-tools          30
Modules Loaded          ablk_helper ac acpi_pad acpi_thermal_rel a
esni_intel aes_x86_64 ahci ansi_cprng arc4 autofs4 battery binfmt_
misc bluetooth bnep btbcm btcoexist btintel btrtl btusb button ccm
cdrom cfg80211 coretemp crc16 crc32c_intel crc32_pclmul crct10dif
_pclmul cryptd ctr drbg drm drm_kms_helper dw_dmac_core efi_pstore
efivarfs efivars evdev ext4 fat fjes gf128mul ghash_clmulni_intel
glue_helper hid hid_generic hmac hp_accel hp_wireless hp_wmi i2c_
algo_bit i915 input_polldev int3400_thermal int3403_thermal int340
x_thermal_zone intel_cstate intel_pch_thermal intel_powerclamp int
el_rapl intel_soc_dts_iosf irqbypass jbd2 joydev kvm kvm_intel lib
ahci libata lis3lv02d lp lrw mac80211 mbcache media mei mei_me mem
stick mfd_core mii mmc_core msr nls_cp437 nls_utf8 nvram parport p
arport_pc ppdev processor_thermal_device psmouse r8169 rfcomm rfki
ll rtl8723be rtl8723_common rtl_pci rtlwifi rtsx_pci rtsx_pci_ms r
tsx_pci_sdmmc scsi_mod sd_mod serio_raw sg shpchp snd snd_compress
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_co
dec_realtek snd_hda_core snd_hda_ext_core snd_hda_intel snd_hwdep
snd_pcm snd_rawmidi snd_seq snd_seq_device snd_seq_midi snd_seq_mi
di_event snd_soc_core snd_soc_skl snd_soc_skl_ipc snd_soc_sst_dsp
snd_soc_sst_ipc snd_soc_sst_match snd_timer soundcore sparse_keyma
p sr_mod thermal tpm tpm_crb tpm_tis usb_common usbcore usbhid uvc
video vfat video videobuf2_core videobuf2_memops videobuf2_v4l2 vi
deobuf2_vmalloc videodev wmi x86_pkg_temp_thermal xhci_hcd xhci_pc
i

[7.2.] Processor information (from /proc/cpuinfo):

abhishek scripts $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
stepping        : 3
microcode       : 0x88
cpu MHz         : 1621.508
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht t
m pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon p
ebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pn
i pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16
xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_time
r aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 av
x2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt
xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_wind
ow hwp_epp
bugs            :
bogomips        : 5183.89
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
stepping        : 3
microcode       : 0x88
cpu MHz         : 2664.587
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht t
m pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon p
ebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pn
i pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16
xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_time
r aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 av
x2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt
xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_wind
ow hwp_epp
bugs            :
bogomips        : 5185.09
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
stepping        : 3
microcode       : 0x88
cpu MHz         : 2336.254
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht t
m pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon p
ebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pn
i pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16
xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_time
r aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 av
x2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt
xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_wind
ow hwp_epp
bugs            :
bogomips        : 5185.41
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 78
model name      : Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
stepping        : 3
microcode       : 0x88
cpu MHz         : 2760.278
cache size      : 4096 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 22
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr
pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht t
m pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon p
ebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pn
i pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 sdbg fma cx16
xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_time
r aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 av
x2 smep bmi2 erms invpcid mpx rdseed adx smap clflushopt xsaveopt
xsavec xgetbv1 dtherm ida arat pln pts hwp hwp_notify hwp_act_wind
ow hwp_epp
bugs            :
bogomips        : 5185.13
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

[7.3.] Module information (from /proc/modules):
abhishek ~ $ cat /proc/modules
rfcomm 69632 14 - Live 0x0000000000000000
ctr 16384 0 - Live 0x0000000000000000
ccm 20480 0 - Live 0x0000000000000000
bnep 20480 2 - Live 0x0000000000000000
binfmt_misc 20480 1 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 36864 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
videodev 167936 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live
0x0000000000000000
media 32768 2 uvcvideo,videodev, Live 0x0000000000000000
x86_pkg_temp_thermal 16384 0 - Live 0x0000000000000000
intel_powerclamp 16384 0 - Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
kvm_intel 188416 0 - Live 0x0000000000000000
snd_soc_skl 57344 0 - Live 0x0000000000000000
snd_soc_skl_ipc 36864 1 snd_soc_skl, Live 0x0000000000000000
kvm 565248 1 kvm_intel, Live 0x0000000000000000
snd_soc_sst_ipc 16384 1 snd_soc_skl_ipc, Live 0x0000000000000000
snd_soc_sst_dsp 40960 1 snd_soc_skl_ipc, Live 0x0000000000000000
snd_hda_ext_core 28672 1 snd_soc_skl, Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
snd_soc_sst_match 16384 1 snd_soc_skl, Live 0x0000000000000000
snd_soc_core 188416 1 snd_soc_skl, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
snd_compress 20480 1 snd_soc_core, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
hmac 16384 1 - Live 0x0000000000000000
bluetooth 516096 41 rfcomm,bnep,btusb,btrtl,btbcm,btintel, Live
0x0000000000000000
dw_dmac_core 24576 1 snd_soc_sst_dsp, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
rtl8723be 90112 0 - Live 0x0000000000000000
snd_hda_intel 36864 3 - Live 0x0000000000000000
snd_hda_codec 131072 4
snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,
Live 0x0000000000000000
snd_hda_core 81920 7
snd_hda_codec_hdmi,snd_soc_skl,snd_hda_ext_core,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,
Live 0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
drbg 24576 1 - Live 0x0000000000000000
ansi_cprng 16384 0 - Live 0x0000000000000000
nvram 16384 0 - Live 0x0000000000000000
btcoexist 53248 1 rtl8723be, Live 0x0000000000000000
rtl8723_common 24576 1 rtl8723be, Live 0x0000000000000000
rtl_pci 28672 1 rtl8723be, Live 0x0000000000000000
rtlwifi 73728 2 rtl8723be,rtl_pci, Live 0x0000000000000000
mac80211 634880 3 rtl8723be,rtl_pci,rtlwifi, Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
cfg80211 569344 2 rtlwifi,mac80211, Live 0x0000000000000000
snd_pcm 106496 7
snd_hda_codec_hdmi,snd_soc_skl,snd_hda_ext_core,snd_soc_core,snd_hda_intel,snd_hda_codec,snd_hda_core,
Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
msr 16384 0 - Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
hp_wmi 16384 0 - Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
sparse_keymap 16384 1 hp_wmi, Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
cryptd 20480 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
rfkill 24576 7 bluetooth,cfg80211,hp_wmi, Live 0x0000000000000000
snd_seq_midi 16384 0 - Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
snd_seq_midi_event 16384 1 snd_seq_midi, Live 0x0000000000000000
intel_cstate 16384 0 - Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
intel_rapl 16384 0 - Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
snd_rawmidi 32768 1 snd_seq_midi, Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
snd_seq 65536 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
snd_seq_device 16384 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x0000000000000000
snd_timer 32768 2 snd_pcm,snd_seq, Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
snd 81920 19 snd_hda_codec_hdmi,snd_soc_core,snd_compress,snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer,
Live 0x0000000000000000
tpm_crb 16384 0 - Live 0x0000000000000000
hp_wireless 16384 0 - Live 0x0000000000000000
wmi 16384 1 hp_wmi, Live 0x0000000000000000
evdev 24576 32 - Live 0x0000000000000000
tpm_tis 20480 0 - Live 0x0000000000000000
int3403_thermal 16384 0 - Live 0x0000000000000000
processor_thermal_device 16384 0 - Live 0x0000000000000000
int340x_thermal_zone 16384 2 int3403_thermal,processor_thermal_device,
Live 0x0000000000000000
intel_soc_dts_iosf 16384 1 processor_thermal_device, Live 0x0000000000000000
int3400_thermal 16384 0 - Live 0x0000000000000000
acpi_pad 24576 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
intel_pch_thermal 16384 0 - Live 0x0000000000000000
mei_me 32768 0 - Live 0x0000000000000000
tpm 45056 2 tpm_crb,tpm_tis, Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
mei 94208 1 mei_me, Live 0x0000000000000000
parport_pc 28672 0 - Live 0x0000000000000000
ppdev 20480 0 - Live 0x0000000000000000
lp 20480 0 - Live 0x0000000000000000
parport 45056 3 parport_pc,ppdev,lp, Live 0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 1 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 106496 1 ext4, Live 0x0000000000000000
mbcache 16384 2 ext4, Live 0x0000000000000000
sr_mod 24576 0 - Live 0x0000000000000000
cdrom 57344 1 sr_mod, Live 0x0000000000000000
sd_mod 45056 4 - Live 0x0000000000000000
hid_generic 16384 0 - Live 0x0000000000000000
usbhid 49152 0 - Live 0x0000000000000000
hid 114688 2 hid_generic,usbhid, Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
mmc_core 131072 1 rtsx_pci_sdmmc, Live 0x0000000000000000
i915 1277952 15 - Live 0x0000000000000000
i2c_algo_bit 16384 1 i915, Live 0x0000000000000000
drm_kms_helper 143360 1 i915, Live 0x0000000000000000
crc32c_intel 24576 0 - Live 0x0000000000000000
drm 352256 16 i915,drm_kms_helper, Live 0x0000000000000000
psmouse 126976 0 - Live 0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
xhci_hcd 172032 1 xhci_pci, Live 0x0000000000000000
libata 241664 2 ahci,libahci, Live 0x0000000000000000
mii 16384 1 r8169, Live 0x0000000000000000
usbcore 237568 5 uvcvideo,btusb,usbhid,xhci_pci,xhci_hcd, Live
0x0000000000000000
rtsx_pci 53248 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
scsi_mod 225280 4 sg,sr_mod,sd_mod,libata, Live 0x0000000000000000
mfd_core 16384 1 rtsx_pci, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
video 40960 1 i915, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
button 16384 1 i915, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
abhishek ~ $ cat /proc/ioports
0000-0000 : PCI Bus 0000:00
 0000-0000 : dma1
 0000-0000 : pic1
 0000-0000 : timer0
 0000-0000 : timer1
 0000-0000 : keyboard
 0000-0000 : PNP0C09:00
   0000-0000 : EC data
 0000-0000 : keyboard
 0000-0000 : PNP0C09:00
   0000-0000 : EC cmd
 0000-0000 : rtc0
 0000-0000 : dma page reg
 0000-0000 : pic2
 0000-0000 : dma2
 0000-0000 : fpu
 0000-0000 : pnp 00:02
 0000-0000 : pnp 00:02
 0000-0000 : pnp 00:02
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
 0000-0000 : pnp 00:02
 0000-0000 : pnp 00:02
   0000-0000 : ACPI PM1a_EVT_BLK
   0000-0000 : ACPI PM1a_CNT_BLK
   0000-0000 : ACPI PM_TMR
   0000-0000 : ACPI CPU throttle
   0000-0000 : ACPI PM2_CNT_BLK
   0000-0000 : ACPI GPE0_BLK
 0000-0000 : pnp 00:01
 0000-0000 : PCI Bus 0000:04
   0000-0000 : 0000:04:00.0
     0000-0000 : r8169
 0000-0000 : PCI Bus 0000:03
   0000-0000 : 0000:03:00.0
     0000-0000 : rtl_pci
 0000-0000 : PCI Bus 0000:01
   0000-0000 : 0000:01:00.0
 0000-0000 : 0000:00:02.0
 0000-0000 : 0000:00:1f.4
 0000-0000 : 0000:00:17.0
   0000-0000 : ahci
 0000-0000 : 0000:00:17.0
   0000-0000 : ahci
 0000-0000 : 0000:00:17.0
   0000-0000 : ahci
 0000-0000 : PCI Bus 0000:02
 0000-0000 : pnp 00:02
   0000-0000 : pnp 00:02
     0000-0000 : pnp 00:02
abhishek ~ $ cat /proc/iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : System ROM
00000000-00000000 : System RAM
 00000000-00000000 : Kernel code
 00000000-00000000 : Kernel data
 00000000-00000000 : Kernel bss
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : ACPI Tables
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : reserved
 00000000-00000000 : Graphics Stolen Memory
00000000-00000000 : PCI Bus 0000:00
 00000000-00000000 : pnp 00:06
 00000000-00000000 : PCI Bus 0000:02
 00000000-00000000 : PCI Bus 0000:01
   00000000-00000000 : 0000:01:00.0
   00000000-00000000 : 0000:01:00.0
 00000000-00000000 : 0000:00:02.0
 00000000-00000000 : PCI Bus 0000:01
   00000000-00000000 : 0000:01:00.0
 00000000-00000000 : PCI Bus 0000:04
   00000000-00000000 : 0000:04:00.0
     00000000-00000000 : r8169
   00000000-00000000 : 0000:04:00.0
     00000000-00000000 : r8169
 00000000-00000000 : PCI Bus 0000:03
   00000000-00000000 : 0000:03:00.0
     00000000-00000000 : rtl_pci
 00000000-00000000 : PCI Bus 0000:02
   00000000-00000000 : 0000:02:00.0
     00000000-00000000 : rtsx_pci
 00000000-00000000 : 0000:00:14.0
   00000000-00000000 : xhci-hcd
 00000000-00000000 : 0000:00:1f.3
   00000000-00000000 : ICH HD audio
 00000000-00000000 : 0000:00:04.0
 00000000-00000000 : 0000:00:1f.3
   00000000-00000000 : ICH HD audio
 00000000-00000000 : 0000:00:1f.2
 00000000-00000000 : 0000:00:17.0
   00000000-00000000 : ahci
 00000000-00000000 : 0000:00:14.2
   00000000-00000000 : Intel PCH thermal driver
 00000000-00000000 : 0000:00:16.0
   00000000-00000000 : mei_me
 00000000-00000000 : 0000:00:17.0
   00000000-00000000 : ahci
 00000000-00000000 : 0000:00:1f.4
 00000000-00000000 : 0000:00:17.0
   00000000-00000000 : ahci
 00000000-00000000 : 0000:00:02.0
   00000000-00000000 : BOOTFB
00000000-00000000 : PCI MMCONFIG 0000 [bus 00-ff]
 00000000-00000000 : reserved
   00000000-00000000 : pnp 00:06
00000000-00000000 : reserved
 00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:00
00000000-00000000 : reserved
00000000-00000000 : reserved
 00000000-00000000 : IOAPIC 0
00000000-00000000 : reserved
 00000000-00000000 : HPET 0
   00000000-00000000 : PNP0103:00
00000000-00000000 : reserved
 00000000-00000000 : pnp 00:06
 00000000-00000000 : pnp 00:06
 00000000-00000000 : pnp 00:06
00000000-00000000 : pnp 00:06
00000000-00000000 : reserved
00000000-00000000 : dmar0
00000000-00000000 : dmar1
00000000-00000000 : Local APIC
 00000000-00000000 : reserved
00000000-00000000 : INT0800:00
 00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer

[7.5.] PCI information ('lspci -vvv' as root)
http://paste.ubuntu.com/18535755/

[7.6.] SCSI information (from /proc/scsi/scsi)
abhishek ~ $ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):
abhishek ~ $ ls /proc
1      119    1450   15536  1821   2005   223    27     35   649
7975  960          fs           pagetypeinfo
10     12     1451   1564   1858   2018   2237   2790   36   66    798
  9714         interrupts   partitions
1009   120    1454   15810  1882   2038   224    28     38   7     8
  978          iomem        sched_debug
1021   121    14547  15812  1894   2058   2241   2804   39   7021  800
  988          ioports      self
103    122    14569  16     19     2061   2242   290    40   7089  802
  994          irq          slabinfo
104    123    1464   1603   19084  208    2243   29497  41   7110  829
  acpi         kallsyms     softirqs
1042   1239   1485   1604   1913   2087   2256   29800  42   7112  831
  asound       kcore        stat
1045   127    14864  16083  19190  20873  2273   29827  43   7141  832
  buddyinfo    keys         swaps
1046   13     1487   1611   1927   21     2277   3      46   7148  834
  bus          key-users    sys
1049   131    1489   1613   1933   21175  2282   30     464  7174  835
  cgroups      kmsg         sysrq-trigger
1082   132    1490   1615   1937   2127   2364   30939  47   7190  839
  cmdline      kpagecgroup  sysvipc
10908  138    1496   16174  1953   2129   24     30942  48   72    841
  consoles     kpagecount   thread-self
11     14     15     1621   1956   21707  24117  31     49   7200  843
  cpuinfo      kpageflags   timer_list
110    141    1500   1629   1970   2171   24877  31327  5    7261  848
  crypto       loadavg      timer_stats
1135   14162  1502   1650   1973   22     2493   32     523  7264  854
  devices      locks        tty
1142   1426   1506   1656   1974   222    25     32031  552  7266  858
  diskstats    meminfo      uptime
1143   1427   1517   1718   1983   2223   25264  32676  64   7268  862
  dma          misc         version
1147   1428   1523   1729   1986   2224   253    32742  643  7270  9
  driver       modules      vmallocinfo
1150   1430   1528   17491  1992   2225   26     33     644  7273
9143  execdomains  mounts       vmstat
1151   1437   1530   18     2      2226   26022  34     645  7308  941
  fb           mtrr         zoneinfo
118    1449   1531   1800   20     2229   261    348    647  797   956
  filesystems  net


[X.] Other notes, patches, fixes, workarounds:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1588428/
