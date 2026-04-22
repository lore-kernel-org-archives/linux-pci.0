Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2E223707;
	Wed, 22 Apr 2026 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876467; cv=none; b=UBXcEHOmXyveJC265KTEYrwjGGpMILK4FNRPU3kMc6NT/+bZ20/IasLYRJ6pojwt3ZhnR2oFRUdLuVEsWOgas2cJkkRroG9/xHxO6Rjm3ebkg7QM79ogfdPFf85F94OiXQsyzBmIzXBGd4WK8lU2E8kBZ9f5Nzzh1z2hnjCW73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876467; c=relaxed/simple;
	bh=9lGLslDUH5sYAXgwtzrumkGMS+8kK+9ZNMnps0B/TjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZz6FaeopLisTh4wVqbye1B5buo1m2kCswuZ9PaCnmaxKlNythpz3KF7zoYS+pDE2sjcTG2V6Iju+ESa6x5NcjMIiw2yCgsnmbHewHlOD83UEJKPQKmnwPgIbKc42mXMnCvWbfd2SOGnkiRjI4O3abkrGrSn03Vqpom2tSz5qAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQzrtw6A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQzrtw6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDF9C19425;
	Wed, 22 Apr 2026 16:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876467;
	bh=9lGLslDUH5sYAXgwtzrumkGMS+8kK+9ZNMnps0B/TjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQzrtw6AvclU6lAPG7/0lIJY9y20ACOtceLHDc4FMOtqc++iSjAcLPd6/6c7VXg/Z
	 RMN7ERKtXryxp18sA5uRtQ48Lntse6CCUNhFveD0VcVfG00CG2WvvK7BykVnJI7qRY
	 ZsOpI+E3r0Ng8cYzUh/Btj+LZSclKgNZjUXAiSxv2PDLLGNAJqfklbskdddbY1F+KN
	 /u6U0ykyNmRqjA3ToW6ETChr+Q1vwkGmGnIKkhmZ6iVF8hyedQlVMSJSQOdLqq/7v4
	 Dc02L3VWh92buAt/E/rAE3fwNMJcWCpVlbTomvHlIgEpe/pWVQ6g9DTxUk0+3k3Dnm
	 j+GmszLTOCkqQ==
Date: Wed, 22 Apr 2026 22:17:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jia Wang <wangjia@ultrarisc.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
Message-ID: <7n5b44ynbem2xve3twofaqunqlkw4aijatuuemujrfq5yd5mzq@5qnikt7ximd3>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>

On Wed, Apr 15, 2026 at 03:21:19PM +0800, Jia Wang wrote:
> From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> 
> Add DP1000 SoC PCIe Root Complex driver.
> 
> Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/pci/controller/dwc/Kconfig           |  12 ++
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.h |  22 ++++
>  drivers/pci/controller/dwc/pcie-ultrarisc.c  | 186 +++++++++++++++++++++++++++
>  5 files changed, 222 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2ec02d8443dd..c8159670a14d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20588,6 +20588,7 @@ M:	Jia Wang <wangjia@ultrarisc.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> +F:	drivers/pci/controller/dwc/pcie-ultrarisc.c
>  
>  PCIE ENDPOINT DRIVER FOR QUALCOMM
>  M:	Manivannan Sadhasivam <mani@kernel.org>
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d0aa031397fa..06f7d98259cd 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -548,4 +548,16 @@ config PCIE_VISCONTI_HOST
>  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>  	  This driver supports TMPV7708 SoC.
>  
> +config PCIE_ULTRARISC
> +	tristate "UltraRISC PCIe host controller"
> +	depends on ARCH_ULTRARISC || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	select PCI_MSI
> +	default y if ARCH_ULTRARISC
> +	help
> +	  Enables support for the PCIe controller in the UltraRISC SoC.
> +	  This driver supports UR-DP1000 SoC.
> +	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
> +	  requiring no further configuration on that platform.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 67ba59c02038..884c46b78e01 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
>  obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
>  obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
>  obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
> +obj-$(CONFIG_PCIE_ULTRARISC) += pcie-ultrarisc.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ae6389dd9caa..88dcb0e7943a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -69,6 +69,8 @@
>  
>  /* Synopsys-specific PCIe configuration registers */
>  #define PCIE_PORT_FORCE			0x708
> +/* Bit[7:0] LINK_NUM: Link Number. Not used for endpoint */
> +#define PORT_LINK_NUM_MASK		GENMASK(7, 0)
>  #define PORT_FORCE_DO_DESKEW_FOR_SRIS	BIT(23)
>  
>  #define PCIE_PORT_AFR			0x70C
> @@ -96,6 +98,26 @@
>  #define PCIE_PORT_LANE_SKEW		0x714
>  #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
>  
> +/*
> + * PCIE_TIMER_CTRL_MAX_FUNC_NUM: Timer Control and Max Function Number
> + * Register.
> + * This register holds the ack frequency, latency, replay, fast link
> + * scaling timers, and max function number values.
> + * Bit[30:29] FAST_LINK_SCALING_FACTOR: Fast Link Timer Scaling Factor.
> + *   0x0 (SF_1024):Scaling Factor is 1024 (1ms is 1us).
> + *     When the LTSSM is in Config or L12 Entry State, 1ms
> + *     timer is 2us, 2ms timer is 4us and 3ms timer is 6us.
> + *   0x1 (SF_256): Scaling Factor is 256 (1ms is 4us)
> + *   0x2 (SF_64): Scaling Factor is 64 (1ms is 16us)
> + *   0x3 (SF_16): Scaling Factor is 16 (1ms is 64us)
> + */
> +#define PCIE_TIMER_CTRL_MAX_FUNC_NUM	0x718
> +#define PORT_FLT_SF_MASK	GENMASK(30, 29)
> +#define PORT_FLT_SF_VAL_1024	0x0
> +#define PORT_FLT_SF_VAL_256	0x1
> +#define PORT_FLT_SF_VAL_64	0x2
> +#define PORT_FLT_SF_VAL_16	0x3
> +
>  #define PCIE_PORT_DEBUG0		0x728
>  #define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> new file mode 100644
> index 000000000000..7094ee8c532f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DWC PCIe RC driver for UltraRISC DP1000 SoC

