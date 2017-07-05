Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47852 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751755AbdGELNc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2017 07:13:32 -0400
Date: Wed, 5 Jul 2017 13:13:12 +0200
From: Wim ten Have <wim.ten.have@oracle.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Wim ten Have <wim.ten.have@oracle.com>
Subject: Re: Red Hat (Fedora) bug report 1467674 concerning your kernel
 functional performance enhancements causing PCI Express crashes,
Message-ID: <20170705131312.6073b8aa.wim.ten.have@oracle.com>
In-Reply-To: <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
References: <20170704161352.1cdb2670.wim.ten.have@oracle.com>
        <CAErSpo7PbSZgRtPJiXuOd6FPgLK5AGki51fTUm_-KUDZ96sRww@mail.gmail.com>
        <2acc9a73-0c2c-31f3-fcdf-42289213860e@codeaurora.org>
        <20170704195916.43fbe6e4.wim.ten.have@oracle.com>
        <97b8c58e-7384-0519-5ccb-837fa5054d84@codeaurora.org>
        <17f06c42-a96f-d1da-38e5-95117626eb29@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 4 Jul 2017 21:00:03 -0400
Sinan Kaya <okaya@codeaurora.org> wrote:

> On 7/4/2017 6:25 PM, Sinan Kaya wrote:
> > 
> > I can also see this in your lspci output. 
> > 
> > 00:08.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2) (prog-if 00 [Normal decode])
> > 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
> > 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> > 	Latency: 0, Cache Line Size: 64 bytes
> > 	Interrupt: pin A routed to IRQ 19
> > 	NUMA node: 0
> > 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> > 	I/O behind bridge: 0000f000-00000fff [empty]
> > 	Memory behind bridge: efe00000-efefffff [size=1M]
> > 	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff [empty]
> > 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
> > 	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
> > 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> > 	Capabilities: [a0] HyperTransport: MSI Mapping Enable+ Fixed-
> > 		Mapping Address Base: 00000000fee00000
> > 	Capabilities: [b0] Express (v1) Root Port (Slot-), MSI 00
> > 
> > I'll post a patch to apply extended tags to systems with PCI express v2 and higher
> > bridges only.
> 
> Please give this patch a try. I can make the patch pretty and re-post if it works for you. 

    Howdy,

  I setup your patch under an /usr/src/kernel/rpmbuild tree for current
  "kernel-4.11.8-200.fc25.src.rpm" and made below change to kernel.spec
  file together with an rpmbuild -ba cycle on SPECS/kernel.spec.

  Your patch under the SOURCE/PATCH tree

	<wtenhave@hagen:55> ls -l SOURCES/0001-pci-do-not-enable-extended-tags-on-pre-dated-v1.x-sy.patch 
	-rw-r--r-- 1 wtenhave users 2658 Jul  5 09:45 SOURCES/0001-pci-do-not-enable-extended-tags-on-pre-dated-v1.x-sy.patch

  Change to the kernel.spec file

	<wtenhave@hagen:56> rcsdiff -u SPECS/kernel.spec
	===================================================================
	RCS file: SPECS/kernel.spec,v
	retrieving revision 1.1
	diff -u -r1.1 SPECS/kernel.spec
	--- SPECS/kernel.spec	2017/07/05 07:54:17	1.1
	+++ SPECS/kernel.spec	2017/07/05 07:54:20
	@@ -635,6 +635,9 @@
	 # rhbz 1459326
	 Patch683: RFC-audit-fix-a-race-condition-with-the-auditd-tracking-code.patch
	 
	+# rhbz 1467674
	+Patch700: 0001-pci-do-not-enable-extended-tags-on-pre-dated-v1.x-sy.patch
	+
	 # END OF PATCH DEFINITIONS
	 
	 %endif

  From an 'rpmbuild -ba kernel.spec' nicely proceeded and generated all
  package.  They all installed and the system boots and works like a charm!

