Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:37835 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753366Ab2DPTpL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Apr 2012 15:45:11 -0400
Message-ID: <4F8C76C3.1040705@fold.natur.cuni.cz>
Date: Mon, 16 Apr 2012 21:45:07 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec
 timeframe
References: <4F6A483D.50702@fold.natur.cuni.cz> <CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com> <4F6A5A53.305@fold.natur.cuni.cz> <CAE9FiQXP7fO9OGN557jdofFFiFj96wL--ZA8X3UPEJ6o9JLvBw@mail.gmail.com> <4F8BEB1D.9080903@fold.natur.cuni.cz> <CAE9FiQXoX3J6P_9Tun_XbkK3egvSeBZxAtC13HacFDO0fwmZaA@mail.gmail.com> <4F8C756B.3090009@fold.natur.cuni.cz>
In-Reply-To: <4F8C756B.3090009@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



Martin Mokrejs wrote:
> Yinghai Lu wrote:
>> On Mon, Apr 16, 2012 at 2:49 AM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>> Hi Yinghai,
>>>
>>> Yinghai Lu wrote:
>>>> On Wed, Mar 21, 2012 at 3:46 PM, Martin Mokrejs
>>>   I had some Ooopses with 3.4-rc2 but now I have tested 3.4-rc3. Still, linux
>>> does NOT realize that I have removed an ExpressCard from the slot. It realizes
>>> that only when I pluging the card back again. Actually, this is a case of a
>>> NEC chipset base USB3.0 card.
>>>
>>>  In contrast, kernel DOES recognize that I unplugged a FireWire card from the
>>> same slot.
>>>
>>>  This is a Dell Vostro 3550 laptop. Below is what syslog logged with my comment.
>>> Empty lines between the log entries are inserted whe I either inserted or removed
>>> a card. Probably a bit more will be in the attached dmesg file.
> 
> [cut]
> 
>> please check boot with pciehp.pciehp_debug=1
>>
>> also you could use tail -f /var/log/messages to get more timely outputs.
> 
> I tried the third Express Card I do have here. It is probably the most interesting
> to play with. ;) It plugs somehow weirdly into the slot. I somehow have to push it in
> and a little bit pull out so that some mechanical lock catches the card. But, it allocated
> resources only once, and in other cases the driver is somehow locked up. It could be
> a driver issue but I think it is interesting information in this moment. Below I leave
> always 3 empty lines to emphasize I was pulling out the card and after a while back in
> (like in previous attempts). The output is just the one from dmesg, it is more detailed
> then what is logged through syslogd.
> 
> 
> 
> 
> [ 2784.573629] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2784.573631] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2784.573644] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2784.573669] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2785.580455] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
> [ 2785.580464] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs 
> [ 2785.580470] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> [ 2788.317351] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2788.317360] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2788.317369] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 2788.317412] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2788.317570] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 2788.317572] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> [ 2788.799777] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2788.799779] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2788.799782] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2788.799802] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2789.804129] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
> [ 2789.804399] pci 0000:11:00.0: [9710:9912] type 0 class 0x000700
> [ 2789.804610] pci 0000:11:00.0: reg 10: [io  0x0000-0x0007]
> [ 2789.804743] pci 0000:11:00.0: reg 14: [mem 0x00000000-0x00000fff]
> [ 2789.805193] pci 0000:11:00.0: reg 24: [mem 0x00000000-0x00000fff]
> [ 2789.805976] pci 0000:11:00.0: PME# supported from D3hot D3cold
> [ 2789.806397] pci 0000:11:00.1: [9710:9912] type 0 class 0x000700
> [ 2789.806618] pci 0000:11:00.1: reg 10: [io  0x0000-0x0007]
> [ 2789.806802] pci 0000:11:00.1: reg 14: [mem 0x00000000-0x00000fff]
> [ 2789.808796] pci 0000:11:00.1: reg 24: [mem 0x00000000-0x00000fff]
> [ 2789.809452] pci 0000:11:00.1: PME# supported from D3hot D3cold
> [ 2789.809800] pci 0000:11:00.2: [9710:9912] type 0 class 0x000701
> [ 2789.809955] pci 0000:11:00.2: reg 10: [io  0x0000-0x0007]
> [ 2789.810086] pci 0000:11:00.2: reg 14: [io  0x0000-0x0007]
> [ 2789.810165] pci 0000:11:00.2: reg 18: [mem 0x00000000-0x00000fff]
> [ 2789.810523] pci 0000:11:00.2: reg 24: [mem 0x00000000-0x00000fff]
> [ 2789.811273] pci 0000:11:00.2: PME# supported from D3hot D3cold
> [ 2789.864174] pci 0000:11:00.0: BAR 1: assigned [mem 0xf6c00000-0xf6c00fff]
> [ 2789.864199] pci 0000:11:00.0: BAR 5: assigned [mem 0xf6c01000-0xf6c01fff]
> [ 2789.864224] pci 0000:11:00.1: BAR 1: assigned [mem 0xf6c02000-0xf6c02fff]
> [ 2789.864250] pci 0000:11:00.1: BAR 5: assigned [mem 0xf6c03000-0xf6c03fff]
> [ 2789.864294] pci 0000:11:00.2: BAR 2: assigned [mem 0xf6c04000-0xf6c04fff]
> [ 2789.864339] pci 0000:11:00.2: BAR 5: assigned [mem 0xf6c05000-0xf6c05fff]
> [ 2789.864396] pci 0000:11:00.0: BAR 0: assigned [io  0xc000-0xc007]
> [ 2789.864461] pci 0000:11:00.1: BAR 0: assigned [io  0xc008-0xc00f]
> [ 2789.864535] pci 0000:11:00.2: BAR 0: assigned [io  0xc010-0xc017]
> [ 2789.864614] pci 0000:11:00.2: BAR 1: assigned [io  0xc018-0xc01f]
> [ 2789.864640] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
> [ 2789.864643] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
> [ 2789.864648] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
> [ 2789.864652] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
> [ 2789.864953] serial 0000:11:00.0: enabling device (0100 -> 0103)
> [ 2789.910711] 0000:11:00.0: ttyS0 at I/O 0xc000 (irq = 19) is a ST16650V2
> [ 2789.911900] serial 0000:11:00.1: enabling device (0100 -> 0103)
> [ 2789.953869] 0000:11:00.1: ttyS1 at I/O 0xc008 (irq = 16) is a ST16650V2
> [ 2790.018840] ppdev: user-space parallel port driver
> [ 2790.020038] parport_serial 0000:11:00.2: enabling device (0100 -> 0103)
> [ 2790.020647] parport0: PC-style at 0xc010 (0xc018), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
> 
> 
> [ 2839.728485] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2839.728494] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2839.728503] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 2839.728546] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2839.728710] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 2839.728712] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> 
> 
> [ 2859.890589] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2859.890602] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2859.890605] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2859.890631] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2860.897910] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
> [ 2860.897919] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs 
> [ 2860.897925] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> [ 2860.907011] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2860.907019] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2860.907028] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 2860.907073] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2860.907209] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 2860.907211] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> [ 2861.242654] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2861.242656] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2861.242669] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2861.242684] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2862.245893] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
> [ 2862.245902] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs 
> [ 2862.245908] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> 
> 
> [ 2900.516939] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2900.516948] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2900.516957] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 2900.516999] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2900.517170] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 2900.517172] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> 
> 
> [ 2917.473608] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2917.473610] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2917.473624] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2917.473649] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2918.481860] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
> [ 2918.481869] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs 
> [ 2918.481875] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> 
> 
> [ 2962.382234] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2962.382244] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2962.382253] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 2962.382283] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2962.382446] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 2962.382448] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> [ 2991.261907] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 2991.261920] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 2991.261923] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
> [ 2991.261943] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 2992.261621] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
> [ 2992.261630] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs 
> [ 2992.261636] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> 
> 
> [ 3010.910120] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
> [ 3010.910129] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
> [ 3010.910138] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
> [ 3010.910180] pciehp 0000:00:1c.7:pcie04: Surprise Removal
> [ 3010.910346] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
> [ 3010.910348] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00


