Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:32891 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755975Ab3CaXRY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Mar 2013 19:17:24 -0400
Message-ID: <5158C400.1030307@fold.natur.cuni.cz>
Date: Mon, 01 Apr 2013 01:17:20 +0200
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz>   <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz>   <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>   <51428A72.2060602@huawei.com> <51548E13.8030308@fold.natur.cuni.cz>  <1364545211.1817.228.camel@yhuang-dev>  <5155A101.2090705@fold.natur.cuni.cz> <1364640886.5773.5.camel@yhuang-mobile.sh.intel.com> <51581170.30708@fold.natur.cuni.cz> <515813CB.8020001@fold.natur.cuni.cz>
In-Reply-To: <515813CB.8020001@fold.natur.cuni.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[ also +Len Brown -- would you please comment what the ACPI-related bug in BIOS
 could be causing? Should be the message be logged also under 3.8.3? It does
 NOT happen! ]

Hi Ying,
  I see the linux-pci throwed away the email dmesg and lspci attached.
For the sake of archives I am including here some ACPI-related stuff.

Martin Mokrejs wrote:
> Attaching the dmesg file from after all the tests. Effectively it covers
> only bootup messages but there is one of your debug messages:
> 
> [   15.941468] pcieport 0000:00:1c.0: ppri: will go suspend, is_hotplug_bridge: 0.
> 
> I am also attaching the full lspci -vvv output captured after the cold boot.
> I should have used 'diff -u50' to sow broader regions around the changes
> to make it clearer the diffs were all about 1c.7 and 11:00 only. From the
> full file you can get offset line numbers yourself to double check if necessary.

Am I right that your patches aimed to yield
'System wakeup disabled by ACPI' for all pci devices? Somehow, that did NOT happen
for 11:00, the card in the express card slot (it was inserted before cold boot).

[    1.590952] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    1.593046] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    1.594430] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.595855] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    1.597369] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    1.598917] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    1.602131] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    1.624166] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.630725] pci 0000:05:00.0: System wakeup disabled by ACPI
[    1.634536] pci 0000:09:00.0: System wakeup disabled by ACPI
[    1.636221] pci 0000:0b:00.0: System wakeup disabled by ACPI

This "issue" looks common to all your three patches.



Also, notably, there is on patched 3.9-rc1:

[    0.926322] ACPI: Added _OSI(Module Device)
[    0.926424] ACPI: Added _OSI(Processor Device)
[    0.926523] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.926625] ACPI: Added _OSI(Processor Aggregator Device)
[    0.932346] ACPI: EC: Look up EC in DSDT
[    0.942636] ACPI: Executed 1 blocks of module-level executable AML code
[    1.034418] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    1.088331] ACPI: SSDT 00000000dad51698 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.091493] ACPI: Dynamic OEM Table Load:
[    1.091496] ACPI: SSDT           (null) 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.123506] ACPI: SSDT 00000000dad52a98 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.128317] ACPI: Dynamic OEM Table Load:
[    1.128319] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.158678] ACPI: SSDT 00000000dad50d98 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.161258] ACPI: Dynamic OEM Table Load:
[    1.161260] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.190627] ACPI: Interpreter enabled
[    1.190722] ACPI: (supports S0 S1ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130117/hwxface-568)
[    1.191110]  S3 S4 S5)
[    1.191195] ACPI: Using IOAPIC for interrupt routing
[    1.191763] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.519009] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.526115] acpi PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x19)


while 3.8.3 used to give:

[    1.057812] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    1.125133] ACPI: SSDT 00000000dad51698 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.128452] ACPI: Dynamic OEM Table Load:
[    1.128455] ACPI: SSDT           (null) 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.165751] ACPI: SSDT 00000000dad52a98 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.170762] ACPI: Dynamic OEM Table Load:
[    1.170764] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.210483] ACPI: SSDT 00000000dad50d98 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.213195] ACPI: Dynamic OEM Table Load:
[    1.213198] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.251508] ACPI: Interpreter enabled
[    1.251603] ACPI: (supports S0 S1 S3 S4 S5)
[    1.252290] ACPI: Using IOAPIC for interrupt routing
[    1.530836] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.539002] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.539115] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.552100] pci_root PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x19)

According to Google looks like the 'ACPI Exception: AE_NOT_FOUND' is pointing to a buggy BIOS
(this is Dell Vostro 3550, A11 BIOS version).
Looks 3.8 series just does not have new enough ACPI to print out the message to the user
doesn't it happen there? What is affected by the BIOS bug? :(