s/UltraRISC DP1000 SoC/UltraRISC SoCs

> + *
> + * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +#define PCIE_CUS_CORE          0x400000
> +
> +#define LTSSM_ENABLE           BIT(7)
> +#define FAST_LINK_MODE         BIT(12)
> +#define HOLD_PHY_RST           BIT(14)
> +#define L1SUB_DISABLE          BIT(15)
> +
> +struct ultrarisc_pcie {

You should drop it since there seems to be no need of it now.

> +	struct dw_pcie *pci;
> +};
> +
> +static struct pci_ops ultrarisc_pci_ops = {
> +	.map_bus = dw_pcie_own_conf_map_bus,
> +	.read = pci_generic_config_read32,
> +	.write = pci_generic_config_write32,

Why 32 bit read/write? Does this controller has this limitation? If so, it
should be mentioned in the commit message.

> +};
> +
> +static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct pci_host_bridge *bridge = pp->bridge;
> +
> +	bridge->ops = &ultrarisc_pci_ops;
> +
> +	return 0;
> +}
> +
> +static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	/*
> +	 * DP1000 does not support sending PME_Turn_Off from the RC.
> +	 * Keep this callback empty to skip the generic MSG TLP path.
> +	 */
> +}
> +
> +static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
> +	.init = ultrarisc_pcie_host_init,
> +	.pme_turn_off = ultrarisc_pcie_pme_turn_off,
> +};
> +
> +static int ultrarisc_pcie_start_link(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	u8 cap_exp;

Use reverse Xmas order.

> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
> +	val &= ~FAST_LINK_MODE;
> +	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM);
> +	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
> +	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
> +
> +	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
> +	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
> +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> +	FIELD_MODIFY(PORT_LINK_NUM_MASK, &val, 0);
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> +
> +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_DEVCTL2);
> +	FIELD_MODIFY(PCI_EXP_DEVCTL2_COMP_TIMEOUT, &val, 0x6);

No hardcoded constant please... Define a macro for it.

> +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_DEVCTL2, val);

Are you sure you want to do all these in start_link()? This callback is supposed
to just enable LTSSM. But you seem to be overloading with other configurations.

> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
> +	val &= ~(HOLD_PHY_RST | L1SUB_DISABLE);
> +	val |= LTSSM_ENABLE;
> +	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = ultrarisc_pcie_start_link,
> +};
> +
> +static int ultrarisc_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ultrarisc_pcie *pcie;
> +	struct dw_pcie *pci;
> +	struct dw_pcie_rp *pp;

Use reverse Xmas order

> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +
> +	/* Set a default value suitable for at most 16 in and 16 out windows */
> +	pci->atu_size = SZ_8K;
> +	pci->max_link_speed = 4;

Get this from DT please... This can change between SoC revisions.

> +	pcie->pci = pci;
> +
> +	pp = &pci->pp;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pp->irq = platform_get_irq(pdev, 1);
> +	if (pp->irq < 0)
> +		return pp->irq;

Who is requesting this IRQ?

> +
> +	pp->num_vectors = MAX_MSI_IRQS;

Are you sure your controller supports 256 MSIs with one SPI interrupt? It is
possible, but want to make sure it is the case.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
