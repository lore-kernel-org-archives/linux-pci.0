Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1434133A717;
	Thu,  2 Apr 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151144; cv=none; b=cnvXCZ79q0uvte0a59yHloGwWBggGPZwsZT2rwML1B18SRGQp2d20ZYer8cZO2wc5u1Myd3RZ2m7hl69mQ495TZQeDq8Ls3lkUVxMAlIRwLV4mBmiQFqXLRGLOezoJfhIWKm9si3lHfaCVt5VEy9O1V+V9ELI6Bu6aunElXnBGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151144; c=relaxed/simple;
	bh=jRSIv8LioujVpT978cG++b4luP/nCgUJUTakC1huHso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/+b5gGYSE1q+I4/c3cuAt9RSnHN1AfYev2E/cq937XvCoLJk7bc4IdCj79x99jFoUeV2S6QriHJD7QZrN2Y0PsRwwIA6FyvgGkeOvDwG7/wC2qunN7uoEUbcK8jrQ8sCc2Npe+X30tytoiOJMGLaRFE/D3VAnZaBEMLBdy+qLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uujFBkm8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uujFBkm8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE74C116C6;
	Thu,  2 Apr 2026 17:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151143;
	bh=jRSIv8LioujVpT978cG++b4luP/nCgUJUTakC1huHso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uujFBkm8qRDxJlbtJTRBJz0//a/OE09OeLOdoNWJKpBUotc9f4pZEqpnIHcXkS0/B
	 IokxgkzrvgGRFsqY4AvMiFYbhtfgf0/oZTNX0XcVSxuwvvmQQbV/dJGEQBmCUFKbtc
	 hbB9mUtt0tYS0zTwgCuWgsDVYPtNfL5NwYCScLAaUJu5rfYu+fisL5qCzM30JLAODG
	 AF1wEV+PKUTaKiIjP9O0/2MrX/Nq8Ya72p26h3YoIIRhcoL4gWXASOxItoxIrY06DZ
	 uyPTpemhbz239kDAPncJS7TuNJEucfsI6itm8P9apcjM/mIvCKlngLblnc62YheoAI
	 QDsulNPyHB4Mw==
Date: Thu, 2 Apr 2026 23:02:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v4 3/4] PCI: tegra: Add Tegra264 support
Message-ID: <iaoee5r5e2w52fap7ex23wdikbuvpjpesinedgjkehsedszhzo@64yoo2avmxle>
References: <20260402-tegra264-pcie-v4-0-21e2e19987e8@nvidia.com>
 <20260402-tegra264-pcie-v4-3-21e2e19987e8@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402-tegra264-pcie-v4-3-21e2e19987e8@nvidia.com>

On Thu, Apr 02, 2026 at 04:27:37PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
> driver is very small, with its main purpose being to set up the address
> translation registers and then creating a standard PCI host using ECAM.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

What is the rationale for adding a new driver? Can't you reuse the existing one?
If so, that should be mentioned in the description.

> ---
> Changes in v2:
> - specify generations applicable for PCI_TEGRA driver to avoid confusion
> - drop SPDX-FileCopyrightText tag
> - rename link_state to link_up to clarify meaning
> - replace memset() by an empty initializer
> - sanity-check only enable BAR regions
> - bring PCI link out of reset in case firmware didn't
> - use common wait times instead of defining our own
> - use core helpers to parse and print PCI link speed
> - fix multi-line comment
> - use dev_err_probe() more ubiquitously
> - fix probe sequence and error cleanup
> - use DEFINE_NOIRQ_DEV_PM_OPS() to avoid warnings for !PM_SUSPEND
> - reuse more standard registers and remove unused register definitions
> - use %pe and ERR_PTR() to print symbolic errors
> - add signed-off-by from Manikanta as the original author
> - add myself as author after significantly modifying the driver
> ---
>  drivers/pci/controller/Kconfig         |  10 +-
>  drivers/pci/controller/Makefile        |   1 +
>  drivers/pci/controller/pcie-tegra264.c | 527 +++++++++++++++++++++++++++++++++
>  3 files changed, 537 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 5aaed8ac6e44..6ead04f7bd6e 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -254,7 +254,15 @@ config PCI_TEGRA
>  	select IRQ_MSI_LIB
>  	help
>  	  Say Y here if you want support for the PCIe host controller found
> -	  on NVIDIA Tegra SoCs.
> +	  on NVIDIA Tegra SoCs (Tegra20 through Tegra186).
> +
> +config PCIE_TEGRA264
> +	bool "NVIDIA Tegra264 PCIe controller"

