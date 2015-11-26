Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:54388 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbKZPWC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 10:22:02 -0500
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
Subject: RE: [PATCH] PCI: hisi: Add support for HiSilicon Hip06 PCIe host
 bridge controllers
Date: Thu, 26 Nov 2015 15:21:44 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162EC73C@lhreml503-mbs>
References: <1447840269-25001-1-git-send-email-gabriele.paoloni@huawei.com>
 <20151125220830.GH8869@localhost>
In-Reply-To: <20151125220830.GH8869@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: 25 November 2015 22:09
> To: Gabriele Paoloni
> Cc: Wangzhou (B); linux-pci@vger.kernel.org; xuwei (O); zhangjukuo;
> qiuzhenfa; qiujiang; liudongdong (C); Liguozhu (Kenneth); linux-
> kernel@vger.kernel.org; lorenzo.pieralisi@arm.com; bhelgaas@google.com
> Subject: Re: [PATCH] PCI: hisi: Add support for HiSilicon Hip06 PCIe
> host bridge controllers
> 
> Hi Gabriele,
> 
> On Wed, Nov 18, 2015 at 05:51:09PM +0800, Gabriele Paoloni wrote:
> > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> 
> Would you mind fixing wherever this comes from?  I've been manually
> fixing it to match your signed-off-by (which is conventionally
> capitalized), but it'd be handier if you fixed it on your end.

Sure sorry for this, I'll fix it in the next version

> 
> > This patch adds support for HiSilicon Hip06 SoC that implements
> > v2 HW IP of the PCIe Host Bridge controller.
> > Hip05 SoC references have been replaced with v1-Hip05 and references
> > to v2-Hip06 have been added.
> > Documentation has been updated to include Hip06 and the DT example
> > also has been updated accordingly.
> > Finally Gabriele Paoloni has been added as maintainer of the driver
> >
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> 
> This order is wrong.  This order says that Zhou took something from you
> and posted it.  But this email came from you, so either the order
> should be reversed, or it should be "Reviewed-by" or "Acked-by" Zhou.
> 
> Since Zhou is the current HiSi maintainer, I do want to see this patch
> either posted directly by him or acked by him.

I have talked to Wang Zhou and we agreed  to have me as Signed-off and
him as Reviewed-by

> 
> > ---
> > This patch is based on top of Arnd Bergmann patch [PATCH] PCI: hisi:
> > fix deferred probing
> > ---
> >  .../devicetree/bindings/pci/hisilicon-pcie.txt     | 16 ++--
> >  MAINTAINERS                                        |  1 +
> >  drivers/pci/host/Kconfig                           |  5 +-
> >  drivers/pci/host/pcie-hisi.c                       | 91
> ++++++++++++++++++----
> >  4 files changed, 90 insertions(+), 23 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > index 17c6ed9..3eee49a 100644
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
> > +- compatible: Should contain "hisilicon,v1-pcie-hip05" or
> "hisilicon,v2-pcie-hip06".
> 
> Why are you adding "v1" and "v2" to these strings?  Isn't "hip05" vs
> "hip06" enough by itself?

Well there has been a bit of confusion internally with the naming
conventions, now it is sorted and we'll use hip05 and hip06 only 

> 
> >  - reg: Should contain rc_dbi, config registers location and length.
> >  - reg-names: Must include the following entries:
> >    "rc_dbi": controller configuration registers; @@ -20,10 +20,14 @@
> > Optional properties:
> >  - status: Either "ok" or "disabled".
> >  - dma-coherent: Present if DMA operations are coherent.
> >
> > -Example:
> > +Hip05/Hip06 Example:
> >  	pcie@0xb0080000 {
> > -		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
> > +		compatible = "hisilicon,v1-pcie-hip05", "snps,dw-pcie";
> >  		reg = <0 0xb0080000 0 0x10000>, <0x220 0x00000000 0 0x2000>;
> > +/* for v2 HW IP use
> > + *		compatible = "hisilicon,v2-pcie-hip06", "snps,dw-pcie";
> > + *		reg = <0 0xa0090000 0 0x10000>, <0 0xa8000000 0 0x2000>;
> > + */
> 
> The only thing changing here is the "compatible" string, so I think it
> clutters up the example to include these two lines.  It almost made me
> overlook the "hisilicon,hip05-pcie" change (which I think should be in
> a separate patch).

Ok I will remove the hip06 specific lines.

> 
> >  		reg-names = "rc_dbi", "config";
> >  		bus-range = <0  15>;
> >  		msi-parent = <&its_pcie>;
> > @@ -41,4 +45,4 @@ Example:
> >  				  0x0 0 0 3 &mbigen_pcie 3 12
> >  				  0x0 0 0 4 &mbigen_pcie 4 13>;
> >  		status = "ok";
> > -	};
> > +	};
> > \ No newline at end of file
> 
> Spurious change that we don't want.