I have to add, that as I plugged in the card some 15 minutes later, I got all PCI resources.
The line "Apr 16 21:23:47" is actually "[ 3010.910138]" above.

Apr 16 21:23:47 vostro kernel: [ 3010.910138] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
Apr 16 21:38:06 vostro kernel: [ 3868.604844] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)

The time "Apr 16 21:38:06" corresponds to "[ 3868.604828]" right below:

[ 3868.604828] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
[ 3868.604840] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
[ 3868.604844] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
[ 3868.604869] pciehp 0000:00:1c.7:pcie04: Surprise Removal
[ 3869.610640] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
[ 3869.610824] pci 0000:11:00.0: [9710:9912] type 0 class 0x000700
[ 3869.611003] pci 0000:11:00.0: reg 10: [io  0x0000-0x0007]
[ 3869.611275] pci 0000:11:00.0: reg 14: [mem 0x00000000-0x00000fff]
[ 3869.611917] pci 0000:11:00.0: reg 24: [mem 0x00000000-0x00000fff]
[ 3869.612691] pci 0000:11:00.0: PME# supported from D3hot D3cold
[ 3869.613163] pci 0000:11:00.1: [9710:9912] type 0 class 0x000700
[ 3869.613280] pci 0000:11:00.1: reg 10: [io  0x0000-0x0007]
[ 3869.613406] pci 0000:11:00.1: reg 14: [mem 0x00000000-0x00000fff]
[ 3869.613800] pci 0000:11:00.1: reg 24: [mem 0x00000000-0x00000fff]
[ 3869.614502] pci 0000:11:00.1: PME# supported from D3hot D3cold
[ 3869.614952] pci 0000:11:00.2: [9710:9912] type 0 class 0x000701
[ 3869.615112] pci 0000:11:00.2: reg 10: [io  0x0000-0x0007]
[ 3869.615191] pci 0000:11:00.2: reg 14: [io  0x0000-0x0007]
[ 3869.615282] pci 0000:11:00.2: reg 18: [mem 0x00000000-0x00000fff]
[ 3869.615683] pci 0000:11:00.2: reg 24: [mem 0x00000000-0x00000fff]
[ 3869.616440] pci 0000:11:00.2: PME# supported from D3hot D3cold
[ 3869.670705] pci 0000:11:00.0: BAR 1: assigned [mem 0xf6c00000-0xf6c00fff]
[ 3869.670725] pci 0000:11:00.0: BAR 5: assigned [mem 0xf6c01000-0xf6c01fff]
[ 3869.670750] pci 0000:11:00.1: BAR 1: assigned [mem 0xf6c02000-0xf6c02fff]
[ 3869.670776] pci 0000:11:00.1: BAR 5: assigned [mem 0xf6c03000-0xf6c03fff]
[ 3869.670840] pci 0000:11:00.2: BAR 2: assigned [mem 0xf6c04000-0xf6c04fff]
[ 3869.670866] pci 0000:11:00.2: BAR 5: assigned [mem 0xf6c05000-0xf6c05fff]
[ 3869.670885] pci 0000:11:00.0: BAR 0: assigned [io  0xc000-0xc007]
[ 3869.670918] pci 0000:11:00.1: BAR 0: assigned [io  0xc008-0xc00f]
[ 3869.670956] pci 0000:11:00.2: BAR 0: assigned [io  0xc010-0xc017]
[ 3869.670988] pci 0000:11:00.2: BAR 1: assigned [io  0xc018-0xc01f]
[ 3869.671008] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
[ 3869.671011] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
[ 3869.671016] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
[ 3869.671021] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
[ 3869.671380] serial 0000:11:00.0: enabling device (0100 -> 0103)
[ 3869.716018] 0000:11:00.0: ttyS0 at I/O 0xc000 (irq = 19) is a ST16650V2
[ 3869.716672] serial 0000:11:00.1: enabling device (0100 -> 0103)
[ 3869.759172] 0000:11:00.1: ttyS1 at I/O 0xc008 (irq = 16) is a ST16650V2
[ 3869.759831] parport_serial 0000:11:00.2: enabling device (0100 -> 0103)
[ 3869.760568] parport0: PC-style at 0xc010 (0xc018), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]

