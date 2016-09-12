Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752632AbcILWPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 18:15:53 -0400
Date: Mon, 12 Sep 2016 17:15:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Don't disable/unprepare clocks on
 prepare/enable failure
Message-ID: <20160912221547.GJ23532@localhost>
References: <1472635702-26465-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472635702-26465-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 31, 2016 at 11:28:22AM +0200, Geert Uytterhoeven wrote:
> If clk_prepare_enable() fails, we must not call clk_disable_unprepare()
> in the error path.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to pci/host-rcar for v4.9, thanks!

> ---
>  drivers/pci/host/pcie-rcar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 65db7a2215090ff4..0f5c2b2b4f8dfcd2 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -782,7 +782,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
>  	}
>  	err = clk_prepare_enable(pcie->clk);
>  	if (err)
> -		goto fail_clk;
> +		return err;
>  
>  	pcie->bus_clk = devm_clk_get(&pdev->dev, "pcie_bus");
>  	if (IS_ERR(pcie->bus_clk)) {
> @@ -792,7 +792,7 @@ static int rcar_pcie_get_resources(struct platform_device *pdev,
>  	}
>  	err = clk_prepare_enable(pcie->bus_clk);
>  	if (err)
> -		goto err_map_reg;
> +		goto fail_clk;
>  
>  	i = irq_of_parse_and_map(pdev->dev.of_node, 0);
>  	if (!i) {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
