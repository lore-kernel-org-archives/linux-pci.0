Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC2372B5A;
	Thu,  5 Mar 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703646; cv=none; b=BvgAKYb4fmfURsHsivnrFEk1Lb0x0x7j6F4LdCwmPOOsHfgy1o/Gy+cRPvpxb/gu8Mt3kdziXFrhK7vL7tAi9lSHhhaMbSyRZIcCO5LyHekN2A5XIpeiCpUONwrLywnD+TWjzAeIhKeOfc1+1l+oqDcW0WT/j9rcc4sH5ppydR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703646; c=relaxed/simple;
	bh=kgO0ABwU6ejaUWxo1SJnPWReRAdrnrMCus4MWC9HptU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJY6/MLtygDAs3msBwrRxLwbedyVIo4AaLRG3r7o/v1hzd1wlDdLrdA5ppBpKGr+QPtV2yfOXWorklOAtSr/SXT7Q6Ga5HBu72bawGmKGaDdgZ3z/s/K5tq55Wd0qOghGOEgcrADkeG1nEPuHSglKU96eTYOomBc+FMZVkayfEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b08uI5NN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b08uI5NN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267AFC116C6;
	Thu,  5 Mar 2026 09:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772703646;
	bh=kgO0ABwU6ejaUWxo1SJnPWReRAdrnrMCus4MWC9HptU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b08uI5NNQpJZX1sUB7QKtFgL/ceEoR0CgHA5+AB+9NtnEsfIi8xL09NFBa6zc+jFs
	 SUhrQzOW/xY4C2pGnfk1M80jLI6ql1xXrxF9Z+8drZGL0/GodZ9vGMjrdQlKBygZPH
	 WpNBD1+kjS0q3lZ5tTgNqAvIxTu98mM99qKtMSQVtNVLNe0NzTwzZDoE5m5sGQK30J
	 WP+DLfVpbu6lhOX4im8tiZw7W46UftopQXZhY44BzsHfFT6UWvjzPCMT0G8HNLrKNc
	 kgr9uVvctbSihPQmolr1bGmTkpB00Z+NugU9RTh0t3Zc4lKh+NpmvDpuf0rhk+BO3F
	 WA4wS4lB9c4Nw==
Date: Thu, 5 Mar 2026 15:10:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com, 
	jingoohan1@gmail.com, vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 03/13] PCI: tegra194: Don't force the device into the
 D0 state before L2
Message-ID: <6ekumkzuh6znxzf4deaawc46mgoen6haxcrvrein2irpw3xqhc@shwkkvjnlj6h>
References: <20260303065448.2361488-1-mmaddireddy@nvidia.com>
 <20260303065448.2361488-4-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303065448.2361488-4-mmaddireddy@nvidia.com>

On Tue, Mar 03, 2026 at 12:24:38PM +0530, Manikanta Maddireddy wrote:
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> As per PCIe CEM spec rev 4.0 ver 1.0 sec 2.3, the PCIe Endpoint device
> should be in D3 state to assert wake# pin. This takes precedence over PCI

WAKE#

> Express Base r4.0 v1.0 September 27-2017, 5.2 Link State Power Management
> which states that the device can be put into D0 state before taking the
> link to L2 state. To enable the wake functionality for Endpoint devices,
> do not force the devices to D0 state before taking the link to L2 state.
> There is no functional issue with the Endpoint devices where the link
> doesn't go into L2 state (the reason why the earlier change was made in
> the first place) as the Root Port proceeds with the usual flow post PME
> timeout.
> 

So the previous claim in the comments is not true?

I agree with this patch in principle, but just want to know why the comment
claimed there is an issue if the devices are not in D0 state.

- Mani

> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
> Changes V6 -> V7: Fix commit message
> Changes V1 -> V6: None
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 41 ----------------------
>  1 file changed, 41 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index afbc0bdd8a93..831986de584e 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1258,44 +1258,6 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
>  	return 0;
>  }
>  
> -static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
> -{
> -	struct dw_pcie_rp *pp = &pcie->pci.pp;
> -	struct pci_bus *child, *root_port_bus = NULL;
> -	struct pci_dev *pdev;
> -
> -	/*
> -	 * link doesn't go into L2 state with some of the endpoints with Tegra
> -	 * if they are not in D0 state. So, need to make sure that immediate
> -	 * downstream devices are in D0 state before sending PME_TurnOff to put
> -	 * link into L2 state.
> -	 * This is as per PCI Express Base r4.0 v1.0 September 27-2017,
> -	 * 5.2 Link State Power Management (Page #428).
> -	 */
> -
> -	list_for_each_entry(child, &pp->bridge->bus->children, node) {
> -		if (child->parent == pp->bridge->bus) {
> -			root_port_bus = child;
> -			break;
> -		}
> -	}
> -
> -	if (!root_port_bus) {
> -		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
> -		return;
> -	}
> -
> -	/* Bring downstream devices to D0 if they are not already in */
> -	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
> -		if (PCI_SLOT(pdev->devfn) == 0) {
> -			if (pci_set_power_state(pdev, PCI_D0))
> -				dev_err(pcie->dev,
> -					"Failed to transition %s to D0 state\n",
> -					dev_name(&pdev->dev));
> -		}
> -	}
> -}
> -
>  static int tegra_pcie_get_slot_regulators(struct tegra_pcie_dw *pcie)
>  {
>  	pcie->slot_ctl_3v3 = devm_regulator_get_optional(pcie->dev, "vpcie3v3");
> @@ -1625,7 +1587,6 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
>  
>  static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
>  {
> -	tegra_pcie_downstream_dev_to_D0(pcie);
>  	dw_pcie_host_deinit(&pcie->pci.pp);
>  	tegra_pcie_dw_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
> @@ -2335,7 +2296,6 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
>  	if (!pcie->link_state)
>  		return 0;
>  
> -	tegra_pcie_downstream_dev_to_D0(pcie);
>  	tegra_pcie_dw_pme_turnoff(pcie);
>  	tegra_pcie_unconfig_controller(pcie);
>  
> @@ -2409,7 +2369,6 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
>  			return;
>  
>  		debugfs_remove_recursive(pcie->debugfs);
> -		tegra_pcie_downstream_dev_to_D0(pcie);
>  
>  		disable_irq(pcie->pci.pp.irq);
>  		if (IS_ENABLED(CONFIG_PCI_MSI))
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
