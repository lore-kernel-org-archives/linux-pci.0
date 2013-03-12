Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:43041 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932432Ab3CLQDz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Mar 2013 12:03:55 -0400
Message-ID: <513F51DE.1070101@fold.natur.cuni.cz>
Date: Tue, 12 Mar 2013 17:03:42 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.7.10: acpiphp with pcie_aspm=off and eSATA card Sil 3132
References: <513E4A30.5070909@fold.natur.cuni.cz>
In-Reply-To: <513E4A30.5070909@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Hi,
>   while testing how acpiphp behaves when an eSATA express card is repeatedly
> inserted and removed from a slot, I realized few new things. The 
> 
> while true; do echo -n "$(date +%T) SlotStatus "; setpci -s1c.7 0x5a.w; sleep 1; done
> 
> reveals that when I cold boot with a card in a slot, it reports 0040. When I boot with
> an empty slot, we start with 0000 instead.
> 
> The first insertion of the card moves us to 0140.
> 
> If the mechanics works well, value stays at 0140 and upon sucessfull eject it falls down to 0100.
> 
> If the card slips out (like in this case) the value reports 0140 while the
> slot is actually empty. Then the next insert in unnoticed, value is still 0140, and following
> eject (even eject) rescues us and the slot reports 0100 properly.


Below is a comparison with a cold-booted laptop using the same card
inserted (still acpiphp as in $subj).

Interesting is that on the lines starting with + sign (cold booted with
an empty card slot, the hotplug insert via acpiphp on 3.7.10 kernel with
pcie_aspm=off) and reg 10, 18, 20, 30 the hex values are zeroed in their
upper bits. Is this same as
'[virtual] Expansion ROM at f0000000 [disabled] [size=512K]'
in lspci ouput?


# cut -c 16- eSATA_inserted_coldboot/dmesg_after_HDD_attached.txt > /tmp/dmesg_eSATA_inserted_coldboot.txt
# cut -c 16- eSATA_hotplug_disabled_Media_card_reader/dmesg_after.txt > /tmp/dmesg_eSATA_hotplug_disabled_Media_card_reader.txt
# diff -u -w /tmp/dmesg_eSATA_inserted_coldboot.txt /tmp/dmesg_eSATA_hotplug_disabled_Media_card_reader.txt | less

--- /tmp/dmesg_eSATA_inserted_coldboot.txt      2013-03-12 15:55:55.000000000 +0100
+++ /tmp/dmesg_eSATA_hotplug_disabled_Media_card_reader.txt     2013-03-12 15:56:13.000000000 +0100
@@ -369,12 +369,6 @@
 pci_bus 0000:0b: bus scan returning with max=0b
 pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
 pci_bus 0000:11: scanning bus
-pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
-pci 0000:11:00.0: reg 10: [mem 0xf6c84000-0xf6c8407f 64bit]
-pci 0000:11:00.0: reg 18: [mem 0xf6c80000-0xf6c83fff 64bit]
-pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
-pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
-pci 0000:11:00.0: supports D1 D2
 pci_bus 0000:11: fixups for bus
 pci 0000:00:1c.7: PCI bridge to [bus 11-16]
 pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -439,9 +433,6 @@
 pci 0000:09:00.0: BAR 0: reserving [mem 0xf7e00000-0xf7e01fff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 0: reserving [mem 0xf7d00000-0xf7d0ffff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 2: reserving [mem 0xf7d10000-0xf7d11fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 0: reserving [mem 0xf6c84000-0xf6c8407f flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 2: reserving [mem 0xf6c80000-0xf6c83fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 4: reserving [io  0xc000-0xc07f flags 0x40101] (d=0, p=0)
 e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
 e820: reserve RAM buffer [mem 0xda4e5000-0xdbffffff]
 e820: reserve RAM buffer [mem 0xda793000-0xdbffffff]
[cut]
+pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+pci 0000:11:00.0: supports D1 D2
+pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+sata_sil24 0000:11:00.0: version 1.1
+sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+sata_sil24 0000:11:00.0: enabling bus mastering
+scsi6 : sata_sil24
+scsi7 : sata_sil24
+ata7: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+ata8: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+ata7: SATA link down (SStatus 0 SControl 0)
+ata8: SATA link down (SStatus 0 SControl 0)
+sata_sil24 0000:11:00.0: PME# disabled
+sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?







Below is merely another example of the same thing but with MediaCardReader enabled
in BIOS.
It is in turn being "reset" by ehci_hcd in the end. I believe this is why I observed
that the media card reader sometime appears in the system only after I plugged into
the express card slot a card (not sure from top of my head if that only only with
this eSATA card or even other cards, could be that this is sata_sil24-specific).
I gather the Media Card Reader is just an innocent victim as I haven't found
lsusb/lspci diffs when I have the card reader or disabled in BIOS, except that device
being one. Why other USB-bound devices, like the UVC Camera, are not being reset as
well by ehci_hcd, I do not know. Maybe usb-storage or ums-realtek looks only for
disk-like devices? Or sata_sil24 looks for disk-like devices to reset them?


# cut -c 16- eSATA_hotplug/dmesg_after.txt > /tmp/dmesg_eSATA_hotplug_enabled_Media_card_reader.txt
# diff -u -w /tmp/dmesg_eSATA_inserted_coldboot.txt /tmp/dmesg_eSATA_hotplug_enabled_Media_card_reader.txt | less

--- /tmp/dmesg_eSATA_inserted_coldboot.txt      2013-03-12 15:55:55.000000000 +0100
+++ /tmp/dmesg_eSATA_hotplug_enabled_Media_card_reader.txt      2013-03-12 16:24:48.000000000 +0100
@@ -369,12 +369,6 @@
 pci_bus 0000:0b: bus scan returning with max=0b
 pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
 pci_bus 0000:11: scanning bus
-pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
-pci 0000:11:00.0: reg 10: [mem 0xf6c84000-0xf6c8407f 64bit]
-pci 0000:11:00.0: reg 18: [mem 0xf6c80000-0xf6c83fff 64bit]
-pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
-pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
-pci 0000:11:00.0: supports D1 D2
 pci_bus 0000:11: fixups for bus
 pci 0000:00:1c.7: PCI bridge to [bus 11-16]
 pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
@@ -439,9 +433,6 @@
 pci 0000:09:00.0: BAR 0: reserving [mem 0xf7e00000-0xf7e01fff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 0: reserving [mem 0xf7d00000-0xf7d0ffff flags 0x140204] (d=0, p=0)
 pci 0000:0b:00.0: BAR 2: reserving [mem 0xf7d10000-0xf7d11fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 0: reserving [mem 0xf6c84000-0xf6c8407f flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 2: reserving [mem 0xf6c80000-0xf6c83fff flags 0x140204] (d=0, p=0)
-pci 0000:11:00.0: BAR 4: reserving [io  0xc000-0xc07f flags 0x40101] (d=0, p=0)
 e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
 e820: reserve RAM buffer [mem 0xda4e5000-0xdbffffff]
 e820: reserve RAM buffer [mem 0xda793000-0xdbffffff]
[cut]
+pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+pci 0000:11:00.0: supports D1 D2
+pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+sata_sil24 0000:11:00.0: version 1.1
+sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+sata_sil24 0000:11:00.0: enabling bus mastering
+scsi7 : sata_sil24
+scsi8 : sata_sil24
+ata7: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+ata8: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+sata_sil24 0000:11:00.0: PME# disabled
+ata7: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
+------------[ cut here ]------------
+WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()
+Hardware name: Vostro 3550
+Modules linked in: sata_sil24 i915 fbcon bitblit cfbfillrect softcursor cfbimgblt font i2c_algo_bit cfbcopyarea drm_kms_helper drm fb iwldvm iwlwifi fbdev
+Pid: 4, comm: kworker/0:0 Not tainted 3.7.10-default #2
+Call Trace:
+ [<ffffffff81077a43>] warn_slowpath_common+0x7e/0x96
+ [<ffffffff81077a70>] warn_slowpath_null+0x15/0x17
+ [<ffffffff81340de4>] ata_host_detach+0x75/0xdb
+ [<ffffffff81340e62>] ata_pci_remove_one+0x18/0x1a
+ [<ffffffff81281c84>] pci_device_remove+0x38/0x8b
+ [<ffffffff81307a41>] __device_release_driver+0x81/0xd4
+ [<ffffffff81307ab4>] device_release_driver+0x20/0x2d
+ [<ffffffff813075ee>] bus_remove_device+0xef/0x103
+ [<ffffffff813052fe>] device_del+0x131/0x183
+ [<ffffffff8130535e>] device_unregister+0xe/0x1a
+ [<ffffffff8127d741>] pci_stop_bus_device+0x65/0x87
+ [<ffffffff8127d8af>] pci_stop_and_remove_bus_device+0xf/0x1c
+ [<ffffffff8128d516>] acpiphp_disable_slot+0x8f/0x17e
+ [<ffffffff8128c593>] ? get_slot_status+0x38/0x9b
+ [<ffffffff8128d63a>] acpiphp_check_bridge.isra.16+0x35/0xc6
+ [<ffffffff8128db5b>] _handle_hotplug_event_bridge+0x275/0x3de
+ [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
+ [<ffffffff810b4944>] ? trace_hardirqs_on_caller+0x121/0x158
+ [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
+ [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
+ [<ffffffff8128d8e6>] ? _handle_hotplug_event_func+0x17f/0x17f
+ [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
+ [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
+ [<ffffffff8108ff0a>] kthread+0xac/0xb4
+ [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
+ [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
+ [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
+---[ end trace 6a632979eae68aa3 ]---
+------------[ cut here ]------------
+WARNING: at drivers/ata/libata-core.c:6243 ata_host_detach+0x75/0xdb()
+Hardware name: Vostro 3550
+Modules linked in: sata_sil24 i915 fbcon bitblit cfbfillrect softcursor cfbimgblt font i2c_algo_bit cfbcopyarea drm_kms_helper drm fb iwldvm iwlwifi fbdev
+Pid: 4, comm: kworker/0:0 Tainted: G        W    3.7.10-default #2
+Call Trace:
+ [<ffffffff81077a43>] warn_slowpath_common+0x7e/0x96
+ [<ffffffff81077a70>] warn_slowpath_null+0x15/0x17
+ [<ffffffff81340de4>] ata_host_detach+0x75/0xdb
+ [<ffffffff81340e62>] ata_pci_remove_one+0x18/0x1a
+ [<ffffffff81281c84>] pci_device_remove+0x38/0x8b
+ [<ffffffff81307a41>] __device_release_driver+0x81/0xd4
+ [<ffffffff81307ab4>] device_release_driver+0x20/0x2d
+ [<ffffffff813075ee>] bus_remove_device+0xef/0x103
+ [<ffffffff813052fe>] device_del+0x131/0x183
+ [<ffffffff8130535e>] device_unregister+0xe/0x1a
+ [<ffffffff8127d741>] pci_stop_bus_device+0x65/0x87
+ [<ffffffff8127d8af>] pci_stop_and_remove_bus_device+0xf/0x1c
+ [<ffffffff8128d516>] acpiphp_disable_slot+0x8f/0x17e
+ [<ffffffff8128c593>] ? get_slot_status+0x38/0x9b
+ [<ffffffff8128d63a>] acpiphp_check_bridge.isra.16+0x35/0xc6
+ [<ffffffff8128db5b>] _handle_hotplug_event_bridge+0x275/0x3de
+ [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
+ [<ffffffff810b4944>] ? trace_hardirqs_on_caller+0x121/0x158
+ [<ffffffff8108b7da>] process_one_work+0x1ae/0x2d2
+ [<ffffffff8108b770>] ? process_one_work+0x144/0x2d2
+ [<ffffffff8128d8e6>] ? _handle_hotplug_event_func+0x17f/0x17f
+ [<ffffffff8108c4d2>] worker_thread+0x13e/0x1d5
+ [<ffffffff8108c394>] ? manage_workers+0x23d/0x23d
+ [<ffffffff8108ff0a>] kthread+0xac/0xb4
+ [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
+ [<ffffffff815e542c>] ret_from_fork+0x7c/0xb0
+ [<ffffffff8108fe5e>] ? __init_kthread_worker+0x54/0x54
+---[ end trace 6a632979eae68aa4 ]---
+sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
+pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
+pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
+pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
+pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
+pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
+pci 0000:11:00.0: supports D1 D2
+pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
+pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
+pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
+pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
+pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
+pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
+pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
+sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
+sata_sil24 0000:11:00.0: enabling bus mastering
+scsi9 : sata_sil24
+scsi10 : sata_sil24
+ata9: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
+ata10: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 1
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 2
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 3
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 4
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 5
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 6
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 7
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 8
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 9
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 10
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 11
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 12
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 13
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 14
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 15
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 16
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 17
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 18
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 19
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 20
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 21
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 22
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 23
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 24
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 25
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 26
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 27
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 28
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 29
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 30
+ehci_hcd 0000:00:1d.0: detected XactErr len 0/13 retry 31
+ehci_hcd 0000:00:1d.0: devpath 1.6 ep2in 3strikes
+hub 2-1:1.0: logical disconnect on port 6
+hub 2-1:1.0: state 7 ports 8 chg 0040 evt 0000
+hub 2-1:1.0: port 6, status 0100, change 0001, 12 Mb/s
+usb 2-1.6: USB disconnect, device number 5
+usb 2-1.6: unregistering device
+usb 2-1.6: unregistering interface 2-1.6:1.0
+usb 2-1.6: usb_disable_device nuking all URBs
+hub 2-1:1.0: debounce: port 6: total 100ms stable 100ms status 0x100
+ata9: SATA link down (SStatus 0 SControl 0)
+hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0040
+hub 2-1:1.0: port 6, status 0101, change 0001, 12 Mb/s
+hub 2-1:1.0: debounce: port 6: total 100ms stable 100ms status 0x101
+usb 2-1.6: new high-speed USB device number 8 using ehci_hcd
+usb 2-1.6: default language 0x0409
+usb 2-1.6: udev 8, busnum 2, minor = 135
+usb 2-1.6: New USB device found, idVendor=0bda, idProduct=0138
+usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
+usb 2-1.6: Product: USB2.0-CRW
+usb 2-1.6: Manufacturer: Generic
+usb 2-1.6: SerialNumber: 20090516388200000
+usb 2-1.6: usb_probe_device
+usb 2-1.6: configuration #1 chosen from 1 choice
+usb 2-1.6: adding 2-1.6:1.0 (config #1, interface 0)
+usb-storage 2-1.6:1.0: usb_probe_interface
+usb-storage 2-1.6:1.0: usb_probe_interface - got id
+ums-realtek 2-1.6:1.0: usb_probe_interface
+ums-realtek 2-1.6:1.0: usb_probe_interface - got id
+scsi11 : usb-storage 2-1.6:1.0
+hub 2-1:1.0: state 7 ports 8 chg 0000 evt 0040
+sata_sil24 0000:11:00.0: PME# disabled


I still do not know what those [virtual] Expansion ROM lines really mean
but let me complete the picture of coldplug vs. hotplug of the eSATA card with:

--- eSATA_inserted_coldboot/lspci_vvvxxx_after_HDD_attached.txt 2013-03-11 18:12:27.000000000 +0100
+++ eSATA_hotplug/lspci_vvvxxx_after.txt        2013-03-11 20:20:59.000000000 +0100
@@ -74,7 +74,7 @@
 10: 04 a0 f0 f7 00 00 00 00 00 00 00 00 00 00 00 00
 20: 00 00 00 00 00 00 00 00 00 00 00 00 28 10 b3 04
 30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00
-40: 45 02 00 1e 08 00 01 80 06 00 00 66 f8 3f 00 10
+40: 45 02 00 1e 08 00 01 80 06 00 00 60 f8 3f 00 10
 50: 01 8c 03 c8 08 00 00 00 00 00 00 00 00 00 00 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -439,7 +439,7 @@
        I/O behind bridge: 0000c000-0000dfff
        Memory behind bridge: f6c00000-f7cfffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f10fffff
-       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
+       Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
@@ -459,7 +459,7 @@
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
-                       Changed: MRL- PresDet- LinkState-
+                       Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
@@ -478,11 +478,11 @@
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: pcieport
 00: 86 80 1e 1c 07 00 10 00 b5 00 04 06 10 00 81 00
-10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 00
+10: 00 00 00 00 00 00 00 00 00 11 16 00 c0 d0 00 20
 20: c0 f6 c0 f7 01 f0 01 f1 00 00 00 00 00 00 00 00
 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 04 10 00
 40: 10 80 42 01 00 80 00 00 00 00 10 00 12 3c 12 08
-50: 40 00 11 70 60 b2 3c 00 00 00 40 00 00 00 00 00
+50: 40 00 11 70 60 b2 3c 00 00 00 40 01 00 00 00 00
 60: 00 00 00 00 16 00 00 00 00 00 00 00 00 00 00 00
 70: 01 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
 80: 05 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
@@ -544,7 +544,7 @@
 70: 78 f0 79 f0 7a f0 7b f0 7c f0 7d f0 7e f0 7f f0
 80: 00 00 00 3c 00 00 00 00 6d 00 04 00 00 00 00 00
 90: 00 00 00 00 00 0f 00 00 01 00 80 fe 00 00 00 00
-a0: 04 0e a0 00 71 18 06 00 00 47 00 00 00 00 00 80
+a0: 04 0e 80 00 71 18 06 00 00 47 00 00 00 00 00 80
 b0: 00 00 00 00 00 00 00 00 04 81 00 00 00 00 00 00
 c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
@@ -802,14 +802,14 @@
 11:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Physical Slot: 1
-       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
+       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
-       Latency: 0, Cache Line Size: 64 bytes
+       Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 19
-       Region 0: Memory at f6c84000 (64-bit, non-prefetchable) [size=128]
-       Region 2: Memory at f6c80000 (64-bit, non-prefetchable) [size=16K]
+       Region 0: Memory at f6c04000 (64-bit, non-prefetchable) [size=128]
+       Region 2: Memory at f6c00000 (64-bit, non-prefetchable) [size=16K]
        Region 4: I/O ports at c000 [size=128]
-       Expansion ROM at f6c00000 [disabled] [size=512K]
+       [virtual] Expansion ROM at f0000000 [disabled] [size=512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
@@ -835,10 +835,10 @@
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
        Kernel driver in use: sata_sil24
-00: 95 10 32 31 07 00 10 00 01 00 80 01 10 00 00 00
-10: 04 40 c8 f6 00 00 00 00 04 00 c8 f6 00 00 00 00
+00: 95 10 32 31 07 01 10 00 01 00 80 01 08 00 00 00
+10: 04 40 c0 f6 00 00 00 00 04 00 c0 f6 00 00 00 00
 20: 01 c0 00 00 00 00 00 00 00 00 00 00 95 10 32 31
-30: 00 00 c0 f6 54 00 00 00 00 00 00 00 0a 01 00 00
+30: 00 00 00 00 54 00 00 00 00 00 00 00 00 01 00 00
 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


I will let you breath now for a while. ;-)

Regards,
Martin
