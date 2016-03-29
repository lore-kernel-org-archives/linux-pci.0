Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:62259 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbcC2Ov1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2016 10:51:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Krzysztof =?utf-8?B?SGHFgmFzYQ==?= <khalasa@piap.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Petr =?utf-8?B?xaB0ZXRpYXI=?= <ynezz@true.cz>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
Date: Tue, 29 Mar 2016 16:50:40 +0200
Message-ID: <5741237.2X2Q0sCFQj@wuerfel>
In-Reply-To: <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl> <23031613.R8qN30TbTq@wuerfel> <CAJ+vNU2BKLDREOWP8EWXZR43to10yw+qvKwv1MzS4a_L9n5ozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 29 March 2016 07:29:34 Tim Harvey wrote:
> On Tue, Mar 29, 2016 at 6:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 29 March 2016 06:32:29 Tim Harvey wrote:

> >> I think 31e98e0d24cd2537a63e06e235e050a06b175df7 "ARM:
> >> imx_v6_v7_defconfig: enable PCI_MSI" should be reverted as well until
> >> we figure this out.
> >
> > That doesn't sound like a helpful solution, multi_v7_defconfig for
> > instance will still be broken because it enables PCI_MSI, and so
> > will be all major distros.
> 
> Arnd,
> 
> True, but keep in mind that as far as I can tell this behavior has
> been around since MSI was added to the IMX6 (breakage of devices that
> use legacy irq's if MSI is enabled) which was in 3.16.

I see. This part wasn't clear to me.

> > What happens if we patch the pci-imx6 driver to not make use of
> > its MSI support even when that is enabled in the kernel? Does that
> > get both devices in your GW5xxx to work with legacy interrupts or
> > is one or both of them still broken?
> >
> >         Arnd
> >
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index eb5a2755a164..d7607b2695c6 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -470,7 +470,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
> >
> >         imx6_pcie_establish_link(pp);
> >
> > -       if (IS_ENABLED(CONFIG_PCI_MSI))
> > +       if (0 && IS_ENABLED(CONFIG_PCI_MSI))
> >                 dw_pcie_msi_init(pp);
> >  }
> >
> > @@ -490,7 +490,7 @@ static int __init imx6_add_pcie_port(struct pcie_port *pp,
> >  {
> >         int ret;
> >
> > -       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > +       if (0 && IS_ENABLED(CONFIG_PCI_MSI)) {
> >                 pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> >                 if (pp->msi_irq <= 0) {
> >                         dev_err(&pdev->dev, "failed to get MSI irq\n");
> >
> 
> That is not enough - we would also need to disable a couple more in
> the designware core that imx6 uses, which is also used by several
> other SoC's. We should probably get some feedback from people with
> those SoC's regarding MSI breaking legacy irqs.

Good point. I really just meant this as an experiment, trying to
figure out what causes it to break. I'd be surprised if the
MSI support in the generic pcie-designware driver caused the same
problem on the other SoCs.

> PCI_MSI was enabled in imx_v6_v7_defconfig in 4.5 and enabled in
> multi_v7_defconfig back in 3.16. PCI MSI was first introduced for the
> IMX6 host controller in 3.16 as well. I verified that the same issue
> exists all the way back to 3.16.

Thanks for doing that research.

> I don't know if its worse to disable PCI MSI for IMX6/designware all
> the way back to 3.16 or to disable it just back to 4.5 where imx_v6_v7
> enabled it, or perhaps just figure out the actual issue and get that
> backported?

I'd like to see the problem understood better before we talk about
backports.

One thing I just noticed is that the same GPC interrupt line (GIC_SPI
120) is used for MSI and for IntD. Maybe there is something going on with
sharing an interrupt line between a nested irqchip and a device?

Could this be a bug in the generic IRQ handling code? Can you check
which interrupt the broken device(s) on your machine are using? Is
it always the 120 (IntD) line, or are the other three lines broken
as well? I don't actually know how to look it up, but the 'lspci -t'
output should let us reconstruct the swizzling manually.

	Arnd
