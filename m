Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:44617 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754187Ab3CaBvo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2013 21:51:44 -0400
Message-ID: <515796AC.7030101@fold.natur.cuni.cz>
Date: Sun, 31 Mar 2013 03:51:40 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: 3.7.10: acpiphp with pcie_aspm=off with eSATA SiI3132 under laptop-mode-tools
 1.62-r1
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
  I am also having hard time to keep up with the various patches and kernel versions.
I am rather starting a new thread here to ensure I won't mess up so far started threads.
I went to check something on vanilla 3.7.10 kernel with acpiphp and pcie_aspm=off
which I am quite happy with so far even when laptop-mode-tools are making some devices
to be suspended. The exception from the three express cards I have to play with was always,
puzzlingly enough, the eSATA card in conjuction with acpiphp and 3.7 kernel series.
>From the 3.8 series we learned that laptop-mode-tools merely caused the xHCI port being dead
and similarly, express card slot was dead because of a similar issue.
The 3.9-rc1 is again a different story, I will reply to Ying Huang through the proper thread
later. So, here we are talking just about 3.7.10.

 Because Ying Huang asked me for additional 3.9-rc1 tests to install back laptop-mode-tools
to test his second patch and I wanted to be sure they behave like before (uninstall kept
old config files on my laptop, which was good). I tested using the 3.7.10 the hot remove
of the cold-booted eSATA card, hotinsert, ...., as usually, under laptop-mode-tools running.

  Although I saw some of the stacktraces in the past now I realized there might be an ordering
issue. Sometimes, the sata_sil24 driver is not able to release some of the ataXX
(SATA) ports. Looks it happens first with the latter port but later even the *first* port is
a victim.

  Here is the normal, cold boot detection of the card based on SiI 3132 chip. You can see
the after 2 sec delay (if no disks are attached to the card) both ports are downed.
I thought around 3.2.x I reported that 2 seconds were not enough for re-negotiation
of the SATA speed and if I remember right it was increased to 5 seconds. Actually, that was
more about speed negotiation being decreased from 6Gbit to 3Gbit and 1.5Gbit but still, I
wonder whether the 2 second conflict with that 5 sec idea.

[   11.906994] ata7: SATA link down (SStatus 0 SControl 0)
[   13.993988] ata8: SATA link down (SStatus 0 SControl 0)
...
[   23.553753] r8169 0000:05:00.0 eth0: link down
[   30.928199] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_suspend: 0
[   30.928301] xhci_hcd 0000:0b:00.0: PME# enabled
[   30.928813] pcieport 0000:00:1c.0: PME# enabled
[   31.311526] microcode: CPU0 updated to revision 0x28, date = 2012-04-24
[   31.312268] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
[   31.312271] perf_event_intel: PEBS enabled due to microcode update

I ejected the cold booted card:

[   55.213507] sata_sil24 0000:11:00.0: PME# disabled
[   55.216967] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[   55.222541] pcieport 0000:00:1c.7: PME# enabled

Note that not only 11:00 is set to PME# disabled but also 1c.7. I hot inserted the eSATA
card into the slot but that was not picked up because the root port 1c.7 was suspended.
After I realized that I had manually disabled powersaving for all devices.

