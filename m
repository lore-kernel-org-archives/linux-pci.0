Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41868 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab3ILHBe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2013 03:01:34 -0400
Date: Thu, 12 Sep 2013 09:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Message-ID: <20130912070131.GO30088@pengutronix.de>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
 <1378958611-4274-4-git-send-email-xobs@kosagi.com>
 <20130912062859.GM30088@pengutronix.de>
 <6FF3113C3FCC43A4A0D711C8656A4C03@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6FF3113C3FCC43A4A0D711C8656A4C03@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 12, 2013 at 02:44:01PM +0800, Sean Cross wrote:
> > Sean,
> > 
> > Several more comments.
> > 
> > Shawn,
> > 
> > A question about a clk_set_parent inside.
> > 
> > On Thu, Sep 12, 2013 at 04:03:31AM +0000, Sean Cross wrote:
> > > +
> > > +#define IMX6_ENTER_RESET 0
> > > +#define IMX6_EXIT_RESET 1
> > 
> > 
> > 
> > These are unused
> > 
> > > +
> > > +#define IMX6_POWER_OFF 0
> > > +#define IMX6_POWER_ON 1
> > 
> > 
> > 
> > unused aswell
> > 
> Thanks.  These leaked out from an earlier revision of the code.  I'll remove them. 
> > 
> > > +static int pcie_phy_poll_ack(void __iomem *dbi_base, int max_iterations,
> > > + int exp_val)
> > > +{
> > > + u32 val;
> > > + u32 wait_counter = 0;
> > > +
> > > + do {
> > > + val = readl(dbi_base + PCIE_PHY_STAT);
> > > + val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> > > + wait_counter++;
> > > + } while ((wait_counter < max_iterations) && (val != exp_val));
> > 
> > 
> > 
> > may_iterations is never something else than 100 so you should drop the
> > argument.
> > Also I would prefer a real timeout here rather than a counter.
> 
> Is there a construct to have a real timer?  Would a completion work here instead?

A completion is overkill. Polling is fine, but it should be a well
defined amount of time which is independent of current cpu speed. Adding
a udelay(1) to the loop should be enough.

> > 
> > 
> > I'm unsure this should be done here. Shawn, should we do this in SoC
> > code?
> 
> A different board could easily use lvds2 to drive the PCIe clock.  I think that I should change the variable names to simply "lvds_sel".

Why should it use a different clock? It's fine to make this
configurable, but only if we actually know the reasons why it should be
configurable.

Even if it should be configurable I'm still unsure whether this should
be done at pci driver level.

> > 
> > 
> > devm_gpio_request_one can still fail.
> It can fail, but it's only critical for the power switch.  However, arguably it's a critical error even if these GPIOs can't be allocated, so I'll go ahead and add the same consistency check and error return code to the other three switches.

If you want to make the gpios optional that's fine, but when
of_get_named_gpio succeeds, then devm_gpio_request_one should succeed
aswell, otherwise there's something wrong.

> > > + struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> > > +
> > > + clk_disable_unprepare(imx6_pcie->pcie_axi);
> > > + clk_disable_unprepare(imx6_pcie->lvds1_gate);
> > > + clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
> > 
> > 
> > 
> > Still no unregister for the pcie controller?
> The Designware core doesn't support unregistering (or even module unloading).  I'm not sure how to handle that case.  For that matter, when is remove() even called on a module that can't be unloaded?

Then don't implement the remove callback. That's better than providing a
bogus remove function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
