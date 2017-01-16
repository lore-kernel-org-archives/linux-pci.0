Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33655 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdAPJbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 04:31:41 -0500
Date: Mon, 16 Jan 2017 10:31:36 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcie: ti: Provide patch to force GEN1 PCIe operation
Message-ID: <20170116103136.21c899ac@jawa>
In-Reply-To: <587C8088.80905@ti.com>
References: <1484486354-4585-1-git-send-email-lukma@denx.de>
        <587C6A40.8070608@ti.com>
        <20170116074927.086418f4@jawa>
        <587C8088.80905@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

> Hi Łukasz,
> 
> On Monday 16 January 2017 12:19 PM, Lukasz Majewski wrote:
> > Hi Kishon,
> > 
> >> Hi,
> >>
> >> On Sunday 15 January 2017 06:49 PM, Lukasz Majewski wrote:
> >>> Some devices (due to e.g. bad PCIe signal integrity) require to
> >>> run with forced GEN1 speed on PCIe bus.
> >>>
> >>> This patch changes the speed explicitly on dra7 based devices when
> >>> proper device tree attribute is defined for the PCIe controller.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>
> >> Bjorn has already queued a patch to do the same thing
> >> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-dra7xx
> > 
> > It seems like Bjorn only modifies CAP registers.
> 
> The patch also modifies the LNKCTL2 register.
> > 
> > He also needs to change register with 0x080C offset to actually
> > ( PCIECTRL_PL_WIDTH_SPEED_CTL )
> 
> This bit is used to initiate speed change (after the link is
> initialized in GEN1). Resetting the bit (like what you have done
> here) prevents speed change.

This is strange, but e2e advised me to do things as I did in the patch
to _force_ GEN1 operation on PCIe2 port [1] (AM5728)

Link:
[1] https://e2e.ti.com/support/arm/sitara_arm/f/791/t/566421

Both patches modify 0x5180 007C register to set GEN1 capability
(PCI_EXP_LNKCAP_SLS_2_5GB)

The problem is with second register (in your patch):

>From SPRUHZ6G TRM:

PCIECTRL_EP_DBICS_LNK_CAS_2 (0x5180 00A0)
- TRGT_LINK_SPEED (Reset 0x1) - "Target Link Speed" - no more
  description in TRM

It is set to PCI_EXP_LNKCAP_SLS_2_5GB = 0x1, which is the same as
default /reset value.


Could you clarify which way to _force_ PCIe GEN1 operation is correct?
Mine shows differences in lspci output (as posted in [1]).

> 
> IMO the better way is to set the LNKCTL2 to GEN1 instead of hacking
> the IP register.

>From the original patch description:

"Add support to force Root Complex to work in GEN1 mode if so desired,
but don't force GEN1 mode on any board just yet."

Are there any (floating around) patches allowing forcing GEN1 operation
on any board (I would like to reuse/port them to my current solution)?

Thanks in advance,
Łukasz Majewski

