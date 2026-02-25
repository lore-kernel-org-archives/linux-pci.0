Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E83B8D73;
	Wed, 25 Feb 2026 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026663; cv=none; b=WsREf2S+jzlOESMWCacH3UoT9UoaWuZV05DG5scCVtoqqoL4+kORbLcrmaeJm9YFuTIZCL2oPq76Hzhq6JsXWcNlYDWZ9VEMX+15YmKHYMaCuszgjjoJKeiDGqqCV5owQ31/+4FB0N7Xl1WO6q8aP/hvkLFIChZkLPGMVpKWefE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026663; c=relaxed/simple;
	bh=bemM/LEC5Wzvw6ugCvnxYCb6QCsFWpOqKSWd7GnGE7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWR9XLmsTKPZn0FQ/zBch0nNYYuNayMbDsszpqhiagIV5Dkn0U5LLZYqZJevQEgGtlwcBZ/IvB8+SwVI2UPdRX/W5Blb0gVwx59Qi//RhjqoVy3+sZwxMStU7XXJgenBFL0YoW/ip3o/l0JTs9pHXCjdvbox7QJKn2+eKtCSvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSncYQQ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSncYQQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0929C116D0;
	Wed, 25 Feb 2026 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772026663;
	bh=bemM/LEC5Wzvw6ugCvnxYCb6QCsFWpOqKSWd7GnGE7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSncYQQ7SfEoFvhk+wo6PEBV5SmEef64co+tO7nCKUQu4t8sKan4cyCLbAdUipyEj
	 rYlHVWiiDdXZQn+6m8al5b4nnICAemVVYkfbyIKkpYdL6shM20tzgQqgDvi8DdjoBM
	 iTINtvyyroZ8VRj+DL640xbA4V5R+iccKCBIkh1iTlZRu9HomcZ0uta1lUsmY7A7Xu
	 FSDy2w9jiwUKGSq+ldKl4pyUKIMWFi0pVRPaWWsfo6hQBwWnP1mH3nGJUNCK06Kp6G
	 yJGKwF6e3R7Bh4oWNmHqI8udvQTeUsR8zhy9aIEhpSbbMo6Yhd9SYY9i0T6xpfAi9J
	 +KhEgCczq6Nig==
Date: Wed, 25 Feb 2026 19:07:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <cxfbgzwsybfvixu3qqi66fvspmhe5knuevwcj6zwsakkzqwd3z@czmitvgl7nwt>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
 <20260129092900.1900-1-zhangsenchuan@eswincomputing.com>
 <a3yu54e6feo5immtdju4fgvne7fh3p4ytlawfdhawmpzvagi64@o7wuhhdiitft>
 <78296255.3869.19c8eb694d6.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78296255.3869.19c8eb694d6.Coremail.zhangsenchuan@eswincomputing.com>

