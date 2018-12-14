Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9591C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 00:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ACB2075B
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 00:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="ezQHveDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78ACB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeLNArG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:47:06 -0500
Received: from mail.nic.cz ([217.31.204.67]:41943 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeLNArF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 19:47:05 -0500
Received: from localhost (unknown [172.20.6.233])
        by mail.nic.cz (Postfix) with ESMTPS id 0066562E08;
        Fri, 14 Dec 2018 01:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1544748423; bh=yb8lOHDan8M1Cc1yuiZy165cJcrcrl+OlXBrhkDw6NM=;
        h=Date:From:To;
        b=ezQHveDO/2JaruPu2IZmOOBViEQIEqRQifKaL2mEH1FSaUJVgfv16LhZ5dZn3U1hY
         Cif8AhpGHZVbXJn0OXhRuEh2R1UsDNYJ1mQ4fB56/FdmcUBiRdS0k6CAIZKBw3dnrW
         TP+EmhfRUeHnZtco9UKtPVlVvD15JYZybg0jjGp8=
Date:   Fri, 14 Dec 2018 01:47:01 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181214014701.373b220b@nic.cz>
In-Reply-To: <20181212102142.16053-4-miquel.raynal@bootlin.com>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miquel,
are there already patches for the A37xx comphy driver?

On Wed, 12 Dec 2018 11:21:33 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> The IP needs its PHY to be properly configured to work. While the PHY
> is usually already configured by the bootloader, we will need this
> feature when adding S2RAM support. Take care of registering and
> configuring the PHY from the driver itself.
> 
> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 62
> +++++++++++++++++++++++++++ 1 file changed, 62 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c
> b/drivers/pci/controller/pci-aardvark.c index
> 1d31d74ddab7..da695572a2ed 100644 ---
> a/drivers/pci/controller/pci-aardvark.c +++
> b/drivers/pci/controller/pci-aardvark.c @@ -17,6 +17,7 @@
>  #include <linux/pci.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
>  #include <linux/of_address.h>
>  #include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
> @@ -204,6 +205,7 @@ struct advk_pcie {
>  	int root_bus_nr;
>  	struct pci_bridge_emul bridge;
>  	struct gpio_desc *reset_gpio;
> +	struct phy *phy;
>  };
>  
>  static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64
> reg) @@ -1025,6 +1027,62 @@ static int
> advk_pcie_setup_reset_gpio(struct advk_pcie *pcie) return 0;
>  }
>  
> +static void advk_pcie_disable_phy(struct advk_pcie *pcie)
> +{
> +	phy_power_off(pcie->phy);
> +	phy_exit(pcie->phy);
> +}
> +
> +static int advk_pcie_enable_phy(struct advk_pcie *pcie)
> +{
> +	int ret;
> +
> +	if (!pcie->phy)
> +		return 0;
> +
> +	ret = phy_init(pcie->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
> +	if (ret) {
> +		phy_exit(pcie->phy);
> +		return ret;
> +	}
> +
> +	ret = phy_power_on(pcie->phy);
> +	if (ret) {
> +		phy_exit(pcie->phy);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int advk_pcie_setup_phy(struct advk_pcie *pcie)
> +{
> +	struct device *dev = &pcie->pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret = 0;
> +
> +	pcie->phy = devm_of_phy_get(dev, node, NULL);
> +	if (IS_ERR(pcie->phy) && (PTR_ERR(pcie->phy) ==
> -EPROBE_DEFER))
> +		return PTR_ERR(pcie->phy);
> +
> +	/* Old bindings miss the PHY handle */
> +	if (IS_ERR(pcie->phy)) {
> +		dev_warn(dev, "PHY unavailable (%ld)\n",
> PTR_ERR(pcie->phy));
> +		pcie->phy = NULL;
> +		return 0;
> +	}
> +
> +	ret = advk_pcie_enable_phy(pcie);
> +	if (ret)
> +		dev_err(dev, "Failed to initialize PHY (%d)\n", ret);
> +
> +	return ret;
> +}
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1060,6 +1118,10 @@ static int advk_pcie_probe(struct
> platform_device *pdev) return ret;
>  	}
>  
> +	ret = advk_pcie_setup_phy(pcie);
> +	if (ret)
> +		return ret;
> +
>  	ret = advk_pcie_setup_reset_gpio(pcie);
>  	if (ret)
>  		return ret;

