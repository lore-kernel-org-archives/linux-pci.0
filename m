Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13305 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3JNACE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 13 Oct 2013 20:02:04 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUM00BNSTFCFN00@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 14 Oct 2013 09:02:00 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, 'Shawn Guo' <shawn.guo@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>
References: <CAErSpo5e5ZyVqGOHR9p568k7_Qx4tBQCBjQvWvL+xGCqFLHHKQ@mail.gmail.com>
 <1381457552-6575-1-git-send-email-marex@denx.de>
 <20131012071959.GB21305@S2101-09.ap.freescale.net>
 <201310121128.31801.marex@denx.de>
In-reply-to: <201310121128.31801.marex@denx.de>
Subject: Re: [PATCH 1/2] PCI: imx6: Make reset-gpio optional
Date: Mon, 14 Oct 2013 09:02:00 +0900
Message-id: <000501cec870$9aebcc80$d0c36580$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, October 12, 2013 6:29 PM, Marek Vasut wrote:
> > On Fri, Oct 11, 2013 at 04:12:31AM +0200, Marek Vasut wrote:
> > > Some boards do not have a PCIe reset GPIO. To avoid probe
> > > failure on these boards, make the reset GPIO optional as
> > > well.
> > >
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Frank Li <lznuaa@gmail.com>
> > > Cc: Richard Zhu <r65037@freescale.com>
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Cc: Sean Cross <xobs@kosagi.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Yinghai Lu <yinghai@kernel.org>
> > > ---
> > >
> > >  drivers/pci/host/pci-imx6.c | 29 +++++++++++++++--------------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> > > index d3639aa..8e7adce 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -220,9 +220,12 @@ static int imx6_pcie_assert_core_reset(struct
> > > pcie_port *pp)
> > >
> > >  	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> > >
> > >  			IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> > >
> > > -	gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > -	msleep(100);
> > > -	gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > +	/* Some boards don't have PCIe reset GPIO. */
> > > +	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > +		gpio_set_value(imx6_pcie->reset_gpio, 0);
> > > +		msleep(100);
> > > +		gpio_set_value(imx6_pcie->reset_gpio, 1);
> > > +	}
> > >
> > >  	return 0;
> > >
> > >  }
> > >
> > > @@ -447,17 +450,15 @@ static int __init imx6_pcie_probe(struct
> > > platform_device *pdev)
> > >
> > >  	/* Fetch GPIOs */
> > >  	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
> > >
> > > -	if (!gpio_is_valid(imx6_pcie->reset_gpio)) {
> > > -		dev_err(&pdev->dev, "no reset-gpio defined\n");
> > > -		ret = -ENODEV;
> > > -	}
> >
> > The 'reset-gpio' is documented as a required property in bindings doc
> > Documentation/devicetree/bindings/pci/designware-pcie.txt.  You need
> > to update bindings doc if you turn it into an optional property.
> 
> That's true, thanks for pointing it out!

+cc Kishon Vijay Abraham I, Pratyush Anand, Mohit KUMAR

Yes, right.
"reset-gpio" property can be moved to an optional property.
Also, the patch to fix 'Designware' part such as 'designware-pcie.txt'
can be shared with other related people as below.

  - Samsung Exynos PCIe: Jingoo Han
  - ST Spear PCIe: Pratyush Anand, Mohit KUMAR
  - TI OMAP PCIe: Kishon Vijay Abraham I

Best regards,
Jingoo Han

