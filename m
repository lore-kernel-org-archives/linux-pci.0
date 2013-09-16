Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38886 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3IPJZE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 05:25:04 -0400
Date: Mon, 16 Sep 2013 11:25:01 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, tharvey@gateworks.com,
	bhelgaas@google.com
Subject: Re: [PATCH v6 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
Message-ID: <20130916092501.GY30088@pengutronix.de>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
 <1379319655-20210-4-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1379319655-20210-4-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 08:20:54AM +0000, Sean Cross wrote:
> Add support for the PCIe port present on the i.MX6 family of controllers.
> These use the Synopsis Designware core tied to their own PHY.
> 
> +static int pcie_phy_poll_ack(void __iomem *dbi_base, int exp_val)
> +{
> +	u32 val;
> +	u32 max_iterations = 10;
> +	u32 wait_counter = 0;
> +
> +	do {
> +		val = readl(dbi_base + PCIE_PHY_STAT);
> +		val = (val >> PCIE_PHY_STAT_ACK_LOC) & 0x1;
> +		wait_counter++;
> +
> +		if (val == exp_val)
> +			return 0;
> +
> +		udelay(1);
> +	} while ((wait_counter < max_iterations) && (val != exp_val));

The test for val != exp_val is unnecessary now of course.

With this and the devm_clk_get Shawn mentioned:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
