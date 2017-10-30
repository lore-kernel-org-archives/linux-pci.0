Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([91.232.154.25]:45312 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932291AbdJ3JNH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Oct 2017 05:13:07 -0400
Subject: Re: [PATCH V2 02/12] PCI: tegra: Move REFCLK pad settings out of
 phy_power_on()
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com
References: <1509337143-25963-1-git-send-email-mmaddireddy@nvidia.com>
 <1509337143-25963-3-git-send-email-mmaddireddy@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
From: Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <0b471cf9-c43d-2708-28b3-74e65d5b60ab@kapsi.fi>
Date: Mon, 30 Oct 2017 11:13:05 +0200
MIME-Version: 1.0
In-Reply-To: <1509337143-25963-3-git-send-email-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30.10.2017 06:18, Manikanta Maddireddy wrote:
> In Tegra186 PHY programming is done by BPMP-FW, so PHY calls are skipped
> in driver. REFCLK pad settings are independent of PHY and should be
> programmed by driver. So move REFCLK pad settings out of phy_power_on().
> These pad settings improves REFCLK peak to peak amplitude.

s/improves/improve/.

>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> V2:
> * no change in this patch
>
>  drivers/pci/host/pci-tegra.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> index b41c60c7414c..2c64eb6cc3cc 100644
> --- a/drivers/pci/host/pci-tegra.c
> +++ b/drivers/pci/host/pci-tegra.c
> @@ -910,7 +910,6 @@ static int tegra_pcie_port_phy_power_off(struct tegra_pcie_port *port)
>  static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> -	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_pcie_port *port;
>  	int err;
>
> @@ -936,12 +935,6 @@ static int tegra_pcie_phy_power_on(struct tegra_pcie *pcie)
>  		}
>  	}
>
> -	/* Configure the reference clock driver */
> -	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
> -
> -	if (soc->num_ports > 2)
> -		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> -
>  	return 0;
>  }
>
> @@ -2049,6 +2042,17 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  	return 0;
>  }
>
> +static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
> +{
> +	const struct tegra_pcie_soc *soc = pcie->soc;
> +
> +	/* Configure the reference clock driver */
> +	pads_writel(pcie, soc->pads_refclk_cfg0, PADS_REFCLK_CFG0);
> +
> +	if (soc->num_ports > 2)
> +		pads_writel(pcie, soc->pads_refclk_cfg1, PADS_REFCLK_CFG1);
> +}
> +
>  /*
>   * FIXME: If there are no PCIe cards attached, then calling this function
>   * can result in the increase of the bootup time as there are big timeout
> @@ -2107,6 +2111,7 @@ static void tegra_pcie_enable_ports(struct tegra_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	struct tegra_pcie_port *port, *tmp;
>
> +	tegra_pcie_apply_pad_settings(pcie);

Perhaps an empty line after this.

>  	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
>  		dev_info(dev, "probing port %u, using %u lanes\n",
>  			 port->index, port->lanes);
>

With that,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
