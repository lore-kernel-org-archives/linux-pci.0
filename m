Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43440 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755454Ab3JNBSB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Oct 2013 21:18:01 -0400
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Mon, 14 Oct 2013 03:17:56 +0200
Cc: "'Shawn Guo'" <shawn.guo@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Frank Li'" <lznuaa@gmail.com>,
	"'Richard Zhu'" <r65037@freescale.com>,
	"'Sascha Hauer'" <s.hauer@pengutronix.de>,
	"'Sean Cross'" <xobs@kosagi.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	"'Yinghai Lu'" <yinghai@kernel.org>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Pratyush Anand'" <pratyush.anand@st.com>,
	"'Mohit KUMAR'" <Mohit.KUMAR@st.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com> <000501cec870$9aebcc80$d0c36580$%han@samsung.com> <201310140244.48433.marex@denx.de>
In-Reply-To: <201310140244.48433.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310140317.56961.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Han,

> > On Saturday, October 12, 2013 6:29 PM, Marek Vasut wrote:
> > > > On Fri, Oct 11, 2013 at 04:12:31AM +0200, Marek Vasut wrote:
> > > > > Some boards do not have a PCIe reset GPIO. To avoid probe
> > > > > failure on these boards, make the reset GPIO optional as
> > > > > well.
> > > > > 
> > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Frank Li <lznuaa@gmail.com>
> > > > > Cc: Richard Zhu <r65037@freescale.com>
> > > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Cc: Sean Cross <xobs@kosagi.com>
> > > > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > > > Cc: Yinghai Lu <yinghai@kernel.org>
> > > > > ---
> > > > > 
> > > > >  drivers/pci/host/pci-imx6.c | 29 +++++++++++++++--------------
> > > > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/host/pci-imx6.c
> > > > > b/drivers/pci/host/pci-imx6.c index d3639aa..8e7adce 100644
> > > > > --- a/drivers/pci/host/pci-imx6.c
> > > > > +++ b/drivers/pci/host/pci-imx6.c
> > > > > @@ -220,9 +220,12 @@ static int imx6_pcie_assert_core_reset(struct
> > > > > pcie_port *pp)
> > > > > 
> > > > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > > > >  	
> > > > >  			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > > > > 
> > > > > -	gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > > > -	msleep(100);
> > > > > -	gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > > > +	/* Some boards don't have PCIe reset GPIO. */
> > > > > +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > > > +		gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > > > +		msleep(100);
> > > > > +		gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > > > +	}
> > > > > 
> > > > >  	return 0;
> > > > >  
> > > > >  }
> > > > > 
> > > > > @@ -447,17 +450,15 @@ static int __init imx6_pcie_probe(struct
> > > > > platform_device *pdev)
> > > > > 
> > > > >  	/* Fetch GPIOs */
> > > > >  	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > > > > 
> > > > > -	if (!gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > > > -		dev_err(&pdev->dev, "no reset-gpio defined\n");
> > > > > -		ret = -ENODEV;
> > > > > -	}
> > > > 
> > > > The 'reset-gpio' is documented as a required property in bindings doc
> > > > Documentation/devicetree/bindings/pci/designware-pcie.txt.  You need
> > > > to update bindings doc if you turn it into an optional property.
> > > 
> > > That's true, thanks for pointing it out!
> > 
> > +cc Kishon Vijay Abraham I, Pratyush Anand, Mohit KUMAR
> > 
> > Yes, right.
> > "reset-gpio" property can be moved to an optional property.
> > Also, the patch to fix 'Designware' part such as 'designware-pcie.txt'
> > can be shared with other related people as below.
> > 
> >   - Samsung Exynos PCIe: Jingoo Han
> >   - ST Spear PCIe: Pratyush Anand, Mohit KUMAR
> >   - TI OMAP PCIe: Kishon Vijay Abraham I
> 
> I'm in the process of rebasing the patches on top of next 2013-10-10. Right
> now I'm getting a crash in __write_msi_msg() when my Intel "igb" reports
> "enabling bus mastering" . Any quick idea? Seems like this MSI support is
> new in the pcie- designware.c .
> 
> I'll just start plumbing to see what it is.

Looks like irq_alloc_descs() return -EEXIST for me in assign_irq() . Noone 
checks the return value of it , so it can fail later on ;-) Now, why does it 
return -EEXIST in the first place? I'm sure someone more experienced with PCI 
would know right away .
