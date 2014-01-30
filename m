Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:65022 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbaA3NpD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 08:45:03 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [PATCH V3 7/8] pcie: SPEAr13xx: Add designware pcie support
Date: Thu, 30 Jan 2014 14:44:57 +0100
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>, spear-devel@list.st.com,
	linux-pci@vger.kernel.org
References: <cover.1391077731.git.mohit.kumar@st.com> <1c7f0dd04e9af55886dc74789bfcf92ce900e131.1391077731.git.mohit.kumar@st.com> <201401301434.20188.arnd@arndb.de>
In-Reply-To: <201401301434.20188.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201401301444.57541.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 January 2014, Arnd Bergmann wrote:
> > +             pcie0: pcie@b1000000 {
> > +                     compatible = "st,spear1340-pcie", "snps,dw-pcie";
> > +                     reg = <0xb1000000 0x4000>;
> > +                     interrupts = <0 68 0x4>;
> > +                     pcie_is_gen1 = <0>;
> > +                     num-lanes = <1>;
> > +                     phys = <&miphy0 1 0>;
> > +                     phy-names = "pcie-phy";
> > +                     #address-cells = <3>;
> > +                     #size-cells = <2>;
> > +                     device_type = "pci";
> > +                     ranges = <0x00000800 0 0x80000000 0x80000000 0 0x00020000   /* configuration space */
> > +                             0x81000000 0 0   0x80020000 0 0x00010000   /* downstream I/O */
> > +                             0x82000000 0 0x80030000 0xc0030000 0 0x0ffd0000>; /* non-prefetchable memory */
> > +                     status = "disabled";
> > +             };
> 
> Shouldn't there be more than one interrupt? Normally each root port has
> four legacy IRQs, in order to support bridge devices.
> 

Sorry, my mistake: I was thinking of the interrupt map for legacy IRQs.
The interrupt here is used only for the integrated MSI controller, right?
That seems fine from the DT bindings perspective but raises two other
questions:

1. Are you not lacking an interrupt-map property to enable legacy IntA
   IRQs?

2. If the MSI controller is integrated in the pcie host controller,
   does that maintain the PCIe ordering guarantees between inbound
   DMA and MSI, or is it possible that the <0 68 0x4> IRQ gets
   raised at the CPU before the the DMA transfer becomes visible to
   the CPU in main memory?

	Arnd
