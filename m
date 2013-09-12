Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:22301 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751475Ab3ILHLu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Sep 2013 03:11:50 -0400
Date: Thu, 12 Sep 2013 15:11:45 +0800
From: Sean Cross <xobs@kosagi.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>
Message-ID: <65E0D2C79B2B43D28CC77454F44ECCFA@kosagi.com>
In-Reply-To: <20130912070131.GO30088@pengutronix.de>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
 <1378958611-4274-4-git-send-email-xobs@kosagi.com>
 <20130912062859.GM30088@pengutronix.de>
 <6FF3113C3FCC43A4A0D711C8656A4C03@kosagi.com>
 <20130912070131.GO30088@pengutronix.de>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, 12 September, 2013 at 3:01 PM, Sascha Hauer wrote:
> On Thu, Sep 12, 2013 at 02:44:01PM +0800, Sean Cross wrote:
> > > Sean,
> > > 
> > > Several more comments.
> > > 
> > > > +static int pcie_phy_poll_ack(void __iomem *dbi_base, int max_iterations,
> > > > + int exp_val)
> > > > +{
> > > > + u32 val;
> > > > + u32 wait_counter = 0;
> > > > +
> > > > + do {
> > > > + val = readl(dbi_base + PCIE_PHY_STAT);
> > > > + val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> > > > + wait_counter++;
> > > > + } while ((wait_counter < max_iterations) && (val != exp_val));
> > > 
> > > 
> > > 
> > > 
> > > 
> > > may_iterations is never something else than 100 so you should drop the
> > > argument.
> > > Also I would prefer a real timeout here rather than a counter.
> > 
> > 
> > 
> > Is there a construct to have a real timer? Would a completion work here instead?
> 
> A completion is overkill. Polling is fine, but it should be a well
> defined amount of time which is independent of current cpu speed. Adding
> a udelay(1) to the loop should be enough.

In that case, it makes sense to drop the max_iterations value by a factor of 10 or so. 
> > > 
> > > 
> > > I'm unsure this should be done here. Shawn, should we do this in SoC
> > > code?
> > 
> > 
> > 
> > A different board could easily use lvds2 to drive the PCIe clock. I think that I should change the variable names to simply "lvds_sel".
> 
> Why should it use a different clock? It's fine to make this
> configurable, but only if we actually know the reasons why it should be
> configurable.
> 
> Even if it should be configurable I'm still unsure whether this should
> be done at pci driver level.

I'm a bit wary of including clock setup like this in the SoC code, as different boards might be different.  If a board designer wants to run LVDS2 to the PCIe slot, that's entirely acceptable.  It might not actually ever get done, but it seems like the sort of board-specific thing that device tree was designed to handle.
> > > devm_gpio_request_one can still fail.
> > 
> > It can fail, but it's only critical for the power switch. However, arguably it's a critical error even if these GPIOs can't be allocated, so I'll go ahead and add the same consistency check and error return code to the other three switches.
> 
> 
> 
> If you want to make the gpios optional that's fine, but when
> of_get_named_gpio succeeds, then devm_gpio_request_one should succeed
> aswell, otherwise there's something wrong.

Ah, alright.  I'll add the errors, then. 
> > > > + struct imx6_pcie *imx6_pcie = platform_get_drvdata(pdev);
> > > > +
> > > > + clk_disable_unprepare(imx6_pcie->pcie_axi);
> > > > + clk_disable_unprepare(imx6_pcie->lvds1_gate);
> > > > + clk_disable_unprepare(imx6_pcie->pcie_ref_125m);
> > > 
> > > 
> > > 
> > > 
> > > 
> > > Still no unregister for the pcie controller?
> > The Designware core doesn't support unregistering (or even module unloading). I'm not sure how to handle that case. For that matter, when is remove() even called on a module that can't be unloaded?
> 
> 
> 
> Then don't implement the remove callback. That's better than providing a
> bogus remove function.

I'll cut out the remove() function. 


