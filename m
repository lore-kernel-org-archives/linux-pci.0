Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:12712 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046AbcAKJjM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2016 04:39:12 -0500
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	qiujiang <qiujiang@huawei.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH v2] PCI: hisi: Add support for HiSilicon Hip06 PCIe host
 bridge controllers
Date: Mon, 11 Jan 2016 09:38:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1EC52FFD@lhreml503-mbs>
References: <1448558225-24491-1-git-send-email-gabriele.paoloni@huawei.com>
 <20160108202016.GG5354@localhost>
In-Reply-To: <20160108202016.GG5354@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 08 January 2016 20:20
> To: Gabriele Paoloni
> Cc: Wangzhou (B); linux-pci@vger.kernel.org; xuwei (O); zhangjukuo;
> qiuzhenfa; qiujiang; liudongdong (C); Liguozhu (Kenneth); linux-
> kernel@vger.kernel.org; lorenzo.pieralisi@arm.com; bhelgaas@google.com
> Subject: Re: [PATCH v2] PCI: hisi: Add support for HiSilicon Hip06 PCIe
> host bridge controllers
> 
> On Fri, Nov 27, 2015 at 01:17:05AM +0800, Gabriele Paoloni wrote:
> > This patch adds support for HiSilicon Hip06 SoC.
> > Documentation has been updated to include Hip06.
> > Gabriele Paoloni has been added as maintainer of the driver
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> Beautiful, applied to pci/host-hisi for v4.5, thanks, Gabriele!

Great! Thanks a lot Bjorn!

