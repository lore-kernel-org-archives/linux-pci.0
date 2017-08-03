Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Aug 2017 16:42:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 053/102] PCI: tegra: explicitly request exclusive reset
 control
Message-ID: <20170803214251.GD20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-54-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170719152646.25903-54-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 19, 2017 at 05:25:57PM +0200, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
> 
> No functional changes.
> 
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to pci/host-tegra for v4.14, thanks!

Tegra folks, holler if you see any issues.

> ---
>  drivers/pci/host/pci-tegra.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index b3722b7709df8..a64bd0a191767 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -1147,15 +1147,15 @@ static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  
> -	pcie->pex_rst = devm_reset_control_get(dev, "pex");
> +	pcie->pex_rst = devm_reset_control_get_exclusive(dev, "pex");
>  	if (IS_ERR(pcie->pex_rst))
>  		return PTR_ERR(pcie->pex_rst);
>  
> -	pcie->afi_rst = devm_reset_control_get(dev, "afi");
> +	pcie->afi_rst = devm_reset_control_get_exclusive(dev, "afi");
>  	if (IS_ERR(pcie->afi_rst))
>  		return PTR_ERR(pcie->afi_rst);
>  
> -	pcie->pcie_xrst = devm_reset_control_get(dev, "pcie_x");
> +	pcie->pcie_xrst = devm_reset_control_get_exclusive(dev, "pcie_x");
>  	if (IS_ERR(pcie->pcie_xrst))
>  		return PTR_ERR(pcie->pcie_xrst);
>  
> -- 
> 2.11.0
> 
