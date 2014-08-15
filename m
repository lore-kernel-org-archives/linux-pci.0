Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:47274 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaHOFBt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Aug 2014 01:01:49 -0400
Received: by mail-ig0-f172.google.com with SMTP id h15so982090igd.11
        for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2014 22:01:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1407745453.4660.7.camel@weser.hi.pengutronix.de>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	<1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	<CAJ+vNU0vT2Fot6V=pn7HKDctNHrWMDiudghVTtAojv8mPDXhBw@mail.gmail.com>
	<1407745453.4660.7.camel@weser.hi.pengutronix.de>
Date: Thu, 14 Aug 2014 22:01:48 -0700
Message-ID: <CAJ+vNU2QEQQEA93n_Rc952Wyht1Ytd09tpU7XRyo_rVop5SWdA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Tim Harvey <tharvey@gateworks.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <Shawn.Guo@freescale.com>,
	Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 11, 2014 at 1:24 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Tim,
>
> Am Samstag, den 09.08.2014, 10:49 -0700 schrieb Tim Harvey:
> [...]
>
>> i/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
>> > index a568efaa331c..1be607360988 100644
>> > --- a/drivers/pci/host/pci-imx6.c
>> > +++ b/drivers/pci/host/pci-imx6.c
>> > @@ -49,6 +49,9 @@ struct imx6_pcie {
>> >
>> >  /* PCIe Port Logic registers (memory-mapped) */
>> >  #define PL_OFFSET 0x700
>> > +#define PCIE_PL_PFLR (PL_OFFSET + 0x08)
>> > +#define PCIE_PL_PFLR_LINK_STATE_MASK           (0x3f << 16)
>> > +#define PCIE_PL_PFLR_FORCE_LINK                        (1 << 15)
>> >  #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
>> >  #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
>> >  #define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING        (1 << 29)
>> > @@ -214,6 +217,31 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>> >  static int imx6_pcie_assert_core_reset(struct pcie_port *pp)
>> >  {
>> >         struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
>> > +       u32 val, gpr1, gpr12;
>> > +
>> > +       /*
>> > +        * If the bootloader already enabled the link we need some special
>> > +        * handling to get the core back into a state where it is safe to
>> > +        * touch it for configuration. As there is no dedicated reset signal
>> > +        * wired up for MX6QDL, we need to manually force LTSSM into "detect"
>> > +        * state before completely disabling LTSSM, which is a prerequisite
>> > +        * for core configuration.
>> > +        * If both LTSSM_ENABLE and REF_SSP_ENABLE are active we have a strong
>> > +        * indication that the bootloader activated the link.
>> > +        */
>> > +       regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1, &gpr1);
>> > +       regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, &gpr12);
>> > +
>> > +       if ((gpr1 & IMX6Q_GPR1_PCIE_REF_CLK_EN) &&
>> > +           (gpr12 & IMX6Q_GPR12_PCIE_CTL_2)) {
>> > +               val = readl(pp->dbi_base + PCIE_PL_PFLR);
>> > +               val &= ~PCIE_PL_PFLR_LINK_STATE_MASK;
>> > +               val |= PCIE_PL_PFLR_FORCE_LINK;
>> > +               writel(val, pp->dbi_base + PCIE_PL_PFLR);
>>
>> Lucas,
>>
>> I hate to delay this patch any longer as I believe its critical that
>> this gets in the current kernel. I did however encounter an issue when
>> I backported this to another (older 3.10 kernel I use). The access
>> above to dbi_base to force the link down assumes that PCIe clock is
>> enabled (or it will hang the system). This obviously must be the case
>> for the current kernel (the bootloader enables it and I guess the
>> clock setup for imx6 doesn't disturb it), but on the particular kernel
>> I was backporting to there must be enough differences in the clock
>> tree that the clock setup disabled the PCIe clocks. Thus I had to
>> enable them early, right before the access to dbi_base above in that
>> kernel.
>>
>> I wonder if we should at least put a comment before the dbi_base
>> access above about the assumption that the bootloader also enabled
>> PCIe clock and the clock config left it as such so we don't get burned
>> later on if the clock config changes and causes a hang here.
>>
>
> What clock are we talking about here exactly? If it's just the register
> clock "pcie" we may as well enable it early to make things robust. Other
> clocks may be a bit more problematic.
>

Lucas,

I'm not really sure, I just duplicated what was being done in the
regular clock setup to resolve my issue on a 3.10 vendor kernel where
I have backported the pci driver from mainline. I'm not clear yet why
the clocks still wouldn't be enabled from the bootloader, but I assume
its because of something else that is happening in that vendor kernel.
I don't feel there is anything wrong with your patch and have already
acked it - it solves a real issue with the current driver. Its just
worth realizing that clocks do have to be setup before you access
dbi_base which currently is true, but in the future may depend on
changes that occur outside of the pci driver.

Tim