Sorry about this, will fix in the next one.

> 
> > diff --git a/MAINTAINERS b/MAINTAINERS index 7af7f4a..3f97cf1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8195,6 +8195,7 @@ F:	drivers/pci/host/pci-xgene-msi.c
> >
> >  PCIE DRIVER FOR HISILICON
> >  M:	Zhou Wang <wangzhou1@hisilicon.com>
> > +M:	Gabriele Paoloni <gabriele.paoloni@huawei.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index
> > f131ba9..f5c58cf 100644
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
> > +	  Say Y here if you want PCIe controller support on SoCs
> supporting
> > +	  HiSilicon Hip05 and Hip06 SoCs
> 
> Looks like an extra "support" or "supporting" in this sentence.

Yes, I will rephrase...it definitively doesn't sound ok

> 
> >  endmenu
> > diff --git a/drivers/pci/host/pcie-hisi.c
> > b/drivers/pci/host/pcie-hisi.c index 163671a..1210685 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -1,10 +1,11 @@
> >  /*
> > - * PCIe host controller driver for HiSilicon Hip05 SoC
> > + * PCIe host bridge controller driver for HiSilicon SoCs
> 
> "host bridge controller driver" is really a mouthful.  "host controller
> driver" is still accurate and probably enough.

Ok will change

> 
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
> > @@ -16,21 +17,35 @@  #include <linux/of_address.h>  #include
> > <linux/of_pci.h>  #include <linux/platform_device.h>
> > +#include <linux/of_device.h>
> >  #include <linux/regmap.h>
> >
> >  #include "pcie-designware.h"
> >
> > -#define PCIE_SUBCTRL_SYS_STATE4_REG                     0x6818
> > -#define PCIE_LTSSM_LINKUP_STATE                         0x11
> > -#define PCIE_LTSSM_STATE_MASK                           0x3F
> > +#define PCIE_HOST_V1                                 0x1
> > +#define PCIE_HOST_V2                                 0x2
> > +
> > +#define PCIE_LTSSM_LINKUP_STATE                      0x11
> > +#define PCIE_LTSSM_STATE_MASK                        0x3F
> > +#define PCIE_SUBCTRL_SYS_STATE4_REG                  0x6818
> > +#define PCIE_SYS_STATE4                              0x31c
> > +#define PCIE_V2_CTRL_OFF                             0x1000
> 
> This mixes up some reordering and whitespace changes with the actual
> Hip06 changes.  But I guess they're so trivial it's probably not worth
> splitting them out.  But since you are changing them anyway, please
> convert them to use tabs instead of spaces.

Sure will do, thanks.

> 
> >  #define to_hisi_pcie(x)	container_of(x, struct hisi_pcie, pp)
> >
> > +struct hisi_pcie;
> > +
> > +struct pcie_soc_ops {
> > +	int (*hisi_pcie_link_up)(struct hisi_pcie *pcie);
> > +	u32 soc_type;
> > +};
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
> > -44,7 +59,7 @@ static inline u32 hisi_pcie_apb_readl(struct hisi_pcie
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
> > @@ -67,7 +82,7 @@ static int hisi_pcie_cfg_read(struct pcie_port *pp,
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
> > @@ -96,13 +111,8 @@ static int hisi_pcie_cfg_write(struct pcie_port
> > *pp, int where, int  size,
> >
> >  static int hisi_pcie_link_up(struct pcie_port *pp)  {
> > -	u32 val;
> >  	struct hisi_pcie *hisi_pcie = to_hisi_pcie(pp);
> > -
> > -	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
> > -		    0x100 * hisi_pcie->port_id, &val);
> > -
> > -	return ((val & PCIE_LTSSM_STATE_MASK) == PCIE_LTSSM_LINKUP_STATE);
> > +	return hisi_pcie->soc_ops->hisi_pcie_link_up(hisi_pcie);
> >  }
> >
> >  static struct pcie_host_ops hisi_pcie_host_ops = { @@ -143,7 +153,9
> > @@ static int hisi_pcie_probe(struct platform_device *pdev)  {
> >  	struct hisi_pcie *hisi_pcie;
> >  	struct pcie_port *pp;
> > +	const struct of_device_id *match;
> >  	struct resource *reg;
> > +	struct device_driver *driver;
> >  	int ret;
> >
> >  	hisi_pcie = devm_kzalloc(&pdev->dev, sizeof(*hisi_pcie),
> > GFP_KERNEL); @@ -152,6 +164,10 @@ static int hisi_pcie_probe(struct
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
> > @@ -180,11 +196,51 @@ static int hisi_pcie_probe(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +/* Check if the link is up for V1 PCIe HW IP*/
> 
> These comments aren't really necessary; it's obvious from the names
> what's going on.  I'd use "hip05" and "hip06" because they seem more
> descriptive than "v1" and "v2", but I'm a little confused about what
> your conventional names are.