Piece of dmesg from your third patch (containing those 'ppri' debug prints) covering the ACPI
messages.

[    0.362558] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.362706] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.370241] PCI: Using configuration type 1 for base access
[    0.418113] bio: create slab <bio-0> at 0
[    0.585719] raid6: sse2x1    7608 MB/s
[    0.755953] raid6: sse2x2    9349 MB/s
[    0.926188] raid6: sse2x4   10667 MB/s
[    0.926190] raid6: using algorithm sse2x4 (10667 MB/s)
[    0.926191] raid6: using ssse3x2 recovery algorithm
[    0.926322] ACPI: Added _OSI(Module Device)
[    0.926424] ACPI: Added _OSI(Processor Device)
[    0.926523] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.926625] ACPI: Added _OSI(Processor Aggregator Device)
[    0.932346] ACPI: EC: Look up EC in DSDT
[    0.942636] ACPI: Executed 1 blocks of module-level executable AML code
[    1.034418] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored
[    1.088331] ACPI: SSDT 00000000dad51698 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.091493] ACPI: Dynamic OEM Table Load:
[    1.091496] ACPI: SSDT           (null) 0064F (v01  PmRef  Cpu0Cst 00003001 INTL 20051117)
[    1.123506] ACPI: SSDT 00000000dad52a98 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.128317] ACPI: Dynamic OEM Table Load:
[    1.128319] ACPI: SSDT           (null) 00303 (v01  PmRef    ApIst 00003000 INTL 20051117)
[    1.158678] ACPI: SSDT 00000000dad50d98 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.161258] ACPI: Dynamic OEM Table Load:
[    1.161260] ACPI: SSDT           (null) 00119 (v01  PmRef    ApCst 00003000 INTL 20051117)
[    1.190627] ACPI: Interpreter enabled
[    1.190722] ACPI: (supports S0 S1ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20130117/hwxface-568)
[    1.191110]  S3 S4 S5)
[    1.191195] ACPI: Using IOAPIC for interrupt routing
[    1.191763] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.519009] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    1.526115] acpi PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x19)
[    1.542922] PCI host bridge to bus 0000:00
[    1.543024] pci_bus 0000:00: root bus resource [bus 00-3e]
[    1.543126] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[    1.543227] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
[    1.543329] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    1.543432] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff]
[    1.543534] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff]
[    1.543636] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff]
[    1.543738] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff]
[    1.543841] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff]
[    1.543943] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff]
[    1.544045] pci_bus 0000:00: root bus resource [mem 0xdfa00000-0xfeafffff]
[    1.544148] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed44fff]
[    1.544251] pci_bus 0000:00: scanning bus
[    1.544290] pci 0000:00:00.0: [8086:0104] type 00 class 0x060000
[    1.544298] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0/0xa
[    1.546226] pci 0000:00:02.0: [8086:0126] type 00 class 0x030000
[    1.546242] pci 0000:00:02.0: reg 10: [mem 0xf6800000-0xf6bfffff 64bit]
[    1.546251] pci 0000:00:02.0: reg 18: [mem 0xe0000000-0xefffffff 64bit pref]
[    1.546257] pci 0000:00:02.0: reg 20: [io  0xf000-0xf03f]
[    1.548073] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    1.548113] pci 0000:00:16.0: reg 10: [mem 0xf7f0a000-0xf7f0a00f 64bit]
[    1.548243] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.548269] pci 0000:00:16.0: PME# disabled
[    1.550203] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    1.550239] pci 0000:00:1a.0: reg 10: [mem 0xf7f08000-0xf7f083ff]
[    1.550395] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.550401] pci 0000:00:1a.0: PME# disabled
[    1.569774] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    1.570451] pci 0000:00:1b.0: [8086:1c20] type 00 class 0x040300
[    1.570481] pci 0000:00:1b.0: reg 10: [mem 0xf7f00000-0xf7f03fff 64bit]
[    1.570627] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    1.570633] pci 0000:00:1b.0: PME# disabled
[    1.571885] pci 0000:00:1b.0: System wakeup disabled by ACPI
[    1.572487] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    1.572559] pci 0000:00:1c.0: calling pci_fixup_transparent_bridge+0x0/0x1d
[    1.572645] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.572651] pci 0000:00:1c.0: PME# disabled
[    1.573280] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    1.573868] pci 0000:00:1c.1: [8086:1c12] type 01 class 0x060400
[    1.573938] pci 0000:00:1c.1: calling pci_fixup_transparent_bridge+0x0/0x1d
[    1.574024] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    1.574030] pci 0000:00:1c.1: PME# disabled
[    1.574701] pci 0000:00:1c.1: System wakeup disabled by ACPI
[    1.575303] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
[    1.575374] pci 0000:00:1c.3: calling pci_fixup_transparent_bridge+0x0/0x1d
[    1.575460] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    1.575465] pci 0000:00:1c.3: PME# disabled
[    1.576220] pci 0000:00:1c.3: System wakeup disabled by ACPI
[    1.576821] pci 0000:00:1c.4: [8086:1c18] type 01 class 0x060400
[    1.576891] pci 0000:00:1c.4: calling pci_fixup_transparent_bridge+0x0/0x1d
[    1.576975] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.576981] pci 0000:00:1c.4: PME# disabled
[    1.577772] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    1.579703] pci 0000:00:1c.7: [8086:1c1e] type 01 class 0x060400
[    1.579773] pci 0000:00:1c.7: calling pci_fixup_transparent_bridge+0x0/0x1d
[    1.579856] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    1.579862] pci 0000:00:1c.7: PME# disabled
[    1.580992] pci 0000:00:1c.7: System wakeup disabled by ACPI
[    1.581590] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    1.581625] pci 0000:00:1d.0: reg 10: [mem 0xf7f07000-0xf7f073ff]
[    1.581782] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.581788] pci 0000:00:1d.0: PME# disabled
[    1.603022] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    1.603663] pci 0000:00:1f.0: [8086:1c4b] type 00 class 0x060100
[    1.604394] pci 0000:00:1f.2: [8086:1c03] type 00 class 0x010601
[    1.604433] pci 0000:00:1f.2: reg 10: [io  0xf0b0-0xf0b7]
[    1.604448] pci 0000:00:1f.2: reg 14: [io  0xf0a0-0xf0a3]
[    1.604462] pci 0000:00:1f.2: reg 18: [io  0xf090-0xf097]
[    1.604476] pci 0000:00:1f.2: reg 1c: [io  0xf080-0xf083]
[    1.604491] pci 0000:00:1f.2: reg 20: [io  0xf060-0xf07f]
[    1.604507] pci 0000:00:1f.2: reg 24: [mem 0xf7f06000-0xf7f067ff]
[    1.604605] pci 0000:00:1f.2: PME# supported from D3hot
[    1.604612] pci 0000:00:1f.2: PME# disabled
[    1.606249] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    1.606278] pci 0000:00:1f.3: reg 10: [mem 0xf7f05000-0xf7f050ff 64bit]
[    1.606320] pci 0000:00:1f.3: reg 20: [io  0xf040-0xf05f]
[    1.607978] pci_bus 0000:00: fixups for bus
[    1.607983] pci 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 0
[    1.608424] pci_bus 0000:03: scanning bus
[    1.608427] pci_bus 0000:03: fixups for bus
[    1.608429] pci 0000:00:1c.0: PCI bridge to [bus 03-04]
[    1.608537] pci_bus 0000:03: bus scan returning with max=03
[    1.608543] pci 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 0
[    1.608980] pci_bus 0000:05: scanning bus
[    1.609031] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[    1.609059] pci 0000:05:00.0: reg 10: [io  0xe000-0xe0ff]
[    1.609108] pci 0000:05:00.0: reg 18: [mem 0xf1104000-0xf1104fff 64bit pref]
[    1.609138] pci 0000:05:00.0: reg 20: [mem 0xf1100000-0xf1103fff 64bit pref]
[    1.609278] pci 0000:05:00.0: supports D1 D2
[    1.609279] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.609286] pci 0000:05:00.0: PME# disabled
[    1.609558] pci 0000:05:00.0: System wakeup disabled by ACPI
[    1.610158] pci_bus 0000:05: fixups for bus
[    1.610160] pci 0000:00:1c.1: PCI bridge to [bus 05-06]
[    1.610257] pci 0000:00:1c.1:   bridge window [io  0xe000-0xefff]
[    1.610271] pci 0000:00:1c.1:   bridge window [mem 0xf1100000-0xf11fffff 64bit pref]
[    1.610272] pci_bus 0000:05: bus scan returning with max=05
[    1.610279] pci 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 0
[    1.610711] pci_bus 0000:09: scanning bus
[    1.610993] pci 0000:09:00.0: [8086:008a] type 00 class 0x028000
[    1.611296] pci 0000:09:00.0: reg 10: [mem 0xf7e00000-0xf7e01fff 64bit]
[    1.612984] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    1.613035] pci 0000:09:00.0: PME# disabled
[    1.613422] pci 0000:09:00.0: System wakeup disabled by ACPI
[    1.614008] pci_bus 0000:09: fixups for bus
[    1.614010] pci 0000:00:1c.3: PCI bridge to [bus 09-0a]
[    1.614112] pci 0000:00:1c.3:   bridge window [mem 0xf7e00000-0xf7efffff]
[    1.614121] pci_bus 0000:09: bus scan returning with max=09
[    1.614127] pci 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 0
[    1.614556] pci_bus 0000:0b: scanning bus
[    1.614613] pci 0000:0b:00.0: [104c:8241] type 00 class 0x0c0330
[    1.614650] pci 0000:0b:00.0: reg 10: [mem 0xf7d00000-0xf7d0ffff 64bit]
[    1.614678] pci 0000:0b:00.0: reg 18: [mem 0xf7d10000-0xf7d11fff 64bit]
[    1.614842] pci 0000:0b:00.0: supports D1 D2
[    1.614844] pci 0000:0b:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.614851] pci 0000:0b:00.0: PME# disabled
[    1.615100] pci 0000:0b:00.0: System wakeup disabled by ACPI
[    1.615692] pci_bus 0000:0b: fixups for bus
[    1.615693] pci 0000:00:1c.4: PCI bridge to [bus 0b-0c]
[    1.615795] pci 0000:00:1c.4:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    1.615804] pci_bus 0000:0b: bus scan returning with max=0b
[    1.615810] pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 0
[    1.616238] pci_bus 0000:11: scanning bus
[    1.616292] pci 0000:11:00.0: [1095:3132] type 00 class 0x018000
[    1.616334] pci 0000:11:00.0: reg 10: [mem 0xf6c84000-0xf6c8407f 64bit]
[    1.616367] pci 0000:11:00.0: reg 18: [mem 0xf6c80000-0xf6c83fff 64bit]
[    1.616389] pci 0000:11:00.0: reg 20: [io  0xc000-0xc07f]
[    1.616431] pci 0000:11:00.0: reg 30: [mem 0xf6c00000-0xf6c7ffff pref]
[    1.616546] pci 0000:11:00.0: supports D1 D2
[    1.617192] pci_bus 0000:11: fixups for bus
[    1.617193] pci 0000:00:1c.7: PCI bridge to [bus 11-16]
[    1.617292] pci 0000:00:1c.7:   bridge window [io  0xc000-0xdfff]
[    1.617297] pci 0000:00:1c.7:   bridge window [mem 0xf6c00000-0xf7cfffff]
[    1.617307] pci 0000:00:1c.7:   bridge window [mem 0xf0000000-0xf10fffff 64bit pref]
[    1.617308] pci_bus 0000:11: bus scan returning with max=11
[    1.617314] pci 0000:00:1c.0: scanning [bus 03-04] behind bridge, pass 1
[    1.617324] pci 0000:00:1c.1: scanning [bus 05-06] behind bridge, pass 1
[    1.617333] pci 0000:00:1c.3: scanning [bus 09-0a] behind bridge, pass 1
[    1.617342] pci 0000:00:1c.4: scanning [bus 0b-0c] behind bridge, pass 1
[    1.617351] pci 0000:00:1c.7: scanning [bus 11-16] behind bridge, pass 1
[    1.617358] pci_bus 0000:00: bus scan returning with max=16
[    1.617359] ACPI _OSC control for PCIe not granted, disabling ASPM
[    1.624464] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    1.626424] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 10 11 12 14 15)
[    1.628384] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
[    1.630341] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.632286] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.634296] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    1.636320] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 10 11 12 14 15)
[    1.638286] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 10 11 12 14 15)
[    1.641066] ACPI: Enabled 4 GPEs in block 00 to 3F
[    1.641085] acpi root: \_SB_.PCI0 notify handler is installed
[    1.641253] Found 1 acpi root devices


You see, the 11:00 does not say: 'System wakeup disabled by ACPI'?

Len, if you wat to get acpidump and full dmesg I can send it to you directly. Custom
DSDT?