> You should be seeing messages like this during boot.
> 
> [    3.949621] pci 0003:01:00.0: clearing extended tags capability
> [    3.959540] pci 0003:01:00.1: clearing extended tags capability
> [    3.969454] pci 0003:01:00.2: clearing extended tags capability
> [    3.979373] pci 0003:01:00.3: clearing extended tags capability
> [    3.989290] pci 0003:01:00.4: clearing extended tags capability

  Correct ... see excerpt below.

	[    0.000000] Linux version 4.11.8-200.fc25.x86_64 (root@hagen) (gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) ) #1 SMP Wed Jul 5 10:37:18 CEST 2017
	[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.11.8-200.fc25.x86_64 root=/dev/mapper/fedora_hagen-root ro rd.lvm.lv=fedora_hagen/root rd.lvm.lv=fedora_hagen/swap audit=0
	[    0.000000] x86/fpu: x87 FPU will use FXSAVE
	[    0.000000] e820: BIOS-provided physical RAM map:
		...
	[    0.532911] PCI host bridge to bus 0000:00
	[    0.533104] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
	[    0.533301] pci_bus 0000:00: root bus resource [io  0xd000-0xefff window]
	[    0.533501] pci_bus 0000:00: root bus resource [io  0x0d00-0x0fff window]
	[    0.533699] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
	[    0.534039] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xf1ffffff window]
	[    0.534376] pci_bus 0000:00: root bus resource [mem 0xefb00000-0xefffffff window]
	[    0.534722] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff window]
	[    0.535060] pci_bus 0000:00: root bus resource [bus 00-fd]
	[    0.535264] pci 0000:00:01.0: [1166:0036] type 01 class 0x060400
	[    0.535299] pci 0000:00:01.0: Enabling HT MSI Mapping
	[    0.535552] pci 0000:00:01.0: System wakeup disabled by ACPI
	[    0.535786] pci 0000:00:02.0: [1166:0205] type 00 class 0x060000
	[    0.535882] pci 0000:00:02.1: [1166:0214] type 00 class 0x01018a
	[    0.535904] pci 0000:00:02.1: reg 0x10: [io  0x01f0-0x01f7]
	[    0.535912] pci 0000:00:02.1: reg 0x14: [io  0x03f4-0x03f7]
	[    0.535920] pci 0000:00:02.1: reg 0x18: [io  0x0170-0x0177]
	[    0.535929] pci 0000:00:02.1: reg 0x1c: [io  0x0374-0x0377]
	[    0.535937] pci 0000:00:02.1: reg 0x20: [io  0x08c0-0x08cf]
	[    0.535956] pci 0000:00:02.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
	[    0.536154] pci 0000:00:02.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
	[    0.536350] pci 0000:00:02.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
	[    0.536551] pci 0000:00:02.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
	[    0.536814] pci 0000:00:02.2: [1166:0234] type 00 class 0x060100
	[    0.536951] pci 0000:00:03.0: [1166:0223] type 00 class 0x0c0310
	[    0.536967] pci 0000:00:03.0: reg 0x10: [mem 0xefbed000-0xefbedfff]
	[    0.536976] pci 0000:00:03.0: reg 0x14: [io  0xd000-0xd0ff]
	[    0.537089] pci 0000:00:03.1: [1166:0223] type 00 class 0x0c0310
	[    0.537104] pci 0000:00:03.1: reg 0x10: [mem 0xefbee000-0xefbeefff]
	[    0.537113] pci 0000:00:03.1: reg 0x14: [io  0xd400-0xd4ff]
	[    0.537222] pci 0000:00:03.2: [1166:0223] type 00 class 0x0c0320
	[    0.537237] pci 0000:00:03.2: reg 0x10: [mem 0xefbef000-0xefbeffff]
	[    0.537246] pci 0000:00:03.2: reg 0x14: [io  0xd800-0xd8ff]
	[    0.537311] pci 0000:00:03.2: supports D1 D2
	[    0.537312] pci 0000:00:03.2: PME# supported from D0 D1 D2 D3hot
	[    0.537373] pci 0000:00:04.0: [1002:515e] type 00 class 0x030000
	[    0.537389] pci 0000:00:04.0: reg 0x10: [mem 0xe0000000-0xe7ffffff pref]
	[    0.537398] pci 0000:00:04.0: reg 0x14: [io  0xdc00-0xdcff]
	[    0.537407] pci 0000:00:04.0: reg 0x18: [mem 0xefbf0000-0xefbfffff]
	[    0.537440] pci 0000:00:04.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
	[    0.537468] pci 0000:00:04.0: supports D1 D2
	[    0.537513] pci 0000:00:07.0: [1166:0140] type 01 class 0x060400
	[    0.537550] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
	[    0.537603] pci 0000:00:08.0: [1166:0142] type 01 class 0x060400
	[    0.537639] pci 0000:00:08.0: PME# supported from D0 D3hot D3cold
	[    0.537666] pci 0000:00:08.0: System wakeup disabled by ACPI
	[    0.537893] pci 0000:00:09.0: [1166:0144] type 01 class 0x060400
	[    0.537936] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
	[    0.537964] pci 0000:00:09.0: System wakeup disabled by ACPI
	[    0.538187] pci 0000:00:0a.0: [1166:0142] type 01 class 0x060400
	[    0.538221] pci 0000:00:0a.0: PME# supported from D0 D3hot D3cold
	[    0.538248] pci 0000:00:0a.0: System wakeup disabled by ACPI
	[    0.538478] pci 0000:00:0b.0: [1166:0144] type 01 class 0x060400
	[    0.538512] pci 0000:00:0b.0: PME# supported from D0 D3hot D3cold
	[    0.538577] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
	[    0.538629] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
	[    0.538683] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
	[    0.538729] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
	[    0.538778] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
	[    0.538827] pci 0000:00:19.0: [1022:1200] type 00 class 0x060000
	[    0.538885] pci 0000:00:19.1: [1022:1201] type 00 class 0x060000
	[    0.538945] pci 0000:00:19.2: [1022:1202] type 00 class 0x060000
	[    0.538993] pci 0000:00:19.3: [1022:1203] type 00 class 0x060000
	[    0.539045] pci 0000:00:19.4: [1022:1204] type 00 class 0x060000
	[    0.539152] pci 0000:03:0d.0: [1166:0104] type 01 class 0x060400
	[    0.539228] pci 0000:03:0e.0: [1166:024b] type 00 class 0x01018f
	[    0.539238] pci 0000:03:0e.0: reg 0x10: [io  0xecb0-0xecb7]
	[    0.539244] pci 0000:03:0e.0: reg 0x14: [io  0xeca0-0xeca3]
	[    0.539250] pci 0000:03:0e.0: reg 0x18: [io  0xecb8-0xecbf]
	[    0.539255] pci 0000:03:0e.0: reg 0x1c: [io  0xeca4-0xeca7]
	[    0.539261] pci 0000:03:0e.0: reg 0x20: [io  0xece0-0xecef]
	[    0.539267] pci 0000:03:0e.0: reg 0x24: [mem 0xefdfe000-0xefdfffff]
	[    0.539273] pci 0000:03:0e.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
	[    0.539337] pci 0000:00:01.0: PCI bridge to [bus 03-04]
	[    0.539537] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
	[    0.539540] pci 0000:00:01.0:   bridge window [mem 0xefc00000-0xefdfffff]
	[    0.539598] pci 0000:03:0d.0: PCI bridge to [bus 04]
	[    0.539828] pci 0000:00:07.0: PCI bridge to [bus 05]
	[    0.540068] pci 0000:01:00.0: [14e4:1659] type 00 class 0x020000
	[    0.540087] pci 0000:01:00.0: reg 0x10: [mem 0xefef0000-0xefefffff 64bit]
	[    0.540185] pci 0000:01:00.0: PME# supported from D3hot D3cold
	[    0.542890] pci 0000:00:08.0: PCI bridge to [bus 01]
	[    0.543094] pci 0000:00:08.0:   bridge window [mem 0xefe00000-0xefefffff]
	[    0.543155] pci 0000:02:00.0: [14e4:1659] type 00 class 0x020000
	[    0.543175] pci 0000:02:00.0: reg 0x10: [mem 0xefff0000-0xefffffff 64bit]
	[    0.543277] pci 0000:02:00.0: PME# supported from D3hot D3cold
	[    0.545889] pci 0000:00:09.0: PCI bridge to [bus 02]
	[    0.546088] pci 0000:00:09.0:   bridge window [mem 0xeff00000-0xefffffff]
	[    0.546130] pci 0000:00:0a.0: PCI bridge to [bus 06]
	[    0.546351] pci 0000:00:0b.0: PCI bridge to [bus 07]
***>	[    0.546570] pci 0000:01:00.0: clearing extended tags capability
***>	[    0.546773] pci 0000:02:00.0: clearing extended tags capability
		...

	<wtenhave@hagen:60> uname -a
	Linux hagen 4.11.8-200.fc25.x86_64 #1 SMP Wed Jul 5 10:37:18 CEST 2017 x86_64 x86_64 x86_64 GNU/Linux

  I'll update RHT Bugzilla entry 1467674 with this info. 
  Hope someone picks this up for Fedora25 and Fedora26 (next week).

Regards,
- Wim.
