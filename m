Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB3DC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB10120693
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfDLPtn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:49:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36971 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDLPtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2019 11:49:43 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hEyQv-0008GX-3L; Fri, 12 Apr 2019 17:49:41 +0200
Message-ID: <1555084180.11529.27.camel@pengutronix.de>
Subject: Re: [PATCH v3 01/11] PCI: imx6: Simplify
 imx7d_pcie_wait_for_phy_pll_lock()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Apr 2019 17:49:40 +0200
In-Reply-To: <20190401042547.14067-2-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
         <20190401042547.14067-2-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> Make use of regmap_read_poll_timeout() to simplify
> imx7d_pcie_wait_for_phy_pll_lock(). No functional change intended.
> 
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2eb39d5de4f6..fb0b29e5b1f0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -89,9 +89,8 @@ struct imx6_pcie {
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > -#define PHY_PLL_LOCK_WAIT_MAX_RETRIES	2000
> > -#define PHY_PLL_LOCK_WAIT_USLEEP_MIN	50
> >  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
> > +#define PHY_PLL_LOCK_WAIT_TIMEOUT	(2000 * PHY_PLL_LOCK_WAIT_USLEEP_MAX)
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> >  #define PCIE_RC_IMX6_MSI_CAP			0x50
> @@ -488,20 +487,14 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>  {
> >  	u32 val;
> > -	unsigned int retries;
> >  	struct device *dev = imx6_pcie->pci->dev;
>  
> > -	for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
> > -		regmap_read(imx6_pcie->iomuxc_gpr, IOMUXC_GPR22, &val);
> -
> > -		if (val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED)
> > -			return;
> -
> > -		usleep_range(PHY_PLL_LOCK_WAIT_USLEEP_MIN,
> > -			     PHY_PLL_LOCK_WAIT_USLEEP_MAX);
> > -	}
> -
> > -	dev_err(dev, "PCIe PLL lock timeout\n");
> > +	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
> > +				     IOMUXC_GPR22, val,
> > +				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
> > +				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> > +				     PHY_PLL_LOCK_WAIT_TIMEOUT))
> > +		dev_err(dev, "PCIe PLL lock timeout\n");
>  }
>  
>  static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