This driver seems to be using external MSI controller. So it can be built as a
module. Also, you have the remove() callback for some reason.

> +	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on PCI_MSI

Why?

> +	help
> +	  Say Y here if you want support for the PCIe host controller found
> +	  on NVIDIA Tegra264 SoCs.
>  
>  config PCIE_RCAR_HOST
>  	bool "Renesas R-Car PCIe controller (host mode)"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index ac8db283f0fe..d478743b5142 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_HYPERV_INTERFACE) += pci-hyperv-intf.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
>  obj-$(CONFIG_PCI_AARDVARK) += pci-aardvark.o
>  obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
> +obj-$(CONFIG_PCIE_TEGRA264) += pcie-tegra264.o
>  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>  obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> new file mode 100644
> index 000000000000..3ce1ad971bdb
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -0,0 +1,527 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe host controller driver for Tegra264 SoC
> + *
> + * Copyright (c) 2022-2026, NVIDIA CORPORATION. All rights reserved.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/interconnect.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/pci.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +#include <soc/tegra/fuse.h>
> +
> +#include "../pci.h"
> +
> +/* XAL registers */
> +#define XAL_RC_ECAM_BASE_HI			0x00
> +#define XAL_RC_ECAM_BASE_LO			0x04
> +#define XAL_RC_ECAM_BUSMASK			0x08
> +#define XAL_RC_IO_BASE_HI			0x0c
> +#define XAL_RC_IO_BASE_LO			0x10
> +#define XAL_RC_IO_LIMIT_HI			0x14
> +#define XAL_RC_IO_LIMIT_LO			0x18
> +#define XAL_RC_MEM_32BIT_BASE_HI		0x1c
> +#define XAL_RC_MEM_32BIT_BASE_LO		0x20
> +#define XAL_RC_MEM_32BIT_LIMIT_HI		0x24
> +#define XAL_RC_MEM_32BIT_LIMIT_LO		0x28
> +#define XAL_RC_MEM_64BIT_BASE_HI		0x2c
> +#define XAL_RC_MEM_64BIT_BASE_LO		0x30
> +#define XAL_RC_MEM_64BIT_LIMIT_HI		0x34
> +#define XAL_RC_MEM_64BIT_LIMIT_LO		0x38
> +#define XAL_RC_BAR_CNTL_STANDARD		0x40
> +#define XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN	BIT(0)
> +#define XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN	BIT(1)
> +#define XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN	BIT(2)
> +
> +/* XTL registers */
> +#define XTL_RC_PCIE_CFG_LINK_STATUS		0x5a
> +
> +#define XTL_RC_MGMT_PERST_CONTROL		0x218
> +#define XTL_RC_MGMT_PERST_CONTROL_PERST_O_N	BIT(0)
> +
> +#define XTL_RC_MGMT_CLOCK_CONTROL		0x47c
> +#define XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT	BIT(9)
> +
> +struct tegra264_pcie {
> +	struct device *dev;
> +	bool link_up;

Keep bool types at the end to avoid holes.

> +
> +	/* I/O memory */
> +	void __iomem *xal;
> +	void __iomem *xtl;
> +	void __iomem *ecam;
> +
> +	/* bridge configuration */
> +	struct pci_config_window *cfg;
> +	struct pci_host_bridge *bridge;
> +
> +	/* wake IRQ */
> +	struct gpio_desc *wake_gpio;
> +	unsigned int wake_irq;
> +
> +	/* BPMP and bandwidth management */
> +	struct icc_path *icc_path;
> +	struct tegra_bpmp *bpmp;
> +	u32 ctl_id;
> +};
> +
> +static int tegra264_pcie_parse_dt(struct tegra264_pcie *pcie)
> +{
> +	int err;
> +
> +	pcie->wake_gpio = devm_gpiod_get_optional(pcie->dev, "nvidia,pex-wake",

You should switch to standard 'wake-gpios' property.

> +						  GPIOD_IN);
> +	if (IS_ERR(pcie->wake_gpio))
> +		return PTR_ERR(pcie->wake_gpio);
> +
> +	if (pcie->wake_gpio) {

Since you are bailing out above, you don't need this check.

> +		device_init_wakeup(pcie->dev, true);
> +
> +		err = gpiod_to_irq(pcie->wake_gpio);
> +		if (err < 0) {
> +			dev_err(pcie->dev, "failed to get wake IRQ: %pe\n",
> +				ERR_PTR(err));
> +			return err;
> +		}
> +
> +		pcie->wake_irq = (unsigned int)err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void tegra264_pcie_bpmp_set_rp_state(struct tegra264_pcie *pcie)

I don't think this function name is self explanatory. Looks like it is turning
off the PCIe controller, so how about tegra264_pcie_power_off()?

> +{
> +	struct tegra_bpmp_message msg = {};
> +	struct mrq_pcie_request req = {};
> +	int err;
> +
> +	req.cmd = CMD_PCIE_RP_CONTROLLER_OFF;
> +	req.rp_ctrlr_off.rp_controller = pcie->ctl_id;
> +
> +	msg.mrq = MRQ_PCIE;
> +	msg.tx.data = &req;
> +	msg.tx.size = sizeof(req);
> +
> +	err = tegra_bpmp_transfer(pcie->bpmp, &msg);
> +	if (err)
> +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %pe\n",

Why not dev_err()?

> +			 pcie->ctl_id, ERR_PTR(err));
> +
> +	if (msg.rx.ret)
> +		dev_info(pcie->dev, "failed to turn off PCIe #%u: %d\n",

Same here.

> +			 pcie->ctl_id, msg.rx.ret);
> +}
> +
> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width, bw;
> +	int err;
> +
> +	value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	bw = width * (PCIE_SPEED2MBS_ENC(speed) / BITS_PER_BYTE);
> +	value = MBps_to_icc(bw);

So this becomes, 'width * (PCIE_SPEED2MBS_ENC(speed) / 8) * 1000 / 8'. But don't
you want, 'width * (PCIE_SPEED2MBS_ENC(speed)) * 1000 / 8'?

> +
> +	err = icc_set_bw(pcie->icc_path, bw, bw);
> +	if (err < 0)
> +		dev_err(pcie->dev,
> +			"failed to request bandwidth (%u MBps): %pe\n",
> +			bw, ERR_PTR(err));

So you don't want to error out if this fails?

> +}
> +
> +/*
> + * The various memory regions used by the controller (I/O, memory, ECAM) are
> + * set up during early boot and have hardware-level protections in place. If
> + * the DT ranges don't match what's been setup, the controller won't be able
> + * to write the address endpoints properly, so make sure to validate that DT
> + * and firmware programming agree on these ranges.
> + */
> +static bool tegra264_pcie_check_ranges(struct platform_device *pdev)
> +{
> +	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device_node *np = pcie->dev->of_node;
> +	struct of_pci_range_parser parser;
> +	phys_addr_t phys, limit, hi, lo;
> +	struct of_pci_range range;
> +	struct resource *res;
> +	bool status = true;
> +	u32 value;
> +	int err;
> +
> +	err = of_pci_range_parser_init(&parser, np);
> +	if (err < 0)
> +		return false;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		unsigned int addr_hi, addr_lo, limit_hi, limit_lo, enable;
> +		unsigned long type = range.flags & IORESOURCE_TYPE_BITS;
> +		phys_addr_t start, end, mask;
> +		const char *region = NULL;
> +
> +		end = range.cpu_addr + range.size - 1;
> +		start = range.cpu_addr;
> +
> +		switch (type) {
> +		case IORESOURCE_IO:
> +			addr_hi = XAL_RC_IO_BASE_HI;
> +			addr_lo = XAL_RC_IO_BASE_LO;
> +			limit_hi = XAL_RC_IO_LIMIT_HI;
> +			limit_lo = XAL_RC_IO_LIMIT_LO;
> +			enable = XAL_RC_BAR_CNTL_STANDARD_IOBAR_EN;
> +			mask = SZ_64K - 1;
> +			region = "I/O";
> +			break;
> +
> +		case IORESOURCE_MEM:
> +			if (range.flags & IORESOURCE_PREFETCH) {
> +				addr_hi = XAL_RC_MEM_64BIT_BASE_HI;
> +				addr_lo = XAL_RC_MEM_64BIT_BASE_LO;
> +				limit_hi = XAL_RC_MEM_64BIT_LIMIT_HI;
> +				limit_lo = XAL_RC_MEM_64BIT_LIMIT_LO;
> +				enable = XAL_RC_BAR_CNTL_STANDARD_64B_BAR_EN;
> +				region = "prefetchable memory";
> +			} else {
> +				addr_hi = XAL_RC_MEM_32BIT_BASE_HI;
> +				addr_lo = XAL_RC_MEM_32BIT_BASE_LO;
> +				limit_hi = XAL_RC_MEM_32BIT_LIMIT_HI;
> +				limit_lo = XAL_RC_MEM_32BIT_LIMIT_LO;
> +				enable = XAL_RC_BAR_CNTL_STANDARD_32B_BAR_EN;
> +				region = "memory";
> +			}
> +
> +			mask = SZ_1M - 1;
> +			break;
> +		}
> +
> +		/* not interested in anything that's not I/O or memory */
> +		if (!region)
> +			continue;
> +
> +		/* don't check regions that haven't been enabled */
> +		value = readl(pcie->xal + XAL_RC_BAR_CNTL_STANDARD);
> +		if ((value & enable) == 0)
> +			continue;
> +
> +		hi = readl(pcie->xal + addr_hi);
> +		lo = readl(pcie->xal + addr_lo);
> +		phys = hi << 32 | lo;
> +
> +		hi = readl(pcie->xal + limit_hi);
> +		lo = readl(pcie->xal + limit_lo);
> +		limit = hi << 32 | lo | mask;
> +
> +		if (phys != start || limit != end) {
> +			dev_err(pcie->dev,
> +				"%s region mismatch: %pap-%pap -> %pap-%pap\n",
> +				region, &phys, &limit, &start, &end);
> +			status = false;
> +		}
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
> +	if (!res)
> +		return false;
> +
> +	hi = readl(pcie->xal + XAL_RC_ECAM_BASE_HI);
> +	lo = readl(pcie->xal + XAL_RC_ECAM_BASE_LO);
> +	phys = hi << 32 | lo;
> +
> +	value = readl(pcie->xal + XAL_RC_ECAM_BUSMASK);
> +	limit = phys + ((value + 1) << 20) - 1;
> +
> +	if (phys != res->start || limit != res->end) {
> +		dev_err(pcie->dev,
> +			"ECAM region mismatch: %pap-%pap -> %pap-%pap\n",
> +			&phys, &limit, &res->start, &res->end);
> +		status = false;
> +	}
> +
> +	return status;
> +}
> +
> +static bool tegra264_pcie_link_up(struct tegra264_pcie *pcie,
> +				  enum pci_bus_speed *speed)
> +{
> +	u16 value = readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +
> +	if (value & PCI_EXP_LNKSTA_DLLLA) {
> +		if (speed)
> +			*speed = pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS,
> +							   value)];
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void tegra264_pcie_init(struct tegra264_pcie *pcie)
> +{
> +	enum pci_bus_speed speed;
> +	unsigned int i;
> +	u32 value;
> +
> +	/* bring the link out of reset */

s/link/controller or endpoint?

> +	value = readl(pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +	value |= XTL_RC_MGMT_PERST_CONTROL_PERST_O_N;
> +	writel(value, pcie->xtl + XTL_RC_MGMT_PERST_CONTROL);
> +
> +	if (!tegra_is_silicon()) {

This looks like some pre-silicon validation thing. Do you really want it to be
present in the upstream driver?

> +		dev_info(pcie->dev,
> +			 "skipping link state for PCIe #%u in simulation\n",
> +			 pcie->ctl_id);
> +		pcie->link_up = true;
> +		return;
> +	}
> +
> +	for (i = 0; i < PCIE_LINK_WAIT_MAX_RETRIES; i++) {
> +		if (tegra264_pcie_link_up(pcie, NULL))
> +			break;
> +
> +		usleep_range(PCIE_LINK_WAIT_US_MIN, PCIE_LINK_WAIT_US_MAX);
> +	}
> +
> +	if (tegra264_pcie_link_up(pcie, &speed)) {

Why are you doing it for the second time?

> +		/* Per PCIe r5.0, 6.6.1 wait for 100ms after DLL up */

No need of this comment.

> +		msleep(PCIE_RESET_CONFIG_WAIT_MS);
> +
> +		dev_info(pcie->dev, "PCIe #%u link is up (speed: %s)\n",
> +			 pcie->ctl_id, pci_speed_string(speed));
> +		tegra264_pcie_icc_set(pcie);
> +		pcie->link_up = true;
> +	} else {
> +		dev_info(pcie->dev, "PCIe #%u link is down\n", pcie->ctl_id);
> +
> +		value = readl(pcie->xtl + XTL_RC_MGMT_CLOCK_CONTROL);
> +
> +		/*
> +		 * Set link state only when link fails and no hot-plug feature
> +		 * is present.
> +		 */
> +		if ((value & XTL_RC_MGMT_CLOCK_CONTROL_PEX_CLKREQ_I_N_PIN_USE_CONV_TO_PRSNT) == 0) {
> +			dev_info(pcie->dev,
> +				 "PCIe #%u link is down and not hotplug-capable, turning off\n",
> +				 pcie->ctl_id);
> +			tegra264_pcie_bpmp_set_rp_state(pcie);
> +			pcie->link_up = false;
> +		} else {
> +			pcie->link_up = true;
> +		}
> +	}
> +}
> +
> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct tegra264_pcie *pcie;
> +	struct resource_entry *bus;
> +	struct resource *res;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pcie));
> +	if (!bridge)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate host bridge\n");
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	platform_set_drvdata(pdev, pcie);
> +	pcie->bridge = bridge;
> +	pcie->dev = dev;
> +
> +	err = pinctrl_pm_select_default_state(dev);

