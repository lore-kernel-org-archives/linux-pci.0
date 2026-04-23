Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B01737B028;
	Thu, 23 Apr 2026 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939311; cv=none; b=tSHSC45X+4YKIZJwWzldqcExcI7CoYQEg15CepfpZn/XPiTMswnf4dRXC66RbDcdFtxHYw7IblXU7cXGjws4K200zQkMw12NVSI9R2E+6PX8/wq/oLSI89gMGzc7ntjJwmMeEXqJszWp3CNUT4UcQ/83NpSi6pDXy+TJnskCEi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939311; c=relaxed/simple;
	bh=mDp2Djyar+ms10cpQ3y3cTy7qhpC0RjdCz/H6RIs10w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Ka18iEX243gVM4HpUmsTjXzUD0kTm2ZwNDdUU6urOovz/FYuJfu/scXWL6rp1G8HDbjy1JIjA1sVwL4+QzZc5L7XWeIBZJEQMuBYNefQg5uizXgZT7PIq1/oPpdgTvjq95h7Z7lwKYartiutXC/Jb7W5bVnmfjG1BJ/TdWxbc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=eyKQTr6c; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="eyKQTr6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=7hLh8qFUjKgkNluyWVF2i7mi4X4Wq6fQt
	25u+HwKiz4=; b=eyKQTr6cAI/zc476nDgAVsatEggi+EX/kftamStl8p8EKpvLC
	AMbn/9LmYGQnGWwj0rTmDlRanv3zLmKWMiemldbVWt3679ybosa3AhY86ja6ZJMC
	nU5U3AtARkob6L7NrNdgBZMliCWCGgqnet15GtfNY/6VAqOH6xbUIOI+No=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkNE8elpH7YCAA--.1573S2;
	Thu, 23 Apr 2026 18:15:33 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/3] PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root
 Complex driver
From: Jia Wang <wangjia@ultrarisc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <7n5b44ynbem2xve3twofaqunqlkw4aijatuuemujrfq5yd5mzq@5qnikt7ximd3>
References: <20260415-ultrarisc-pcie-v3-0-73f06e972616@ultrarisc.com>
 <20260415-ultrarisc-pcie-v3-3-73f06e972616@ultrarisc.com>
 <7n5b44ynbem2xve3twofaqunqlkw4aijatuuemujrfq5yd5mzq@5qnikt7ximd3>
Date: Thu, 23 Apr 2026 18:14:48 +0800
Message-Id: <177693928812.2917474.4251479012132866533.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776939288; l=11020;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=mDp2Djyar+ms10cpQ3y3cTy7qhpC0RjdCz/H6RIs10w=;
 b=d2GsNM6z140QuojO4oT0O7RK2Yblkz/yPZqXYoeXI42IR36SaAgyuBZ5WOuh9/EVlWmxbTX+4
 mvhO6v5spxjBkSVvmicB5VMuVmF/sB+1sbz8ZjbaUz8rnW7ct7gS1jF
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnEkNE8elpH7YCAA--.1573S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw4DGr1fJw1ftw4rJF1xuFg_yoWDuF1Dpa
	y5CFWFyF4UJF43Za1avas8AF1aqFn3CrWUK39Fgw12v3ZIkry8WFyvg34akF97WF4jgryY
	yw15ta43CFs8tFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAGEWnoRb4AYQAGsL

