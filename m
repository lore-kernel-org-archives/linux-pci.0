Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B4C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7520857
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552312904;
	bh=6wcilqyb4aQjpqrmBwUx6Nq4jANm14HdWg0P1G0r0cA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iic1M5F7DRh8oh4Rw0P0on79NYpVWdjh+T3iEVegFe5pVOrT94q6hVO/SQsUvqTFt
	 y8cJxF643fN1wiR8RNe/ivMDvwedUoBqVzSDgOL2MyiZJH9IwL6wuifnpfX6FJUhq0
	 KnSW0L83ANIjJwLGkP96/D2/blgyNIL07S+nA1sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCKOBo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCKOBn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 10:01:43 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9CB20657;
        Mon, 11 Mar 2019 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552312902;
        bh=6wcilqyb4aQjpqrmBwUx6Nq4jANm14HdWg0P1G0r0cA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoK0VlP1j9uDENp2jAxHMZTD32jb4E+85bPq35zxVvJhY1W2BrRkUt7wXYixaGpBw
         OoBMhgKtDLKaE/SzOHQQ25gpKG3cU32nEMPzeE6qjmavyHw0o3ufwCoES11GWo5ypA
         nProHHmU5vh8VUsT7SGnRT8Q2FiNaAZcfbGOXie8=
Date:   Mon, 11 Mar 2019 09:01:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv4 24/28] PCI: mobiveil: add PCIe Gen4 RC driver for NXP
 Layerscape SoCs
Message-ID: <20190311140140.GA161843@google.com>
References: <20190311093130.7209-1-Zhiqiang.Hou@nxp.com>
 <20190311093130.7209-25-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190311093130.7209-25-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 09:33:16AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This PCIe controller is based on the Mobiveil GPEX IP, which is
> compatible with the PCI Express™ Base Specification, Revision 4.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V4:
>  - no change
> 
>  drivers/pci/controller/mobiveil/Kconfig       |  10 +
>  drivers/pci/controller/mobiveil/Makefile      |   1 +
>  .../controller/mobiveil/pci-layerscape-gen4.c | 254 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  16 +-
>  4 files changed, 279 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> 
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> index 64343c07bfed..3ddb7d6163a9 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -21,4 +21,14 @@ config PCIE_MOBIVEIL_PLAT
>  	  Soft IP. It has up to 8 outbound and inbound windows
>  	  for address translation and it is a PCIe Gen4 IP.
>  
> +config PCI_LAYERSCAPE_GEN4
> +	bool "Freescale Layerscpe PCIe Gen4 controller"

"Layerscape"

> +	depends on PCI
> +	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_MOBIVEIL_HOST
> +	help
> +	  Say Y here if you want PCIe Gen4 controller support on
> +	  Layerscape SoCs. The PCIe controller can work in RC or
> +	  EP mode according to RCW[HOST_AGT_PEX] setting.
>  endmenu
> diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
> index 9fb6d1c6504d..ff66774ccac4 100644
> --- a/drivers/pci/controller/mobiveil/Makefile
> +++ b/drivers/pci/controller/mobiveil/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
> +obj-$(CONFIG_PCI_LAYERSCAPE_GEN4) += pci-layerscape-gen4.o
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> new file mode 100644
> index 000000000000..174cbcac4059
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP Layerscape SoCs

It would be nice to make "NXP Layerscape SoCs" a little more specific
so we can tell how it's different from the existing pci-layerscape.c
that says "Freescale Layerscape SoCs".  I assume this driver only
works with gen4 parts.

> + * Copyright 2018 NXP

s/2018/2019/

> + *
> + * Author: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-mobiveil.h"
> +
> +/* LUT and PF control registers */
> +#define PCIE_LUT_OFF			(0x80000)
> +#define PCIE_PF_OFF			(0xc0000)
> +#define PCIE_PF_INT_STAT		(0x18)
> +#define PF_INT_STAT_PABRST		(31)

You mix constants that are

  - the bit position (like this), and
  - the actual bit mask, like PAB_INTP_RESET

Pick one and use a single style.  My personal preference is a plain
hex bit mask, e.g.,

  #define PF_INT_STAT_PABRST    0x80000000
  #define PAB_INTP_RESET        0x00000002

But some people like BIT() or the style you used for PAB_INTP_RESET:

  #define PAB_INTP_RESET        BIT(1)
  #define PAB_INTP_RESET        (0x1 << 1)

