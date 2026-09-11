Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8CF43713C;
	Fri, 11 Sep 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164733; cv=none; b=ew4ce9SXPPjJQS+0XRxs4Hvn9w8zJ3GiUPkoADgHh9lOGDG9dvDh9AI4I8mW8HtZF2JbD3CBU6mrXALUsqPbILOkCRjt8h6QAoIYNhayBRkd7a7Pi+nnIDQD23pCUUvSKpJ9e5bA747pPzs2hDFVm5xj8z29XigVbU9WyY/Yldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164733; c=relaxed/simple;
	bh=7SacOg1IENiLKpqU81RPB0pY6bRjEI9ald8g9YA+/JA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZzbqqbE74canXHyXIHMJKKET/hV7ctskd86qoUbjs5IntBYVeFCAr3q7psIQJrYs0CM3p9QpPlcgfdvS09Yt9YLfpLcWNA/Y113kt+nRMr2DAo9W1oNHMlYiIPHVsjaZ04TGboO3kua6GqwJAMTopDVuMCgUhxId1c9BGCeMG+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZSM3z6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZSM3z6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6811F000FF;
	Fri, 11 Sep 2026 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164731;
	bh=zcSpC8B/zBe1QBiSP3SsQ8IbOXdwAlEg8XGj9L10bq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=fpZSM3z6PJ9swFzsvH+djv6QNuc3r3Jbh6fc5fg1plDIs1WScdIHvAlLBKslHFOpC
	 VUlgeo0f4KrBy7cqz2x9XD+Eh3NSgeWTi4XevOllxU7aRx6le8EGCRlOn+NRS1y7ZT
	 GYBZJbc5xO7X6hzpn+Zvxucqhh1evUkZ/RnAsEuHLV1vwBDcR/+mcWL3e5UX0jetdV
	 yVMQfWSmiYNtJBa+MBKplM6FwGvkAsIabg7ccf5NsRaHmsVooL7N1AKbaAWG/Rv2bV
	 0AwWtnXJG/bkaR0cMvSqKCps8HWA3DXqOgv3MqLk2Vx/pAe1cBKiOZbR7fWWy90N/G
	 b2VIe389tv9qg==
Date: Fri, 11 Sep 2026 17:12:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH v9 3/3] PCI: Remove device links to PHY
Message-ID: <20260911221209.GA587622@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810124315.433448-4-vladimir.oltean@nxp.com>

[+cc Felix, author of device link leak fixes]

On Mon, Aug 10, 2026 at 03:43:15PM +0300, Vladimir Oltean wrote:
> This is practically a full revert of commit
> 7a4db656a635 ("PCI: dra7xx: Create functional dependency between PCIe and PHY")
> and a partial revert of the device link pieces from commits
> dfb80534692d ("PCI: cadence: Add generic PHY support to host and EP drivers")
> 49229238ab47 ("PCI: keystone: Cleanup PHY handling")

Can we split this into three commits (dra7xx, cadence, keystone)?
This combined commit is applied on the pci/controller/misc branch, and
then we have conflicts between that branch and
pci/controller/dwc-dra7xx.

I think if we split this into three separate commits, we can apply the
dra7xx one on pci/controller/dwc-dra7xx and drop Felix's device link
leak fixes below so we don't clutter the git history with conflict
resolutions or irrelevant commits:

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=2b9a036b568c ("PCI: dra7xx: Fix device link leak when devm_phy_get() fails")

  https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/commit/?id=bdfdf654b4b2 ("PCI: dra7xx: Fix device links leak when dra7xx_pcie_enable_phy() fails")

