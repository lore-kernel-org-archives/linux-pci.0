Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34088 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285AbbEMNyS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 May 2015 09:54:18 -0400
Received: by iecmd7 with SMTP id md7so32429904iec.1
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2015 06:54:17 -0700 (PDT)
Date: Wed, 13 May 2015 08:54:14 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Suravee Suthikulanit <suravee.suthikulpanit@amd.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jayachandran C <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Ming Lei <ming.lei@canonical.com>
Subject: Re: [PATCH v2 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150513135414.GA27374@google.com>
References: <1430791333-26013-1-git-send-email-jchandra@broadcom.com>
 <20150505155346.GJ1550@arm.com>
 <20150506141859.GC26028@red-moon>
 <CAErSpo7z_Sf5QvMa8MBY0f7DQOmwhcpUnCFG=ZsmHuwT2HouQw@mail.gmail.com>
 <554ADCE0.8020603@amd.com>
 <555347EE.6050502@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555347EE.6050502@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Suravee,

On Wed, May 13, 2015 at 07:47:42AM -0500, Suravee Suthikulanit wrote:
> On 5/6/2015 10:32 PM, Suravee Suthikulanit wrote:
> >I tested this patch series on the AMD Seattle w/o PCI_PROBE_ONLY mode
> >and that works fine. However, w/ PCI_PROBE_ONLY, I also run into the
> >resource not claimed issue (no surprise here).
> >
> >So, I tried porting the pcibios_claim_one_bus() from
> >arch/alpha/kernel/pci.c as Lorenzo suggested, plus the a small change in
> >pci_claim_resource(), and it seems to work w/ PCI_PROBE_ONLY. (Please
> >see example patch below.)
> >
> >The additional while loop is needed in the pci_claim_resource() since I
> >need to reference back to the resource in the root bus, which are
> >defined from the DT node. Does this sounds like a reasonable approach?
> >
> >diff --git a/drivers/pci/host/pci-host-generic.c
> >b/drivers/pci/host/pci-host-generic.c
> >index e9cc559..0dfa23d 100644
> >--- a/drivers/pci/host/pci-host-generic.c
> >+++ b/drivers/pci/host/pci-host-generic.c
> >@@ -261,7 +261,10 @@ static int gen_pci_probe(struct platform_device *pdev)
> >      if (!pci_has_flag(PCI_PROBE_ONLY)) {
> >          pci_bus_size_bridges(bus);
> >          pci_bus_assign_resources(bus);
> >+    } else {
> >+        pci_claim_one_bus(bus);
> >      }
> >+
> >      pci_bus_add_devices(bus);
> >
> >      /* Configure PCI Express settings */
> >diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> >index 232f925..d4b43b3 100644
> >--- a/drivers/pci/setup-res.c
> >+++ b/drivers/pci/setup-res.c
> >@@ -109,6 +109,7 @@ int pci_claim_resource(struct pci_dev *dev, int
> >resource)
> >  {
> >      struct resource *res = &dev->resource[resource];
> >      struct resource *root, *conflict;
> >+    struct pci_dev *pdev = dev;
> >
> >      if (res->flags & IORESOURCE_UNSET) {
> >          dev_info(&dev->dev, "can't claim BAR %d %pR: no address
> >assigned\n",
> >@@ -116,7 +117,18 @@ int pci_claim_resource(struct pci_dev *dev, int
> >resource)
> >          return -EINVAL;
> >      }
> >
> >-    root = pci_find_parent_resource(dev, res);
> >+    while (pdev) {
> >+        root = pci_find_parent_resource(pdev, res);
> >+        if (root)
> >+            break;
> >+
> >+        if (pci_has_flag(PCI_PROBE_ONLY) &&
> >+            !pci_is_root_bus(pdev->bus))
> >+            pdev = pdev->bus->self;
> >+        else
> >+            break;
> >+    }
> >+
> >      if (!root) {
> >          dev_info(&dev->dev, "can't claim BAR %d %pR: no compatible
> >bridge window\n",
> >               resource, res);
> 
> 
> [From Bjorn]
> I don't understand this new loop.  Apparently you have a device BAR, and
> the upstream bridge doesn't have a window that contains the BAR?  That
> sounds like a problem with the upstream bridge resources.
> 
> Do you have an example that would make this more concrete, e.g., a host
> bridge, P2P bridge(s), and endpoint with their resources?
> 
> [Suravee]
> Here is the information you were asking for. This information is
> setup from the FW. In the PCI bridge (00:02.1), I see the
> prefetchable memory behind bridge is already setup.

Here's a summary:

  00:02.1: PCI bridge to [bus 01]
  00:02.1:   [io window disabled]
  00:02.1:   [mem window disabled]
  00:02.1:   bridge window [mem 0x7f_ffe0_0000-0x7f_ffff_ffff 64bit pref]
  01:00.0: BAR 0: [mem 0x7f_ffe8_0000-0x... 64bit pref]
  01:00.0: BAR 2: [io  0x0020-0x3f]
  01:00.0: BAR 4: [mem 0x7f_fff0_4000-0x... 64bit pref]

So I guess the new loop would be for the I/O resource because the
00:02.1 I/O window is disabled?  This definitely seems like a problem --
we should enable that I/O window so we can claim the 01:00.0 I/O
resource with the 00:02.1 I/O window as the parent.  We don't want the
parent to be the host bridge window.  In fact, unless we enable that
I/O window, the 01:00.0 I/O BAR won't even work!

It may be that the driver for 01:00.0 doesn't need the I/O BAR.  We
can leave the bridge I/O window disabled and let pci_claim_resource()
fail, which means we'll treat the 01:00.0 I/O BAR as unassigned.
That's all fine; we'll never turn on PCI_COMMAND_IO, and as long as
the driver doesn't request I/O space, everything should just work.
Note that the driver would have to use pci_enable_device_mem() to
tell us that it doesn't need I/O space.

> OUTPUT from lspci -tv:
> 
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Device 1a00
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Device 1a01
>            \-02.1  PCI Bridge -[01]--+-00.0  Intel Corporation
> 82599ES 10-Gigabit SFI/SFP+ Network Connection
>                         \-00.1  Intel Corporation 82599ES 10-Gigabit
> SFI/SFP+ Network Connection
> 
> OUTPUT from lspci -vvv:
> 
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1a00
> 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1a00
> 	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1a01
> 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 
> 00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1a02
> (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 00fff000-00000fff
> 	Memory behind bridge: fff00000-000fffff
> 	Prefetchable memory behind bridge: 0000007fffe00000-0000007fffffffff
> 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
> 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
> 		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
> .......
> 
> 01:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> SFI/SFP+ Network Connection (rev 01)
> 	Subsystem: Intel Corporation Ethernet Server Adapter X520-2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin A routed to IRQ 46
> 	Region 0: Memory at 7fffe80000 (64-bit, prefetchable) [size=512K]
> 	Region 2: I/O ports at 0020 [size=32]
> 	Region 4: Memory at 7ffff04000 (64-bit, prefetchable) [size=16K]
> .......
> 
> 01:00.1 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
> SFI/SFP+ Network Connection (rev 01)
> 	Subsystem: Intel Corporation Ethernet Server Adapter X520-2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0
> 	Interrupt: pin B routed to IRQ 47
> 	Region 0: Memory at 7fffe00000 (64-bit, prefetchable) [size=512K]
> 	Region 2: I/O ports at 0000 [size=32]
> 	Region 4: Memory at 7ffff00000 (64-bit, prefetchable) [size=16K]
> ........
> 
> Thanks,
> Suravee
> 
