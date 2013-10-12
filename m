Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:37267 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab3JLJ2j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 12 Oct 2013 05:28:39 -0400
From: Marek Vasut <marex@denx.de>
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Sat, 12 Oct 2013 11:28:31 +0200
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com> <1381457552-6575-1-git-send-email-marex@denx.de> <20131012071959.GB21305@S2101-09.ap.freescale.net>
In-Reply-To: <20131012071959.GB21305@S2101-09.ap.freescale.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310121128.31801.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Shawn Guo,

> On Fri, Oct 11, 2013 at 04:12:31AM +0200, Marek Vasut wrote:
> > Some boards do not have a PCIe reset GPIO. To avoid probe
> > failure on these boards, make the reset GPIO optional as
> > well.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Frank Li <lznuaa@gmail.com>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > ---
> > 
> >  drivers/pci/host/pci-imx6.c | 29 +++++++++++++++--------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > index d3639aa..8e7adce 100644
> > --- a/drivers/pci/host/pci-imx6.c
> > +++ b/drivers/pci/host/pci-imx6.c
> > @@ -220,9 +220,12 @@ static int imx6_pcie_assert_core_reset(struct
> > pcie_port *pp)
> > 
> >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> >  	
> >  			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > 
> > -	gpio_set_value(imx6_pcie->reset_gpio, 0);
> > -	msleep(100);
> > -	gpio_set_value(imx6_pcie->reset_gpio, 1);
> > +	/* Some boards don't have PCIe reset GPIO. */
> > +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > +		gpio_set_value(imx6_pcie->reset_gpio, 0);
> > +		msleep(100);
> > +		gpio_set_value(imx6_pcie->reset_gpio, 1);
> > +	}
> > 
> >  	return 0;
> >  
> >  }
> > 
> > @@ -447,17 +450,15 @@ static int __init imx6_pcie_probe(struct
> > platform_device *pdev)
> > 
> >  	/* Fetch GPIOs */
> >  	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > 
> > -	if (!gpio_is_valid(imx6_pcie->reset_gpio)) {
> > -		dev_err(&pdev->dev, "no reset-gpio defined\n");
> > -		ret = -ENODEV;
> > -	}
> 
> The 'reset-gpio' is documented as a required property in bindings doc
> Documentation/devicetree/bindings/pci/designware-pcie.txt.  You need
> to update bindings doc if you turn it into an optional property.

That's true, thanks for pointing it out!