I definitely don't like the simple bit position like this:

  #define PF_INT_STAT_PABRST    31

because that means you have to repeat things like
"1 << PF_INT_STAT_PABRST" everywhere you use it.

> +#define PCIE_PF_DBG			(0x7fc)
> +#define PF_DBG_LTSSM_MASK		(0x3f)
> +#define PF_DBG_WE			(31)
> +#define PF_DBG_PABR			(27)

Parens are not needed around single constants like these.

> +#define LS_PCIE_G4_LTSSM_L0		0x2d /* L0 state */
> +
> +#define to_ls_pcie_g4(x)		platform_get_drvdata((x)->pdev)
> +
> +struct ls_pcie_g4 {
> +	struct mobiveil_pcie *pci;
> +	struct delayed_work dwork;
> +	int irq;
> +};
> +
> +static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +	return ioread32(pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + off);
> +}
> +
> +static inline void ls_pcie_g4_lut_writel(struct ls_pcie_g4 *pcie,
> +					 u32 off, u32 val)
> +{
> +	iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + off);
> +}
> +
> +static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +	return ioread32(pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off);
> +}
> +
> +static inline void ls_pcie_g4_pf_writel(struct ls_pcie_g4 *pcie,
> +					u32 off, u32 val)
> +{
> +	iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off);
> +}
> +
> +static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u32 header_type;
> +
> +	header_type = csr_readb(mv_pci, PCI_HEADER_TYPE);
> +	header_type &= 0x7f;
> +
> +	return header_type == PCI_HEADER_TYPE_BRIDGE;
> +}
> +
> +static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
> +{
> +	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> +	u32 state;
> +
> +	state = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	state =	state & PF_DBG_LTSSM_MASK;
> +
> +	if (state == LS_PCIE_G4_LTSSM_L0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u32 val, act_stat;
> +	int to = 100;
> +
> +	/* Poll for pab_csb_reset to set and PAB activity to clear */
> +	do {
> +		usleep_range(10, 15);
> +		val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_INT_STAT);
> +		act_stat = csr_readl(mv_pci, PAB_ACTIVITY_STAT);
> +	} while (((val & 1 << PF_INT_STAT_PABRST) == 0 || act_stat) && to--);
> +	if (to < 0) {
> +		dev_err(&mv_pci->pdev->dev, "poll PABRST&PABACT timeout\n");
> +		return;
> +	}
> +
> +	/* clear PEX_RESET bit in PEX_PF0_DBG register */
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val |= 1 << PF_DBG_WE;
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val |= 1 << PF_DBG_PABR;
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val &= ~(1 << PF_DBG_WE);
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	mobiveil_host_init(mv_pci, true);
> +
> +	to = 100;
> +	while (!ls_pcie_g4_link_up(mv_pci) && to--)
> +		usleep_range(200, 250);
> +	if (to < 0)
> +		dev_err(&mv_pci->pdev->dev, "PCIe link trainning timeout\n");

s/trainning/training/

> +}
> +
> +static irqreturn_t ls_pcie_g4_handler(int irq, void *dev_id)

Function name should include "irq_handler" or "isr".  Run

  git grep request_irq drivers/pci/controller/

and follow the existing conventions.