find  /sys/bus/pci/devices/*/power/ -name control | while read f; do echo on > $f; done

Due to the card being loaded in the slot while powersaving was disabled the
'config space was restored' for the root port 1c.7 on which 11:00 is bound. There were
no lines since [   55.222541], really.

So here is the result of the echo commands in the while loop:

[  297.931267] pcieport 0000:00:1c.0: PME# disabled
[  297.951047] pcieport 0000:00:1c.7: restoring config space at offset 0x1c (was 0x2000d0c0, writing 0xd0c0)
[  297.951221] pcieport 0000:00:1c.7: PME# disabled
[  297.971264] xhci_hcd 0000:0b:00.0: PME# disabled
[  297.971279] xhci_hcd 0000:0b:00.0: enabling bus mastering
[  297.971432] xhci_hcd 0000:0b:00.0: hcd_pci_runtime_resume: 0
[  297.972027] usb usb3: usb wakeup-resume
[  297.972031] usb usb3: usb auto-resume
[  297.972054] usb usb4: usb wakeup-resume
[  297.972056] usb usb4: usb auto-resume
[  297.990996] hub 3-0:1.0: hub_resume
[  297.991208] hub 4-0:1.0: hub_resume
[  297.991263] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  297.991271] hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000

Note that 11:00 should be in PME# disabled state already since [   55.213507] and
since I did the 'find ... | while ... echo' command then definitely since that
time should be in PME# disabled. And would laptop-mode-tools change it back it should
have been logged, right?

But the very first hot insert at [  307.787283] below does *not* start with a
11:00 PME# enabled ... ah that's a nonsense. There should be PME# disabled
associated with hot insert, and upon hotremove I should see PME# enabled.
But, what we see instead is that PME# disabled is logged after hot removal
and is:
  1. maybe just a bogus message?
  2. or actually a swapped text of the message
  3. or a flipped value somewhere?
  4. or could it be that no change happened at all? Because 11:00 should have been
     already in state with disabled powersaving.

But I bet on either a flipped value somewhere or flipped text of the message.


[  307.787283] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[  307.787328] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[  307.787360] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[  307.787381] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[  307.787422] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[  307.787551] pci 0000:11:00.0: supports D1 D2
[  307.808319] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[  307.808323] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[  307.808345] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[  307.808347] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[  307.808368] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[  307.808370] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[  307.808377] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[  307.809427] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  307.809650] sata_sil24 0000:11:00.0: enabling bus mastering
[  307.813734] scsi8 : sata_sil24
[  307.814641] scsi9 : sata_sil24
[  307.815261] ata9: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  307.815264] ata10: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  309.893352] ata9: SATA link down (SStatus 0 SControl 0)
[  311.980117] ata10: SATA link down (SStatus 0 SControl 0)
[  519.411922] sata_sil24 0000:11:00.0: PME# disabled
[  519.414103] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?


  It seems that that the PME# enbaled (although here says disabled) message should
appear *after* both SATA ports were put into "down" state *without* an error
(actually SStatus 0). Later below you will see that the PME# disabled sometimes
appears already after the *first* ataXX is downed. A serialization bug? Aside
from the fact I believe the message should have been PME# enabled, as I already
pointed. ;-)


 

Here is continuation of the dmesg output, I really did not omit a single line
since [  519.414103]:

[  596.337476] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[  596.337522] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[  596.337554] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[  596.337575] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[  596.337617] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[  596.337733] pci 0000:11:00.0: supports D1 D2
[  596.358105] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[  596.358109] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[  596.358132] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[  596.358134] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[  596.358155] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[  596.358157] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[  596.358164] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[  596.359299] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  596.359486] sata_sil24 0000:11:00.0: enabling bus mastering
[  596.363095] scsi10 : sata_sil24
[  596.363882] scsi11 : sata_sil24
[  596.364558] ata11: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  596.364562] ata12: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  598.443430] ata11: SATA link down (SStatus 0 SControl 0)
[  600.530316] ata12: SATA link down (SStatus 0 SControl 0)
[  604.984442] sata_sil24 0000:11:00.0: PME# disabled
[  604.986411] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?


  Still, I don't see any PME# enabled lines for the 11:00 device.
Why? Provided laptop-mode-tools are running maybe they put the device into PME# enable
and I only see PME# disable? But how come that it was NOT logged by kernel?
I propose to distinguish the PME# messages to clearly state whether the change
was requested by kernel driver or a userspace tool. Also, are they always logged
with same log level?


  A third issue is that when for some reason sata_sil24 put into "down" state either
of the two SATA ports with "(SStatus FFFFFFFF SControl FFFFFFFF)" error? something gets
stuck in pci path:

[  852.587677] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  852.587865] sata_sil24 0000:11:00.0: enabling bus mastering
[  852.591156] scsi16 : sata_sil24
[  852.591901] scsi17 : sata_sil24
[  852.592566] ata17: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  852.592570] ata18: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  854.671769] ata17: SATA link down (SStatus 0 SControl 0)
[  854.882213] sata_sil24 0000:11:00.0: PME# disabled
[  856.868527] ata18: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[  856.868605] ------------[ cut here ]------------
[  856.868611] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()
[  856.868612] Hardware name: Vostro 3550
[  856.868613] Modules linked in: i915 fbcon bitblit cfbfillrect softcursor cfbimgblt font i2c_algo_bit cfbcopyarea drm_kms_helper drm fb iwldvm fbdev iwlwifi sata_sil24
[  856.868625] Pid: 1664, comm: kworker/0:2 Not tainted 3.7.10-default #2
[  856.868626] Call Trace:
[  856.868632]  [<ffffffff81077a43>] warn_slowpath_common+0x7e/0x96
[  856.868634]  [<ffffffff81077a70>] warn_slowpath_null+0x15/0x17
[  856.868635]  [<ffffffff81340de4>] ata_host_detach+0x75/0xdb
[  856.868637]  [<ffffffff81340e62>] ata_pci_remove_one+0x18/0x1a
[  856.868640]  [<ffffffff81281c84>] pci_device_remove+0x38/0x8b
[  856.868643]  [<ffffffff81307a41>] __device_release_driver+0x81/0xd4
[  856.868645]  [<ffffffff81307ab4>] device_release_driver+0x20/0x2d
[  856.868647]  [<ffffffff813075ee>] bus_remove_device+0xef/0x103
[  856.868649]  [<ffffffff813052fe>] device_del+0x131/0x183
[  856.868651]  [<ffffffff8130535e>] device_unregister+0xe/0x1a
[  856.868653]  [<ffffffff8127d741>] pci_stop_bus_device+0x65/0x87
[  856.868655]  [<ffffffff8127d8af>] pci_stop_and_remove_bus_device+0xf/0x1c
[  856.868658]  [<ffffffff8128d516>] acpiphp_disable_slot+0x8f/0x17e
[  856.868660]  [<ffffffff8128c593>] ? get_slot_status+0x38/0x9b
[  856.868662]  [<ffffffff8128d63a>] acpiphp_check_bridge.isra.16+0x35/0xc6
[  856.868665]  [<ffffffff8128db5b>] _handle_hotplug_event_bridge+0x275/0x3de
[  856.868667]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[  856.868670]  [<ffffffff810b4944>] ? trace_hardirqs_on_caller+0x121/0x158
[  856.868672]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[  856.868673]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[  856.868675]  [<ffffffff8128d8e6>] ? _handle_hotplug_event_func+0x17f/0x17f
[  856.868677]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[  856.868679]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[  856.868681]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[  856.868683]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[  856.868687]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[  856.868689]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[  856.868690] ---[ end trace 03d1c1fcfbca273a ]---
[  856.869699] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?


Since now, some lock "thread?" is running in kernel and later the automatic lock
detector will complain (you will see later). Do not know if that is by incidence
or not but during subsequent hot removal the *first* SATA port will only be put
into "down" state (albeit with the same SStatus message) *and*, the second SATA
(ata20 in the below case) port does *not* appear in syslog anymore. But then,
how come PME# 'disabled' is printed before ata20 was handled?:

[  866.187404] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  866.187589] sata_sil24 0000:11:00.0: enabling bus mastering
[  866.190814] scsi18 : sata_sil24
[  866.192555] scsi19 : sata_sil24
[  866.193229] ata19: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  866.193233] ata20: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  867.533369] sata_sil24 0000:11:00.0: PME# disabled
[  869.519643] ata19: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[  869.519745] ------------[ cut here ]------------
[  869.519751] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()
...
[  869.520664] ------------[ cut here ]------------
[  869.520666] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()

  [ Now two same stacktraces with ata_host_detach() are printed.
    Why they are two I don't know. ]

That probably locks up also sata_sil24 driver now in a weird state (aside from
the pci drivers around [  604.986411] hanging already somewhere). Further hot inserts
and removals result in usually one stacktrace printed and sometimes with the *first*
SATA port of the *two* being put into "down" state with SState 0. Good. But the
*second* SATA port is not anymore in the dmesg output, never.

[  869.542279] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  869.542493] sata_sil24 0000:11:00.0: enabling bus mastering
[  869.546021] scsi20 : sata_sil24
[  869.547643] scsi21 : sata_sil24
[  869.550803] ata21: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  869.550814] ata22: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  871.636503] ata21: SATA link down (SStatus 0 SControl 0)
[  871.937076] sata_sil24 0000:11:00.0: PME# disabled
[  871.938194] ------------[ cut here ]------------
[  871.938199] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()

...

[  876.252472] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  876.252664] sata_sil24 0000:11:00.0: enabling bus mastering
[  876.255923] scsi22 : sata_sil24
[  876.259005] scsi23 : sata_sil24
[  876.260800] ata23: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  876.260805] ata24: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  878.346501] ata23: SATA link down (SStatus 0 SControl 0)
[  895.711406] sata_sil24 0000:11:00.0: PME# disabled
[  895.712506] ------------[ cut here ]------------
[  895.712510] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()

...

[  899.887223] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  899.887410] sata_sil24 0000:11:00.0: enabling bus mastering
[  899.890702] scsi24 : sata_sil24
[  899.892579] scsi25 : sata_sil24
[  899.893274] ata25: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  899.893278] ata26: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  901.971311] ata25: SATA link down (SStatus 0 SControl 0)
[  902.231682] sata_sil24 0000:11:00.0: PME# disabled
[  902.232899] ------------[ cut here ]------------
[  902.232904] WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()

...

Finally, the lock manager reports the background issue:

[ 1080.705063] INFO: task kworker/u:4:1616 blocked for more than 120 seconds.
[ 1080.705070] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705075] kworker/u:4     D ffffffff81ca46c0     0  1616      2 0x00000000
[ 1080.705088]  ffff88040b2b9c88 0000000000000046 0000000000000096 ffff88040b8f4d80
[ 1080.705098]  ffffffff815e48c1 ffff88040ba78000 ffff88040b2b9fd8 ffff88040b2b9fd8
[ 1080.705107]  0000000000011700 ffff88040ba78000 0000000000000292 ffff88040277c000
[ 1080.705118] Call Trace:
[ 1080.705140]  [<ffffffff815e48c1>] ? _raw_spin_unlock_irqrestore+0x3a/0x41
[ 1080.705142]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705146]  [<ffffffff8134a71e>] ata_port_wait_eh+0x6d/0xcb
[ 1080.705150]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705152]  [<ffffffff813463ae>] ata_port_probe+0x25/0x32
[ 1080.705154]  [<ffffffff813463eb>] async_port_probe+0x30/0x4d
[ 1080.705157]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705159]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705160]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705162]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705164]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705166]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705168]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705170]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705172]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705174]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705176] 2 locks held by kworker/u:4/1616:
[ 1080.705177]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705182]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705186] INFO: task kworker/u:5:1617 blocked for more than 120 seconds.
[ 1080.705186] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705187] kworker/u:5     D ffffffff81ca46c0     0  1617      2 0x00000000
[ 1080.705189]  ffff88040b2a5c98 0000000000000046 ffff88040b2a5cc0 ffffffff8191a3f0
[ 1080.705191]  ffff88040b2a5c58 ffff88040babdd00 ffff88040b2a5fd8 ffff88040b2a5fd8
[ 1080.705193]  0000000000011700 ffff88040babdd00 ffff88040b2a5c88 ffffffff8192fc60
[ 1080.705196] Call Trace:
[ 1080.705197]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705200]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705202]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705204]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705205]  [<ffffffff813463f3>] async_port_probe+0x38/0x4d
[ 1080.705207]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705209]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705210]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705212]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705214]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705215]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705217]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705219]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705221]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705223]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705224] 2 locks held by kworker/u:5/1617:
[ 1080.705225]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705228]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705243] INFO: task kworker/u:0:4134 blocked for more than 120 seconds.
[ 1080.705244] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705244] kworker/u:0     D ffffffff81ca46c0     0  4134      2 0x00000000
[ 1080.705247]  ffff880406d67c98 0000000000000046 ffff880406d67cc0 ffff880407f72e80
[ 1080.705249]  ffff880406d67c58 ffff880407f70000 ffff880406d67fd8 ffff880406d67fd8
[ 1080.705251]  0000000000011700 ffff880407f70000 ffff880406d67c88 ffffffff8192fc60
[ 1080.705253] Call Trace:
[ 1080.705255]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705257]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705259]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705261]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705263]  [<ffffffff813463e3>] async_port_probe+0x28/0x4d
[ 1080.705265]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705266]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705268]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705269]  [<ffffffff815e2e82>] ? mutex_unlock+0x9/0xb
[ 1080.705271]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705273]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705274]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705276]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705278]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705280]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705282]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705283] 2 locks held by kworker/u:0/4134:
[ 1080.705283]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705286]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705290] INFO: task kworker/u:1:4195 blocked for more than 120 seconds.
[ 1080.705291] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705291] kworker/u:1     D ffffffff81ca46c0     0  4195      2 0x00000000
[ 1080.705293]  ffff880406d63c98 0000000000000046 ffff880406d63cc0 ffff88040b8f4d80
[ 1080.705295]  ffff880406d63c58 ffff880407f75d00 ffff880406d63fd8 ffff880406d63fd8
[ 1080.705297]  0000000000011700 ffff880407f75d00 ffff880406d63c88 ffffffff8192fc60
[ 1080.705299] Call Trace:
[ 1080.705301]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705303]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705305]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705307]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705308]  [<ffffffff813463e3>] async_port_probe+0x28/0x4d
[ 1080.705310]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705311]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705313]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705315]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705316]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705318]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705319]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705321]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705323]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705325]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705326] 2 locks held by kworker/u:1/4195:
[ 1080.705327]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705329]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705333] INFO: task kworker/u:2:4256 blocked for more than 120 seconds.
[ 1080.705334] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705334] kworker/u:2     D ffffffff81ca46c0     0  4256      2 0x00000000
[ 1080.705336]  ffff8804033e1c98 0000000000000046 ffff8804033e1cc0 ffffffff8191a3f0
[ 1080.705338]  ffff8804033e1c58 ffff88040cffae80 ffff8804033e1fd8 ffff8804033e1fd8
[ 1080.705340]  0000000000011700 ffff88040cffae80 ffff8804033e1c88 ffffffff8192fc60
[ 1080.705342] Call Trace:
[ 1080.705344]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705346]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705348]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705350]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705351]  [<ffffffff813463f3>] async_port_probe+0x38/0x4d
[ 1080.705353]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705354]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705356]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705358]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705359]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705361]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705363]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705365]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705366]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705368]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705369] 2 locks held by kworker/u:2/4256:
[ 1080.705370]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705373]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705376] INFO: task kworker/u:3:4265 blocked for more than 120 seconds.
[ 1080.705377] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705378] kworker/u:3     D ffffffff81ca46c0     0  4265      2 0x00000000
[ 1080.705379]  ffff880406d4fc98 0000000000000046 ffff880406d4fcc0 ffff880402732e80
[ 1080.705381]  ffff880406d4fc58 ffff880407f72e80 ffff880406d4ffd8 ffff880406d4ffd8
[ 1080.705383]  0000000000011700 ffff880407f72e80 ffff880406d4fc88 ffffffff8192fc60
[ 1080.705385] Call Trace:
[ 1080.705387]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705389]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705391]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705393]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705394]  [<ffffffff813463e3>] async_port_probe+0x28/0x4d
[ 1080.705396]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705398]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705399]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705401]  [<ffffffff815e2e82>] ? mutex_unlock+0x9/0xb
[ 1080.705403]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705404]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705406]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705408]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705410]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705411]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705413]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705414] 2 locks held by kworker/u:3/4265:
[ 1080.705415]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705418]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705421] INFO: task kworker/u:6:4266 blocked for more than 120 seconds.
[ 1080.705422] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705422] kworker/u:6     D ffffffff81ca46c0     0  4266      2 0x00000000
[ 1080.705424]  ffff880407eb1c98 0000000000000046 ffff880407eb1cc0 ffffffff8191a3f0
[ 1080.705426]  ffff880407eb1c58 ffff880407f71f00 ffff880407eb1fd8 ffff880407eb1fd8
[ 1080.705428]  0000000000011700 ffff880407f71f00 ffff880407eb1c88 ffffffff8192fc60
[ 1080.705430] Call Trace:
[ 1080.705432]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705434]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705436]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705438]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705439]  [<ffffffff813463f3>] async_port_probe+0x38/0x4d
[ 1080.705441]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705442]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705444]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705446]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705447]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705449]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705450]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705452]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705454]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705456]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705457] 2 locks held by kworker/u:6/4266:
[ 1080.705458]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705461]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705464] INFO: task kworker/u:7:4278 blocked for more than 120 seconds.
[ 1080.705465] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705465] kworker/u:7     D ffffffff81ca46c0     0  4278      2 0x00000000
[ 1080.705467]  ffff880407d9fc98 0000000000000046 ffff880407d9fcc0 ffff88040babec80
[ 1080.705469]  ffff880407d9fc58 ffff88040cf7dd00 ffff880407d9ffd8 ffff880407d9ffd8
[ 1080.705471]  0000000000011700 ffff88040cf7dd00 ffff880407d9fc88 ffffffff8192fc60
[ 1080.705473] Call Trace:
[ 1080.705475]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705477]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705479]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705481]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705482]  [<ffffffff813463e3>] async_port_probe+0x28/0x4d
[ 1080.705484]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705486]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705487]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705489]  [<ffffffff815e2e82>] ? mutex_unlock+0x9/0xb
[ 1080.705490]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705492]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705493]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705495]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705497]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705499]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705501]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705502] 2 locks held by kworker/u:7/4278:
[ 1080.705502]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705505]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705509] INFO: task kworker/u:8:4279 blocked for more than 120 seconds.
[ 1080.705509] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705510] kworker/u:8     D ffffffff81ca46c0     0  4279      2 0x00000000
[ 1080.705512]  ffff880404cc7c98 0000000000000046 ffff880404cc7cc0 ffffffff8191a3f0
[ 1080.705514]  ffff880404cc7c58 ffff88040cfacd80 ffff880404cc7fd8 ffff880404cc7fd8
[ 1080.705516]  0000000000011700 ffff88040cfacd80 ffff880404cc7c88 ffffffff8192fc60
[ 1080.705518] Call Trace:
[ 1080.705520]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705522]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705524]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705526]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705527]  [<ffffffff813463f3>] async_port_probe+0x38/0x4d
[ 1080.705529]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705530]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705532]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705534]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705535]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705537]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705538]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705540]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705542]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705544]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705545] 2 locks held by kworker/u:8/4279:
[ 1080.705546]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705548]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705552] INFO: task kworker/u:9:4284 blocked for more than 120 seconds.
[ 1080.705553] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1080.705553] kworker/u:9     D ffffffff81ca46c0     0  4284      2 0x00000000
[ 1080.705555]  ffff880403359c98 0000000000000046 ffff880403359cc0 ffff88040d2b4d80
[ 1080.705557]  ffff880403359c58 ffff88040babec80 ffff880403359fd8 ffff880403359fd8
[ 1080.705559]  0000000000011700 ffff88040babec80 ffff880403359c88 ffffffff8192fc60
[ 1080.705561] Call Trace:
[ 1080.705563]  [<ffffffff815e3b27>] schedule+0x5f/0x61
[ 1080.705565]  [<ffffffff81095687>] async_synchronize_cookie_domain+0xba/0x116
[ 1080.705567]  [<ffffffff81090712>] ? __init_waitqueue_head+0x4c/0x4c
[ 1080.705569]  [<ffffffff810956f3>] async_synchronize_cookie+0x10/0x12
[ 1080.705570]  [<ffffffff813463e3>] async_port_probe+0x28/0x4d
[ 1080.705572]  [<ffffffff81095a38>] async_run_entry_fn+0xc0/0x1a4
[ 1080.705574]  [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
[ 1080.705575]  [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
[ 1080.705577]  [<ffffffff815e2e82>] ? mutex_unlock+0x9/0xb
[ 1080.705578]  [<ffffffff81095978>] ? async_schedule+0x12/0x12
[ 1080.705580]  [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
[ 1080.705581]  [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
[ 1080.705583]  [<ffffffff8108ff0a>] kthread+0xac/0xb4
[ 1080.705585]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705587]  [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
[ 1080.705589]  [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
[ 1080.705590] 2 locks held by kworker/u:9/4284:
[ 1080.705590]  #0:  (events_unbound){.+.+.+}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2
[ 1080.705593]  #1:  ((&entry->work)){+.+.+.}, at: [<ffffffff8108b770>] process_one_work+0x144/0x2d2


After all the testing, I could not rmmod sata_sil24 but that understandable. Of course
shutdown procedure hung in the end while "Remounting filesystems readonly" but because my
local keyboard was already dead, I could only power off the laptop.

I thought this could be yet another piece into the huge puzzle. At least improved
debug messages would be very useful.

A quick summary:

# grep PME dmesg.txt 
[    1.688952] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.688977] pci 0000:00:16.0: PME# disabled
[    1.689236] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.689241] pci 0000:00:1a.0: PME# disabled
[    1.689463] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.689469] pci 0000:00:1b.0: PME# disabled
[    1.689669] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.689675] pci 0000:00:1c.0: PME# disabled
[    1.689879] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.689884] pci 0000:00:1c.1: PME# disabled
[    1.690087] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.690092] pci 0000:00:1c.3: PME# disabled
[    1.690293] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.690299] pci 0000:00:1c.4: PME# disabled
[    1.690508] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.690514] pci 0000:00:1c.7: PME# disabled
[    1.690759] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.690765] pci 0000:00:1d.0: PME# disabled
[    1.691234] pci 0000:00:1f.2: PME# supported from D3hot
[    1.691239] pci 0000:00:1f.2: PME# disabled
[    1.691993] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.692000] pci 0000:05:00.0: PME# disabled
[    1.707382] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    1.707434] pci 0000:09:00.0: PME# disabled
[    1.724865] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.724871] pci 0000:0b:00.0: PME# disabled
[   30.928301] xhci_hcd 0000:0b:00.0: PME# enabled
[   30.928813] pcieport 0000:00:1c.0: PME# enabled
[   55.213507] sata_sil24 0000:11:00.0: PME# disabled
[   55.222541] pcieport 0000:00:1c.7: PME# enabled
[  297.931267] pcieport 0000:00:1c.0: PME# disabled
[  297.951221] pcieport 0000:00:1c.7: PME# disabled
[  297.971264] xhci_hcd 0000:0b:00.0: PME# disabled
[  519.411922] sata_sil24 0000:11:00.0: PME# disabled
[  604.984442] sata_sil24 0000:11:00.0: PME# disabled
[  743.368312] sata_sil24 0000:11:00.0: PME# disabled
[  751.865664] sata_sil24 0000:11:00.0: PME# disabled
[  854.882213] sata_sil24 0000:11:00.0: PME# disabled
[  867.533369] sata_sil24 0000:11:00.0: PME# disabled
[  871.937076] sata_sil24 0000:11:00.0: PME# disabled
[  895.711406] sata_sil24 0000:11:00.0: PME# disabled
[  902.231682] sata_sil24 0000:11:00.0: PME# disabled
[  922.251867] sata_sil24 0000:11:00.0: PME# disabled
[  956.510828] sata_sil24 0000:11:00.0: PME# disabled
[ 1000.824829] sata_sil24 0000:11:00.0: PME# disabled
[ 1063.880900] sata_sil24 0000:11:00.0: PME# disabled
#

Martin

