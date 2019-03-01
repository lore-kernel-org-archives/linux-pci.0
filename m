Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B593BC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 11:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822AD20851
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 11:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfCALc1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:32:27 -0500
Received: from foss.arm.com ([217.140.101.70]:33480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbfCALc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 06:32:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D81FEBD;
        Fri,  1 Mar 2019 03:32:26 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7ACA3F5C1;
        Fri,  1 Mar 2019 03:32:24 -0800 (PST)
Date:   Fri, 1 Mar 2019 11:32:22 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Trent Piepho <tpiepho@impinj.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: Don't request "pci_aux" clock on i.MX7
Message-ID: <20190301113222.GB17669@e107981-ln.cambridge.arm.com>
References: <20190301085559.18736-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301085559.18736-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 01, 2019 at 12:55:59AM -0800, Andrey Smirnov wrote:
> The clock in question is not present on i.MX7, so move the code
> requesting it into i.MX8MQ-only path.
> 
> Fixes: eeb61c4e8530 ("PCI: imx6: Add code to request/control
> "pcie_aux" clock for i.MX8MQ")
> Reported-by: Trent Piepho <tpiepho@impinj.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Trent Piepho <tpiepho@impinj.com>
> Cc: linux-imx@nxp.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I have squashed this patch in the commit it fixes, pci/dwc
branch, please have a look.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 08f1ee050c73..5fe364a9959d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1100,8 +1100,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
>  		}
>  		break;
> -	case IMX7D:
>  	case IMX8MQ:
> +		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> +		if (IS_ERR(imx6_pcie->pcie_aux)) {
> +			dev_err(dev, "pcie_aux clock source missing or invalid\n");
> +			return PTR_ERR(imx6_pcie->pcie_aux);
> +		}
> +		/* fall through */
> +	case IMX7D:
>  		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
>  			imx6_pcie->controller_id = 1;
>  
> @@ -1118,12 +1124,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
>  		}
> -
> -		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> -		if (IS_ERR(imx6_pcie->pcie_aux)) {
> -			dev_err(dev, "pcie_aux clock source missing or invalid\n");
> -			return PTR_ERR(imx6_pcie->pcie_aux);
> -		}
>  		break;
>  	default:
>  		break;
> -- 
> 2.20.1
> 
