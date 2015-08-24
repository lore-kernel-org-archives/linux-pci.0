Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH] pci: acpi: Generic function for setting up PCI device DMA
 coherency
To: Bjorn Helgaas <bhelgaas@google.com>
References: <1439459925-2361-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20150814015004.GA26431@google.com>
 <CAErSpo7yN08tKyo-yyyVG58vUptbHGN=L+MEZ8TQy1gm5a1_0Q@mail.gmail.com>
CC: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	"Hanjun Guo" <hanjun.guo@linaro.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jeremy Linton <jeremy.linton@arm.com>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <55DB6BF6.1030206@amd.com>
Date: Tue, 25 Aug 2015 02:09:42 +0700
MIME-Version: 1.0
In-Reply-To: <CAErSpo7yN08tKyo-yyyVG58vUptbHGN=L+MEZ8TQy1gm5a1_0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 8/25/15 00:32, Bjorn Helgaas wrote:
> Here it is again.
>
> On Thu, Aug 13, 2015 at 6:50 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> Hi Suravee,
>>
>> On Thu, Aug 13, 2015 at 04:58:45PM +0700, Suravee Suthikulpanit wrote:
>>> This patch refactors of_pci_dma_configure() into a more generic
>>> pci_dma_configure(), which can be reused by non-OF code.
>>> Then, it adds support for setting up PCI device DMA coherency from
>>> ACPI _CCA object that should normally be specified in the DSDT node
>>> of its PCI host bridge..
>>
>> Since this does two things:
>>    1) Rename of_pci_dma_configure() and move it to PCI
>>    2) Add _CCA support,
>> maybe it should be split into two patches?

Sure, I can take care of that and separate them into two patches.

>> There are a couple more comments below.
>>
>> While looking at this, I thought some of the existing code could be
>> made simpler and easier to follow.  I appended a couple possible patches;
>> you can incorporate them or ignore them, whatever seems best to you.
>>
>> Bjorn

Please see my response below.

>> [...]
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index cefd636..e2fcd3b 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -6,12 +6,14 @@
>>>   #include <linux/delay.h>
>>>   #include <linux/init.h>
>>>   #include <linux/pci.h>
>>> -#include <linux/of_pci.h>
>>> +#include <linux/of_device.h>
>>>   #include <linux/pci_hotplug.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/module.h>
>>>   #include <linux/cpumask.h>
>>>   #include <linux/pci-aspm.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/property.h>
>>>   #include <asm-generic/pci-bridge.h>
>>>   #include "pci.h"
>>>
>>> @@ -1544,6 +1546,35 @@ static void pci_init_capabilities(struct pci_dev *dev)
>>>        pci_enable_acs(dev);
>>>   }
>>>
>>> +/**
>>> + * pci_dma_configure - Setup DMA configuration
>>> + * @pci_dev: ptr to pci_dev struct of the PCI device
>>> + *
>>> + * Function to update PCI devices's DMA configuration using the same
>>> + * info from the OF node or ACPI node of host bridge's parent (if any).
>>> + */
>>> +static void pci_dma_configure(struct pci_dev *pci_dev)
>>
>> Almost all pci_dev pointers in probe.c are named "dev", so I would use
>> that for this one, too.  I probably would just drop the "struct device
>> *dev" below and use "&dev->dev" the two places you need it.  That's a
>> common idiom in PCI.
>>
I'll take care of this.

