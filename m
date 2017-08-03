Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdHCVlx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 17:41:53 -0400
Date: Thu, 3 Aug 2017 16:41:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 052/102] PCI: imx6: explicitly request exclusive reset
 control
Message-ID: <20170803214149.GC20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-53-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719152646.25903-53-p.zabel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 05:25:56PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to pci/host-imx6 for v4.14, thanks!


Richard, Lucas, holler if you see any issues.

> ---
>  drivers/pci/dwc/pci-imx6.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index bf5c3616e3448..5a2ece394ad39 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -778,14 +778,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  		}
>  		break;
>  	case IMX7D:
> -		imx6_pcie->pciephy_reset = devm_reset_control_get(dev,
> -								  "pciephy");
> +		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
> +									    "pciephy");
>  		if (IS_ERR(imx6_pcie->pciephy_reset)) {
>  			dev_err(dev, "Failed to get PCIEPHY reset control\n");
>  			return PTR_ERR(imx6_pcie->pciephy_reset);
>  		}
>  
> -		imx6_pcie->apps_reset = devm_reset_control_get(dev, "apps");
> +		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
> +									 "apps");
>  		if (IS_ERR(imx6_pcie->apps_reset)) {
>  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
>  			return PTR_ERR(imx6_pcie->apps_reset);
> -- 
> 2.11.0
> 
