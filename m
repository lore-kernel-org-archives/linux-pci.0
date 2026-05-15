Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC03321A2;
	Fri, 15 May 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864172; cv=none; b=lVcM39Ox8SGAlLSLZy+Q4bck+VBsG2VQQuXG6u1e1YFnVPooxFjpAoKYISaCYqY6RgApy0XgCOH7m0/IxlQbGH0lPtluB+oZoH7mCq3OvIO07aY4cKT2xQDefuzQo+AkIMYxlp/rqQy9pEY+gr3v37y4Cp0mpNhBte5YdlzX5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864172; c=relaxed/simple;
	bh=SedbGXwK4aJOlbTTWEI5B8hx7KCD74sgdfit/X5/dJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKiLgIpVNeC4jfAtUKZP+xqOxmIMao/TcRa3SQgJCnOumq5TBeVcuM/p7ptJ6GFKaH3rhlmTAEhp4t0qxT7cqMLIN2gNryuRsbhDgf+8fcPZTHSMC0nmiuzhYh/OOfqZukyIGBD0/ka8leeeG0PEmMx18xHeiPG8Gz3FQp+69i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa3pZcmi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa3pZcmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979D9C2BCB0;
	Fri, 15 May 2026 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778864172;
	bh=SedbGXwK4aJOlbTTWEI5B8hx7KCD74sgdfit/X5/dJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xa3pZcmiApyLXNIWHocH1qtmaMryAJkTWFgl+rng4s+TItk7aPdEyki3iosuzdkpy
	 dgMoi/zAjmq1PaylNozIrTBcWx2+miI4B3X/5vpx2wIA4hyWqf/WnNbnV9bsUNJdi0
	 A2/NaH5AKgVd7c5/xDWZpgPnsQ6J66Ni0O3qxYhlMkyNkAonTG/uiTVDQ9sQ0ismet
	 gkX84eIz9xXaskpFWuRsmZ01UJ8CUA/lAInYKclnjXLC68dSmjN8pdCc2G31aiAxC0
	 UucbSO9ecDfCOoB5pNipj0B2O1REqoFub+DwkVlt7VWbjAZx43vX5E1L7xODkNvcyH
	 ewY6CfpJxGZkg==
Date: Fri, 15 May 2026 22:25:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH 5/9] PCI: tegra: Explicitly specify PMC instance to use
Message-ID: <rt3tpcu7eucylbxurtvraghnyljkv52zau75jwkkbtyfslc2ox@2bjkryjd4nqp>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-5-a6de5da7216b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506-pmc-v1-5-a6de5da7216b@nvidia.com>

On Wed, May 06, 2026 at 03:41:56PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently the kernel relies on a global variable to reference the PMC
> context. Use an explicit lookup for the PMC and pass that to the public
> PMC APIs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/pci-tegra.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 512309763d1f..2c6c521e6901 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -340,6 +340,8 @@ struct tegra_pcie {
>  	struct reset_control *afi_rst;
>  	struct reset_control *pcie_xrst;
>  
> +	struct tegra_pmc *pmc;
> +
>  	bool legacy_phy;
>  	struct phy *phy;
>  
> @@ -1165,7 +1167,7 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>  	clk_disable_unprepare(pcie->afi_clk);
>  
>  	if (!dev->pm_domain)
> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +		tegra_pmc_powergate_power_off(pcie->pmc, TEGRA_POWERGATE_PCIE);
>  
>  	err = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  	if (err < 0)
> @@ -1183,7 +1185,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  	reset_control_assert(pcie->pex_rst);
>  
>  	if (!dev->pm_domain)
> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +		tegra_pmc_powergate_power_off(pcie->pmc, TEGRA_POWERGATE_PCIE);
>  
>  	/* enable regulators */
>  	err = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
> @@ -1191,12 +1193,14 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  		dev_err(dev, "failed to enable regulators: %d\n", err);
>  
>  	if (!dev->pm_domain) {
> -		err = tegra_powergate_power_on(TEGRA_POWERGATE_PCIE);
> +		err = tegra_pmc_powergate_power_on(pcie->pmc,
> +						   TEGRA_POWERGATE_PCIE);
>  		if (err) {
>  			dev_err(dev, "failed to power ungate: %d\n", err);
>  			goto regulator_disable;
>  		}
> -		err = tegra_powergate_remove_clamping(TEGRA_POWERGATE_PCIE);
> +		err = tegra_pmc_powergate_remove_clamping(pcie->pmc,
> +							  TEGRA_POWERGATE_PCIE);
>  		if (err) {
>  			dev_err(dev, "failed to remove clamp: %d\n", err);
>  			goto powergate;
> @@ -1234,7 +1238,7 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  	clk_disable_unprepare(pcie->afi_clk);
>  powergate:
>  	if (!dev->pm_domain)
> -		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> +		tegra_pmc_powergate_power_off(pcie->pmc, TEGRA_POWERGATE_PCIE);
>  regulator_disable:
>  	regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
>  
> @@ -1432,6 +1436,12 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
>  		return err;
>  	}
>  
> +	pcie->pmc = devm_tegra_pmc_get(dev);
> +	if (IS_ERR(pcie->pmc)) {
> +		dev_err_probe(dev, PTR_ERR(pcie->pmc), "failed to get PMC\n");
> +		return err;

As Sashiko pointed out, you need to return dev_err_probe() directly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
