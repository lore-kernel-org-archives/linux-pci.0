Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A534028B;
	Tue,  9 Jun 2026 14:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781014706; cv=none; b=OEiUW8beLJOC324y/rrryT81mYHY8c5ImBgFeAT97qdBem1DSp9b+u7jIHUumxm69t3N8Ou12iMe8WIwlxtEEpqLIkl2VOrnQhqEmUxW1rjl4yOyJ0hnujEkQQs/vmREWUvCNzUxNQEt53cG8cbHmFqFIHivV7I+2Y8BcjSwwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781014706; c=relaxed/simple;
	bh=hHuXk7hBPAOHuqknXfqxtiKUndx3Id7hByXgiQlLOaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fougG8S46uh14NrlstZRVcNYnaH6epxpjF5yhdP5iPbYl4BhMYI2v4g8fRLnndwfp4yRD0B7jhxd7JgU9qK8oOpZqLX37i9Z3/RmfpI9W6JeblIcKiueexjuqiPp9kdqm3uFaurtD8xxEQ6vbmQABeSiEghUpLDS4OYzUkj/y4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM+xhsd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM+xhsd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6AB1F00898;
	Tue,  9 Jun 2026 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781014705;
	bh=NSdCVXmf/FSFEPh76vybp3lyGq1hMV3I6z1fDAOvPXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HM+xhsd/kVgMNQ0nZoL5DJOSV+N4g5kXGk5GnoGwbaIeRcuBryIsN15/UDAiNShrb
	 efSETT9eDOx82f6ZFhyuOZ9QeB1nJ/sQjZhfocHkge9t+m3HbKJTaGLS/U3D8E9jJg
	 TnMK2zmNTQ0fWhs+hpo0J5pLXsjoBXdfJFtmOSduR7Q3gjBQcGLhFe/WmQQfFRukBd
	 go8TnAYBoOeP5I7QC8x8DsUKAbIb7QcIIWH4MeVOYRLJ5P+5aU/ZxtY+//nUmp8/pP
	 hVi/ORiW/RYclWvUzTGDXE9W6v/h8FNkFJaWN4PjJlfuiTC0Hct5RGK+u2STVG7IN8
	 F4SIuBZtZR+9A==
Date: Tue, 9 Jun 2026 19:48:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Alex Elder <elder@riscstar.com>, Nam Cao <namcao@linutronix.de>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Randolph Lin <randolph@andestech.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 5/5] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <wztjdv4t5cn7djj3jyvheest7rn5nr2g3efzwods2fz3yy5wn2@hbl644sd6fst>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-6-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517014841.254085-6-inochiama@gmail.com>

On Sun, May 17, 2026 at 09:48:40AM +0800, Inochi Amaoto wrote:
> The PCIe controller on Spacemit K3 is almost a standard Synopsys
> DesignWare PCIe IP with extra link and reset control. Unlike
> the PCIe controller on K1, this controller supports external MSI
> interrupt controller and can use multiple PHYs at the same time.
> 
> Add driver to support PCIe controller on Spacemit K3 PCIe.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c | 169 ++++++++++++++++++
>  2 files changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index f2fde13107f2..fae971ecd876 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -439,7 +439,7 @@ config PCIE_SOPHGO_DW
>  	  Sophgo SoCs.
>  
>  config PCIE_SPACEMIT_K1
> -	tristate "SpacemiT K1 PCIe controller (host mode)"
> +	tristate "SpacemiT K1/K3 PCIe controller (host mode)"

Can you just say 'SpacemiT PCIe controller (host mode)"? I believe I asked Alex
while adding K1 support and he said this driver might not support future IP
revisions, but here we are.

>  	depends on ARCH_SPACEMIT || COMPILE_TEST
>  	depends on HAS_IOMEM
>  	select PCIE_DW_HOST
> @@ -447,7 +447,7 @@ config PCIE_SPACEMIT_K1
>  	default ARCH_SPACEMIT
>  	help
>  	  Enables support for the DesignWare based PCIe controller in
> -	  the SpacemiT K1 SoC operating in host mode.  Three controllers
> +	  the SpacemiT K1/K3 SoC operating in host mode. Three controllers
>  	  are available on the K1 SoC; the first of these shares a PHY
>  	  with a USB 3.0 host controller (one or the other can be used).
>  
> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> index 7f6f1df31cd8..7854d26220a9 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -23,6 +23,7 @@
>  
>  #define PCI_VENDOR_ID_SPACEMIT		0x201f
>  #define PCI_DEVICE_ID_SPACEMIT_K1	0x0001
> +#define PCI_DEVICE_ID_SPACEMIT_K3	0x0002
>  
>  /* Offsets and field definitions for link management registers */
>  #define K1_PHY_AHB_IRQ_EN			0x0000
> @@ -32,8 +33,20 @@
>  #define SMLH_LINK_UP			BIT(1)
>  #define RDLH_LINK_UP			BIT(12)
>  
> +#define INTR_STATUS				0x0010
> +
>  #define INTR_ENABLE				0x0014
>  #define MSI_CTRL_INT			BIT(11)
> +#define RDLH_LINK_UP_INT		BIT(20)
> +
> +#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
> +
> +#define K3_ADDR_INTR_STATUS1			0x0018
> +
> +#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
> +#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
> +
> +#define K3_MAX_PHY_NUMBER		6

