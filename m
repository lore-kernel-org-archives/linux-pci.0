Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E59383C9F;
	Fri, 20 Mar 2026 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999259; cv=none; b=DwcYoUT+eSxUdqToy0B1s4jmdQ3hzl0ihozSRd/hsEL021Zp+PUZ9p2YlDuNLqGzv/eQ5+KyogQL4N5wnGsr8tyW9Tu6EYG+vGo7SgS46AmPL5CM3vTjbHAPfdCjYRzm4XKvWDwID/BZC9OaKdoD/uFopI6uIUEgfSicVUlnzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999259; c=relaxed/simple;
	bh=3DXd5Qom6x58BAUd7KlDNM2vPkB1pVEH91IPQNvOJZo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MJ3SaITkZh/tYs79b6EPPTNO8BUXuJ+p7KnlQ2ujpFbLVlYAz0oNoIK4RQ6w/ee+j+1zZzGQCNLgck8+gIN22vUmhlP7wx5J2p3FnkEiYIfXGK+0xZOE5uNZdK74omWk6/XlshDnbQ5WfnJ1TWuAfneZx5pfHljOequKunc1PgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=NEvvUqt5; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="NEvvUqt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=JgrjJi9A57JMubnNMXxYLzfk4KPURxmRe
	27E5qztSng=; b=NEvvUqt5rJsKmgcqSwXh4SJ7DCJWIUlrqSPBKIuw/64oepa52
	veiGedaj2KS/vy4hJRcew0rgBoouqEK95qxnAi0fAZK1bkBpRDPzwM+7dS9Ll25D
	YZVzopaMk6PV3K7OspJkeqLgdozMlthBnrhuDpYHFD0sp1Pdn4FLOZVNUo=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAHtSSxFL1pGbQBAA--.1513S2;
	Fri, 20 Mar 2026 17:34:41 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/4] PCI: dwc: Add UltraRISC DP1000 PCIe rc driver
From: Jia Wang <wangjia@ultrarisc.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: wangjia@ultrarisc.com, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20260316204958.GA23965@bhelgaas>
References: <20260316204958.GA23965@bhelgaas>
Date: Fri, 20 Mar 2026 17:33:51 +0800
Message-Id: <177399923192.868832.15400115908767309112.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773999232; l=12639;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=3DXd5Qom6x58BAUd7KlDNM2vPkB1pVEH91IPQNvOJZo=;
 b=hMJ52sW1WvY7jqAzCOSheowbBLGnV7nkza6JaQME3cPinelrZpu/dmsukRZjeA4Kbe+zdymvc
 /0xU3E/SZbSAo7o0kLduZnO/OHTLRg2y391qtFnjJB8Vw7TuM+5t3BB
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAHtSSxFL1pGbQBAA--.1513S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw4ftrWkGF45Xr1xGrW5trb_yoWkKw13pa
	y5GFWYyF4UJF45WF42vas8AF13twn3CryUKrsFgw129F9Ivr97Wryv934akF97uF4jgryj
	yw1jyFy7Can0g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRE2Q6tUUUUU==
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAMEWm844oABAACsm

On 2026-03-16 15:49 -0500, Bjorn Helgaas wrote:
> In subject, s/dwc/ultrarisc/ or whatever tag we're going to use for
> this driver, e.g.,
> 
>   PCI: ultrarisc: Add UltraRISC DP1000 PCIe Root Complex driver
> 
> On Mon, Mar 16, 2026 at 03:07:00PM +0800, Jia Wang via B4 Relay wrote:
> > From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > 
> > Add DP1000 soc PCIe rc driver.
> 
> s/soc/SoC/
> s/rc/RC/ or Root Complex (also in subject)
>

Thanks for the review.

I will update the subject and commit message accordingly.
 
> > Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig           |  15 ++
> >  drivers/pci/controller/dwc/Makefile          |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h |  22 +++
> >  drivers/pci/controller/dwc/pcie-ultrarisc.c  | 202 +++++++++++++++++++++++++++
> >  4 files changed, 240 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d0aa031397fa..0a33891bf7ef 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -548,4 +548,19 @@ config PCIE_VISCONTI_HOST
> >  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> >  	  This driver supports TMPV7708 SoC.
> >  
> > +config PCIE_ULTRARISC
> > +	bool "UltraRISC PCIe host controller"
> > +	depends on ARCH_ULTRARISC || COMPILE_TEST
> > +	select PCIE_DW_HOST
> > +	select PCI_MSI
> > +	default y if ARCH_ULTRARISC
> > +	help
> > +	  Enables support for the PCIe controller in the UltraRISC SoC.
> > +	  This driver supports UR-DP1000 SoC. When selected, it automatically
> > +	  enables both `PCIE_DW_HOST` and `PCI_MSI`, ensuring proper support
> > +	  for MSI-based interrupt handling in the PCIe controller.
> 
> I don't think the PCIE_DW_HOST and PCI_MSI explanation is relevant for
> Kconfig help.
>

