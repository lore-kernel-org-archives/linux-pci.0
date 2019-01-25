Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE158C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC43A218D0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 11:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbfAYL6d (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:58:33 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46044 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAYL6d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 06:58:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D052EBD;
        Fri, 25 Jan 2019 03:58:32 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5D13F5AF;
        Fri, 25 Jan 2019 03:58:30 -0800 (PST)
Date:   Fri, 25 Jan 2019 11:58:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2] Revert "PCI: armada8k: Add support for gpio
 controlled reset signal"
Message-ID: <20190125115824.GA15799@e107981-ln.cambridge.arm.com>
References: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 11:42:45PM +0200, Baruch Siach wrote:
> This reverts commit 3d71746c420c1c1c27cf5c4e48f8fa0a6cfdc185.
> 
> That commit breaks boot on Macchiatobin when a Mellanox NIC is in the
> PCIe slot.
> 
> It turns out that full reset cycle requires first comphy serdes
> initialization. Reset signal toggle without comphy initialization makes
> access to PCI configuration registers stall indefinitely. U-Boot toggles
> the Macchiatobin PCIe reset line already at boot, after initializing the
> comphy serdes.
> 
> So while commit 3d71746c42 ("PCI: armada8k: Add support for gpio
> controlled reset signal") enables PCIe on platforms that U-Boot does
> not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
> (and boot) on the Macchiatobin.

I have applied it and will send it upstream but please do test
changes and make sure u-boot configurations are consistent, this
commit log does not look promising in that respect.

Thanks,
Lorenzo

> Revert commit 3d71746c42 ("PCI: armada8k: Add support for gpio
> controlled reset signal") entirely for now to fix the Macchaitobin
> regression. Proper PCIe reset support would require PCIe comphy setup
> support. That must wait for another kernel release.
> 
> Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Add commit title to commit id mentions
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b171b6bc15c8..0c389a30ef5d 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,7 +22,6 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> -#include <linux/gpio/consumer.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -30,7 +29,6 @@ struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
> -	struct gpio_desc *reset_gpio;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -139,12 +137,6 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> -	if (pcie->reset_gpio) {
> -		/* assert and then deassert the reset signal */
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> -		msleep(100);
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> -	}
>  	dw_pcie_setup_rc(pp);
>  	armada8k_pcie_establish_link(pcie);
>  
> @@ -257,14 +249,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> -	/* Get reset gpio signal and hold asserted (logically high) */
> -	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> -						   GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->reset_gpio)) {
> -		ret = PTR_ERR(pcie->reset_gpio);
> -		goto fail_clkreg;
> -	}
> -
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = armada8k_add_pcie_port(pcie, pdev);
> -- 
> 2.20.1
> 
