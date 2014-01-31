Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog125.obsmtp.com ([207.126.144.159]:41722 "EHLO
	eu1sys200aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753837AbaAaEo7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 23:44:59 -0500
Date: Fri, 31 Jan 2014 10:14:46 +0530
From: Pratyush Anand <pratyush.anand@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Message-ID: <20140131044446.GE2618@pratyush-vbox>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <1c7f0dd04e9af55886dc74789bfcf92ce900e131.1391077731.git.mohit.kumar@st.com>
 <201401301434.20188.arnd@arndb.de>
 <201401301444.57541.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <201401301444.57541.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 30, 2014 at 09:44:57PM +0800, Arnd Bergmann wrote:
> On Thursday 30 January 2014, Arnd Bergmann wrote:
> > > +             pcie0: pcie@b1000000 {
> > > +                     compatible = "st,spear1340-pcie", "snps,dw-pcie";
> > > +                     reg = <0xb1000000 0x4000>;
> > > +                     interrupts = <0 68 0x4>;
> > > +                     pcie_is_gen1 = <0>;
> > > +                     num-lanes = <1>;
> > > +                     phys = <&miphy0 1 0>;
> > > +                     phy-names = "pcie-phy";
> > > +                     #address-cells = <3>;
> > > +                     #size-cells = <2>;
> > > +                     device_type = "pci";
> > > +                     ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
> > > +                             0x81000000 0 0   0x80020000 0 0x00010000   /* downstream I/O */
> > > +                             0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
> > > +                     status = "disabled";
> > > +             };
> > 
> > Shouldn't there be more than one interrupt? Normally each root port has
> > four legacy IRQs, in order to support bridge devices.
> > 
> 
> Sorry, my mistake: I was thinking of the interrupt map for legacy IRQs.
> The interrupt here is used only for the integrated MSI controller, right?

yes.

> That seems fine from the DT bindings perspective but raises two other
> questions:
> 
> 1. Are you not lacking an interrupt-map property to enable legacy IntA
>    IRQs?

As current pcie-designeware driver is not supporting legacy IntA IRQs,
so we left it.

> 
> 2. If the MSI controller is integrated in the pcie host controller,
>    does that maintain the PCIe ordering guarantees between inbound
>    DMA and MSI, or is it possible that the <0 68 0x4> IRQ gets
>    raised at the CPU before the the DMA transfer becomes visible to
>    the CPU in main memory?

If the system does not guarantee it, then won't be it a bug in the
hardware?
In our case, there is no separate interrupt for DMA completion. (I do
not know if other system does have DMA interrupt). We have only one
interrupt and when it is received SW will look into main memory (MSI
address) for MSI data. If DMA transfer is yet not complete, then SW ll
read junk data and which will be  a bug.

We have never seen any erroneous behaviour with MSI interrupt.

Regards
Pratyush
> 
> 	Arnd
