Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DCC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A502920857
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="zfII5c1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBHMrD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:47:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32879 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBHMq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:46:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so3486189wrv.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yKdoLsadNyncrt4ydGPvR3J7GAwbHiAemxkUQeLhi3Q=;
        b=zfII5c1MlamrOX0e0N6DyP0S09jUQ9M6UwE4uXM+DowtsYUUiF9VJKrS8BDfT57ACR
         dlllMY4DW+kjT7mDjzdxLxw+qbRImGaM/DWpgn9efNxO+k5Dmxfkl7L0PoCKul3l4CRU
         /VkBzGmQ0y8erI1kldUeoALQ5GgZy4iRFTyVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yKdoLsadNyncrt4ydGPvR3J7GAwbHiAemxkUQeLhi3Q=;
        b=YKm06SSJwsVL3TpwM88V9t/LINUt5LZreP03h4OHcYCYZkEXPsjhhaZBrRK+dFRHcc
         odmVPgB4POcFqAxRqlQo7ZOyT7lR1FdR6B6pDddicMS2O9Ruhu4LG9UCkuLlAai0CbbY
         QQh7pmTdbluAuXsJDtYXp06iehseJH5kemdLGxbuKOnZhiW19i3vvutLyzxzBoiO/qFy
         9eqqQ/DiiunziIPnTsO1vZTRX1KU6549X6AVKqrnkfhyXiiOkhLnbETu+juqgscdk4OI
         U6YOUPArE+pjglqaCjckrEKdG0rdt2/k71H1OWkTiHQ78mTdUBdFgi3X/fGBf42SnyiM
         eDDA==
X-Gm-Message-State: AHQUAubyHbb1GAk2ODQtsSN0I9GQZDJyJKYuLUfuj+lvrkT2QTTmZLz4
        jFSVVsaY384t4HvNy47qqn9CbHDWOSJX5QaIiALljQ==
X-Google-Smtp-Source: AHgI3IaK4CA8iIT7GiVXgPhVQ8BAZpjCEol8mOQ0yjtqAFsdeLV7+5vOlUcwbePic1nM7wQXaFrfE99bD46ilNa9e/Y=
X-Received: by 2002:adf:b201:: with SMTP id u1mr3506182wra.165.1549630015167;
 Fri, 08 Feb 2019 04:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-24-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-24-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:19:34 +0530
Message-ID: <CAFZiPx0aGTy6yQ=fCojjP1awLEHevPSHRCUDEFL7KJtA4t=CGw@mail.gmail.com>
Subject: Re: [PATCHv3 23/27] PCI: mobiveil: add PCIe Gen4 RC driver for NXP
 Layerscape SoCs
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ZQ,