On 2026-04-22 22:17 +0530, Manivannan Sadhasivam wrote:
> On Wed, Apr 15, 2026 at 03:21:19PM +0800, Jia Wang wrote:
> > From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > 
> > Add DP1000 SoC PCIe Root Complex driver.
> > 
> > Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  MAINTAINERS                                  |   1 +
> >  drivers/pci/controller/dwc/Kconfig           |  12 ++
> >  drivers/pci/controller/dwc/Makefile          |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h |  22 ++++
> >  drivers/pci/controller/dwc/pcie-ultrarisc.c  | 186 +++++++++++++++++++++++++++
> >  5 files changed, 222 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2ec02d8443dd..c8159670a14d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20588,6 +20588,7 @@ M:	Jia Wang <wangjia@ultrarisc.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> > +F:	drivers/pci/controller/dwc/pcie-ultrarisc.c
> >  
> >  PCIE ENDPOINT DRIVER FOR QUALCOMM
> >  M:	Manivannan Sadhasivam <mani@kernel.org>
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d0aa031397fa..06f7d98259cd 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -548,4 +548,16 @@ config PCIE_VISCONTI_HOST
> >  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> >  	  This driver supports TMPV7708 SoC.
> >  
> > +config PCIE_ULTRARISC
> > +	tristate "UltraRISC PCIe host controller"
> > +	depends on ARCH_ULTRARISC || COMPILE_TEST
> > +	select PCIE_DW_HOST
> > +	select PCI_MSI
> > +	default y if ARCH_ULTRARISC
> > +	help
> > +	  Enables support for the PCIe controller in the UltraRISC SoC.
> > +	  This driver supports UR-DP1000 SoC.
> > +	  By default, this symbol is enabled when ARCH_ULTRARISC is active,
> > +	  requiring no further configuration on that platform.
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > index 67ba59c02038..884c46b78e01 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -38,6 +38,7 @@ obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> >  obj-$(CONFIG_PCIE_SPACEMIT_K1) += pcie-spacemit-k1.o
> >  obj-$(CONFIG_PCIE_STM32_HOST) += pcie-stm32.o
> >  obj-$(CONFIG_PCIE_STM32_EP) += pcie-stm32-ep.o
> > +obj-$(CONFIG_PCIE_ULTRARISC) += pcie-ultrarisc.o
> >  
> >  # The following drivers are for devices that use the generic ACPI
> >  # pci_root.c driver but don't support standard ECAM config access.
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index ae6389dd9caa..88dcb0e7943a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -69,6 +69,8 @@
> >  
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_FORCE			0x708
> > +/* Bit[7:0] LINK_NUM: Link Number. Not used for endpoint */
> > +#define PORT_LINK_NUM_MASK		GENMASK(7, 0)
> >  #define PORT_FORCE_DO_DESKEW_FOR_SRIS	BIT(23)
> >  
> >  #define PCIE_PORT_AFR			0x70C
> > @@ -96,6 +98,26 @@
> >  #define PCIE_PORT_LANE_SKEW		0x714
> >  #define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
> >  
> > +/*
> > + * PCIE_TIMER_CTRL_MAX_FUNC_NUM: Timer Control and Max Function Number
> > + * Register.
> > + * This register holds the ack frequency, latency, replay, fast link
> > + * scaling timers, and max function number values.
> > + * Bit[30:29] FAST_LINK_SCALING_FACTOR: Fast Link Timer Scaling Factor.
> > + *   0x0 (SF_1024):Scaling Factor is 1024 (1ms is 1us).
> > + *     When the LTSSM is in Config or L12 Entry State, 1ms
> > + *     timer is 2us, 2ms timer is 4us and 3ms timer is 6us.
> > + *   0x1 (SF_256): Scaling Factor is 256 (1ms is 4us)
> > + *   0x2 (SF_64): Scaling Factor is 64 (1ms is 16us)
> > + *   0x3 (SF_16): Scaling Factor is 16 (1ms is 64us)
> > + */
> > +#define PCIE_TIMER_CTRL_MAX_FUNC_NUM	0x718
> > +#define PORT_FLT_SF_MASK	GENMASK(30, 29)
> > +#define PORT_FLT_SF_VAL_1024	0x0
> > +#define PORT_FLT_SF_VAL_256	0x1
> > +#define PORT_FLT_SF_VAL_64	0x2
> > +#define PORT_FLT_SF_VAL_16	0x3
> > +
> >  #define PCIE_PORT_DEBUG0		0x728
> >  #define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
> >  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > new file mode 100644
> > index 000000000000..7094ee8c532f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -0,0 +1,186 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DWC PCIe RC driver for UltraRISC DP1000 SoC
> 
> s/UltraRISC DP1000 SoC/UltraRISC SoCs
>

Thanks. Will update in the next version.
 