> +{
> +	struct ls_pcie_g4 *pcie = (struct ls_pcie_g4 *)dev_id;
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u32 val;
> +
> +	val = csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & PAB_INTP_RESET)
> +		schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
> +
> +	csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
> +{
> +	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(mv_pci);
> +	u32 val;
> +	int ret;
> +
> +	pcie->irq = platform_get_irq_byname(mv_pci->pdev, "intr");
> +	if (pcie->irq < 0) {
> +		dev_err(&mv_pci->pdev->dev, "Can't get 'intr' irq.\n");

When you use &mv_pci->pdev->dev more than once, as you do here, please
add

  struct device *dev = &mv_pci->pdev->dev;

and use "dev" instead of repeating the whole "&mv_pci->pdev->dev"
expression.

s/irq./IRQ/ (Capitalize IRQ and omit period)

> +		return pcie->irq;
> +	}
> +	ret = devm_request_irq(&mv_pci->pdev->dev, pcie->irq,
> +			       ls_pcie_g4_handler, IRQF_SHARED,
> +			       mv_pci->pdev->name, pcie);
> +	if (ret) {
> +		dev_err(&mv_pci->pdev->dev, "Can't register PCIe IRQ.\n");

Omit period from message and maybe include the IRQ number.

All your messages should start with lower-case or all should start
with upper-case (the two in this function are capitalized, but the
others are not).

> +		return  ret;
> +	}
> +
> +	/* Enable interrupts */
> +	val = PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
> +	      PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
> +	csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
> +
> +	return 0;
> +}
> +
> +static void ls_pcie_g4_reset(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = container_of(work, struct delayed_work,
> +						  work);
> +	struct ls_pcie_g4 *pcie = container_of(dwork, struct ls_pcie_g4, dwork);
> +	struct mobiveil_pcie *mv_pci = pcie->pci;
> +	u16 ctrl;
> +
> +	ctrl = csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
> +	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +	csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
> +	ls_pcie_g4_reinit_hw(pcie);
> +}
> +
> +static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
> +	.interrupt_init = ls_pcie_g4_interrupt_init,
> +};
> +
> +static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
> +	.link_up = ls_pcie_g4_link_up,
> +};
> +
> +static int __init ls_pcie_g4_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mobiveil_pcie *mv_pci;
> +	struct ls_pcie_g4 *pcie;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	if (!of_parse_phandle(np, "msi-parent", 0)) {
> +		dev_err(dev, "failed to find msi-parent\n");
> +		return -EINVAL;
> +	}
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	mv_pci = devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
> +	if (!mv_pci)
> +		return -ENOMEM;
> +
> +	mv_pci->pdev = pdev;
> +	mv_pci->ops = &ls_pcie_g4_pab_ops;
> +	mv_pci->rp.ops = &ls_pcie_g4_rp_ops;
> +	pcie->pci = mv_pci;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	INIT_DELAYED_WORK(&pcie->dwork, ls_pcie_g4_reset);
> +
> +	ret = mobiveil_pcie_host_probe(mv_pci);
> +	if (ret) {
> +		dev_err(dev, "fail to probe!\n");
> +		return  ret;
> +	}
> +
> +	if (!ls_pcie_g4_is_bridge(pcie))
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ls_pcie_g4_of_match[] = {
> +	{ .compatible = "fsl,lx2160a-pcie", },
> +	{ },
> +};
> +
> +static struct platform_driver ls_pcie_g4_driver = {
> +	.driver = {
> +		.name = "layerscape-pcie-gen4",
> +		.of_match_table = ls_pcie_g4_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver_probe(ls_pcie_g4_driver, ls_pcie_g4_probe);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 0f5303962e88..0ccd6cee5f8f 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -41,6 +41,8 @@
>  #define  PAGE_LO_MASK			0x3ff
>  #define  PAGE_SEL_OFFSET_SHIFT		10
>  
> +#define PAB_ACTIVITY_STAT		0x81c
> +
>  #define PAB_AXI_PIO_CTRL		0x0840
>  #define  APIO_EN_MASK			0xf
>  
> @@ -49,8 +51,18 @@
>  
>  #define PAB_INTP_AMBA_MISC_ENB		0x0b0c
>  #define PAB_INTP_AMBA_MISC_STAT		0x0b1c
> -#define  PAB_INTP_INTX_MASK		0x01e0
> -#define  PAB_INTP_MSI_MASK		0x8
> +#define  PAB_INTP_RESET			(0x1 << 1)
> +#define  PAB_INTP_MSI			(0x1 << 3)
> +#define  PAB_INTP_INTA			(0x1 << 5)
> +#define  PAB_INTP_INTB			(0x1 << 6)
> +#define  PAB_INTP_INTC			(0x1 << 7)
> +#define  PAB_INTP_INTD			(0x1 << 8)
> +#define  PAB_INTP_PCIE_UE		(0x1 << 9)
> +#define  PAB_INTP_IE_PMREDI		(0x1 << 29)
> +#define  PAB_INTP_IE_EC			(0x1 << 30)
> +#define  PAB_INTP_MSI_MASK		PAB_INTP_MSI
> +#define  PAB_INTP_INTX_MASK		(PAB_INTP_INTA | PAB_INTP_INTB |\
> +					PAB_INTP_INTC | PAB_INTP_INTD)
>  
>  #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT		0
> -- 
> 2.17.1
> 