As I said there has been some confusion internally in the company...
for next patch we'll only use hip05 and hip06

> 
> > +static int hisi_pcie_link_up_v1(struct hisi_pcie *hisi_pcie) {
> > +	u32 val;
> > +
> > +	regmap_read(hisi_pcie->subctrl, PCIE_SUBCTRL_SYS_STATE4_REG +
> > +		    0x100 * hisi_pcie->port_id, &val);
> > +
> > +	return ((val & PCIE_LTSSM_STATE_MASK) ==
> PCIE_LTSSM_LINKUP_STATE); }
> 
> I'd put these functions just above the hisi_pcie_link_up() wrapper
> because it makes it easier for human code readers, but that's a nit-
> pick.  It might also make the patch easier to read because it might
> show as a simple function rename rather than "remove and add
> elsewhere."

Ok will do, thanks

> 
> > +/* Check if the link is up for V2 PCIe HW IP */ static int
> > +hisi_pcie_link_up_v2(struct hisi_pcie *hisi_pcie) {
> > +	u32 val;
> > +
> > +	val = hisi_pcie_apb_readl(hisi_pcie, PCIE_V2_CTRL_OFF +
> > +			PCIE_SYS_STATE4);
> 
> It looks like hip05 support 4 ports (0, 1, 2, 3).  Does hip06 only
> support one port?  The v1 link_up() function uses hisi_pcie->port_id,
> but this one doesn't.

No, not quite...
hisi_pcie_apb_readl() ends up reading from the register pcie->reg_base.
reg_base is set according to "rc_dbi" property in DT; so each port will
have its own register bank (used to check the link status)...

> 
> > +	return ((val & PCIE_LTSSM_STATE_MASK) ==
> PCIE_LTSSM_LINKUP_STATE); }
> > +
> > +static struct pcie_soc_ops v2_ops = {
> > +		&hisi_pcie_link_up_v2,
> > +		PCIE_HOST_V2
> 
> I don't see PCI_HOST_V2 and PCI_HOST_V1 being used by anything.

Me neither :)
Sorry about this and thanks for flagging it, I missed it when cleaning
up code from a different version of the driver...

> 
> > +};
> > +
> > +static struct pcie_soc_ops v1_ops = {
> > +		&hisi_pcie_link_up_v1,
> > +		PCIE_HOST_V1
> > +};
> > +
> >  static const struct of_device_id hisi_pcie_of_match[] = {
> > -	{.compatible = "hisilicon,hip05-pcie",},
> > +	{
> > +			.compatible = "hisilicon,v1-pcie-hip05",
> 
> Doesn't this break the driver for any DTs in the field with
> "hisilicon,hip05-pcie"?  I don't understand why you need to change this,
> but if you do need to, I think it should be a separate patch by itself
> so it's more obvious.

Well accordingly above I changed
 -		compatible = "hisilicon,hip05-pcie", "snps,dw-pcie";
 +		compatible = "hisilicon,v1-pcie-hip05", "snps,dw-pcie";

However it doesn't apply anymore as I am now going to use just
hip05 and hip05 (no more v1/v2) 

> 
> > +			.data	    = (void *) &v1_ops,
> > +	},
> > +	{
> > +			.compatible = "hisilicon,v2-pcie-hip06",
> > +			.data	    = (void *) &v2_ops,
> > +	},
> >  	{},
> >  };
> >
> > +
> >  MODULE_DEVICE_TABLE(of, hisi_pcie_of_match);
> >
> >  static struct platform_driver hisi_pcie_driver = { @@ -196,3 +252,8
> > @@ static struct platform_driver hisi_pcie_driver = {  };
> >
> >  module_platform_driver(hisi_pcie_driver);
> > +
> > +MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
> > +MODULE_AUTHOR("Dacai Zhu <zhudacai@hisilicon.com>");
> > +MODULE_AUTHOR("Gabriele Paoloni <gabriele.paoloni@huawei.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