On Tue, Feb 24, 2026 at 04:14:16PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Wednesday, 18/02/2026 20:47:14
> > To: zhangsenchuan@eswincomputing.com
> > Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
> > Subject: Re: [PATCH v10 2/2] PCI: eic7700: Add Eswin PCIe host controller driver
> > 
> > On Thu, Jan 29, 2026 at 05:29:00PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > 
> > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > interrupts.
> > > 
> > > Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> > > Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> > > Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig        |  11 +
> > >  drivers/pci/controller/dwc/Makefile       |   1 +
> > >  drivers/pci/controller/dwc/pcie-eic7700.c | 410 ++++++++++++++++++++++
> > >  3 files changed, 422 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index 519b59422b47..c837cb5947b6 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -93,6 +93,17 @@ config PCIE_BT1
> > >  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> > >  	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> > >  
> > > +config PCIE_EIC7700
> > > +	tristate "Eswin EIC7700 PCIe controller"
> > > +	depends on ARCH_ESWIN || COMPILE_TEST
> > > +	depends on PCI_MSI
> > > +	select PCIE_DW_HOST
> > > +	help
> > > +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
> > > +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
> > > +	  enables support for the PCIe controller in the EIC7700 SoC to work in
> > > +	  host mode.
> > > +
> > >  config PCI_IMX6
> > >  	bool
> > >  
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index 67ba59c02038..7c5a5186ea83 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> > >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> > >  obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
> > >  obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> > > +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
> > >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> > >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > > diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
> > > new file mode 100644
> > > index 000000000000..dab8e3b98810
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> > > @@ -0,0 +1,410 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ESWIN EIC7700 PCIe root complex driver
> > > + *
> > > + * Copyright 2026, Beijing ESWIN Computing Technology Co., Ltd.
> > > + *
> > > + * Authors: Yu Ning <ningyu@eswincomputing.com>
> > > + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > + *          Yanghui Ou <ouyanghui@eswincomputing.com>
> > > + */
> > > +
> > > +#include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/resource.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +
> > > +/* ELBI registers */
> > > +#define PCIEELBI_CTRL0_OFFSET		0x0
> > > +#define PCIEELBI_STATUS0_OFFSET		0x100
> > > +
> > > +/* LTSSM register fields */
> > > +#define PCIEELBI_APP_LTSSM_ENABLE	BIT(5)
> > > +
> > > +/* APP_HOLD_PHY_RST register fields */
> > > +#define PCIEELBI_APP_HOLD_PHY_RST	BIT(6)
> > > +
> > > +/* PM_SEL_AUX_CLK register fields */
> > > +#define PCIEELBI_PM_SEL_AUX_CLK		BIT(16)
> > > +
> > > +/* DEV_TYPE register fields */
> > > +#define PCIEELBI_CTRL0_DEV_TYPE		GENMASK(3, 0)
> > > +
> > > +/* Vendor and device ID value */
> > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > +#define PCI_DEVICE_ID_ESWIN_EIC7700	0x2030
> > > +
> > > +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)
> > > +
> > > +static const char * const eic7700_pcie_rsts[] = {
> > > +	"pwr",
> > > +	"dbi",
> > > +};
> > > +
> > > +struct eic7700_pcie_port {
> > > +	struct list_head list;
> > > +	struct reset_control *perst;
> > > +	int num_lanes;
> > > +};
> > > +
> > > +struct eic7700_pcie {
> > > +	struct dw_pcie pci;
> > > +	struct clk_bulk_data *clks;
> > > +	struct reset_control_bulk_data resets[EIC7700_NUM_RSTS];
> > > +	struct list_head ports;
> > > +	int num_clks;
> > > +};
> > > +
> > > +#define to_eic7700_pcie(x) dev_get_drvdata((x)->dev)
> > > +
> > > +static int eic7700_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +	u32 val;
> > > +
> > > +	/* Enable LTSSM */
> > > +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +	val |= PCIEELBI_APP_LTSSM_ENABLE;
> > > +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool eic7700_pcie_link_up(struct dw_pcie *pci)
> > > +{
> > > +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > +	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> > > +
> > > +	return val & PCI_EXP_LNKSTA_DLLLA;
> > > +}
> > > +
> > > +static int eic7700_pcie_perst_reset(struct eic7700_pcie_port *port,
> > > +				    struct eic7700_pcie *pcie)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = reset_control_assert(port->perst);
> > > +	if (ret) {
> > > +		dev_err(pcie->pci.dev, "Failed to assert PERST#\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* Ensure that PERST# has been asserted for at least 100 ms */
> > > +	msleep(PCIE_T_PVPERL_MS);
> > > +
> > > +	ret = reset_control_deassert(port->perst);
> > > +	if (ret) {
> > > +		dev_err(pcie->pci.dev, "Failed to deassert PERST#\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void eic7700_pcie_assert(struct eic7700_pcie *pcie)
> > > +{
> > > +	struct eic7700_pcie_port *port;
> > > +
> > > +	list_for_each_entry(port, &pcie->ports, list)
> > > +		reset_control_assert(port->perst);
> > > +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> > > +}
> > > +
> > > +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
> > > +				   struct device_node *node)
> > > +{
> > > +	struct device *dev = pcie->pci.dev;
> > > +	struct eic7700_pcie_port *port;
> > > +
> > > +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> > > +	if (!port)
> > > +		return -ENOMEM;
> > > +
> > > +	port->perst = of_reset_control_get_exclusive(node, "perst");
> > > +	if (IS_ERR(port->perst)) {
> > > +		dev_err(dev, "Failed to get PERST# reset\n");
> > > +		return PTR_ERR(port->perst);
> > > +	}
> > > +
> > > +	/*
> > > +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> > > +	 * the DWC core initialization code can't parse the num-lanes attribute
> > > +	 * in the Root Port. Before entering the DWC core initialization code,
> > > +	 * the platform driver code parses the Root Port node. The EIC7700 only
> > > +	 * supports one Root Port node, and the num-lanes attribute is suitable
> > > +	 * for the case of one Root Port.
> > > +	 */
> > > +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> > > +		pcie->pci.num_lanes = port->num_lanes;
> > > +
> > > +	INIT_LIST_HEAD(&port->list);
> > > +	list_add_tail(&port->list, &pcie->ports);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
> > > +{
> > > +	struct eic7700_pcie_port *port, *tmp;
> > > +	struct device *dev = pcie->pci.dev;
> > > +	int ret;
> > > +
> > > +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> > > +		ret = eic7700_pcie_parse_port(pcie, of_port);
> > > +		if (ret)
> > > +			goto err_port;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_port:
> > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > +		reset_control_put(port->perst);
> > > +		list_del(&port->list);
> > > +	}
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> > > +	struct eic7700_pcie_port *port;
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/*
> > > +	 * The PWR and DBI reset signals are respectively used to reset the
> > > +	 * PCIe controller and the DBI register.
> > > +	 *
> > > +	 * The PERST# signal is a reset signal that simultaneously controls the
> > > +	 * PCIe controller, PHY, and Endpoint. Before configuring the PHY, the
> > > +	 * PERST# signal must first be deasserted.
> > > +	 *
> > > +	 * The external reference clock is supplied simultaneously to the PHY
> > > +	 * and EP. When the PHY is configurable, the entire chip already has
> > > +	 * stable power and reference clock. The PHY will be ready within 20ms
> > > +	 * after writing app_hold_phy_rst register bit of ELBI register space.
> > > +	 */
> > > +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);
> > > +	if (ret) {
> > > +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
> > > +		goto err_deassert;
> > > +	}
> > > +
> > > +	/* Configure Root Port type */
> > > +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
> > > +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
> > > +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +
> > > +	list_for_each_entry(port, &pcie->ports, list) {
> > > +		ret = eic7700_pcie_perst_reset(port, pcie);
> > > +		if (ret)
> > > +			goto err_perst;
> > > +	}
> > > +
> > > +	/* Configure app_hold_phy_rst */
> > > +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
> > > +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > +
> > > +	/* The maximum waiting time for the clock switch lock is 20ms */
> > > +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET, val,
> > > +				 !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
> > > +				 20000);
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> > > +		goto err_phy_init;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Configure ESWIN VID:DID for Root Port as the default values are
> > > +	 * invalid.
> > > +	 */
> > > +	dw_pcie_dbi_ro_wr_en(pci);
> > > +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_ESWIN);
> > > +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_ESWIN_EIC7700);
> > > +	dw_pcie_dbi_ro_wr_dis(pci);
> > > +
> > > +	return 0;
> > > +
> > > +err_phy_init:
> > > +	list_for_each_entry(port, &pcie->ports, list)
> > > +		reset_control_assert(port->perst);
> > > +err_perst:
> > > +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> > > +err_deassert:
> > > +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void eic7700_pcie_host_deinit(struct dw_pcie_rp *pp)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> > > +
> > > +	eic7700_pcie_assert(pcie);
> > > +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > > +}
> > > +
> > > +static const struct dw_pcie_host_ops eic7700_pcie_host_ops = {
> > > +	.init = eic7700_pcie_host_init,
> > > +	.deinit = eic7700_pcie_host_deinit,
> > > +};
> > > +
> > > +static const struct dw_pcie_ops dw_pcie_ops = {
> > > +	.start_link = eic7700_pcie_start_link,
> > > +	.link_up = eic7700_pcie_link_up,
> > > +};
> > > +
> > > +static int eic7700_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	struct eic7700_pcie_port *port, *tmp;
> > > +	struct device *dev = &pdev->dev;
> > > +	struct eic7700_pcie *pcie;
> > > +	struct dw_pcie *pci;
> > > +	int ret, i;
> > > +
> > > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > +	if (!pcie)
> > > +		return -ENOMEM;
> > > +
> > > +	INIT_LIST_HEAD(&pcie->ports);
> > > +
> > > +	pci = &pcie->pci;
> > > +	pci->dev = dev;
> > > +	pci->ops = &dw_pcie_ops;
> > > +	pci->pp.ops = &eic7700_pcie_host_ops;
> > > +
> > > +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
> > > +	if (pcie->num_clks < 0)
> > > +		return dev_err_probe(dev, pcie->num_clks,
> > > +				     "Failed to get pcie clocks\n");
> > > +
> > > +	for (i = 0; i < EIC7700_NUM_RSTS; i++)
> > > +		pcie->resets[i].id = eic7700_pcie_rsts[i];
> > > +
> > > +	ret = devm_reset_control_bulk_get_exclusive(dev, EIC7700_NUM_RSTS,
> > > +						    pcie->resets);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to get resets\n");
> > > +
> > > +	ret = eic7700_pcie_parse_ports(pcie);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to parse Root Port\n");
> > > +
> > > +	platform_set_drvdata(pdev, pcie);
> > > +
> > > +	pm_runtime_no_callbacks(dev);
> > > +	devm_pm_runtime_enable(dev);
> > > +	ret = pm_runtime_get_sync(dev);
> > > +	if (ret < 0)
> > > +		goto err_pm_runtime_put;
> > > +
> > > +	ret = dw_pcie_host_init(&pci->pp);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to init host\n");
> > > +		goto err_pm_runtime_put;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_pm_runtime_put:
> > > +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> > > +		reset_control_put(port->perst);
> > > +		list_del(&port->list);
> > > +	}
> > > +	pm_runtime_put(dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int eic7700_pcie_suspend_noirq(struct device *dev)
> > > +{
> > > +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> > > +
> > > +	/*
> > > +	 * The ESWIN EIC7700 SoC lacks hardware support for the L2/L3 low-power
> > > +	 * link states. It cannot enter the L2/L3 Ready state through the
> > > +	 * PME_Turn_Off/PME_To_Ack handshake protocol. To avoid this problem,
> > > +	 * the dw_pcie_suspend_noirq API is not used.
> > > +	 */
> > 
> > With 7.0, you can provide a dummy pme_turn_off() API and set
> > 'pci->pp.skip_l23_ready' to reuse the dw_pcie_{suspend/resume}_noirq APIs.
> > 
> 
> Hi Mani,
> 
> Setting pci->pp.skip_l23_ready does indeed allow us to reuse the
> dw_pcie_suspend_noirq function. However, for the dw_pcie_resume_noirq
> function, if the dw_pcie_start_link and dw_pcie_wait_for_link APIs fail to
> execute, the clk/reset resources in the pci->pp.ops->init function cannot
> be released. Perhaps the dw_pcie_resume_noirq function needs to be optimized.

Will this help?

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6ae6189e9b8a..38ad79bbeab1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1300,15 +1300,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 
        ret = dw_pcie_start_link(pci);
        if (ret)
-               return ret;
+               goto err_deinit;
 
        ret = dw_pcie_wait_for_link(pci);
        if (ret)
-               return ret;
+               goto err_stop_link;
 
        if (pci->pp.ops->post_init)
                pci->pp.ops->post_init(&pci->pp);
 
+       return 0;
+
+err_stop_link:
+       dw_pcie_stop_link(pci);
+
+err_deinit:
+       if (pci->pp.ops->deinit)
+               pci->pp.ops->deinit(&pci->pp);
+
        return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);

- Mani

-- 
மணிவண்ணன் சதாசிவம்
