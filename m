Return-Path: <SRS0=4nOf=BR=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=4nOf=BR=axis.com=niklas.cassel@kernel.org>
Subject: Re: [PATCH 08/10] PCI: dwc: artpec6: add support for endpoint mode
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Jesper Nilsson <jespern@axis.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Jingoo Han" <jingoohan1@gmail.com>, Xiaowei Song
	<songxiaowei@hisilicon.com>, "Peter Robinson" <pbrobinson@gmail.com>, Tomasz
 Nowicki <tn@semihalf.com>, "Gabriele Paoloni" <gabriele.paoloni@huawei.com>,
	Duc Dang <dhdang@apm.com>, <linux-arm-kernel@axis.com>,
	<linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20171013160914.3220-1-niklas.cassel@axis.com>
 <20171013160914.3220-9-niklas.cassel@axis.com>
 <20171016234326.GM25517@bhelgaas-glaptop.roam.corp.google.com>
 <ebc64a29-4080-af88-c774-b3223115aef0@ti.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <6a9b7221-1ed7-368d-f737-084e4a1519dc@axis.com>
Date: Wed, 18 Oct 2017 10:15:28 +0200
MIME-Version: 1.0
In-Reply-To: <ebc64a29-4080-af88-c774-b3223115aef0@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 10/18/2017 10:03 AM, Kishon Vijay Abraham I wrote:
> Hi Bjorn,
> 
> On Tuesday 17 October 2017 05:13 AM, Bjorn Helgaas wrote:
>> On Fri, Oct 13, 2017 at 06:09:11PM +0200, Niklas Cassel wrote:
>>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>>> ---
>>>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   3 +-
>>>  drivers/pci/dwc/Kconfig                            |  41 +++--
>>>  drivers/pci/dwc/Makefile                           |   4 +-
>>>  drivers/pci/dwc/pcie-artpec6.c                     | 202 ++++++++++++++++++++-
>>>  4 files changed, 233 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>>> index 4e4aee4439ea..33eef7ae5a23 100644
>>> --- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>>> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>>> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
>>>  and thus inherits all the common properties defined in designware-pcie.txt.
>>>  
>>>  Required properties:
>>> -- compatible: "axis,artpec6-pcie", "snps,dw-pcie"
>>> +- compatible: "axis,artpec6-pcie", "snps,dw-pcie" for ARTPEC-6 in RC mode;
>>> +	      "axis,artpec6-pcie-ep", "snps,dw-pcie" for ARTPEC-6 in EP mode;
>>>  - reg: base addresses and lengths of the PCIe controller (DBI),
>>>  	the PHY controller, and configuration address space.
>>>  - reg-names: Must include the following entries:
>>> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
>>> index 22ec82fcdea2..e333283fb1ed 100644
>>> --- a/drivers/pci/dwc/Kconfig
>>> +++ b/drivers/pci/dwc/Kconfig
>>> @@ -14,6 +14,36 @@ config PCIE_DW_EP
>>>  	depends on PCI_ENDPOINT
>>>  	select PCIE_DW
>>>  
>>> +config PCIE_ARTPEC6
>>> +	bool "Axis ARTPEC-6 PCIe controller"
>>> +	depends on (PCI && PCI_MSI_IRQ_DOMAIN) || PCI_ENDPOINT
>>> +	depends on MACH_ARTPEC6
>>> +	help
>>> +	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>>> +	  SoCs.  This PCIe controller uses the DesignWare core.
>>> +
>>> +if PCIE_ARTPEC6
>>> +
>>> +config PCIE_ARTPEC6_HOST
>>> +	bool "Axis ARTPEC-6 Host Mode"
>>> +	depends on PCI
>>> +	depends on PCI_MSI_IRQ_DOMAIN
>>> +	select PCIEPORTBUS
>>> +	select PCIE_DW_HOST
>>> +	help
>>> +	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>>> +	  host mode.
>>> +
>>> +config PCIE_ARTPEC6_EP
>>> +	bool "Axis ARTPEC-6 Endpoint Mode"
>>> +	depends on PCI_ENDPOINT
>>> +	select PCIE_DW_EP
>>> +	help
>>> +	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>>> +	  endpoint mode.
>>> +
>>> +endif
>>> +
>>>  config PCI_DRA7XX
>>>  	bool "TI DRA7xx PCIe controller"
>>>  	depends on SOC_DRA7XX || COMPILE_TEST
>>> @@ -148,17 +178,6 @@ config PCIE_ARMADA_8K
>>>  	  DesignWare hardware and therefore the driver re-uses the
>>>  	  DesignWare core functions to implement the driver.
>>>  
>>> -config PCIE_ARTPEC6
>>> -	bool "Axis ARTPEC-6 PCIe controller"
>>> -	depends on PCI
>>> -	depends on MACH_ARTPEC6
>>> -	depends on PCI_MSI_IRQ_DOMAIN
>>> -	select PCIEPORTBUS
>>> -	select PCIE_DW_HOST
>>> -	help
>>> -	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>>> -	  SoCs.  This PCIe controller uses the DesignWare core.
>>> -
>>>  config PCIE_KIRIN
>>>  	depends on OF && ARM64
>>>  	bool "HiSilicon Kirin series SoCs PCIe controllers"
>>
>>> diff --git a/drivers/pci/dwc/Makefile b/drivers/pci/dwc/Makefile
>>> index c61be9738cce..ac98242b83a9 100644
>>> --- a/drivers/pci/dwc/Makefile
>>> +++ b/drivers/pci/dwc/Makefile
>>> @@ -2,6 +2,9 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>>>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>>> +ifneq ($(filter y,$(CONFIG_PCIE_ARTPEC6_HOST) $(CONFIG_PCIE_ARTPEC6_EP)),)
>>> +        obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>>> +endif
>>
>> I see you're copying the DRA7XX style here, but I don't really
>> understand it.  I guess the idea is to build pcie-artpec6.o if either
>> CONFIG_PCIE_ARTPEC6_HOST or CONFIG_PCIE_ARTPEC6_EP is set (or both).
>>
>> Is this really the simplest way to express that in Kconfig?  Both the
>> "if PCIE_ARTPEC6" and this ifneq thing are complicated and relatively
>> unusual.
>>
>>>  ifneq ($(filter y,$(CONFIG_PCI_DRA7XX_HOST) $(CONFIG_PCI_DRA7XX_EP)),)
>>>          obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>>  endif
>>
>>> +static void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>>
>> Looks funny to have this dw_*() function in pcie-artpec6.c.  Intended?
>> Or is this something other endpoint drivers could/should share?
> 
> yeah, dw_pcie_ep_reset_bar is already present in pcie-designware-ep.c which
> should be made as library function to be used by other drivers. (pci-dra7xx.c
> has also added something like above which should also be fixed).
> 

Hello Kishon,

I can remove the static keyword from dw_pcie_ep_reset_bar,
move the declaration to pcie-designware.h,
and make sure that both pcie-artpec6.c and pci-dra7xx.c uses it.

Will do this in the next version of the patch series if you
don't have any objection.


Regards,
Niklas
