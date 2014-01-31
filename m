Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63677 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932236AbaAaTBa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 14:01:30 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Fri, 31 Jan 2014 20:01:20 +0100
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cover.1391077731.git.mohit.kumar@st.com> <201401301444.57541.arnd@arndb.de> <20140131044446.GE2618@pratyush-vbox>
In-Reply-To: <20140131044446.GE2618@pratyush-vbox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201401312001.20708.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 31 January 2014, Pratyush Anand wrote:
> > That seems fine from the DT bindings perspective but raises two other
> > questions:
> > 
> > 1. Are you not lacking an interrupt-map property to enable legacy IntA
> >    IRQs?
> 
> As current pcie-designeware driver is not supporting legacy IntA IRQs,
> so we left it.

Hmm, that sounds hard to believe. Doesn't that exclude 90% of the add-on
cards? I noticed that imx also doesn't have it, but exynos does.

Can you check the data sheet again? Maybe the IntA IRQs are not mapped to
host (GIC) IRQs but instead get handled internally in the MSI controller?
IIRC, PCIe INTa IRQs are implemented as MSI on the bus, but normally
get turned into physical IRQ lines by the root complex. If the RC
contains the MSI controller itself, that may have a special register
for the LSI.

> > 2. If the MSI controller is integrated in the pcie host controller,
> >    does that maintain the PCIe ordering guarantees between inbound
> >    DMA and MSI, or is it possible that the <0 68 0x4> IRQ gets
> >    raised at the CPU before the the DMA transfer becomes visible to
> >    the CPU in main memory?
> 
> If the system does not guarantee it, then won't be it a bug in the
> hardware?
> In our case, there is no separate interrupt for DMA completion. (I do
> not know if other system does have DMA interrupt). We have only one
> interrupt and when it is received SW will look into main memory (MSI
> address) for MSI data. If DMA transfer is yet not complete, then SW ll
> read junk data and which will be  a bug.
> 
> We have never seen any erroneous behaviour with MSI interrupt.

There should not be a separate interrupt for DMA, the typical behavior
of a PCIe adapter (SCSI, ethernet, ...) is that it sends an MSI after
data has arrived from an external interface and gets submitted as a
bus-master DMA into main memory. The actual data transfer may have the
'relaxed ordering' bit set on the PCIe transaction, but the MSI message
(which is essentially a 4-byte DMA) will not, which means that all buses
are required to only forward the MSI after the DMA is completed.
If the PCIe host is located on a bus that is not directly connected
to the memory controller, the RC may have seen the DMA complete and
signalled the IRC to the CPU while the data transfer is still in
progress on its way to the actual memory.

That kind of problem is extremely hard to debug and will only occur
in rare cases of bus congestion.

	Arnd
