Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38981 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaENImx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 May 2014 04:42:53 -0400
Message-ID: <1400056898.4837.11.camel@weser.hi.pengutronix.de>
Subject: Re: [Q] Synopsys PCIe interrupts
From: Lucas Stach <l.stach@pengutronix.de>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Tim Harvey <tharvey@gateworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>
Date: Wed, 14 May 2014 10:41:38 +0200
In-Reply-To: <48f8fbc1569e49df8fe8e15e4138d8d9@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <fd5f29f175b2499e9d972629f1ccd74a@HKXPR06MB168.apcprd06.prod.outlook.com>
	 <001801cf6f0f$cfd4b510$6f7e1f30$%han@samsung.com>
	 <CAJ+vNU29uZn+TRx+X8miLuRXhQS32QQZkEF53y09ijNYm9NX7w@mail.gmail.com>
	 <48f8fbc1569e49df8fe8e15e4138d8d9@HKXPR06MB168.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

please limit your lines to a reasonable amount of characters, thanks.

Am Mittwoch, den 14.05.2014, 08:13 +0000 schrieb Phil Edworthy:
> Hi Tim,
> 
> On 14 May 2014 05:55, Tim wrote:
> > On Tue, May 13, 2014 at 5:59 PM, Jingoo Han <jg1.han@samsung.com>
> > wrote:
> > > On Wednesday, May 14, 2014 1:14 AM, Phil Edworthy wrote:
> > >>
> > >> Hi,
> > >>
> > >> I am currently writing another driver that uses the Synopsys Designware
> > >> PCIe host controller driver.
> > >>
> > >> In general, it all looks good thanks to all involved in this driver.
> > >> One area that I am having a little problem with is the interrupts.
> > >>  According to the documentation I have, the module has separate
> > >> interrupts for INTA, INTB, INTC, INTD, MSI, AER, bandwidth management,
> > >>  PME (and possibly a couple of others as well).
> > >>
> > >> However, so far it looks like the upstream implementations just use
> > >> a single interrupt for the module, is that correct? I notice that some
> > >>  DT bindings include other interrupts that are not part of the Designware
> > >> PCIe controller, but that's not what I'm talking about.
> > >
> > > (+cc Mohit Kumar, Pratyush Anand, Marek Vasut, Kishon Vijay Abraham I,
> > >        Lucas Stach, Tim Harvey, Arnd Bergmann)
> > >
> > > PCIe Interrupt mapping is specific for SoC.
> > >
> > > In the case of Exynos, there are three interrupts for
> > > Exynos PCIe; INTx, MSI, PHY Link, respectively as below.
> > >
> > > ./arch/arm/boot/dts/exynos5440.dtsi
> > >         interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > >
> > > <0 20 0>: PCIe RC0 pulse interrupt,
> > >              INTA, INTB, INTC and INTD, etc
> > > <0 21 0>: PCIe RC0 level interrupt,
> > >              MSI, etc
> > > <0 22 0>: PCIe RC0 special interrupt,
> > >              PHY Link related interrupts, etc
> > >
> > > So, there are three lines between GIC and PCIe. Also, IRQ mappings
> > > for other SoCs are different.
> > >
> > > For example, the IMX6 maps INTA/B/C/D to ARM GIC IRQ 155/154/153/152
> > > respectively.
> > >
> > > Then, how many lines are there between GIC and PCIe in your SoC?
> > > How does your SoC map interrupts to GIC?
> > >
> > >>
> > >> In existing implementations, does the hardware just OR
> > >> all these interrupts together?
> > >>
> > 
> > Phil,
> > 
> > There is not just a single interrupt for the upstream implementations.
> > See:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/
> > host/pcie-designware.c#n742
> > 
> > of_irq_parse_and_map_pci(dev, slot, pin) is used to parse the
> > device-tree interrupt map which defines the multiple IRQ's that Jingoo
> > mentions above. For IMX6 these are defined in the imx6qdl.dtsi here:
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/b
> > oot/dts/imx6qdl.dtsi#n146.
> > 
> > So in other words, depending on the slot and pin (each legacy PCI
> > device can have 4 interrupt pins, INTA/B/C/D) the irq would get mapped
> > to a different interrupt. The interrupts are not OR'd together.
> 
> I've just had a look through Lucas' patches for adding MSI interrupts
> to imx6qdl. From this it looks like imx6qdl has 4 interrupts, one is a
> combined interrupt for INTA and MSI, and the other three are for INTB,
> INTC, INTD. Is that correct?
> 
It's the other way around: MSI and INTD share a single irq line, but in
principle your description is correct.
 
> As I mentioned previously, the Synopsys DW PCIe Host IP (or at least
> the version 4.21a that I am looking at) actually outputs all of these
> interrupts (and others for AER, etc) as separate signals. Both the
> Exynos and imx6qdl SoCs appear to combine some of these interrupts.
> 
I don't have access to the underlying DW IP core documentation, only to
a i.MX specific one, so I only know about this specific implementation.

i.MX doesn't seem to have the AER irq wired up.

Because of those differences I've pushed the irq properties of the
binding into the SoC specific part.
If we can enumerate all irq signals from the DW core we could maybe push
this stuff back into common doc/code, but I'm not sure about how to
handle this without breaking the Exynos binding. i.MX won't care as the
only irq it uses besides the legacy irqs, which are mapped through DT,
is now a named irq.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

