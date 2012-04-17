Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:41439 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755690Ab2DQI4I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Apr 2012 04:56:08 -0400
Message-ID: <4F8D3024.8030203@fold.natur.cuni.cz>
Date: Tue, 17 Apr 2012 10:56:04 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: linux-pci@vger.kernel.org
Subject: Re: 3.2.11: PCI Express card cannot be re-detected withing cca 60sec
 timeframe
References: <4F6A483D.50702@fold.natur.cuni.cz> <CAE9FiQVnErU-cska4gpinyj-LOup-U+3vsEG2z_-7h6kyREYtw@mail.gmail.com> <4F6A5A53.305@fold.natur.cuni.cz> <CAE9FiQXP7fO9OGN557jdofFFiFj96wL--ZA8X3UPEJ6o9JLvBw@mail.gmail.com> <4F8BEB1D.9080903@fold.natur.cuni.cz> <CAE9FiQXoX3J6P_9Tun_XbkK3egvSeBZxAtC13HacFDO0fwmZaA@mail.gmail.com> <4F8C756B.3090009@fold.natur.cuni.cz> <CAE9FiQXF=6Nu38eP++tCr9MVF7RrXqDDraZZ5wBLu6RzBYVPkw@mail.gmail.com>
In-Reply-To: <CAE9FiQXF=6Nu38eP++tCr9MVF7RrXqDDraZZ5wBLu6RzBYVPkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yinghai,

  I forgot to answer one of you questions ... below.