> 
> Thanks
> Kishon
> 
> > 
> > Best regards,
> > Łukasz
> > 
> >>
> >> Thanks
> >> Kishon
> >>
> >>> ---
> >>>
> >>> Patch applies on newest origin/master
> >>> SHA1: f4d3935e4f4884ba80561db5549394afb8eef8f7
> >>>
> >>> Tested at AM5728
> >>>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/ti-pci.txt |  1 +
> >>>  drivers/pci/host/pci-dra7xx.c                    | 23
> >>> +++++++++++++++++++++++
> >>> drivers/pci/host/pcie-designware.h               |  1 + 3 files
> >>> changed, 25 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt
> >>> b/Documentation/devicetree/bindings/pci/ti-pci.txt index
> >>> 60e2516..9f97409 100644 ---
> >>> a/Documentation/devicetree/bindings/pci/ti-pci.txt +++
> >>> b/Documentation/devicetree/bindings/pci/ti-pci.txt @@ -25,6 +25,7
> >>> @@ PCIe Designware Controller 
> >>>  Optional Property:
> >>>   - gpios : Should be added if a gpio line is required to drive
> >>> PERST# line
> >>> + - to,pcie-is-gen1: Indicates that forced gen1 port operation is
> >>> needed. 
> >>>  Example:
> >>>  axi {
> >>> diff --git a/drivers/pci/host/pci-dra7xx.c
> >>> b/drivers/pci/host/pci-dra7xx.c index 9595fad..eec5fae 100644
> >>> --- a/drivers/pci/host/pci-dra7xx.c
> >>> +++
> >>> b/drivers/pci/host/pci-https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-dra7xxdra7xx.c
> >>> @@ -63,6 +63,13 @@ #define
> >>> LINK_UP						BIT(16)
> >>> #define
> >>> DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
> >>> +#define         PCIECTRL_EP_DBICS_LNK_CAP
> >>> 0x007C +#define
> >>> MAX_LINK_SPEEDS_MASK				GENMASK(3, 0)
> >>> +#define         MAX_LINK_SPEEDS_GEN1
> >>> BIT(0) + +#define
> >>> PCIECTRL_PL_WIDTH_SPEED_CTL                     0x080C
> >>> +#define         CFG_DIRECTED_SPEED_CHANGE
> >>> BIT(17) + struct dra7xx_pcie { struct pcie_port	pp;
> >>>  	void __iomem		*base;		/* DT
> >>> ti_conf */ @@ -270,6 +277,7 @@ static int __init
> >>> dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx, struct pcie_port
> >>> *pp = &dra7xx->pp; struct device *dev = pp->dev;
> >>>  	struct resource *res;
> >>> +	u32 val;
> >>>  
> >>>  	pp->irq = platform_get_irq(pdev, 1);
> >>>  	if (pp->irq < 0) {
> >>> @@ -296,6 +304,18 @@ static int __init dra7xx_add_pcie_port(struct
> >>> dra7xx_pcie *dra7xx, if (!pp->dbi_base)
> >>>  		return -ENOMEM;
> >>>  
> >>> +	if (pp->is_gen1) {
> >>> +		dev_info(dev, "GEN1 forced\n");
> >>> +
> >>> +		val = readl(pp->dbi_base +
> >>> PCIECTRL_EP_DBICS_LNK_CAP);
> >>> +		set_mask_bits(&val, MAX_LINK_SPEEDS_MASK,
> >>> MAX_LINK_SPEEDS_GEN1);
> >>> +		writel(val, pp->dbi_base +
> >>> PCIECTRL_EP_DBICS_LNK_CAP); +
> >>> +		val = readl(pp->dbi_base +
> >>> PCIECTRL_PL_WIDTH_SPEED_CTL);
> >>> +		val &= ~CFG_DIRECTED_SPEED_CHANGE;
> >>> +		writel(val, pp->dbi_base +
> >>> PCIECTRL_PL_WIDTH_SPEED_CTL);
> >>> +	}
> >>> +
> >>>  	ret = dw_pcie_host_init(pp);
> >>>  	if (ret) {
> >>>  		dev_err(dev, "failed to initialize host\n");
> >>> @@ -404,6 +424,9 @@ static int __init dra7xx_pcie_probe(struct
> >>> platform_device *pdev) goto err_gpio;
> >>>  	}
> >>>  
> >>> +	if (of_property_read_bool(np, "ti,pcie-is-gen1"))
> >>> +		pp->is_gen1 = true;
> >>> +
> >>>  	reg = dra7xx_pcie_readl(dra7xx,
> >>> PCIECTRL_DRA7XX_CONF_DEVICE_CMD); reg &= ~LTSSM_EN;
> >>>  	dra7xx_pcie_writel(dra7xx,
> >>> PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg); diff --git
> >>> a/drivers/pci/host/pcie-designware.h
> >>> b/drivers/pci/host/pcie-designware.h index a567ea2..2fb0b18 100644
> >>> --- a/drivers/pci/host/pcie-designware.h +++
> >>> b/drivers/pci/host/pcie-designware.h @@ -50,6 +50,7 @@ struct
> >>> pcie_port { struct irq_domain	*irq_domain;
> >>>  	unsigned long		msi_data;
> >>>  	u8			iatu_unroll_enabled;
> >>> +	u8                      is_gen1;
> >>>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> >>>  };
> >>>  
> >>>
> > 
> > 
> > 
> > 
> > Best regards,
> > 
> > Lukasz Majewski
> > 
> > --
> > 
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:
> > wd@denx.de
> > 




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