I questioned this before:
https://lore.kernel.org/linux-pci/o5sxxdikdjwd76zsedvkpsl54nw6wrhopwsflt43y5st67mrub@uuw3yfjfqthd/

> +	if (err < 0)
> +		return dev_err_probe(dev, err,
> +				     "failed to configure sideband pins\n");
> +
> +	err = tegra264_pcie_parse_dt(pcie);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to parse device tree");
> +
> +	pcie->xal = devm_platform_ioremap_resource_byname(pdev, "xal");
> +	if (IS_ERR(pcie->xal))
> +		return dev_err_probe(dev, PTR_ERR(pcie->xal),
> +				     "failed to map XAL memory\n");
> +
> +	pcie->xtl = devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
> +	if (IS_ERR(pcie->xtl))
> +		return dev_err_probe(dev, PTR_ERR(pcie->xtl),
> +				     "failed to map XTL-PRI memory\n");
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "failed to get bus resources\n");
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ecam");
> +	if (!res)
> +		return dev_err_probe(dev, -ENXIO,
> +				     "failed to get ECAM resource\n");
> +
> +	pcie->icc_path = devm_of_icc_get(&pdev->dev, "write");
> +	if (IS_ERR(pcie->icc_path))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pcie->icc_path),
> +				     "failed to get ICC");
> +
> +	/*
> +	 * Parse BPMP property only for silicon, as interaction with BPMP is
> +	 * not needed for other platforms.
> +	 */
> +	if (tegra_is_silicon()) {
> +		pcie->bpmp = tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
> +		if (IS_ERR(pcie->bpmp))
> +			return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
> +					     "failed to get BPMP\n");
> +	}
> +