On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> This PCIe controller is based on the Mobiveil GPEX IP, which is
> compatible with the PCI Express=E2=84=A2 Base Specification, Revision 4.0=
.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/mobiveil/Kconfig       |  10 +
>  drivers/pci/controller/mobiveil/Makefile      |   1 +
>  .../controller/mobiveil/pci-layerscape-gen4.c | 254 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  16 +-
>  4 files changed, 279 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
>
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/contro=
ller/mobiveil/Kconfig
> index 64343c07bfed..3ddb7d6163a9 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -21,4 +21,14 @@ config PCIE_MOBIVEIL_PLAT
>           Soft IP. It has up to 8 outbound and inbound windows
>           for address translation and it is a PCIe Gen4 IP.
>
> +config PCI_LAYERSCAPE_GEN4
> +       bool "Freescale Layerscpe PCIe Gen4 controller"
> +       depends on PCI
> +       depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> +       depends on PCI_MSI_IRQ_DOMAIN
> +       select PCIE_MOBIVEIL_HOST
> +       help
> +         Say Y here if you want PCIe Gen4 controller support on
> +         Layerscape SoCs. The PCIe controller can work in RC or
> +         EP mode according to RCW[HOST_AGT_PEX] setting.
>  endmenu
> diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/contr=
oller/mobiveil/Makefile
> index 9fb6d1c6504d..ff66774ccac4 100644
> --- a/drivers/pci/controller/mobiveil/Makefile
> +++ b/drivers/pci/controller/mobiveil/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_HOST) +=3D pcie-mobiveil-host.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) +=3D pcie-mobiveil-plat.o
> +obj-$(CONFIG_PCI_LAYERSCAPE_GEN4) +=3D pci-layerscape-gen4.o
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/driv=
ers/pci/controller/mobiveil/pci-layerscape-gen4.c
> new file mode 100644
> index 000000000000..174cbcac4059
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -0,0 +1,254 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for NXP Layerscape SoCs
> + *
> + * Copyright 2018 NXP
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
> +#define PCIE_LUT_OFF                   (0x80000)
> +#define PCIE_PF_OFF                    (0xc0000)
> +#define PCIE_PF_INT_STAT               (0x18)
> +#define PF_INT_STAT_PABRST             (31)
> +
> +#define PCIE_PF_DBG                    (0x7fc)
> +#define PF_DBG_LTSSM_MASK              (0x3f)
> +#define PF_DBG_WE                      (31)
> +#define PF_DBG_PABR                    (27)
> +
> +#define LS_PCIE_G4_LTSSM_L0            0x2d /* L0 state */
> +
> +#define to_ls_pcie_g4(x)               platform_get_drvdata((x)->pdev)
> +
> +struct ls_pcie_g4 {
> +       struct mobiveil_pcie *pci;
> +       struct delayed_work dwork;
> +       int irq;
> +};
> +
> +static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +       return ioread32(pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + of=
f);
> +}
> +
> +static inline void ls_pcie_g4_lut_writel(struct ls_pcie_g4 *pcie,
> +                                        u32 off, u32 val)
> +{
> +       iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_LUT_OFF + off=
);
> +}
> +
> +static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +       return ioread32(pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off=
);
> +}
> +
> +static inline void ls_pcie_g4_pf_writel(struct ls_pcie_g4 *pcie,
> +                                       u32 off, u32 val)
> +{
> +       iowrite32(val, pcie->pci->csr_axi_slave_base + PCIE_PF_OFF + off)=
;
> +}
> +
> +static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
> +{
> +       struct mobiveil_pcie *mv_pci =3D pcie->pci;
> +       u32 header_type;
> +
> +       header_type =3D csr_readb(mv_pci, PCI_HEADER_TYPE);
> +       header_type &=3D 0x7f;
> +
> +       return header_type =3D=3D PCI_HEADER_TYPE_BRIDGE;
> +}
> +
> +static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
> +{
> +       struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(pci);
> +       u32 state;
> +
> +       state =3D ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +       state =3D state & PF_DBG_LTSSM_MASK;
> +
> +       if (state =3D=3D LS_PCIE_G4_LTSSM_L0)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static void ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
> +{
> +       struct mobiveil_pcie *mv_pci =3D pcie->pci;
> +       u32 val, act_stat;
> +       int to =3D 100;
> +
> +       /* Poll for pab_csb_reset to set and PAB activity to clear */
> +       do {
> +               usleep_range(10, 15);
> +               val =3D ls_pcie_g4_pf_readl(pcie, PCIE_PF_INT_STAT);
> +               act_stat =3D csr_readl(mv_pci, PAB_ACTIVITY_STAT);
> +       } while (((val & 1 << PF_INT_STAT_PABRST) =3D=3D 0 || act_stat) &=
& to--);
> +       if (to < 0) {
> +               dev_err(&mv_pci->pdev->dev, "poll PABRST&PABACT timeout\n=
");
> +               return;
> +       }
> +
> +       /* clear PEX_RESET bit in PEX_PF0_DBG register */
> +       val =3D ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +       val |=3D 1 << PF_DBG_WE;
> +       ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +       val =3D ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +       val |=3D 1 << PF_DBG_PABR;
> +       ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +       val =3D ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +       val &=3D ~(1 << PF_DBG_WE);
> +       ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +       mobiveil_host_init(mv_pci, true);
> +
> +       to =3D 100;
> +       while (!ls_pcie_g4_link_up(mv_pci) && to--)
> +               usleep_range(200, 250);
> +       if (to < 0)
> +               dev_err(&mv_pci->pdev->dev, "PCIe link trainning timeout\=
n");
> +}
> +
> +static irqreturn_t ls_pcie_g4_handler(int irq, void *dev_id)
> +{
> +       struct ls_pcie_g4 *pcie =3D (struct ls_pcie_g4 *)dev_id;
> +       struct mobiveil_pcie *mv_pci =3D pcie->pci;
> +       u32 val;
> +
> +       val =3D csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
> +       if (!val)
> +               return IRQ_NONE;
> +
> +       if (val & PAB_INTP_RESET)
> +               schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
> +
> +       csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
> +{
> +       struct ls_pcie_g4 *pcie =3D to_ls_pcie_g4(mv_pci);
> +       u32 val;
> +       int ret;
> +
> +       pcie->irq =3D platform_get_irq_byname(mv_pci->pdev, "intr");
> +       if (pcie->irq < 0) {
> +               dev_err(&mv_pci->pdev->dev, "Can't get 'intr' irq.\n");
> +               return pcie->irq;
> +       }
> +       ret =3D devm_request_irq(&mv_pci->pdev->dev, pcie->irq,
> +                              ls_pcie_g4_handler, IRQF_SHARED,
> +                              mv_pci->pdev->name, pcie);
> +       if (ret) {
> +               dev_err(&mv_pci->pdev->dev, "Can't register PCIe IRQ.\n")=
;
> +               return  ret;
> +       }
> +
> +       /* Enable interrupts */
> +       val =3D PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
> +             PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
> +       csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
> +
> +       return 0;
> +}
> +
> +static void ls_pcie_g4_reset(struct work_struct *work)
> +{
> +       struct delayed_work *dwork =3D container_of(work, struct delayed_=
work,
> +                                                 work);
> +       struct ls_pcie_g4 *pcie =3D container_of(dwork, struct ls_pcie_g4=
, dwork);
> +       struct mobiveil_pcie *mv_pci =3D pcie->pci;
> +       u16 ctrl;
> +
> +       ctrl =3D csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
> +       ctrl &=3D ~PCI_BRIDGE_CTL_BUS_RESET;
> +       csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
> +       ls_pcie_g4_reinit_hw(pcie);
> +}
> +
> +static struct mobiveil_rp_ops ls_pcie_g4_rp_ops =3D {
> +       .interrupt_init =3D ls_pcie_g4_interrupt_init,
> +};
> +
> +static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops =3D {
> +       .link_up =3D ls_pcie_g4_link_up,
> +};
> +
> +static int __init ls_pcie_g4_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct mobiveil_pcie *mv_pci;
> +       struct ls_pcie_g4 *pcie;
> +       struct device_node *np =3D dev->of_node;
> +       int ret;
> +
> +       if (!of_parse_phandle(np, "msi-parent", 0)) {
> +               dev_err(dev, "failed to find msi-parent\n");
> +               return -EINVAL;
> +       }
> +
> +       pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +       if (!pcie)
> +               return -ENOMEM;
> +
> +       mv_pci =3D devm_kzalloc(dev, sizeof(*mv_pci), GFP_KERNEL);
> +       if (!mv_pci)
> +               return -ENOMEM;
> +
> +       mv_pci->pdev =3D pdev;
> +       mv_pci->ops =3D &ls_pcie_g4_pab_ops;
> +       mv_pci->rp.ops =3D &ls_pcie_g4_rp_ops;
> +       pcie->pci =3D mv_pci;
> +
> +       platform_set_drvdata(pdev, pcie);
> +
> +       INIT_DELAYED_WORK(&pcie->dwork, ls_pcie_g4_reset);
> +
> +       ret =3D mobiveil_pcie_host_probe(mv_pci);
> +       if (ret) {
> +               dev_err(dev, "fail to probe!\n");
> +               return  ret;
> +       }
> +
> +       if (!ls_pcie_g4_is_bridge(pcie))
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id ls_pcie_g4_of_match[] =3D {
> +       { .compatible =3D "fsl,lx2160a-pcie", },
> +       { },
> +};
> +
> +static struct platform_driver ls_pcie_g4_driver =3D {
> +       .driver =3D {
> +               .name =3D "layerscape-pcie-gen4",
> +               .of_match_table =3D ls_pcie_g4_of_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +
> +builtin_platform_driver_probe(ls_pcie_g4_driver, ls_pcie_g4_probe);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pc=
i/controller/mobiveil/pcie-mobiveil.h
> index 0f5303962e88..0ccd6cee5f8f 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -41,6 +41,8 @@
>  #define  PAGE_LO_MASK                  0x3ff
>  #define  PAGE_SEL_OFFSET_SHIFT         10
>
> +#define PAB_ACTIVITY_STAT              0x81c
> +
>  #define PAB_AXI_PIO_CTRL               0x0840
>  #define  APIO_EN_MASK                  0xf
>
> @@ -49,8 +51,18 @@
>
>  #define PAB_INTP_AMBA_MISC_ENB         0x0b0c
>  #define PAB_INTP_AMBA_MISC_STAT                0x0b1c
> -#define  PAB_INTP_INTX_MASK            0x01e0
> -#define  PAB_INTP_MSI_MASK             0x8
> +#define  PAB_INTP_RESET                        (0x1 << 1)
> +#define  PAB_INTP_MSI                  (0x1 << 3)
> +#define  PAB_INTP_INTA                 (0x1 << 5)
> +#define  PAB_INTP_INTB                 (0x1 << 6)
> +#define  PAB_INTP_INTC                 (0x1 << 7)
> +#define  PAB_INTP_INTD                 (0x1 << 8)
you could use BIT(x) macros instead of these shift operations
> +#define  PAB_INTP_PCIE_UE              (0x1 << 9)
> +#define  PAB_INTP_IE_PMREDI            (0x1 << 29)
> +#define  PAB_INTP_IE_EC                        (0x1 << 30)
please fix and the the indentations
> +#define  PAB_INTP_MSI_MASK             PAB_INTP_MSI
> +#define  PAB_INTP_INTX_MASK            (PAB_INTP_INTA | PAB_INTP_INTB |\
> +                                       PAB_INTP_INTC | PAB_INTP_INTD)
>
>  #define PAB_AXI_AMAP_CTRL(win)         PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT              0
> --
> 2.17.1
>