> > + *
> > + * Copyright (C) 2026 UltraRISC Technology (Shanghai) Co., Ltd.
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/resource.h>
> > +#include <linux/types.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define PCIE_CUS_CORE          0x400000
> > +
> > +#define LTSSM_ENABLE           BIT(7)
> > +#define FAST_LINK_MODE         BIT(12)
> > +#define HOLD_PHY_RST           BIT(14)
> > +#define L1SUB_DISABLE          BIT(15)
> > +
> > +struct ultrarisc_pcie {
> 
> You should drop it since there seems to be no need of it now.
> 

Will drop it in v4.

> > +	struct dw_pcie *pci;
> > +};
> > +
> > +static struct pci_ops ultrarisc_pci_ops = {
> > +	.map_bus = dw_pcie_own_conf_map_bus,
> > +	.read = pci_generic_config_read32,
> > +	.write = pci_generic_config_write32,
> 
> Why 32 bit read/write? Does this controller has this limitation? If so, it
> should be mentioned in the commit message.
> 

The hardware is indeed limited to 32-bit access. I'll add a note in the v4
commit message.

> > +};
> > +
> > +static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct pci_host_bridge *bridge = pp->bridge;
> > +
> > +	bridge->ops = &ultrarisc_pci_ops;
> > +
> > +	return 0;
> > +}
> > +
> > +static void ultrarisc_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> > +{
> > +	/*
> > +	 * DP1000 does not support sending PME_Turn_Off from the RC.
> > +	 * Keep this callback empty to skip the generic MSG TLP path.
> > +	 */
> > +}
> > +
> > +static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
> > +	.init = ultrarisc_pcie_host_init,
> > +	.pme_turn_off = ultrarisc_pcie_pme_turn_off,
> > +};
> > +
> > +static int ultrarisc_pcie_start_link(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +	u8 cap_exp;
> 
> Use reverse Xmas order.
> 

Will fix in v4.

> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
> > +	val &= ~FAST_LINK_MODE;
> > +	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM);
> > +	FIELD_MODIFY(PORT_FLT_SF_MASK, &val, PORT_FLT_SF_VAL_64);
> > +	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
> > +
> > +	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
> > +	FIELD_MODIFY(PCI_EXP_LNKCTL2_TLS, &val, PCI_EXP_LNKCTL2_TLS_16_0GT);
> > +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > +	FIELD_MODIFY(PORT_LINK_NUM_MASK, &val, 0);
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_DEVCTL2);
> > +	FIELD_MODIFY(PCI_EXP_DEVCTL2_COMP_TIMEOUT, &val, 0x6);
> 
> No hardcoded constant please... Define a macro for it.
> 

Will define a macro ULTRARISC_PCIE_COMP_TIMEOUT_65_210MS for this value
in v4.

> > +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_DEVCTL2, val);
> 
> Are you sure you want to do all these in start_link()? This callback is supposed
> to just enable LTSSM. But you seem to be overloading with other configurations.
> 

Will move the extra DBI programming to host_init() in v4, with a link‑up
check to avoid overriding any UEFI‑trained settings.

> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
> > +	val &= ~(HOLD_PHY_RST | L1SUB_DISABLE);
> > +	val |= LTSSM_ENABLE;
> > +	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_ops dw_pcie_ops = {
> > +	.start_link = ultrarisc_pcie_start_link,
> > +};
> > +
> > +static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct ultrarisc_pcie *pcie;
> > +	struct dw_pcie *pci;
> > +	struct dw_pcie_rp *pp;
> 
> Use reverse Xmas order
>

Will fix in v4.
 
> > +	int ret;
> > +
> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > +	if (!pci)
> > +		return -ENOMEM;
> > +
> > +	pci->dev = dev;
> > +	pci->ops = &dw_pcie_ops;
> > +
> > +	/* Set a default value suitable for at most 16 in and 16 out windows */
> > +	pci->atu_size = SZ_8K;
> > +	pci->max_link_speed = 4;
> 
> Get this from DT please... This can change between SoC revisions.
>

During the v2 DT binding review, Krzysztof pointed out that since the
properties are fixed for this hardware, they are deducible from the
compatible string and should be dropped from the DT bindings.

The v2 discussion is here:
https://lore.kernel.org/all/c60a712e-ecf3-4926-9947-0e593cdb921d@kernel.org/

I then moved them into the driver for v3. If future SoC revisions introduce
variations, I'll update the driver to handle them accordingly.

Does this make sense?
 
> > +	pcie->pci = pci;
> > +
> > +	pp = &pci->pp;
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	pp->irq = platform_get_irq(pdev, 1);
> > +	if (pp->irq < 0)
> > +		return pp->irq;
> 
> Who is requesting this IRQ?
> 

Not needed. Will remove it in v4.

> > +
> > +	pp->num_vectors = MAX_MSI_IRQS;
> 
> Are you sure your controller supports 256 MSIs with one SPI interrupt? It is
> possible, but want to make sure it is the case.
> 

Yes. The controller implements 8 MSI control blocks (i = 0..7), each
providing 32 vectors, so 256 MSIs are supported. This is documented in the
controller IP specification.

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
> 

Best Regards,
Jia Wang


