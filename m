Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43086 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeENNrI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 May 2018 09:47:08 -0400
Date: Mon, 14 May 2018 14:47:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: l.stach@pengutronix.de, linux-pci@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] PCI: imx6: Remove space before tabs
Message-ID: <20180514134704.GB12029@e107981-ln.cambridge.arm.com>
References: <1525885308-7824-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1525885308-7824-1-git-send-email-festevam@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 02:01:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Remove space before tabs to fix the following checkpatch
> warning:
> 
> WARNING: please, no space before tabs
> #341: FILE: drivers/pci/dwc/pci-imx6.c:341:
> +^Icase IMX6QP: ^I^I/* FALLTHROUGH */$
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/pci/dwc/pci-imx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v4.18, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> index 4818ef8..80f6046 100644
> --- a/drivers/pci/dwc/pci-imx6.c
> +++ b/drivers/pci/dwc/pci-imx6.c
> @@ -338,7 +338,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
>  		break;
> -	case IMX6QP: 		/* FALLTHROUGH */
> +	case IMX6QP:		/* FALLTHROUGH */
>  	case IMX6Q:
>  		/* power up core phy and enable ref clock */
>  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -- 
> 2.7.4
> 
