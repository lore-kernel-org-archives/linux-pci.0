Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55DB4939.5070605@amd.com>
References: <1439459925-2361-1-git-send-email-Suravee.Suthikulpanit@amd.com> <55DB4939.5070605@amd.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 24 Aug 2015 10:32:00 -0700
Message-ID: <CAErSpo4BzNgvVyEbFZWmQPR4KQsvMT1tRpT1mxPL=TymYSM3DQ@mail.gmail.com>
Subject: Re: [PATCH] pci: acpi: Generic function for setting up PCI device DMA coherency
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 24, 2015 at 9:41 AM, Suravee Suthikulpanit
<Suravee.Suthikulpanit@amd.com> wrote:
> Hi,
>
> Ping. Does anyone have any comments or suggestions?

Yes, I sent you some ideas a couple weeks ago.  I'll resend them.

> On 8/13/15 16:58, Suravee Suthikulpanit wrote:
>>
>> This patch refactors of_pci_dma_configure() into a more generic
>> pci_dma_configure(), which can be reused by non-OF code.
>> Then, it adds support for setting up PCI device DMA coherency from
>> ACPI _CCA object that should normally be specified in the DSDT node
>> of its PCI host bridge..
>>
>> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Bjorn Helgaas <bhelgaas@google.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
>> CC: Rob Herring <robh+dt@kernel.org>
>> CC: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>> Note: According to the ACPI spec, the _CCA attribute is required
>>        for ARM64. Therefore, this patch is a pre-req for ACPI PCI
>>        support for ARM64 which is currently in development.
>>
>>        Also, this should not affect other architectures since
>>        if CCA is not required, the default value is coherent.
>>        Please see include/acpi/acpi_bus.h: acpi_check_dma() and
>>        drivers/acpi/scan.c: acpi_init_coherency() for more information
>>
>>   drivers/of/of_pci.c    | 20 --------------------
>>   drivers/pci/probe.c    | 35 +++++++++++++++++++++++++++++++++--
>>   include/linux/of_pci.h |  3 ---
>>   3 files changed, 33 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
>> index 5751dc5..b66ee4e 100644
>> --- a/drivers/of/of_pci.c
>> +++ b/drivers/of/of_pci.c
>> @@ -117,26 +117,6 @@ int of_get_pci_domain_nr(struct device_node *node)
>>   }
>>   EXPORT_SYMBOL_GPL(of_get_pci_domain_nr);
>>
>> -/**
>> - * of_pci_dma_configure - Setup DMA configuration
>> - * @dev: ptr to pci_dev struct of the PCI device
>> - *
>> - * Function to update PCI devices's DMA configuration using the same
>> - * info from the OF node of host bridge's parent (if any).
>> - */
>> -void of_pci_dma_configure(struct pci_dev *pci_dev)
>> -{
>> -       struct device *dev = &pci_dev->dev;
>> -       struct device *bridge = pci_get_host_bridge_device(pci_dev);
>> -
>> -       if (!bridge->parent)
>> -               return;
>> -
>> -       of_dma_configure(dev, bridge->parent->of_node);
>> -       pci_put_host_bridge_device(bridge);
>> -}
>> -EXPORT_SYMBOL_GPL(of_pci_dma_configure);
>> -
>>   #if defined(CONFIG_OF_ADDRESS)
>>   /**
>>    * of_pci_get_host_bridge_resources - Parse PCI host bridge resources
>> from DT
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index cefd636..e2fcd3b 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -6,12 +6,14 @@
>>   #include <linux/delay.h>
>>   #include <linux/init.h>
>>   #include <linux/pci.h>
>> -#include <linux/of_pci.h>
>> +#include <linux/of_device.h>
>>   #include <linux/pci_hotplug.h>
>>   #include <linux/slab.h>
>>   #include <linux/module.h>
>>   #include <linux/cpumask.h>
>>   #include <linux/pci-aspm.h>
>> +#include <linux/acpi.h>
>> +#include <linux/property.h>
>>   #include <asm-generic/pci-bridge.h>
>>   #include "pci.h"
>>
>> @@ -1544,6 +1546,35 @@ static void pci_init_capabilities(struct pci_dev
>> *dev)
>>         pci_enable_acs(dev);
>>   }
>>
>> +/**
>> + * pci_dma_configure - Setup DMA configuration
>> + * @pci_dev: ptr to pci_dev struct of the PCI device
>> + *
>> + * Function to update PCI devices's DMA configuration using the same
>> + * info from the OF node or ACPI node of host bridge's parent (if any).
>> + */
>> +static void pci_dma_configure(struct pci_dev *pci_dev)
>> +{
>> +       struct device *dev = &pci_dev->dev;
>> +       struct device *bridge = pci_get_host_bridge_device(pci_dev);
>> +       struct acpi_device *adev;
>> +       bool coherent;
>> +
>> +       if (has_acpi_companion(bridge)) {
>> +               adev = to_acpi_node(bridge->fwnode);
>> +               if (acpi_check_dma(adev, &coherent))
>> +                       arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>> +       } else {
>> +               struct device *host = bridge->parent;
>> +               if (!host)
>> +                       return;
>> +
>> +               of_dma_configure(dev, host->of_node);
>> +       }
>> +
>> +       pci_put_host_bridge_device(bridge);
>> +}
>> +
>>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>>   {
>>         int ret;
>> @@ -1557,7 +1588,7 @@ void pci_device_add(struct pci_dev *dev, struct
>> pci_bus *bus)
>>         dev->dev.dma_mask = &dev->dma_mask;
>>         dev->dev.dma_parms = &dev->dma_parms;
>>         dev->dev.coherent_dma_mask = 0xffffffffull;
>> -       of_pci_dma_configure(dev);
>> +       pci_dma_configure(dev);
>>
>>         pci_set_dma_max_seg_size(dev, 65536);
>>         pci_set_dma_seg_boundary(dev, 0xffffffff);
>> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
>> index 29fd3fe..ce0e5ab 100644
>> --- a/include/linux/of_pci.h
>> +++ b/include/linux/of_pci.h
>> @@ -16,7 +16,6 @@ int of_pci_get_devfn(struct device_node *np);
>>   int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8
>> pin);
>>   int of_pci_parse_bus_range(struct device_node *node, struct resource
>> *res);
>>   int of_get_pci_domain_nr(struct device_node *node);
>> -void of_pci_dma_configure(struct pci_dev *pci_dev);
>>   #else
>>   static inline int of_irq_parse_pci(const struct pci_dev *pdev, struct
>> of_phandle_args *out_irq)
>>   {
>> @@ -51,8 +50,6 @@ of_get_pci_domain_nr(struct device_node *node)
>>   {
>>         return -1;
>>   }
>> -
>> -static inline void of_pci_dma_configure(struct pci_dev *pci_dev) { }
>>   #endif
>>
>>   #if defined(CONFIG_OF_ADDRESS)
>>
>
