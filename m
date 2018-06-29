Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34382 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753045AbeF2NgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 09:36:21 -0400
Date: Fri, 29 Jun 2018 14:38:05 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 6/6] PCI: rcar: Shut the PHY down in failpath
Message-ID: <20180629133805.GA9643@red-moon>
References: <20180524143624.26718-1-marek.vasut+renesas@gmail.com>
 <20180524143624.26718-7-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180524143624.26718-7-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2018 at 04:36:24PM +0200, Marek Vasut wrote:
> If anything fails past phy_init_fn() and the system is a Gen3 with
> a PHY, the PHY will be left on and inited. This is caused by the
> phy_init_fn, which is in fact a pointer to rcar_pcie_phy_init_gen3()
> function, which starts the PHY, yet has no counterpart in the failpath.
> Add that counterpart.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> Fixes: 517ca93a7159 ("PCI: rcar: Add R-Car gen3 PHY support")
> ---
> V4: New patch
> ---
>  drivers/pci/host/pcie-rcar.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Applied to pci/controller-fixes to be tentatively merged at -rc4,
thanks.

Lorenzo

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 636c3c5095d2..695781934f0a 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1163,7 +1163,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (rcar_pcie_hw_init(pcie)) {
>  		dev_info(dev, "PCIe link down\n");
>  		err = -ENODEV;
> -		goto err_clk_disable;
> +		goto err_phy_shutdown;
>  	}
>  
>  	data = rcar_pci_read_reg(pcie, MACSR);
> @@ -1175,7 +1175,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  			dev_err(dev,
>  				"failed to enable MSI support: %d\n",
>  				err);
> -			goto err_clk_disable;
> +			goto err_phy_shutdown;
>  		}
>  	}
>  
> @@ -1189,6 +1189,12 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		rcar_pcie_teardown_msi(pcie);
>  
> +err_phy_shutdown:
> +	if (pcie->phy) {
> +		phy_power_off(pcie->phy);
> +		phy_exit(pcie->phy);
> +	}
> +
>  err_clk_disable:
>  	clk_disable_unprepare(pcie->bus_clk);
>  
> -- 
> 2.16.2
> 