> 
> The card is AXAGO ECA-SP (2xRS232 and 1xIEEE1234) used these drivers and should be based on MosChip9901 :
> 
> parport_serial          7071  0 
> ppdev                   5670  0 
> parport_pc             29557  1 parport_serial
> parport                32353  2 ppdev,parport_pc
> 
> 
> Interesting, some months ago I had to patch the kernel but now it is recognized
> by vanilla kernel? I do not have compiled for this kernel the 99xx module yet.
> Hmm?
> 
> # ls -la Axago_drivers_CDROM_v1.09/ECA-Px_Sx/Linux/MCS99XX_NonCascade/
> total 1052
> dr-xr-xr-x 3 root root   4096 Feb 12 23:20 .
> dr-xr-xr-x 4 root root   4096 Oct  8  2011 ..
> -rw-r--r-- 1 root root    394 Feb 12 23:20 .99xx.ko.cmd
> -rw-r--r-- 1 root root  23665 Feb 12 23:20 .99xx.mod.o.cmd
> -rw-r--r-- 1 root root  35989 Feb 12 23:20 .99xx.o.cmd
> drwxr-xr-x 2 root root   4096 Feb 12 23:20 .tmp_versions
> -r-xr-xr-x 1 root root  69578 Feb 24  2011 99xx.c
> -r-xr-xr-x 1 root root   5499 Feb 24  2011 99xx.h
> -rw-r--r-- 1 root root 431305 Feb 12 23:20 99xx.ko
> -rw-r--r-- 1 root root   2033 Feb 12 23:20 99xx.mod.c
> -rw-r--r-- 1 root root  54760 Feb 12 23:20 99xx.mod.o
> -rw-r--r-- 1 root root 378280 Feb 12 23:20 99xx.o
> -r-xr-xr-x 1 root root   1141 Mar  7  2011 99xx_ReleaseNotes
> -r-xr-xr-x 1 root root   1108 Feb  8 00:05 Makefile
> -r-xr-xr-x 1 root root   1045 Feb  8 00:04 Makefile.ori
> -rw-r--r-- 1 root root      0 Feb 12 23:20 Module.symvers
> -r-xr-xr-x 1 root root     88 Mar  8  2011 mcs99xx
> -rw-r--r-- 1 root root     82 Feb 12 23:20 modules.order
> -r-xr-xr-x 1 root root   2802 Feb 24  2011 readme
> -r-xr-xr-x 1 root root   2521 Feb 24  2011 testreport
> #
> 
> 
> http://izto.org/mcs9865/
> http://forums.gentoo.org/viewtopic-p-6949842.html
> 
> 
> 11:00.2 Parallel controller [0701]: NetMos Technology Device [9710:9912] (prog-if 03 [IEEE1284])
>         Subsystem: Device [a000:2000]
>         Physical Slot: 7
>         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin C routed to IRQ 17
>         Region 0: I/O ports at c010 [size=8]
>         Region 1: I/O ports at c018 [size=8]
>         Region 2: Memory at f6c04000 (32-bit, non-prefetchable) [size=4K]
>         Region 5: Memory at f6c05000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [78] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] Express (v1) Legacy Endpoint, MSI 00
>                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <1us, L1 <2us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Latency L0 <64ns, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM L0s Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr+ BadTLP- BadDLLP- Rollover+ Timeout+ NonFatalErr+
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- ChkEn-
>         Kernel driver in use: parport_serial
>         Kernel modules: parport_serial
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
