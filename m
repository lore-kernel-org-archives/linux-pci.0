Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] PCI: dwc: Add support for endpoint mode
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
 <9ce10e6844863029992a5f4e74c89818615850e3.1523266508.git.gustavo.pimentel@synopsys.com>
 <abb244d5-2697-54da-b64c-25c018f50354@ti.com>
 <667dde5d-70b9-0001-59f9-f2b7cb8d06b8@synopsys.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <10d70eb7-6966-4ebc-b8ef-5d2a2ff0c5ad@ti.com>
Date: Tue, 10 Apr 2018 16:39:57 +0530
MIME-Version: 1.0
In-Reply-To: <667dde5d-70b9-0001-59f9-f2b7cb8d06b8@synopsys.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 10 April 2018 04:06 PM, Gustavo Pimentel wrote:
> Hi Kishon,
> 
> On 10/04/2018 06:12, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Monday 09 April 2018 03:11 PM, Gustavo Pimentel wrote:
>>> The PCIe controller dual mode is capable of operating in host mode as well
>>> as endpoint mode by configuration, therefore this patch aims to add
>>> endpoint mode support to the designware driver.
>>>
>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> ---
>>> Change v1->v2:
>>>  - Removed dw_plat_pcie_stop_link empty function.
>>>  - Implemented Kishon's suggestions about dw-pcie-rc and dw-pcie strings.
>>> compatibility.
>>>  - Added second entry on pci_epf_test_ids structure.
>>>
>>>  drivers/pci/dwc/Kconfig                       |  45 ++++++--
>>>  drivers/pci/dwc/pcie-designware-ep.c          |   4 +-
>>>  drivers/pci/dwc/pcie-designware-plat.c        | 153 ++++++++++++++++++++++++--
>>>  drivers/pci/endpoint/functions/pci-epf-test.c |   9 ++
>>>  4 files changed, 190 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>>> index 2f3f5c5..3fd7daf 100644
>>> --- a/drivers/pci/dwc/Kconfig
>>> +++ b/drivers/pci/dwc/Kconfig
>>> @@ -7,8 +7,7 @@ config PCIE_DW
>>>  
>>>  config PCIE_DW_HOST
>>>          bool
>>> -	depends on PCI
>>> -	depends on PCI_MSI_IRQ_DOMAIN
>>> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
>>>          select PCIE_DW
>>>  
>>>  config PCIE_DW_EP
>>> @@ -52,16 +51,42 @@ config PCI_DRA7XX_EP
>>>  
>>>  config PCIE_DW_PLAT
>>>  	bool "Platform bus based DesignWare PCIe Controller"
>>> -	depends on PCI
>>> -	depends on PCI_MSI_IRQ_DOMAIN
>>> -	select PCIE_DW_HOST
>>> -	---help---
>>> -	 This selects the DesignWare PCIe controller support. Select this if
>>> -	 you have a PCIe controller on Platform bus.
>>> +	help
>>> +	  There are two instances of PCIe controller in Designware IP.
>>> +	  This controller can work either as EP or RC. In order to enable
>>> +	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
>>> +	  order to enable device-specific features PCIE_DW_PLAT_EP must be
>>> +	  selected.
>>>  
>>> -	 If you have a controller with this interface, say Y or M here.
>>> +config PCIE_DW_PLAT_HOST
>>> +	bool "Platform bus based DesignWare PCIe Controller - Host mode"
>>> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
>>> +	select PCIE_DW_HOST
>>> +	select PCIE_DW_PLAT
>>> +	default y
>>> +	help
>>> +	  Enables support for the PCIe controller in the Designware IP to
>>> +	  work in host mode. There are two instances of PCIe controller in
>>> +	  Designware IP.
>>> +	  This controller can work either as EP or RC. In order to enable
>>> +	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
>>> +	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>> +	  selected.
>>>  
>>> -	 If unsure, say N.
>>> +config PCIE_DW_PLAT_EP
>>> +	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
>>> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
>>> +	depends on PCI_ENDPOINT
>>> +	select PCIE_DW_EP
>>> +	select PCIE_DW_PLAT
>>> +	help
>>> +	  Enables support for the PCIe controller in the Designware IP to
>>> +	  work in endpoint mode. There are two instances of PCIe controller
>>> +	  in Designware IP.
>>> +	  This controller can work either as EP or RC. In order to enable
>>> +	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
>>> +	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>> +	  selected.
>>>  
>>>  config PCI_EXYNOS
>>>  	bool "Samsung Exynos PCIe controller"
>>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>>> index f07678b..4ac135a 100644
>>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>>> @@ -15,8 +15,10 @@
>>>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>>>  {
>>>  	struct pci_epc *epc = ep->epc;
>>> +	struct pci_epf *epf;
>>>  
>>> -	pci_epc_linkup(epc);
>>> +	list_for_each_entry(epf, &epc->pci_epf, list)
>>> +		pci_epf_linkup(epf);
>>>  }
>>
>> This shouldn't be required anymore.
> 
> Ok. I'll revert it.
> 
>>>  
>>>  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar,
>>> diff --git a/drivers/pci/dwc/pcie-designware-plat.c b/drivers/pci/dwc/pcie-designware-plat.c
>>> index 5416aa8..5382a7a 100644
>>> --- a/drivers/pci/dwc/pcie-designware-plat.c
>>> +++ b/drivers/pci/dwc/pcie-designware-plat.c
>>> @@ -12,19 +12,29 @@
>>>  #include <linux/interrupt.h>
>>>  #include <linux/kernel.h>
>>>  #include <linux/init.h>
>>> +#include <linux/of_device.h>
>>>  #include <linux/of_gpio.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/platform_device.h>
>>>  #include <linux/resource.h>
>>>  #include <linux/signal.h>
>>>  #include <linux/types.h>
>>> +#include <linux/regmap.h>
>>>  
>>>  #include "pcie-designware.h"
>>>  
>>>  struct dw_plat_pcie {
>>> -	struct dw_pcie		*pci;
>>> +	struct dw_pcie			*pci;
>>> +	struct regmap			*regmap;
>>> +	enum dw_pcie_device_mode	mode;
>>>  };
>>>  
>>> +struct dw_plat_pcie_of_data {
>>> +	enum dw_pcie_device_mode	mode;
>>> +};
>>> +
>>> +static const struct of_device_id dw_plat_pcie_of_match[];
>>> +
>>>  static int dw_plat_pcie_host_init(struct pcie_port *pp)
>>>  {
>>>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>> @@ -42,9 +52,53 @@ static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
>>>  	.host_init = dw_plat_pcie_host_init,
>>>  };
>>>  
>>> -static int dw_plat_add_pcie_port(struct pcie_port *pp,
>>> +static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct dw_pcie_ops dw_pcie_ops = {
>>> +	.start_link = dw_plat_pcie_establish_link,
>>> +};
>>> +
>>> +static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +	enum pci_barno bar;
>>> +
>>> +	for (bar = BAR_0; bar <= BAR_5; bar++)
>>> +		dw_pcie_ep_reset_bar(pci, bar);
>>> +}
>>> +
>>> +static int dw_plat_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>>> +				     enum pci_epc_irq_type type,
>>> +				     u8 interrupt_num)
>>> +{
>>> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>> +
>>> +	switch (type) {
>>> +	case PCI_EPC_IRQ_LEGACY:
>>> +		dev_err(pci->dev, "EP cannot trigger legacy IRQs\n");
>>> +		return -EINVAL;
>>> +	case PCI_EPC_IRQ_MSI:
>>> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
>>> +	default:
>>> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct dw_pcie_ep_ops pcie_ep_ops = {
>>> +	.ep_init = dw_plat_pcie_ep_init,
>>> +	.raise_irq = dw_plat_pcie_ep_raise_irq,
>>> +};
>>> +
>>> +static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
>>>  				 struct platform_device *pdev)
>>>  {
>>> +	struct dw_pcie *pci = dw_plat_pcie->pci;
>>> +	struct pcie_port *pp = &pci->pp;
>>>  	struct device *dev = &pdev->dev;
>>>  	int ret;
>>>  
>>> @@ -63,15 +117,44 @@ static int dw_plat_add_pcie_port(struct pcie_port *pp,
>>>  
>>>  	ret = dw_pcie_host_init(pp);
>>>  	if (ret) {
>>> -		dev_err(dev, "failed to initialize host\n");
>>> +		dev_err(dev, "Failed to initialize host\n");
>>>  		return ret;
>>>  	}
>>>  
>>>  	return 0;
>>>  }
>>>  
>>> -static const struct dw_pcie_ops dw_pcie_ops = {
>>> -};
>>> +static int dw_plat_add_pcie_ep(struct dw_plat_pcie *dw_plat_pcie,
>>> +			       struct platform_device *pdev)
>>> +{
>>> +	int ret;
>>> +	struct dw_pcie_ep *ep;
>>> +	struct resource *res;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct dw_pcie *pci = dw_plat_pcie->pci;
>>> +
>>> +	ep = &pci->ep;
>>> +	ep->ops = &pcie_ep_ops;
>>> +
>>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
>>> +	pci->dbi_base2 = devm_ioremap(dev, res->start, resource_size(res));
>>
>> This can throw up a NULL pointer dereferencing error. Use devm_ioremap_resource
>> instead.
> 
> I have looked on [1] and [2] and both implementations uses devm_ioremap
> function, they are also wrong?
> 
> [1] -> https://elixir.bootlin.com/linux/latest/source/drivers/pci/dwc/pcie-artpec6.c
> [2] -> https://elixir.bootlin.com/linux/latest/source/drivers/pci/dwc/pci-dra7xx.c

yes, they are wrong. There was a patch to fix it but somehow dropped
https://patchwork.kernel.org/patch/10173831/.

I'll resend them.

Thanks
Kishon
