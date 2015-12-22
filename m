Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42480 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbbLVRgx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 12:36:53 -0500
Date: Tue, 22 Dec 2015 09:33:33 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Martin Mares <mj@ucw.cz>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3] Add lspci support for Enhanced Allocation Capability.
Message-ID: <20151222173333.GA3301@sean.stalley.intel.com>
References: <1450217759-22063-1-git-send-email-ddaney.cavm@gmail.com>
 <mj+md-20151222.152501.98524.nikam@ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
In-Reply-To: <mj+md-20151222.152501.98524.nikam@ucw.cz>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 22, 2015 at 04:26:02PM +0100, Martin Mares wrote:
> 
> I will merge this soon.
> 
> Could you please provide a hex dump of a config space with this
> capability? (See the test cases in pciutils/tests/.)

Attached is a hex dump from a QEMU model using EA entries in leiu of BARs.

I also attached the output of lspci, so you can see how the Region fields are displayed.
Note that EA memory regions get tagged as [virtual].

I attached 2 outputs to show the truncation case I was talking about [1].
lt_size is the output when (x < 1024) is used in show_size(),
whereas mod_size is the output when (x % 1024) is used.

Thanks for taking a look,
Sean


[1]
diff mod_size lt_size
8c8
< 	Region 0: [virtual] Memory at 80000000 (32-bit, non-prefetchable) [size=131076]
---
> 	Region 0: [virtual] Memory at 80000000 (32-bit, non-prefetchable) [size=128K]

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=mod_size

00:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: [virtual] Memory at 80000000 (32-bit, non-prefetchable) [size=131076]
	Region 1: I/O ports at 0a00 [size=68]
	Capabilities: [40] Enhanced Allocation (EA): NumEntries=2
		Entry 0: Enable+ Writable- EntrySize=2
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 80000000
			 MaxOffset: 00020003
		Entry 1: Enable+ Writable- EntrySize=2
			 BAR Equivalent Indicator: BAR 1
			 PrimaryProperties: I/O space
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 00000a00
			 MaxOffset: 00000043
	Kernel driver in use: e1000


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lt_size

00:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
	Subsystem: Red Hat, Inc QEMU Virtual Machine
	Physical Slot: 4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: [virtual] Memory at 80000000 (32-bit, non-prefetchable) [size=128K]
	Region 1: I/O ports at 0a00 [size=68]
	Capabilities: [40] Enhanced Allocation (EA): NumEntries=2
		Entry 0: Enable+ Writable- EntrySize=2
			 BAR Equivalent Indicator: BAR 0
			 PrimaryProperties: memory space, non-prefetchable
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 80000000
			 MaxOffset: 00020003
		Entry 1: Enable+ Writable- EntrySize=2
			 BAR Equivalent Indicator: BAR 1
			 PrimaryProperties: I/O space
			 SecondaryProperties: entry unavailable for use, PrimaryProperties should be used
			 Base: 00000a00
			 MaxOffset: 00000043
	Kernel driver in use: e1000


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cap-ea

00:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
00: 86 80 0e 10 07 01 10 00 03 00 00 02 00 00 00 00
10: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00
40: 14 00 02 00 02 00 ff 80 00 00 00 80 00 00 02 00
50: 12 02 ff 80 00 0a 00 00 40 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


--IJpNTDwzlM2Ie8A6--
