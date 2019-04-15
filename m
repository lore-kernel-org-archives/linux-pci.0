Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ACC10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D93A20651
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfDOIiE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:38:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43063 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfDOIiE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 04:38:04 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1hFx7q-0004GH-MU; Mon, 15 Apr 2019 10:38:02 +0200
Message-ID: <1555317482.2983.1.camel@pengutronix.de>
Subject: Re: [PATCH v4 08/11] PCI: imx6: Simplify pcie_phy_poll_ack()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Date:   Mon, 15 Apr 2019 10:38:02 +0200
In-Reply-To: <20190415004632.5907-9-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
         <20190415004632.5907-9-andrew.smirnov@gmail.com>
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

Am Sonntag, den 14.04.2019, 17:46 -0700 schrieb Andrey Smirnov:
> Simplify pcie_phy_poll_ack() by incorporating shifting into constant
> definition and convert the code to use 'bool'. No functional change
> intended.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 26 +++++++++++++----------
> ---
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> b/drivers/pci/controller/dwc/pci-imx6.c
> index 669e01353026..3fd084357488 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -112,7 +112,7 @@ struct imx6_pcie {
>  #define PCIE_PHY_CTRL_RD		BIT(19)
>  
>  #define PCIE_PHY_STAT (PL_OFFSET + 0x110)
> -#define PCIE_PHY_STAT_ACK_LOC 16
> +#define PCIE_PHY_STAT_ACK		BIT(16)
>  
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>  
> @@ -151,16 +151,16 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
>  
> -static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int
> exp_val)
> +static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool
> exp_val)
>  {
>  	struct dw_pcie *pci = imx6_pcie->pci;
> -	u32 val;
> +	bool val;
>  	u32 max_iterations = 10;
>  	u32 wait_counter = 0;
>  
>  	do {
> -		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT);
> -		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		val = dw_pcie_readl_dbi(pci, PCIE_PHY_STAT) &
> +			PCIE_PHY_STAT_ACK;
>  		wait_counter++;
>  
>  		if (val == exp_val)
> @@ -184,14 +184,14 @@ static int pcie_phy_wait_ack(struct imx6_pcie
> *imx6_pcie, int addr)
>  	val |= PCIE_PHY_CTRL_CAP_ADR;
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
>  
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	ret = pcie_phy_poll_ack(imx6_pcie, true);
>  	if (ret)
>  		return ret;
>  
>  	val = PCIE_PHY_CTRL_DATA(addr);
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, val);
>  
> -	return pcie_phy_poll_ack(imx6_pcie, 0);
> +	return pcie_phy_poll_ack(imx6_pcie, false);
>  }
>  
>  /* Read from the 16-bit PCIe PHY control registers (not memory-
> mapped) */
> @@ -209,7 +209,7 @@ static int pcie_phy_read(struct imx6_pcie
> *imx6_pcie, int addr, int *data)
>  	phy_ctl = PCIE_PHY_CTRL_RD;
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, phy_ctl);
>  
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	ret = pcie_phy_poll_ack(imx6_pcie, true);
>  	if (ret)
>  		return ret;
>  
> @@ -219,7 +219,7 @@ static int pcie_phy_read(struct imx6_pcie
> *imx6_pcie, int addr, int *data)
>  	/* deassert Read signal */
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, 0x00);
>  
> -	return pcie_phy_poll_ack(imx6_pcie, 0);
> +	return pcie_phy_poll_ack(imx6_pcie, false);
>  }
>  
>  static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, int
> data)
> @@ -241,7 +241,7 @@ static int pcie_phy_write(struct imx6_pcie
> *imx6_pcie, int addr, int data)
>  	var |= PCIE_PHY_CTRL_CAP_DAT;
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	ret = pcie_phy_poll_ack(imx6_pcie, true);
>  	if (ret)
>  		return ret;
>  
> @@ -250,7 +250,7 @@ static int pcie_phy_write(struct imx6_pcie
> *imx6_pcie, int addr, int data)
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
>  	/* wait for ack de-assertion */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> +	ret = pcie_phy_poll_ack(imx6_pcie, false);
>  	if (ret)
>  		return ret;
>  
> @@ -259,7 +259,7 @@ static int pcie_phy_write(struct imx6_pcie
> *imx6_pcie, int addr, int data)
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
>  	/* wait for ack */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 1);
> +	ret = pcie_phy_poll_ack(imx6_pcie, true);
>  	if (ret)
>  		return ret;
>  
> @@ -268,7 +268,7 @@ static int pcie_phy_write(struct imx6_pcie
> *imx6_pcie, int addr, int data)
>  	dw_pcie_writel_dbi(pci, PCIE_PHY_CTRL, var);
>  
>  	/* wait for ack de-assertion */
> -	ret = pcie_phy_poll_ack(imx6_pcie, 0);
> +	ret = pcie_phy_poll_ack(imx6_pcie, false);
>  	if (ret)
>  		return ret;
>  