> 
> > ---
> > This patch is based on top of Arnd Bergmann patch [PATCH] PCI: hisi:
> > fix deferred probing
> > ---
> >  .../devicetree/bindings/pci/hisilicon-pcie.txt     |  8 +--
> >  MAINTAINERS                                        |  1 +
> >  drivers/pci/host/Kconfig                           |  5 +-
> >  drivers/pci/host/pcie-hisi.c                       | 76
> ++++++++++++++++++----
> >  4 files changed, 73 insertions(+), 17 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > index 17c6ed9..b721bea 100644
> > --- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > @@ -1,4 +1,4 @@
> > -HiSilicon PCIe host bridge DT description
> > +HiSilicon Hip05 and Hip06 PCIe host bridge DT description
> >
> >  HiSilicon PCIe host controller is based on Designware PCI core.
> >  It shares common functions with PCIe Designware core driver and
> > inherits @@ -7,8 +7,8 @@
> Documentation/devicetree/bindings/pci/designware-pci.txt.
> >
> >  Additional properties are described here:
> >
> > -Required properties:
> > -- compatible: Should contain "hisilicon,hip05-pcie".
> > +Required properties
> > +- compatible: Should contain "hisilicon,hip05-pcie" or
> "hisilicon,hip06-pcie".
> >  - reg: Should contain rc_dbi, config registers location and length.
> >  - reg-names: Must include the following entries:
> >    "rc_dbi": controller configuration registers; @@ -20,7 +20,7 @@
> > Optional properties:
> >  - status: Either "ok" or "disabled".
> >  - dma-coherent: Present if DMA operations are coherent.
> >
> > -Example:
> > +Hip05 Example (note that Hip06 is the same except compatible):
> >  	pcie@0xb0080000 {
> >  		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> >  		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
> diff
> > --git a/MAINTAINERS b/MAINTAINERS index f3de001..2f78e13 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8250,6 +8250,7 @@ F:	drivers/pci/host/pci-xgene-msi.c
> >
> >  PCIE DRIVER FOR HISILICON
> >  M:	Zhou Wang <wangzhou1@hisilicon.com>
> > +M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index
> > f131ba9..3f73587 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -166,10 +166,11 @@ config PCIE_ALTERA_MSI
> >
> >  config PCI_HISI
> >  	depends on OF && ARM64
> > -	bool "HiSilicon SoC HIP05 PCIe controller"
> > +	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> >  	select PCIEPORTBUS
> >  	select PCIE_DW
> >  	help
> > -	  Say Y here if you want PCIe controller support on HiSilicon
> HIP05 SoC
> > +	  Say Y here if you want PCIe controller support on HiSilicon
> > +	  Hip05 and Hip06 SoCs
> >
> >  endmenu
> > diff --git a/drivers/pci/host/pcie-hisi.c
> > b/drivers/pci/host/pcie-hisi.c index 163671a..0cd7554 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -1,10 +1,11 @@
> >  /*
> > - * PCIe host controller driver for HiSilicon Hip05 SoC
> > + * PCIe host controller driver for HiSilicon SoCs
> >   *
> >   * Copyright (C) 2015 HiSilicon Co., Ltd. http://www.hisilicon.com
> >   *
> > - * Author: Zhou Wang <wangzhou1@hisilicon.com>
> > - *         Dacai Zhu <zhudacai@hisilicon.com>
> > + * Authors: Zhou Wang <wangzhou1@hisilicon.com>
> > + *          Dacai Zhu <zhudacai@hisilicon.com>
> > + *          Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >   *
> >   * This program is free software; you can redistribute it and/or
> modify
> >   * it under the terms of the GNU General Public License version 2 as
> > @@ -16,21 +17,31 @@  #include <linux/of_address.h>  #include
> > <linux/of_pci.h>  #include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> >  #include <linux/regmap.h>
> >
> >  #include "pcie-designware.h"
> >
> > -#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> > -#define PCIE_LTSSM_LINKUP_STATE                         0x11
> > -#define PCIE_LTSSM_STATE_MASK                           0x3F
> > +#define PCIE_LTSSM_LINKUP_STATE				0x11
> > +#define PCIE_LTSSM_STATE_MASK				0x3F
> > +#define PCIE_SUBCTRL_SYS_STATE4_REG			0x6818
> > +#define PCIE_SYS_STATE4						0x31c
> > +#define PCIE_HIP06_CTRL_OFF					0x1000
> >
> >  #define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
> >
> > +struct hisi_pcie;
> > +
> > +struct pcie_soc_ops {
> > +	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie); };
> > +
> >  struct hisi_pcie {
> >  	struct regmap *subctrl;
> >  	void __iomem *reg_base;
> >  	u32 port_id;
> >  	struct pcie_port pp;
> > +	struct pcie_soc_ops *soc_ops;
> >  };
> >
> >  static inline void hisi_pcie_apb_writel(struct hisi_pcie *pcie, @@
> > -44,7 +55,7 @@ static inline u32 hisi_pcie_apb_readl(struct hisi_pcie
> *pcie, u32 reg)
> >  	return readl(pcie->reg_base + reg);
> >  }
> >
> > -/* Hip05 PCIe host only supports 32-bit config access */
> > +/* HipXX PCIe host only supports 32-bit config access */
> >  static int hisi_pcie_cfg_read(struct pcie_port *pp, int where, int
> size,
> >  			      u32 *val)
> >  {
> > @@ -67,7 +78,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp,
> int where, int size,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >
> > -/* Hip05 PCIe host only supports 32-bit config access */
> > +/* HipXX PCIe host only supports 32-bit config access */
> >  static int hisi_pcie_cfg_write(struct pcie_port *pp, int where, int
> size,
> >  				u32 val)
> >  {
> > @@ -94,10 +105,9 @@ static int hisi_pcie_cfg_write(struct pcie_port
> *pp, int where, int  size,
> >  	return PCIBIOS_SUCCESSFUL;
> >  }
> >
> > -static int hisi_pcie_link_up(struct pcie_port *pp)
> > +static int hisi_pcie_link_up_hip05(struct hisi_pcie *hisi_pcie)
> >  {
> >  	u32 val;
> > -	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> >
> >  	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
> >  		    0x100 * hisi_pcie->port_id, &val); @@ -105,6 +115,23 @@
> static
> > int hisi_pcie_link_up(struct pcie_port *pp)
> >  	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> > }
> >
> > +static int hisi_pcie_link_up_hip06(struct hisi_pcie *hisi_pcie) {
> > +	u32 val;
> > +
> > +	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_HIP06_CTRL_OFF +
> > +			PCIE_SYS_STATE4);
> > +
> > +	return ((val & PCIE_LTSSM_STATE_MASK) ==
> PCIE_LTSSM_LINKUP_STATE); }
> > +
> > +static int hisi_pcie_link_up(struct pcie_port *pp) {
> > +	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> > +
> > +	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
> > +}
> > +
> >  static struct pcie_host_ops hisi_pcie_host_ops = {
> >  	.rd_own_conf = hisi_pcie_cfg_read,
> >  	.wr_own_conf = hisi_pcie_cfg_write,
> > @@ -143,7 +170,9 @@ static int hisi_pcie_probe(struct platform_device
> > *pdev)  {
> >  	struct hisi_pcie *hisi_pcie;
> >  	struct pcie_port *pp;
> > +	const struct of_device_id *match;
> >  	struct resource *reg;
> > +	struct device_driver *driver;
> >  	int ret;
> >
> >  	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie),
> > GFP_KERNEL); @@ -152,6 +181,10 @@ static int hisi_pcie_probe(struct
> > platform_device *pdev)
> >
> >  	pp = &hisi_pcie->pp;
> >  	pp->dev = &pdev->dev;
> > +	driver = (pdev->dev).driver;
> > +
> > +	match = of_match_device(driver->of_match_table, &pdev->dev);
> > +	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
> >
> >  	hisi_pcie->subctrl =
> >  	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
> > @@ -180,11 +213,27 @@ static int hisi_pcie_probe(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +static struct pcie_soc_ops hip05_ops = {
> > +		&hisi_pcie_link_up_hip05
> > +};
> > +
> > +static struct pcie_soc_ops hip06_ops = {
> > +		&hisi_pcie_link_up_hip06
> > +};
> > +
> >  static const struct of_device_id hisi_pcie_of_match[] = {
> > -	{.compatible = "hisilicon,hip05-pcie",},
> > +	{
> > +			.compatible = "hisilicon,hip05-pcie",
> > +			.data	    = (void *) &hip05_ops,
> > +	},
> > +	{
> > +			.compatible = "hisilicon,hip06-pcie",
> > +			.data	    = (void *) &hip06_ops,
> > +	},
> >  	{},
> >  };
> >
> > +
> >  MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
> >
> >  static struct platform_driver hisi_pcie_driver = { @@ -196,3 +245,8
> > @@ static struct platform_driver hisi_pcie_driver = {  };
> >
> >  module_platform_driver(hisi_pcie_driver);
> > +
> > +MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
> > +MODULE_AUTHOR("Dacai Zhu <zhudacai@hisilicon.com>");
> > +MODULE_AUTHOR("Gabriele Paoloni <gabriele.paoloni@huawei.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