What does this mean? 6 ports?

>  
>  /* Some controls require APMU regmap access */
>  #define SYSCON_APMU			"spacemit,apmu"
> @@ -48,6 +61,9 @@
>  
>  #define PCIE_CONTROL_LOGIC			0x0004
>  #define PCIE_SOFT_RESET			BIT(0)
> +#define PCIE_PERSTN_OE			BIT(24)
> +#define PCIE_PERSTN_OUT			BIT(25)
> +#define PCIE_IGNORE_PERSTN		BIT(31)
>  
>  struct k1_pcie {
>  	struct dw_pcie pci;
> @@ -262,6 +278,152 @@ static const struct dw_pcie_ops k1_pcie_ops = {
>  	.stop_link	= k1_pcie_stop_link,
>  };
>  
> +static int k3_pcie_enable_phy(struct k1_pcie *pcie)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < pcie->phy_count; i++) {
> +		ret = phy_init(pcie->phy[i]);
> +		if (ret)
> +			goto err_phy;
> +	}
> +
> +	return 0;
> +
> +err_phy:
> +	while (--i >= 0)
> +		phy_exit(pcie->phy[i]);
> +
> +	return ret;
> +}
> +
> +static int k3_pcie_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct k1_pcie *k1 = to_k1_pcie(pci);
> +	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
> +	u32 val;
> +	int ret;
> +
> +	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
> +
> +	k1_pcie_toggle_soft_reset(k1);
> +
> +	ret = k1_pcie_enable_resources(k1);
> +	if (ret)
> +		return ret;
> +
> +	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
> +	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
> +
> +	ret = k3_pcie_enable_phy(k1);
> +	if (ret) {
> +		k1_pcie_disable_resources(k1);
> +		return ret;
> +	}
> +
> +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */

What does this mean?

> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT);
> +	usleep_range(1000, 2000);
> +	regmap_clear_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC, PCIE_PERSTN_OUT);
> +
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	/*
> +	 * Put the controller in root complex mode, and indicate that
> +	 * Vaux (3.3v) is present.
> +	 */

How can the driver confirm without checking DT for vpcie3v3aux-supply?

> +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> +			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
> +
> +	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	val = u32_replace_bits(val, GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE,
> +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K3);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	/* Finally, as a workaround, disable ASPM L1 */
> +	k1_pcie_disable_aspm_l1(k1);
> +
> +	return 0;
> +}
> +
> +static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u32 val;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = dw_pcie_readl_dbi(pci, COHERENCY_CONTROL_3_OFF);
> +	val |= u32_replace_bits(val, K3_CACHE_MSTR_AWCACHE_BEHAVIOR,
> +				K3_CACHE_MSTR_AWCACHE_MODE);
> +	dw_pcie_writel_dbi(pci, COHERENCY_CONTROL_3_OFF, val);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops k3_pcie_host_ops = {
> +	.init		= k3_pcie_init,
> +	.deinit		= k1_pcie_deinit,
> +	.msi_init	= k3_pcie_msi_host_init,
> +};
> +
> +static const struct dw_pcie_ops k3_pcie_ops = {
> +	.link_up	= k1_pcie_link_up,
> +	.start_link	= k1_pcie_start_link,
> +	.stop_link	= k1_pcie_stop_link,
> +};
> +
> +static void k3_pcie_clear_irq_status(struct k1_pcie *k1,
> +				     u32 *status0, u32 *status1, u32 *status2)
> +{
> +	*status0 = readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	*status1 = readl_relaxed(k1->link + INTR_STATUS);
> +	*status2 = readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
> +
> +	writel_relaxed(*status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
> +	writel_relaxed(*status1, k1->link + INTR_STATUS);
> +	writel_relaxed(*status2, k1->link + K3_ADDR_INTR_STATUS1);
> +}
> +
> +static int k3_pcie_parse_port(struct k1_pcie *k1)
> +{
> +	struct device *dev = k1->pci.dev;
> +	u32 status0, status1, status2;
> +	int i;
> +
> +	k1->phy = devm_kmalloc_array(dev, K3_MAX_PHY_NUMBER, sizeof(*k1->phy),
> +				     GFP_KERNEL);
> +	if (!k1->phy)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < K3_MAX_PHY_NUMBER; i++) {
> +		k1->phy[i] = devm_of_phy_get_by_index(dev, dev->of_node, i);
> +		if (IS_ERR(k1->phy[i])) {
> +			if (PTR_ERR(k1->phy[i]) == -ENODEV)
> +				break;
> +
> +			return PTR_ERR(k1->phy[i]);
> +		}
> +	}
> +
> +	k1->phy_count = i;
> +	if (k1->phy_count == 0)
> +		return -EINVAL;
> +
> +	k3_pcie_clear_irq_status(k1, &status0, &status1, &status2);
> +
> +	return 0;
> +}

This function should iterate over the Root Port nodes defined in DT.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
