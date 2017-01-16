Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:16831 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdAPINM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2017 03:13:12 -0500
Subject: Re: [PATCH] pcie: ti: Provide patch to force GEN1 PCIe operation
To: Lukasz Majewski <lukma@denx.de>
References: <1484486354-4585-1-git-send-email-lukma@denx.de>
 <587C6A40.8070608@ti.com> <20170116074927.086418f4@jawa>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <587C8088.80905@ti.com>
Date: Mon, 16 Jan 2017 13:42:56 +0530
MIME-Version: 1.0
In-Reply-To: <20170116074927.086418f4@jawa>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Łukasz,

On Monday 16 January 2017 12:19 PM, Lukasz Majewski wrote:
> Hi Kishon,
> 
>> Hi,
>>
>> On Sunday 15 January 2017 06:49 PM, Lukasz Majewski wrote:
>>> Some devices (due to e.g. bad PCIe signal integrity) require to run
>>> with forced GEN1 speed on PCIe bus.
>>>
>>> This patch changes the speed explicitly on dra7 based devices when
>>> proper device tree attribute is defined for the PCIe controller.
>>>
>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>>
>> Bjorn has already queued a patch to do the same thing
>> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-dra7xx
> 
> It seems like Bjorn only modifies CAP registers.

The patch also modifies the LNKCTL2 register.
> 
> He also needs to change register with 0x080C offset to actually
> ( PCIECTRL_PL_WIDTH_SPEED_CTL )

This bit is used to initiate speed change (after the link is initialized in
GEN1). Resetting the bit (like what you have done here) prevents speed change.

IMO the better way is to set the LNKCTL2 to GEN1 instead of hacking the IP
register.

Thanks
Kishon

> 
> Best regards,
> Łukasz
> 
>>
>> Thanks
>> Kishon
>>
>>> ---
>>>
>>> Patch applies on newest origin/master
>>> SHA1: f4d3935e4f4884ba80561db5549394afb8eef8f7
>>>
>>> Tested at AM5728
>>>
>>> ---
>>>  Documentation/devicetree/bindings/pci/ti-pci.txt |  1 +
>>>  drivers/pci/host/pci-dra7xx.c                    | 23
>>> +++++++++++++++++++++++
>>> drivers/pci/host/pcie-designware.h               |  1 + 3 files
>>> changed, 25 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt
>>> b/Documentation/devicetree/bindings/pci/ti-pci.txt index
>>> 60e2516..9f97409 100644 ---
>>> a/Documentation/devicetree/bindings/pci/ti-pci.txt +++
>>> b/Documentation/devicetree/bindings/pci/ti-pci.txt @@ -25,6 +25,7
>>> @@ PCIe Designware Controller 
>>>  Optional Property:
>>>   - gpios : Should be added if a gpio line is required to drive
>>> PERST# line
>>> + - to,pcie-is-gen1: Indicates that forced gen1 port operation is
>>> needed. 
>>>  Example:
>>>  axi {
>>> diff --git a/drivers/pci/host/pci-dra7xx.c
>>> b/drivers/pci/host/pci-dra7xx.c index 9595fad..eec5fae 100644
>>> --- a/drivers/pci/host/pci-dra7xx.c
>>> +++
>>> b/drivers/pci/host/pci-https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-dra7xxdra7xx.c
>>> @@ -63,6 +63,13 @@ #define
>>> LINK_UP						BIT(16)
>>> #define
>>> DRA7XX_CPU_TO_BUS_ADDR				0x0FFFFFFF
>>> +#define         PCIECTRL_EP_DBICS_LNK_CAP
>>> 0x007C +#define
>>> MAX_LINK_SPEEDS_MASK				GENMASK(3, 0)
>>> +#define         MAX_LINK_SPEEDS_GEN1
>>> BIT(0) + +#define
>>> PCIECTRL_PL_WIDTH_SPEED_CTL                     0x080C
>>> +#define         CFG_DIRECTED_SPEED_CHANGE
>>> BIT(17) + struct dra7xx_pcie { struct pcie_port	pp;
>>>  	void __iomem		*base;		/* DT
>>> ti_conf */ @@ -270,6 +277,7 @@ static int __init
>>> dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx, struct pcie_port
>>> *pp = &dra7xx->pp; struct device *dev = pp->dev;
>>>  	struct resource *res;
>>> +	u32 val;
>>>  
>>>  	pp->irq = platform_get_irq(pdev, 1);
>>>  	if (pp->irq < 0) {
>>> @@ -296,6 +304,18 @@ static int __init dra7xx_add_pcie_port(struct
>>> dra7xx_pcie *dra7xx, if (!pp->dbi_base)
>>>  		return -ENOMEM;
>>>  
>>> +	if (pp->is_gen1) {
>>> +		dev_info(dev, "GEN1 forced\n");
>>> +
>>> +		val = readl(pp->dbi_base +
>>> PCIECTRL_EP_DBICS_LNK_CAP);
>>> +		set_mask_bits(&val, MAX_LINK_SPEEDS_MASK,
>>> MAX_LINK_SPEEDS_GEN1);
>>> +		writel(val, pp->dbi_base +
>>> PCIECTRL_EP_DBICS_LNK_CAP); +
>>> +		val = readl(pp->dbi_base +
>>> PCIECTRL_PL_WIDTH_SPEED_CTL);
>>> +		val &= ~CFG_DIRECTED_SPEED_CHANGE;
>>> +		writel(val, pp->dbi_base +
>>> PCIECTRL_PL_WIDTH_SPEED_CTL);
>>> +	}
>>> +
>>>  	ret = dw_pcie_host_init(pp);
>>>  	if (ret) {
>>>  		dev_err(dev, "failed to initialize host\n");
>>> @@ -404,6 +424,9 @@ static int __init dra7xx_pcie_probe(struct
>>> platform_device *pdev) goto err_gpio;
>>>  	}
>>>  
>>> +	if (of_property_read_bool(np, "ti,pcie-is-gen1"))
>>> +		pp->is_gen1 = true;
>>> +
>>>  	reg = dra7xx_pcie_readl(dra7xx,
>>> PCIECTRL_DRA7XX_CONF_DEVICE_CMD); reg &= ~LTSSM_EN;
>>>  	dra7xx_pcie_writel(dra7xx,
>>> PCIECTRL_DRA7XX_CONF_DEVICE_CMD, reg); diff --git
>>> a/drivers/pci/host/pcie-designware.h
>>> b/drivers/pci/host/pcie-designware.h index a567ea2..2fb0b18 100644
>>> --- a/drivers/pci/host/pcie-designware.h +++
>>> b/drivers/pci/host/pcie-designware.h @@ -50,6 +50,7 @@ struct
>>> pcie_port { struct irq_domain	*irq_domain;
>>>  	unsigned long		msi_data;
>>>  	u8			iatu_unroll_enabled;
>>> +	u8                      is_gen1;
>>>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>>>  };
>>>  
>>>
> 
> 
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> 
