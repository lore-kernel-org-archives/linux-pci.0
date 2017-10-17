Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753594AbdJQRea (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Oct 2017 13:34:30 -0400
Date: Tue, 17 Oct 2017 12:34:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, mperttunen@nvidia.com
Subject: Re: [PATCH V2 2/4] PCI: tegra: Add Tegra186 PCIe support
Message-ID: <20171017173428.GE5641@bhelgaas-glaptop.roam.corp.google.com>
References: <1506513517-25870-1-git-send-email-mmaddireddy@nvidia.com>
 <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506513517-25870-3-git-send-email-mmaddireddy@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 05:28:35PM +0530, Manikanta Maddireddy wrote:
> UPHY programming is performed by BPMP, PHY enable calls are
> not required for Tegra186 PCIe. Power partition ungate is
> done by BPMP powergate driver.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> V2: Add soc->program_uphy check for phy_exit call
>  drivers/pci/host/pci-tegra.c | 132 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 108 insertions(+), 24 deletions(-)

> @@ -1012,10 +1016,12 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  		afi_writel(pcie, value, AFI_FUSE);
>  	}
>  
> -	err = tegra_pcie_phy_power_on(pcie);
> -	if (err < 0) {
> -		dev_err(dev, "failed to power on PHY(s): %d\n", err);
> -		return err;
> +	if (soc->program_uphy) {
> +		err = tegra_pcie_phy_power_on(pcie);
> +		if (err < 0) {
> +			dev_err(dev, "failed to power on PHY(s): %d\n", err);
> +			return err;
> +		}

This looks good: it's obvious that the previously-supported devices
continue to work the same way because you set ".program_uphy = true"
for them.  (It would be even more obvious if you changed the sense so
that only the new device had to add this initializaer, but in general
I prefer the positive logic as you have here, and I did verify that
you added the initializer for all tegra_pcie_soc variants.)

> @@ -1048,19 +1054,23 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)
>  static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	int err;
>  
>  	/* TODO: disable and unprepare clocks? */
>  
> -	err = tegra_pcie_phy_power_off(pcie);
> -	if (err < 0)
> -		dev_err(dev, "failed to power off PHY(s): %d\n", err);
> +	if (soc->program_uphy) {
> +		err = tegra_pcie_phy_power_off(pcie);
> +		if (err < 0)
> +			dev_err(dev, "failed to power off PHY(s): %d\n", err);
> +	}
>  
>  	reset_control_assert(pcie->pcie_xrst);
>  	reset_control_assert(pcie->afi_rst);
>  	reset_control_assert(pcie->pex_rst);
>  
> -	tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +	if (!dev->pm_domain)
> +		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);

But this one isn't obvious because nothing in your patch obviously
affects dev->pm_domain, so I can't tell whether this is safe.  It's
worth a changelog comment to help justify this.

Bjorn
