Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A5C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C120824
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 15:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D5C120824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437638AbeKWCDG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:03:06 -0500
Received: from foss.arm.com ([217.140.101.70]:51994 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437636AbeKWCDF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 21:03:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AFBDA78;
        Thu, 22 Nov 2018 07:23:17 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ACAB3F575;
        Thu, 22 Nov 2018 07:23:15 -0800 (PST)
Date:   Thu, 22 Nov 2018 15:23:10 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181122152310.GA16857@e107981-ln.cambridge.arm.com>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> This commit adds support for the gpio reset signal binding as described
> in the designware-pcie.txt DT binding document. Both the documented
> 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> supported.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied to pci/dwc for v4.21, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 0c389a30ef5d..b171b6bc15c8 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,6 +22,7 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -29,6 +30,7 @@ struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
> +	struct gpio_desc *reset_gpio;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -137,6 +139,12 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> +	if (pcie->reset_gpio) {
> +		/* assert and then deassert the reset signal */
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +		msleep(100);
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +	}
>  	dw_pcie_setup_rc(pp);
>  	armada8k_pcie_establish_link(pcie);
>  
> @@ -249,6 +257,14 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> +	/* Get reset gpio signal and hold asserted (logically high) */
> +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						   GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset_gpio)) {
> +		ret = PTR_ERR(pcie->reset_gpio);
> +		goto fail_clkreg;
> +	}
> +
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = armada8k_add_pcie_port(pcie, pdev);
> -- 
> 2.19.0
> 
