Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54315 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756971Ab3C3Rtj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2013 13:49:39 -0400
Message-ID: <515725B0.60605@fold.natur.cuni.cz>
Date: Sat, 30 Mar 2013 18:49:36 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Huang Ying <ying.huang@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <5381191.45N5KLLmWJ@vostro.rjw.lan> <51563D32.70106@fold.natur.cuni.cz> <2764533.egTWJWstJg@vostro.rjw.lan> <5156457C.9020201@fold.natur.cuni.cz>
In-Reply-To: <5156457C.9020201@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Martin Mokrejs wrote:
> Rafael J. Wysocki wrote:
>> On Saturday, March 30, 2013 02:17:38 AM Martin Mokrejs wrote:
>>> Rafael J. Wysocki wrote:
>>>> On Friday, March 29, 2013 03:11:13 PM Martin Mokrejs wrote:
>>>>> Hi Ying,
>>>>>   thank you for the patch. Here are the results.
>>>>>
>>>>> Huang Ying wrote:
>>>>>> On Thu, 2013-03-28 at 19:38 +0100, Martin Mokrejs wrote:
>>>>>>> Hi Ying,
>>>>>>>   would you please tell me how this report relate to this patch?
>>>>>>>
>>>>>>> [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
>>>>>>>
>>>>>>>   Could you tell me why this PME was being flipped back and forth now?
>>>>>>> Actually, does that make finally some sense to you, pci/acpi devs?
>>>>
>>>> Can you please test this patch:
>>>>
>>>> https://patchwork.kernel.org/patch/2359611/
>>>>
>>>> and report back as I asked you?
>>>
>>> Sorry for the delay I just had to sort out what belongs under what thread
>>> and the patch was under the other. But I agree its testing with this
>>> particular eSATA/ExpressCardSlot/PM fits better here.
>>>
>>>
>>> The good news is that the eSATA card hotplug works almost perfectly with the patch.
>>> I cold booted as always with the card in the slot already loaded, same kernel
>>> .config and commandline options as described under this thread. But the kernel
>>> was 3.8.3! Not 3.9-rc1.
>>
>> Good.  The goal was to fix the problem with eSATA hotplug.
> 
> I thought that was aimed at the XHCI dead port issue. ;-)

Hi,
  first of all, a big fat note. The tests with 3.8.2 and 3.8.2 I always did with aciphp
and pcie_aspm=off. I somehow forgot about that and yesterday after testing the
patch from Huang Ying when it turned out the patch actually not only helps with the
dead xHCI port due to suspend but incidentally also fixes the eSATA card hotplug ...
I decided to move the part related to the eSATA card under this thread.
Hmm, but I forgot that this thread is about pciehp while I was using pciehp.
I will leave it as it is right now but please, bear in mind that with acpiphp
I had principially not much problems on on 3.7 and above (unlike pciehp) and so far
the eSATA card behaved weird under acpiphp unlike the other two cards.
  It could be the pciehp suffers same PCI/PCIe powersaving issue but I cannot
confirm that yet. Just in case you would be trying to find in source code a bug
related to pciehp. Intentionally, while re-testing the behavior (further below)
I left in a stacktrace showing acpiphp path. This email is a confirmation of what
I found yesterday, just waned to emphasize the use of acpiphp vs. pciehp for 3.8.2/3.8.3
testing.


I tried to mimic what laptop-mode-tools caused on my system with vanilla 3.8.3
kernel. I think I managed in the end. The eSATA card hotplug and hotremoval works
(acpiphp with pcie_aspm=off) when 11:00 (ExpressCardSlot) and 1c.7 (its upstream
root port) are set to on.

Once I do 'find  /sys/bus/pci/devices/*/power/ -name control | while read f; do echo auto > $f; done'
then the following fall asleep:

--- runtime_status.txt  2013-03-30 11:01:42.000000000 +0100
+++ runtime_status__after__all_to_auto.txt      2013-03-30 11:04:21.000000000 +0100
@@ -1,9 +1,9 @@
-/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:active
+/sys/bus/pci/devices/0000:00:00.0/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:00:02.0/power/runtime_status:active
-/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:active
+/sys/bus/pci/devices/0000:00:16.0/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:00:1a.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1b.0/power/runtime_status:active
-/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:active
+/sys/bus/pci/devices/0000:00:1c.0/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:00:1c.1/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1c.3/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1c.4/power/runtime_status:active
@@ -11,8 +11,8 @@
 /sys/bus/pci/devices/0000:00:1d.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1f.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:00:1f.2/power/runtime_status:active
-/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:active
+/sys/bus/pci/devices/0000:00:1f.3/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:05:00.0/power/runtime_status:active
 /sys/bus/pci/devices/0000:09:00.0/power/runtime_status:active
-/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:active
+/sys/bus/pci/devices/0000:0b:00.0/power/runtime_status:suspended
 /sys/bus/pci/devices/0000:11:00.0/power/runtime_status:active


Notably, 11:00 does not fall asleep by itself neither it's upstream
port. The hotplug and removal still works but upon eject 11:00
becomes to fall asleep. Sometimes, 1.c7 falls asleep and once that
happens the express card slot is dead (11:00). After doing
echo "on" > /sys/bus/pci/devices/0000:11:00.0/power/control
does not help, one has to wakeup the upstream 1c.7 root port.


Now results of the testing itself:

eSATA card device ejected ... while 1c.7 was "on" and 11:00 in "auto" mode:

[  825.471775] sata_sil24 0000:11:00.0: PME# disabled
[  825.475184] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?