>>> +{
>>> +     struct device *dev = &pci_dev->dev;
>>> +     struct device *bridge = pci_get_host_bridge_device(pci_dev);
>>> +     struct acpi_device *adev;
>>> +     bool coherent;
>>> +
>>> +     if (has_acpi_companion(bridge)) {
>>> +             adev = to_acpi_node(bridge->fwnode);
>>> +             if (acpi_check_dma(adev, &coherent))
>>> +                     arch_setup_dma_ops(dev, 0, 0, NULL, coherent);
>>> +     } else {
>>> +             struct device *host = bridge->parent;
>>> +             if (!host)
>>> +                     return;
>>> +
>>> +             of_dma_configure(dev, host->of_node);
>>> +     }
>>
>> Why is this check reversed with respect to device_dma_is_coherent()?
>> In device_dma_is_coherent(), we first look for an OF property, then look
>> for ACPI _CCA.  But here we check for _CCA, then for OF.
>>
I was trying to save some additional logic. But, think again I should 
not have done so. I'll fix this.

>> [...]
>> commit 18183957888f601807ca0e166516ae60f682eb62
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Aug 13 20:01:21 2015 -0500
>>
>>      ACPI / scan: Move _CCA comments to acpi_init_coherency()
>>
>>      Move the comments about how we handle _CCA to the code that looks at _CCA,
>>      and fix a couple typos.
>>
>>      No functional change.
>>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index ec25635..a12e522 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2188,6 +2188,22 @@ static void acpi_init_coherency(struct acpi_device *adev)
>>          acpi_status status;
>>          struct acpi_device *parent = adev->parent;
>>
>> +       /**
>> +        * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
>> +        * This should be equivalent to specifying dma-coherent for
>> +        * a device in OF.
>> +        *
>> +        * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
>> +        * we have two choices:
>> +        * case 1. Do not support and disable DMA.
>> +        * case 2. Support but rely on arch-specific cache maintenance for
>> +        *         non-coherent DMA operations.
>> +        * Currently, we implement case 1 above.
>> +        *
>> +        * For the case when _CCA is missing (i.e. cca_seen=0) and
>> +        * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
>> +        * and fallback to arch-specific default handling.
>> +        */
>>          if (parent && parent->flags.cca_seen) {
>>                  /*
>>                   * From ACPI spec, OSPM will ignore _CCA if an ancestor
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 83061ca..718942b 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -389,24 +389,6 @@ static inline bool acpi_check_dma(struct acpi_device *adev, bool *coherent)
>>          if (!adev)
>>                  return ret;
>>
>> -       /**
>> -        * Currently, we only support _CCA=1 (i.e. coherent_dma=1)
>> -        * This should be equivalent to specifyig dma-coherent for
>> -        * a device in OF.
>> -        *
>> -        * For the case when _CCA=0 (i.e. coherent_dma=0 && cca_seen=1),
>> -        * There are two cases:
>> -        * case 1. Do not support and disable DMA.
>> -        * case 2. Support but rely on arch-specific cache maintenance for
>> -        *         non-coherence DMA operations.
>> -        * Currently, we implement case 1 above.
>> -        *
>> -        * For the case when _CCA is missing (i.e. cca_seen=0) and
>> -        * platform specifies ACPI_CCA_REQUIRED, we do not support DMA,
>> -        * and fallback to arch-specific default handling.
>> -        *
>> -        * See acpi_init_coherency() for more info.
>> -        */
>>          if (adev->flags.coherent_dma) {
>>                  ret = true;
>>                  if (coherent)
>>

Actually, the reason I put the comment in the acpi_check_dma() is 
because the logic for determining the coherency is in this function, 
which is separate from the CCA parsing/detection logic.

I can probably just get rid of the inline and move the whole function 
into /driver/acpi/scan.c to make it more readable, and fix the typos.

>> commit 84cfb2213cd400fef227ec0d7829ec4e12895da9
>> Author: Bjorn Helgaas <bhelgaas@google.com>
>> Date:   Thu Aug 13 19:49:52 2015 -0500
>>
>>      ACPI / scan: Rename acpi_check_dma() to acpi_dma_is_coherent()
>>
>>      The name "acpi_check_dma()" doesn't give any much indication about what
>>      exactly it checks.  The function also returns information both as a normal
>>      return value and as the "bool *coherent" return parameter.  But "*coherent"
>>      doesn't actually give any extra information: it is unchanged when returning
>>      false and set to true when returning true.
>>
>>      Rename acpi_check_dma() to acpi_dma_is_coherent() so the callers read more
>>      naturally.  Drop the return parameter and just use the function return
>>      value.
>>
>>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This was because, at one point, we wanted to be able to differentiate 
between the case _CCA=0 and missing _CCA in ARM64, where we would 
support DMA (using arch-specific cache maintenance) if _CCA=0, and 
disable DMA when missing _CCA on ARM64.

It seems like the logic is now required (please see 
https://www.mail-archive.com/linux-usb@vger.kernel.org/msg62735.html). 
So, we would need the true/false return, and the coherent variable to be 
able to differentiate between the two cases.

Please let me know what you think.

Thanks,
Suravee