Yinghai Lu wrote:
> On Mon, Apr 16, 2012 at 12:39 PM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
>> Yinghai Lu wrote:
>>> On Mon, Apr 16, 2012 at 2:49 AM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> Hi Yinghai,
>>>>
>>>> Yinghai Lu wrote:
>>>>> On Wed, Mar 21, 2012 at 3:46 PM, Martin Mokrejs
>>>>   I had some Ooopses with 3.4-rc2 but now I have tested 3.4-rc3. Still, linux
>>>> does NOT realize that I have removed an ExpressCard from the slot. It realizes
>>>> that only when I pluging the card back again. Actually, this is a case of a
>>>> NEC chipset base USB3.0 card.
>>>>
>>>>  In contrast, kernel DOES recognize that I unplugged a FireWire card from the
>>>> same slot.
>>>>
>>>>  This is a Dell Vostro 3550 laptop. Below is what syslog logged with my comment.
>>>> Empty lines between the log entries are inserted whe I either inserted or removed
>>>> a card. Probably a bit more will be in the attached dmesg file.
>>
>> [cut]
>>
>>> please check boot with pciehp.pciehp_debug=1
>>>
>>> also you could use tail -f /var/log/messages to get more timely outputs.
>>
>> I tried the third Express Card I do have here. It is probably the most interesting
>> to play with. ;) It plugs somehow weirdly into the slot. I somehow have to push it in
>> and a little bit pull out so that some mechanical lock catches the card. But, it allocated
>> resources only once, and in other cases the driver is somehow locked up. It could be
>> a driver issue but I think it is interesting information in this moment. Below I leave
>> always 3 empty lines to emphasize I was pulling out the card and after a while back in
>> (like in previous attempts). The output is just the one from dmesg, it is more detailed
>> then what is logged through syslogd.
>>
>>
>>
>>
>> [ 2784.573629] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2784.573631] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2784.573644] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2784.573669] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2785.580455] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
>> [ 2785.580464] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs
>> [ 2785.580470] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> 
> good, link can not be trained in 1s.
> 
>> [ 2788.317351] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2788.317360] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2788.317369] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 2788.317412] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2788.317570] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 2788.317572] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> 
> looks removal isr get delay too.
> 
>> [ 2788.799777] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2788.799779] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2788.799782] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2788.799802] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2789.804129] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7011
>> [ 2789.804399] pci 0000:11:00.0: [9710:9912] type 0 class 0x000700
>> [ 2789.804610] pci 0000:11:00.0: reg 10: [io  0x0000-0x0007]
>> [ 2789.804743] pci 0000:11:00.0: reg 14: [mem 0x00000000-0x00000fff]
>> [ 2789.805193] pci 0000:11:00.0: reg 24: [mem 0x00000000-0x00000fff]
>> [ 2789.805976] pci 0000:11:00.0: PME# supported from D3hot D3cold
>> [ 2789.806397] pci 0000:11:00.1: [9710:9912] type 0 class 0x000700
>> [ 2789.806618] pci 0000:11:00.1: reg 10: [io  0x0000-0x0007]
>> [ 2789.806802] pci 0000:11:00.1: reg 14: [mem 0x00000000-0x00000fff]
>> [ 2789.808796] pci 0000:11:00.1: reg 24: [mem 0x00000000-0x00000fff]
>> [ 2789.809452] pci 0000:11:00.1: PME# supported from D3hot D3cold
>> [ 2789.809800] pci 0000:11:00.2: [9710:9912] type 0 class 0x000701
>> [ 2789.809955] pci 0000:11:00.2: reg 10: [io  0x0000-0x0007]
>> [ 2789.810086] pci 0000:11:00.2: reg 14: [io  0x0000-0x0007]
>> [ 2789.810165] pci 0000:11:00.2: reg 18: [mem 0x00000000-0x00000fff]
>> [ 2789.810523] pci 0000:11:00.2: reg 24: [mem 0x00000000-0x00000fff]
>> [ 2789.811273] pci 0000:11:00.2: PME# supported from D3hot D3cold
>> [ 2789.864174] pci 0000:11:00.0: BAR 1: assigned [mem 0xf6c00000-0xf6c00fff]
>> [ 2789.864199] pci 0000:11:00.0: BAR 5: assigned [mem 0xf6c01000-0xf6c01fff]
>> [ 2789.864224] pci 0000:11:00.1: BAR 1: assigned [mem 0xf6c02000-0xf6c02fff]
>> [ 2789.864250] pci 0000:11:00.1: BAR 5: assigned [mem 0xf6c03000-0xf6c03fff]
>> [ 2789.864294] pci 0000:11:00.2: BAR 2: assigned [mem 0xf6c04000-0xf6c04fff]
>> [ 2789.864339] pci 0000:11:00.2: BAR 5: assigned [mem 0xf6c05000-0xf6c05fff]
>> [ 2789.864396] pci 0000:11:00.0: BAR 0: assigned [io  0xc000-0xc007]
>> [ 2789.864461] pci 0000:11:00.1: BAR 0: assigned [io  0xc008-0xc00f]
>> [ 2789.864535] pci 0000:11:00.2: BAR 0: assigned [io  0xc010-0xc017]
>> [ 2789.864614] pci 0000:11:00.2: BAR 1: assigned [io  0xc018-0xc01f]
>> [ 2789.864640] pcieport 0000:00:1c.7: PCI bridge to [bus 11-16]
>> [ 2789.864643] pcieport 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
>> [ 2789.864648] pcieport 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
>> [ 2789.864652] pcieport 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
>> [ 2789.864953] serial 0000:11:00.0: enabling device (0100 -> 0103)
>> [ 2789.910711] 0000:11:00.0: ttyS0 at I/O 0xc000 (irq = 19) is a ST16650V2
>> [ 2789.911900] serial 0000:11:00.1: enabling device (0100 -> 0103)
>> [ 2789.953869] 0000:11:00.1: ttyS1 at I/O 0xc008 (irq = 16) is a ST16650V2
>> [ 2790.018840] ppdev: user-space parallel port driver
>> [ 2790.020038] parport_serial 0000:11:00.2: enabling device (0100 -> 0103)
>> [ 2790.020647] parport0: PC-style at 0xc010 (0xc018), irq 17, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
>>
>>
>> [ 2839.728485] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2839.728494] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2839.728503] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 2839.728546] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2839.728710] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 2839.728712] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> 
> not delayed.
> 
>>
>>
>> [ 2859.890589] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2859.890602] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2859.890605] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2859.890631] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2860.897910] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
>> [ 2860.897919] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs
>> [ 2860.897925] pciehp 0000:00:1c.7:pcie04: Failed to check link status
> 
> link training failed again.
> 
>> [ 2860.907011] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2860.907019] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2860.907028] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 2860.907073] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2860.907209] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 2860.907211] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
> 
> removal isr get delayed.
> 
>> [ 2861.242654] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2861.242656] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2861.242669] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2861.242684] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2862.245893] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
>> [ 2862.245902] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs
>> [ 2862.245908] pciehp 0000:00:1c.7:pcie04: Failed to check link status
>>
>>
>> [ 2900.516939] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2900.516948] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2900.516957] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 2900.516999] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2900.517170] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 2900.517172] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
>>
>>
>> [ 2917.473608] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2917.473610] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2917.473624] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2917.473649] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2918.481860] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
>> [ 2918.481869] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs
>> [ 2918.481875] pciehp 0000:00:1c.7:pcie04: Failed to check link status
>>
>>
>> [ 2962.382234] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2962.382244] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2962.382253] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 2962.382283] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2962.382446] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 2962.382448] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
>> [ 2991.261907] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 2991.261920] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 2991.261923] pciehp 0000:00:1c.7:pcie04: Card present on Slot(7)
>> [ 2991.261943] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 2992.261621] pciehp 0000:00:1c.7:pcie04: pciehp_check_link_status: lnk_status = 7811
>> [ 2992.261630] pciehp 0000:00:1c.7:pcie04: Link Training Error occurs
>> [ 2992.261636] pciehp 0000:00:1c.7:pcie04: Failed to check link status
>>
>>
>> [ 3010.910120] pciehp 0000:00:1c.7:pcie04: pcie_isr: intr_loc 8
>> [ 3010.910129] pciehp 0000:00:1c.7:pcie04: Presence/Notify input change
>> [ 3010.910138] pciehp 0000:00:1c.7:pcie04: Card not present on Slot(7)
>> [ 3010.910180] pciehp 0000:00:1c.7:pcie04: Surprise Removal
>> [ 3010.910346] pciehp 0000:00:1c.7:pcie04: Disabling domain:bus:device=0000:11:00
>> [ 3010.910348] pciehp 0000:00:1c.7:pcie04: pciehp_unconfigure_device: domain:bus:dev = 0000:11:00
>>
> 
> You can try to set express card speed from Auto to Gen1 in your BIOS setup.

I can only Enable/Disable express card slot in BIOS. :(