I’ll remove the explanation about PCIE_DW_HOST and PCI_MSI from the
Kconfig help.
 
> > +	  By default, this symbol is enabled when `ARCH_ULTRARISC` is active,
> > +	  requiring no further configuration on that platform.
> > +
> > +
> 
> Remove spurious blank line.
> 
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
> > index ae6389dd9caa..8f2ed86cb5c5 100644
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
> > + * PCIE_TIMER_CTRL_MAX_FUNC_NUM: Timer Control and Max Function Number Register.
> > + * This register holds the ack frequency, latency, replay, fast link scaling timers,
> > + * and max function number values.
> 
> Wrap to fit in 80 columns like the rest of the file.
> 
> > + * Bit[30:29] FAST_LINK_SCALING_FACTOR: Fast Link Timer Scaling Factor.
> > + *   0x0 (SF_1024):Scaling Factor is 1024 (1ms is 1us).
> > + *     When the LTSSM is in Config or L12 Entry State, 1ms
> > + *     timer is 2us, 2ms timer is 4us and 3ms timer is 6us.
> > + *   0x1 (SF_256): Scaling Factor is 256 (1ms is 4us)
> > + *   0x2 (SF_64): Scaling Factor is 64 (1ms is 16us)
> > + *   0x3 (SF_16): Scaling Factor is 16 (1ms is 64us)
> > + */
> > +#define PCIE_TIMER_CTRL_MAX_FUNC_NUM    0x718
> > +#define PORT_FLT_SF_MASK    GENMASK(30, 29)
> > +#define PORT_FLT_SF(n)      FIELD_PREP(PORT_FLT_SF_MASK, n)
> > +#define PORT_FLT_SF_1024    PORT_FLT_SF(0x0)
> > +#define PORT_FLT_SF_256     PORT_FLT_SF(0x1)
> > +#define PORT_FLT_SF_64      PORT_FLT_SF(0x2)
> > +#define PORT_FLT_SF_16      PORT_FLT_SF(0x3)
> > +
> >  #define PCIE_PORT_DEBUG0		0x728
> >  #define PORT_LOGIC_LTSSM_STATE_MASK	0x3f
> >  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> > diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > new file mode 100644
> > index 000000000000..64cbf16d3ff7
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
> > @@ -0,0 +1,202 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * DWC PCIe RC driver for UltraRISC DP1000 SoC
> > + *
> > + * Copyright (C) 2023 UltraRISC
> > + *
> 
> Remove spurious blank line.  Maybe you want "(C) 2026"?
>

I’ll update the copyright year to 2026 as suggested.
 
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/resource.h>
> > +#include <linux/types.h>
> > +#include <linux/regmap.h>
> 
> Order alphabetically.
> 
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
> > +	struct dw_pcie  *pci;
> 
> s/dw_pcie  /dw_pcie / (single space to match irq_mask below)
> 
> > +	u32 irq_mask[MAX_MSI_CTRLS];
> > +};
> > +
> > +static const struct of_device_id ultrarisc_pcie_of_match[];
> 
> This declaration looks unnecessary.
> 
> > +static struct pci_ops ultrarisc_pci_ops = {
> > +	.map_bus = dw_pcie_own_conf_map_bus,
> > +	.read = pci_generic_config_read32,
> > +	.write = pci_generic_config_write32,
> 
> I guess this hardware has the defect that it can only do 32-bit
> writes?
>
 
Yes, that's correct.

> > +};
> > +
> > +static int ultrarisc_pcie_host_init(struct dw_pcie_rp *pp)
> > +{
> > +	struct pci_host_bridge *bridge = pp->bridge;
> > +
> > +	/* Set the bus ops */
> 
> Drop spurious comment.
> 
> > +	bridge->ops = &ultrarisc_pci_ops;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_host_ops ultrarisc_pcie_host_ops = {
> > +	.init = ultrarisc_pcie_host_init,
> > +};
> > +
> > +static int ultrarisc_pcie_establish_link(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +	u8 cap_exp;
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_CUS_CORE);
> > +	val &= ~FAST_LINK_MODE;
> > +	dw_pcie_writel_dbi(pci, PCIE_CUS_CORE, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM);
> > +	val &= ~PORT_FLT_SF_MASK;
> > +	val |= PORT_FLT_SF_64;
> 
> FIELD_MODIFY() here and below.
>

I'll update to FIELD_MODIFY().
 
> > +	dw_pcie_writel_dbi(pci, PCIE_TIMER_CTRL_MAX_FUNC_NUM, val);
> > +
> > +	cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_LNKCTL2);
> > +	val &= ~PCI_EXP_LNKCTL2_TLS;
> > +	val |= PCI_EXP_LNKCTL2_TLS_16_0GT;
> > +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_LNKCTL2, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_FORCE);
> > +	val &= ~PORT_LINK_NUM_MASK;
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_FORCE, val);
> > +
> > +	val = dw_pcie_readl_dbi(pci, cap_exp + PCI_EXP_DEVCTL2);
> > +	val &= ~PCI_EXP_DEVCTL2_COMP_TIMEOUT;
> > +	val |= 0x6;
> > +	dw_pcie_writel_dbi(pci, cap_exp + PCI_EXP_DEVCTL2, val);
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
> > +	.start_link = ultrarisc_pcie_establish_link,
> 
> s/ultrarisc_pcie_establish_link/ultrarisc_pcie_start_link/
> to match member name and other drivers.
> 
> > +};
> > +
> > +static int ultrarisc_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct ultrarisc_pcie *ultrarisc_pcie;
> 
> "ultrarisc_pcie" is a pretty long name that will be used for
> parameters when you add more functionality.  Several drivers just use
> "pcie", some use the equivalent of "ultrarisc", etc.
>