Now I set 1c.7 to "auto" as well. Hotinsert works because 1c.7 does not immediately
fall asleep after the echo command but upon eject 1c.7 will fall asleep (I mean
gets PME# enabled, can't comment about the eSATA card saying "supports D1 D2"):

[  841.847469] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[  841.847514] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[  841.847546] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[  841.847567] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[  841.847608] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[  841.847739] pci 0000:11:00.0: supports D1 D2
[  841.868167] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[  841.868171] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[  841.868194] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[  841.868196] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[  841.868218] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[  841.868219] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[  841.868227] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[  841.869418] pcieport 0000:00:1c.7: restoring config space at offset 0x1c (was 0x2000d0c0, writing 0xd0c0)
[  841.869475] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[  841.869681] sata_sil24 0000:11:00.0: enabling bus mastering
[  841.873096] scsi8 : sata_sil24
[  841.874967] scsi9 : sata_sil24
[  841.875663] ata9: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[  841.875667] ata10: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[  843.953357] ata9: SATA link down (SStatus 0 SControl 0)
[  846.040248] ata10: SATA link down (SStatus 0 SControl 0)
[  909.965819] sata_sil24 0000:11:00.0: PME# disabled
[  909.967937] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[  909.975174] pcieport 0000:00:1c.7: PME# enabled

Now I will manually set 1c.7 back to "on" and subsequent hotinsert+hotremove will
work again (11:00 is still in "auto"):

[ 1032.752331] pcieport 0000:00:1c.7: PME# disabled
[ 1051.405309] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[ 1051.405355] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[ 1051.405388] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[ 1051.405409] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[ 1051.405449] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[ 1051.405568] pci 0000:11:00.0: supports D1 D2
[ 1051.425977] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[ 1051.425982] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[ 1051.426004] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[ 1051.426006] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[ 1051.426028] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[ 1051.426030] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[ 1051.426037] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[ 1051.427222] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[ 1051.427413] sata_sil24 0000:11:00.0: enabling bus mastering
[ 1051.430736] scsi10 : sata_sil24
[ 1051.432608] scsi11 : sata_sil24
[ 1051.433973] ata11: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[ 1051.433977] ata12: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[ 1053.521187] ata11: SATA link down (SStatus 0 SControl 0)
[ 1055.608091] ata12: SATA link down (SStatus 0 SControl 0)
[ 1070.576590] sata_sil24 0000:11:00.0: PME# disabled
[ 1070.578631] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?

Again hot-insert and eject:

[ 1072.334142] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[ 1072.334187] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[ 1072.334220] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[ 1072.334240] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[ 1072.334281] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[ 1072.334398] pci 0000:11:00.0: supports D1 D2
[ 1072.354775] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[ 1072.354779] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[ 1072.354802] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[ 1072.354804] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[ 1072.354825] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[ 1072.354827] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[ 1072.354834] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[ 1072.355952] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[ 1072.356141] sata_sil24 0000:11:00.0: enabling bus mastering
[ 1072.360476] scsi12 : sata_sil24
[ 1072.361719] scsi13 : sata_sil24
[ 1072.363037] ata13: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[ 1072.363042] ata14: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[ 1074.450035] ata13: SATA link down (SStatus 0 SControl 0)
[ 1076.536960] ata14: SATA link down (SStatus 0 SControl 0)
[ 1078.634799] sata_sil24 0000:11:00.0: PME# disabled
[ 1078.636829] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?

Below few more hotinserts and hotremovals, merely to show the stacktrace
when I I remove/inserted the card too quickly.

[ 1081.210918] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[ 1081.210963] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[ 1081.210995] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[ 1081.211016] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[ 1081.211057] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[ 1081.211173] pci 0000:11:00.0: supports D1 D2
[ 1081.231635] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[ 1081.231640] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[ 1081.231662] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[ 1081.231664] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[ 1081.231686] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[ 1081.231687] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[ 1081.231694] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[ 1081.232773] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[ 1081.232983] sata_sil24 0000:11:00.0: enabling bus mastering
[ 1081.236374] scsi14 : sata_sil24
[ 1081.238038] scsi15 : sata_sil24
[ 1081.239819] ata15: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[ 1081.239823] ata16: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[ 1083.326798] ata15: SATA link down (SStatus 0 SControl 0)
[ 1085.454431] sata_sil24 0000:11:00.0: PME# disabled
[ 1087.430723] ata16: SATA link down (SStatus FFFFFFFF SControl FFFFFFFF)
[ 1087.430761] ------------[ cut here ]------------
[ 1087.430767] WARNING: at drivers/ata/libata-core.c:6244 ata_host_detach+0x75/0xdb()
[ 1087.430768] Hardware name: Vostro 3550
[ 1087.430769] Modules linked in: i915 fbcon cfbfillrect bitblit softcursor cfbimgblt font i2c_algo_bit cfbcopyarea drm_kms_helper drm iwldvm fb iwlwifi fbdev sata_sil24
[ 1087.430783] Pid: 677, comm: kworker/0:1 Not tainted 3.8.3-default #1
[ 1087.430784] Call Trace:
[ 1087.430790]  [<ffffffff8107cbd7>] warn_slowpath_common+0x7e/0x96
[ 1087.430792]  [<ffffffff8107cc04>] warn_slowpath_null+0x15/0x17
[ 1087.430794]  [<ffffffff8136dfa8>] ata_host_detach+0x75/0xdb
[ 1087.430797]  [<ffffffff8136e03f>] ata_pci_remove_one+0x18/0x1a
[ 1087.430799]  [<ffffffff81293221>] pci_device_remove+0x38/0x8b
[ 1087.430802]  [<ffffffff8132d93d>] __device_release_driver+0x81/0xd4
[ 1087.430811]  [<ffffffff8132d9b0>] device_release_driver+0x20/0x2d
[ 1087.430813]  [<ffffffff8132d4ea>] bus_remove_device+0xef/0x103
[ 1087.430816]  [<ffffffff8132b1b5>] device_del+0x128/0x182
[ 1087.430818]  [<ffffffff8132b21d>] device_unregister+0xe/0x1a
[ 1087.430820]  [<ffffffff8128eb2d>] pci_stop_bus_device+0x65/0x87
[ 1087.430822]  [<ffffffff8128ec9b>] pci_stop_and_remove_bus_device+0xf/0x1b
[ 1087.430825]  [<ffffffff812a183d>] acpiphp_disable_slot+0x8f/0x17e
[ 1087.430827]  [<ffffffff812a08bb>] ? get_slot_status+0x38/0x9b
[ 1087.430830]  [<ffffffff812a1961>] acpiphp_check_bridge.isra.16+0x35/0xc6
[ 1087.430832]  [<ffffffff812a1e82>] _handle_hotplug_event_bridge+0x275/0x3de
[ 1087.430836]  [<ffffffff81090964>] ? process_one_work+0x15c/0x2f5
[ 1087.430839]  [<ffffffff810ba154>] ? trace_hardirqs_on_caller+0x121/0x158
[ 1087.430841]  [<ffffffff810909ce>] process_one_work+0x1c6/0x2f5
[ 1087.430843]  [<ffffffff81090964>] ? process_one_work+0x15c/0x2f5
[ 1087.430845]  [<ffffffff810916d1>] worker_thread+0x13e/0x1d5
[ 1087.430847]  [<ffffffff81091593>] ? manage_workers+0x23d/0x23d
[ 1087.430849]  [<ffffffff810951c6>] kthread+0xac/0xb4
[ 1087.430852]  [<ffffffff8109511a>] ? __init_kthread_worker+0x54/0x54
[ 1087.430855]  [<ffffffff8161222c>] ret_from_fork+0x7c/0xb0
[ 1087.430857]  [<ffffffff8109511a>] ? __init_kthread_worker+0x54/0x54
[ 1087.430858] ---[ end trace 5ef7a4c406a8ed2d ]---
[ 1087.431895] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
[ 1087.433409] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[ 1087.433454] pci 0000:11:00.0: reg 10: [mem 0x00000000-0x0000007f 64bit]
[ 1087.433486] pci 0000:11:00.0: reg 18: [mem 0x00000000-0x00003fff 64bit]
[ 1087.433508] pci 0000:11:00.0: reg 20: [io  0x0000-0x007f]
[ 1087.433549] pci 0000:11:00.0: reg 30: [mem 0x00000000-0x0007ffff pref]
[ 1087.433664] pci 0000:11:00.0: supports D1 D2
[ 1087.452162] pci 0000:11:00.0: BAR 6: assigned [mem 0xf0000000-0xf007ffff pref]
[ 1087.452166] pci 0000:11:00.0: BAR 2: assigned [mem 0xf6c00000-0xf6c03fff 64bit]
[ 1087.452188] pci 0000:11:00.0: BAR 2: set to [mem 0xf6c00000-0xf6c03fff 64bit] (PCI address [0xf6c00000-0xf6c03fff])
[ 1087.452190] pci 0000:11:00.0: BAR 0: assigned [mem 0xf6c04000-0xf6c0407f 64bit]
[ 1087.452211] pci 0000:11:00.0: BAR 0: set to [mem 0xf6c04000-0xf6c0407f 64bit] (PCI address [0xf6c04000-0xf6c0407f])
[ 1087.452212] pci 0000:11:00.0: BAR 4: assigned [io  0xc000-0xc07f]
[ 1087.452219] pci 0000:11:00.0: BAR 4: set to [io  0xc000-0xc07f] (PCI address [0xc000-0xc07f])
[ 1087.453329] sata_sil24 0000:11:00.0: enabling device (0100 -> 0103)
[ 1087.453516] sata_sil24 0000:11:00.0: enabling bus mastering
[ 1087.465089] scsi16 : sata_sil24
[ 1087.467788] scsi17 : sata_sil24
[ 1087.468468] ata17: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c00000 irq 19
[ 1087.468471] ata18: SATA max UDMA/100 host m128@0xf6c04000 port 0xf6c02000 irq 19
[ 1089.547535] ata17: SATA link down (SStatus 0 SControl 0)
[ 1091.634429] ata18: SATA link down (SStatus 0 SControl 0)
[ 1098.594853] sata_sil24 0000:11:00.0: PME# disabled
[ 1098.596911] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?

So, this is principially same issue like with the xhci port dying after USB device unplug.
The 0b:00 works even in "auto" mode until its upstream 1c.4 port is set to "auto" and
becomes actually suspended. It is same story like the eSATA card woes. Just beware,
this was acpiphp and  pcie_aspm=off instead of pciehp as I said in the beginning of this email.


Martin