pm_runtime_set_active()

> +	pm_runtime_enable(dev);

devm_pm_runtime_enable()?

> +	pm_runtime_get_sync(dev);
> +
> +	/* sanity check that programmed ranges match what's in DT */
> +	if (!tegra264_pcie_check_ranges(pdev)) {
> +		err = -EINVAL;
> +		goto put_pm;
> +	}
> +
> +	pcie->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pcie->cfg)) {
> +		err = dev_err_probe(dev, PTR_ERR(pcie->cfg),
> +				    "failed to create ECAM\n");
> +		goto put_pm;
> +	}
> +
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->sysdata = pcie->cfg;
> +	pcie->ecam = pcie->cfg->win;
> +
> +	tegra264_pcie_init(pcie);
> +
> +	if (!pcie->link_up)
> +		goto free;

goto free_ecam;

> +
> +	err = pci_host_probe(bridge);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register host: %pe\n", ERR_PTR(err));

dev_err_probe()

> +		goto free;
> +	}
> +
> +	return err;

return 0;

> +
> +free:
> +	pci_ecam_free(pcie->cfg);
> +put_pm:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	if (tegra_is_silicon())
> +		tegra_bpmp_put(pcie->bpmp);
> +
> +	return err;
> +}
> +
> +static void tegra264_pcie_remove(struct platform_device *pdev)
> +{
> +	struct tegra264_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	/*
> +	 * If we undo tegra264_pcie_init() then link goes down and need
> +	 * controller reset to bring up the link again. Remove intention is
> +	 * to clean up the root bridge and re-enumerate during bind.
> +	 */
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(pcie->bridge->bus);
> +	pci_remove_root_bus(pcie->bridge->bus);
> +	pci_unlock_rescan_remove();
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	if (tegra_is_silicon())
> +		tegra_bpmp_put(pcie->bpmp);
> +
> +	pci_ecam_free(pcie->cfg);
> +}
> +
> +static int tegra264_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> +	int err;
> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err = enable_irq_wake(pcie->wake_irq);
> +		if (err < 0)
> +			dev_err(dev, "failed to enable wake IRQ: %pe\n",
> +				ERR_PTR(err));
> +	}
> +
> +	return 0;
> +}
> +
> +static int tegra264_pcie_resume_noirq(struct device *dev)
> +{
> +	struct tegra264_pcie *pcie = dev_get_drvdata(dev);
> +	int err;
> +
> +	if (pcie->wake_gpio && device_may_wakeup(dev)) {
> +		err = disable_irq_wake(pcie->wake_irq);
> +		if (err < 0)
> +			dev_err(dev, "failed to disable wake IRQ: %pe\n",
> +				ERR_PTR(err));
> +	}
> +
> +	if (pcie->link_up == false)
> +		return 0;
> +
> +	tegra264_pcie_init(pcie);
> +

Why do you need init() here without deinit() in tegra264_pcie_suspend_noirq()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