I’ll rename the function to ultrarisc_pcie_start_link and shorten
the local variable to pcie.
 
> > +	struct dw_pcie *pci;
> > +	struct dw_pcie_rp *pp;
> > +	int ret;
> > +
> > +	ultrarisc_pcie = devm_kzalloc(dev, sizeof(*ultrarisc_pcie), GFP_KERNEL);
> > +	if (!ultrarisc_pcie)
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
> > +
> > +	ultrarisc_pcie->pci = pci;
> > +
> > +	pp = &pci->pp;
> > +
> > +	platform_set_drvdata(pdev, ultrarisc_pcie);
> > +
> > +	pp->irq = platform_get_irq(pdev, 1);
> > +	if (pp->irq < 0)
> > +		return pp->irq;
> > +
> > +	pp->num_vectors = MAX_MSI_IRQS;
> > +	pp->ops = &ultrarisc_pcie_host_ops;
> > +
> > +	ret = dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to initialize host\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int ultrarisc_pcie_suspend(struct platform_device *pdev, pm_message_t state)
> 
> If you use generic power management, this will be:
> 
>   static int ultrarisc_pcie_suspend(struct device *dev)
> 
> > +{
> > +	struct ultrarisc_pcie *ultrarisc_pcie = platform_get_drvdata(pdev);
> > +	struct dw_pcie *pci = ultrarisc_pcie->pci;
> > +	struct dw_pcie_rp *pp = &pci->pp;
> > +	int num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> > +	unsigned long flags;
> > +	int ctrl;
> > +
> > +	raw_spin_lock_irqsave(&pp->lock, flags);
> > +
> > +	for (ctrl = 0; ctrl < num_ctrls; ctrl++)
> > +		ultrarisc_pcie->irq_mask[ctrl] = pp->irq_mask[ctrl];
> > +
> > +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ultrarisc_pcie_resume(struct platform_device *pdev)
> > +{
> > +	struct ultrarisc_pcie *ultrarisc_pcie = platform_get_drvdata(pdev);
> > +	struct dw_pcie *pci = ultrarisc_pcie->pci;
> > +	struct dw_pcie_rp *pp = &pci->pp;
> > +	int num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> > +	unsigned long flags;
> > +	int ctrl;
> > +
> > +	raw_spin_lock_irqsave(&pp->lock, flags);
> > +
> > +	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> > +		pp->irq_mask[ctrl] = ultrarisc_pcie->irq_mask[ctrl];
> > +		dw_pcie_writel_dbi(pci,
> > +				   PCIE_MSI_INTR0_MASK +
> > +				   ctrl * MSI_REG_CTRL_BLOCK_SIZE,
> > +				   pp->irq_mask[ctrl]);
> > +	}
> > +
> > +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ultrarisc_pcie_of_match[] = {
> > +	{
> > +		.compatible = "ultrarisc,dp1000-pcie",
> > +	},
> > +	{},
> > +};
> > +
> > +static struct platform_driver ultrarisc_pcie_driver = {
> > +	.driver = {
> > +		.name	= "ultrarisc-pcie",
> > +		.of_match_table = ultrarisc_pcie_of_match,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +	.probe = ultrarisc_pcie_probe,
> > +	.suspend = ultrarisc_pcie_suspend,
> > +	.resume = ultrarisc_pcie_resume,
> 
> Use generic driver PM instead of the platform_driver.suspend/resume.
>

I’ll switch to generic driver PM, and also fix the
Kconfig and formatting issues.

> > +};
> > +builtin_platform_driver(ultrarisc_pcie_driver);
> > 
> > -- 
> > 2.34.1
> > 
> > 
> 

Best regards,
Jia
 

