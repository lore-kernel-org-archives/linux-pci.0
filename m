Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15836 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbaBCAGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 2 Feb 2014 19:06:11 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0E00M5Y8A90Q40@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 03 Feb 2014 09:06:09 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Viresh Kumar' <viresh.linux@gmail.com>,
	'spear-devel' <spear-devel@list.st.com>,
	linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <201401301444.57541.arnd@arndb.de> <20140131044446.GE2618@pratyush-vbox>
 <201401312001.20708.arnd@arndb.de>
 <CAHM4w1k6Y6OWc-qe7-Z9m1FR0OeKE3v=_wsR4NonVsz3yo2J2Q@mail.gmail.com>
In-reply-to: <CAHM4w1k6Y6OWc-qe7-Z9m1FR0OeKE3v=_wsR4NonVsz3yo2J2Q@mail.gmail.com>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Mon, 03 Feb 2014 09:06:08 +0900
Message-id: <000301cf2073$bd4c5d20$37e51760$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, February 01, 2014 3:32 PM, Pratyush Anand wrote:
> On 2/1/14, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 31 January 2014, Pratyush Anand wrote:
> >> > That seems fine from the DT bindings perspective but raises two other
> >> > questions:
> >> >
> >> > 1. Are you not lacking an interrupt-map property to enable legacy IntA
> >> >    IRQs?
> >>
> >> As current pcie-designeware driver is not supporting legacy IntA IRQs,
> >> so we left it.
> >
> > Hmm, that sounds hard to believe. Doesn't that exclude 90% of the add-on
> > cards? I noticed that imx also doesn't have it, but exynos does.
> >
> > Can you check the data sheet again? Maybe the IntA IRQs are not mapped to
> 
> I did not say that designware controller does not supoort it.
> It does support. But pcie-designware driver  is not supporting
> it as of now. I think, a common irq_chip for intx handling need
> to be created in designware driver.
> 
> I am not sure even if exynos does define dt bindings for irq,
> are they able to use it?
> Jingoo can comment.

In the case of Exynos, there are three interrupts for PCIe;
it has different INTx line and MSI line for interrupts.

./arch/arm/boot/dts/exynos5440.dtsi
	interrupts = <0 20 0>, <0 21 0>, <0 22 0>;

<0 20 0>: PCIe RC0 pulse interrupt,
             INTA, INTB, INTC and INTD, etc
<0 21 0>: PCIe RC0 level interrupt,
             MSI, etc
<0 22 0>: PCIe RC0 special interrupt,
             PHY Link related interrupts, etc

Of course, legacy INTx is handled as message only.

Best regards,
Jingoo Han

> 
> > host (GIC) IRQs but instead get handled internally in the MSI controller?
> > IIRC, PCIe INTa IRQs are implemented as MSI on the bus, but normally
> > get turned into physical IRQ lines by the root complex. If the RC
> > contains the MSI controller itself, that may have a special register
> > for the LSI.
> 
> I agree that in PCIe Intx is also handled as message only. As far as
> designware controller is concerned, it has different intx and msi
> controller.  Now, a SoC can have two different irq line or can have
> a single irq line at gic for MSI and INTx. In SPEAr13xx we have a single
> IRQ line for both MSI and INTx.
> 
> Once this patch set gets into mainline, may be someone of us will work
> to add irq chip for INTx in common designware driver, and also its wrapper
> in SPEAr13xx pcie driver.  At that time we will add interrupt-map property to
> enable legacy IntA.
> 
> >
> >> > 2. If the MSI controller is integrated in the pcie host controller,
> >> >    does that maintain the PCIe ordering guarantees between inbound
> >> >    DMA and MSI, or is it possible that the <0 68 0x4> IRQ gets
> >> >    raised at the CPU before the the DMA transfer becomes visible to
> >> >    the CPU in main memory?
> >>
> >> If the system does not guarantee it, then won't be it a bug in the
> >> hardware?
> >> In our case, there is no separate interrupt for DMA completion. (I do
> >> not know if other system does have DMA interrupt). We have only one
> >> interrupt and when it is received SW will look into main memory (MSI
> >> address) for MSI data. If DMA transfer is yet not complete, then SW ll
> >> read junk data and which will be  a bug.
> >>
> >> We have never seen any erroneous behaviour with MSI interrupt.
> >
> > There should not be a separate interrupt for DMA, the typical behavior
> > of a PCIe adapter (SCSI, ethernet, ...) is that it sends an MSI after
> > data has arrived from an external interface and gets submitted as a
> > bus-master DMA into main memory. The actual data transfer may have the
> > 'relaxed ordering' bit set on the PCIe transaction, but the MSI message
> > (which is essentially a 4-byte DMA) will not, which means that all buses
> > are required to only forward the MSI after the DMA is completed.
> > If the PCIe host is located on a bus that is not directly connected
> > to the memory controller, the RC may have seen the DMA complete and
> > signalled the IRC to the CPU while the data transfer is still in
> > progress on its way to the actual memory.
> >
> > That kind of problem is extremely hard to debug and will only occur
> > in rare cases of bus congestion.
> 
> Agreed, But there is anything special for software to do here?
> 
> Thanks a lot for your review.
> 
> Regards
> Pratyush
> >
> > 	Arnd
> > --

