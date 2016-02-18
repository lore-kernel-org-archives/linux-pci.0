Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33641 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425619AbcBRL7U (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 06:59:20 -0500
Received: by mail-wm0-f68.google.com with SMTP id c200so2506244wme.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Feb 2016 03:59:20 -0800 (PST)
Message-ID: <1455796757.23688.27.camel@googlemail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: add initial imx6sx support
From: Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lee Jones <lee.jones@linaro.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 18 Feb 2016 12:59:17 +0100
In-Reply-To: <DBXPR04MB270F3A785BAF6E21BFD03108CAC0@DBXPR04MB270.eurprd04.prod.outlook.com>
References: <1455483164-13755-1-git-send-email-chf.fritz@googlemail.com>
	 <1455483164-13755-3-git-send-email-chf.fritz@googlemail.com>
	 <DBXPR04MB270F3A785BAF6E21BFD03108CAC0@DBXPR04MB270.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard

On Mon, 2016-02-15 at 07:24 +0000, Richard Zhu wrote:
> > -----Original Message-----
> > From: Christoph Fritz [mailto:chf.fritz@googlemail.com]
> > -static void imx6_pcie_init_phy(struct pcie_port *pp)
> > +static int imx6_pcie_init_phy(struct pcie_port *pp)
> >  {
> >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > +	int ret = 0;
> > +
> > +	if (imx6_pcie->is_imx6sx) {
> > +		/* power up separate domain available on i.mx6sx */
> > +		regmap_update_bits(imx6_pcie->gpc_ips_reg,
> > +			PCIE_PHY_IMX6SX_GPC_CNTR,
> > +			PCIE_PHY_IMX6SX_GPC_CNTR_PUP_REQ,
> > +			PCIE_PHY_IMX6SX_GPC_CNTR_PUP_REQ);
> 
>  [Zhu hongxing]  First of all, thanks for trying to upstream imx6sx pcie driver.
> As Lucas discussed with me before,  the GPC regulator operations should be touched in
> Imx pcie driver at all.  These bits operations should be encapsulate into the PM system,
>  for example, the regulator driver.

Ok, for an initial version, I'll just leave the regulator in my
devicetree enabled. For further enhancements I suppose
arch/arm/mach-imx/gpc.c needs to get touched?

Let me reroll this patchset.

Thanks
 -- Christoph