> The trouble with these commits is that they dereference fields inside
> struct phy from a consumer driver, which will become no longer possible.
> 
> Since commit 987351e1ea77 ("phy: core: Add consumer device link
> support") from 2019, the PHY core also adds a device link to order PHY
> provider and consumer suspend/resume operations. All reverted commits
> are from 2017-2018, and what they do should actually be redundant now.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> v8->v9: none
> v7->v8: only context change - "return 0" became "return ret" for
>         cdns_plat_pcie_probe()
> v6->v7: none
> v5->v6: collect tag from Manivannan Sadhasivam
> v3->v5: none
> v2->v3:
> - remove dangling set but unused phy_count local variable in
>   cdns_plat_pcie_probe()
> v1->v2:
> - fully remove struct device link **link from struct cdns_pcie and from
>   cdns_plat_pcie_probe() error path
> - collect tag from Bjorn Helgaas
> - adjust commit title
> ---
>  .../controller/cadence/pcie-cadence-plat.c    |  4 ---
>  drivers/pci/controller/cadence/pcie-cadence.c | 16 +---------
>  drivers/pci/controller/cadence/pcie-cadence.h |  2 --
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ----------
>  drivers/pci/controller/dwc/pci-keystone.c     | 31 +++----------------
>  5 files changed, 5 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> index 8aed8b4c3e11..13edc6be21f5 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	struct pci_host_bridge *bridge;
>  	struct cdns_pcie_ep *ep;
>  	struct cdns_pcie_rc *rc;
> -	int phy_count;
>  	bool is_rc;
>  	int ret;
>  
> @@ -122,9 +121,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> -	phy_count = cdns_plat_pcie->pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index a1eada56edba..0ac980249941 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -222,7 +222,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	struct device_node *np = dev->of_node;
>  	int phy_count;
>  	struct phy **phy;
> -	struct device_link **link;
>  	int i;
>  	int ret;
>  	const char *name;
> @@ -238,10 +237,6 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	for (i = 0; i < phy_count; i++) {
>  		of_property_read_string_index(np, "phy-names", i, &name);
>  		phy[i] = devm_phy_get(dev, name);
> @@ -249,17 +244,10 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  			ret = PTR_ERR(phy[i]);
>  			goto err_phy;
>  		}
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			devm_phy_put(dev, phy[i]);
> -			ret = -EINVAL;
> -			goto err_phy;
> -		}
>  	}
>  
>  	pcie->phy_count = phy_count;
>  	pcie->phy = phy;
> -	pcie->link = link;
>  
>  	ret =  cdns_pcie_enable_phy(pcie);
>  	if (ret)
> @@ -268,10 +256,8 @@ int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie)
>  	return 0;
>  
>  err_phy:
> -	while (--i >= 0) {
> -		device_link_del(link[i]);
> +	while (--i >= 0)
>  		devm_phy_put(dev, phy[i]);
> -	}
>  
>  	return ret;
>  }
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index b4d51adefea5..4a96e1869e53 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -260,7 +260,6 @@ struct cdns_plat_pcie_of_data {
>   * @is_hpa: indicates if the architecture is HPA
>   * @phy_count: number of supported PHY devices
>   * @phy: list of pointers to specific PHY control blocks
> - * @link: list of pointers to corresponding device link representations
>   * @ops: Platform-specific ops to control various inputs from Cadence PCIe
>   *       wrapper
>   * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
> @@ -276,7 +275,6 @@ struct cdns_pcie {
>  	bool				     is_hpa;
>  	int			             phy_count;
>  	struct phy		             **phy;
> -	struct device_link	             **link;
>  	const  struct cdns_pcie_ops          *ops;
>  	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
>  	int				     max_link_speed;
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 3fc889944f02..bf6c5b86bb27 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -9,7 +9,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -678,7 +677,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	int i;
>  	int phy_count;
>  	struct phy **phy;
> -	struct device_link **link;
>  	void __iomem *base;
>  	struct dw_pcie *pci;
>  	struct dra7xx_pcie *dra7xx;
> @@ -726,10 +724,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, phy_count, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	dra7xx->clk = devm_clk_get_optional(dev, NULL);
>  	if (IS_ERR(dra7xx->clk))
>  		return dev_err_probe(dev, PTR_ERR(dra7xx->clk),
> @@ -744,12 +738,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  		phy[i] = devm_phy_get(dev, name);
>  		if (IS_ERR(phy[i]))
>  			return PTR_ERR(phy[i]);
> -
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			ret = -EINVAL;
> -			goto err_link;
> -		}
>  	}
>  
>  	dra7xx->base = base;
> @@ -851,10 +839,6 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_disable(dev);
>  	dra7xx_pcie_disable_phy(dra7xx);
>  
> -err_link:
> -	while (--i >= 0)
> -		device_link_del(link[i]);
> -
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index e9b012a5ea9a..8085c4f61403 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -130,7 +130,6 @@ struct keystone_pcie {
>  	int			num_lanes;
>  	u32			num_viewport;
>  	struct phy		**phy;
> -	struct device_link	**link;
>  	struct			device_node *msi_intc_np;
>  	struct irq_domain	*intx_irq_domain;
>  	struct device_node	*np;
> @@ -1130,7 +1129,6 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	enum dw_pcie_device_mode mode;
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
> -	struct device_link **link;
>  	struct gpio_desc *gpiod;
>  	struct resource *res;
>  	void __iomem *base;
> @@ -1201,31 +1199,17 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	link = devm_kcalloc(dev, num_lanes, sizeof(*link), GFP_KERNEL);
> -	if (!link)
> -		return -ENOMEM;
> -
>  	for (i = 0; i < num_lanes; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
>  		phy[i] = devm_phy_optional_get(dev, name);
>  		if (IS_ERR(phy[i])) {
>  			ret = PTR_ERR(phy[i]);
> -			goto err_link;
> -		}
> -
> -		if (!phy[i])
> -			continue;
> -
> -		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> -		if (!link[i]) {
> -			ret = -EINVAL;
> -			goto err_link;
> +			goto err;
>  		}
>  	}
>  
>  	ks_pcie->np = np;
>  	ks_pcie->pci = pci;
> -	ks_pcie->link = link;
>  	ks_pcie->num_lanes = num_lanes;
>  	ks_pcie->phy = phy;
>  
> @@ -1235,7 +1219,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(gpiod);
>  		if (ret != -EPROBE_DEFER)
>  			dev_err(dev, "Failed to get reset GPIO\n");
> -		goto err_link;
> +		goto err;
>  	}
>  
>  	/* Obtain references to the PHYs */
> @@ -1250,7 +1234,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -		goto err_link;
> +		goto err;
>  	}
>  
>  	platform_set_drvdata(pdev, ks_pcie);
> @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
>  
> -err_link:
> -	while (--i >= 0 && link[i])
> -		device_link_del(link[i]);
> -
> +err:
>  	return ret;
>  }
>  
>  static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> -	struct device_link **link = ks_pcie->link;
> -	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
>  
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> -	while (num_lanes--)
> -		device_link_del(link[num_lanes]);
>  }
>  
>  static struct platform_driver ks_pcie_driver = {
> -- 
> 2.34.1
> 
