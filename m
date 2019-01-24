Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F62C282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF16217D4
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 17:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfAXRBC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:01:02 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfAXRBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jan 2019 12:01:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C3621596;
        Thu, 24 Jan 2019 09:01:01 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AE9E3F237;
        Thu, 24 Jan 2019 09:00:59 -0800 (PST)
Date:   Thu, 24 Jan 2019 17:00:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] Revert "PCI: armada8k: Add support for gpio controlled
 reset signal"
Message-ID: <20190124170056.GE23362@e107981-ln.cambridge.arm.com>
References: <2e0f1e9d250b6ee1b3039362affc411751a3cd4a.1547382494.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0f1e9d250b6ee1b3039362affc411751a3cd4a.1547382494.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 13, 2019 at 02:28:14PM +0200, Baruch Siach wrote:
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
> So while commit 3d71746c42 enables PCIe on platforms that U-Boot does
> not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
> (and boot) on the Macchiatobin.
> 
> Revert commit 3d71746c42 entirely for now to fix the Macchaitobin
> regression. Proper PCIe reset support would require PCIe comphy setup
> support. That must wait for another kernel release.
> 
> Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Read:

https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

reformat the patch, repost it and I will pick it up.

Thanks,
Lorenzo

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
