Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbdECJyU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 May 2017 05:54:20 -0400
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
 deferred probing or error
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Sricharan R <sricharan@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
 <1486136933-20328-8-git-send-email-sricharan@codeaurora.org>
 <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
Cc: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        tn@semihalf.com, Hanjun Guo <hanjun.guo@linaro.org>,
        okaya@codeaurora.org, Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <2bfd11dc-9f94-2b69-7b03-c640e53155e1@arm.com>
Date: Wed, 3 May 2017 10:54:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV05uCcVss+V1E+_OQYosJO6P95rU1WynV-G08-iHJnyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Geert,

On 02/05/17 19:35, Geert Uytterhoeven wrote:
> Hi Sricharan,
> 
> On Fri, Feb 3, 2017 at 4:48 PM, Sricharan R <sricharan@codeaurora.org> wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Failures to look up an IOMMU when parsing the DT iommus property need to
>> be handled separately from the .of_xlate() failures to support deferred
>> probing.
>>
>> The lack of a registered IOMMU can be caused by the lack of a driver for
>> the IOMMU, the IOMMU device probe not having been performed yet, having
>> been deferred, or having failed.
>>
>> The first case occurs when the device tree describes the bus master and
>> IOMMU topology correctly but no device driver exists for the IOMMU yet
>> or the device driver has not been compiled in. Return NULL, the caller
>> will configure the device without an IOMMU.
>>
>> The second and third cases are handled by deferring the probe of the bus
>> master device which will eventually get reprobed after the IOMMU.
>>
>> The last case is currently handled by deferring the probe of the bus
>> master device as well. A mechanism to either configure the bus master
>> device without an IOMMU or to fail the bus master device probe depending
>> on whether the IOMMU is optional or mandatory would be a good
>> enhancement.
>>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Laurent Pichart <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> 
> This patch broke Renesas R-Car Gen3 platforms in renesas-drivers.
> As the IOMMU nodes in DT are not yet enabled, all devices having iommus
> properties in DT now fail to probe.

How exactly do they fail to probe? Per d7b0558230e4, if there are no ops
registered then they should merely defer until we reach the point of
giving up and ignoring the IOMMU. Is it just that you have no other
late-probing drivers or post-init module loads to kick the deferred
queue after that point? I did try to find a way to explicitly kick it
from a suitably late initcall, but there didn't seem to be any obvious
public interface - anyone have any suggestions?

I think that's more of a general problem with the probe deferral
mechanism itself (I've seen the same thing happen with some of the
CoreSight stuff on Juno due to the number of inter-component
dependencies) rather than any specific fault of this series.

Robin.

> This can be fixed by either:
>   - Disabling CONFIG_IPMMU_VMSA, or
>   - Reverting commit 7b07cbefb68d486f (but keeping "int ret = 0;").
> 
> Note that this was a bit hard to investigate, as R-Car Gen3 support wasn't
> upstreamed yet, so bisection pointed to a merge commit.
> 
>> ---
>>  [*] Fixed minor comment from Bjorn for removing the pci.h header inclusion
>>      in of_iommu.c
>>
>>  drivers/base/dma-mapping.c | 5 +++--
>>  drivers/iommu/of_iommu.c   | 4 ++--
>>  drivers/of/device.c        | 7 ++++++-
>>  include/linux/of_device.h  | 9 ++++++---
>>  4 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
>> index 449b948..82bd45c 100644
>> --- a/drivers/base/dma-mapping.c
>> +++ b/drivers/base/dma-mapping.c
>> @@ -353,6 +353,7 @@ int dma_configure(struct device *dev)
>>  {
>>         struct device *bridge = NULL, *dma_dev = dev;
>>         enum dev_dma_attr attr;
>> +       int ret = 0;
>>
>>         if (dev_is_pci(dev)) {
>>                 bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>> @@ -363,7 +364,7 @@ int dma_configure(struct device *dev)
>>         }
>>
>>         if (dma_dev->of_node) {
>> -               of_dma_configure(dev, dma_dev->of_node);
>> +               ret = of_dma_configure(dev, dma_dev->of_node);
>>         } else if (has_acpi_companion(dma_dev)) {
>>                 attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev->fwnode));
>>                 if (attr != DEV_DMA_NOT_SUPPORTED)
>> @@ -373,7 +374,7 @@ int dma_configure(struct device *dev)
>>         if (bridge)
>>                 pci_put_host_bridge_device(bridge);
>>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  void dma_deconfigure(struct device *dev)
>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>> index 1f92d98..2d04663 100644
>> --- a/drivers/iommu/of_iommu.c
>> +++ b/drivers/iommu/of_iommu.c
>> @@ -236,7 +236,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>                         ops = ERR_PTR(err);
>>         }
>>
>> -       return IS_ERR(ops) ? NULL : ops;
>> +       return ops;
>>  }
>>
>>  static int __init of_iommu_init(void)
>> @@ -247,7 +247,7 @@ static int __init of_iommu_init(void)
>>         for_each_matching_node_and_match(np, matches, &match) {
>>                 const of_iommu_init_fn init_fn = match->data;
>>
>> -               if (init_fn(np))
>> +               if (init_fn && init_fn(np))
>>                         pr_err("Failed to initialise IOMMU %s\n",
>>                                 of_node_full_name(np));
>>         }
>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>> index c17c19d..ba51ca6 100644
>> --- a/drivers/of/device.c
>> +++ b/drivers/of/device.c
>> @@ -82,7 +82,7 @@ int of_device_add(struct platform_device *ofdev)
>>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>>   * to fix up DMA configuration.
>>   */
>> -void of_dma_configure(struct device *dev, struct device_node *np)
>> +int of_dma_configure(struct device *dev, struct device_node *np)
>>  {
>>         u64 dma_addr, paddr, size;
>>         int ret;
>> @@ -129,10 +129,15 @@ void of_dma_configure(struct device *dev, struct device_node *np)
>>                 coherent ? " " : " not ");
>>
>>         iommu = of_iommu_configure(dev, np);
>> +       if (IS_ERR(iommu))
>> +               return PTR_ERR(iommu);
>> +
>>         dev_dbg(dev, "device is%sbehind an iommu\n",
>>                 iommu ? " " : " not ");
>>
>>         arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
>> +
>> +       return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(of_dma_configure);
>>
>> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
>> index 3cb2288..9499861 100644
>> --- a/include/linux/of_device.h
>> +++ b/include/linux/of_device.h
>> @@ -56,7 +56,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>>         return of_node_get(cpu_dev->of_node);
>>  }
>>
>> -void of_dma_configure(struct device *dev, struct device_node *np);
>> +int of_dma_configure(struct device *dev, struct device_node *np);
>>  void of_dma_deconfigure(struct device *dev);
>>  #else /* CONFIG_OF */
>>
>> @@ -105,8 +105,11 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
>>  {
>>         return NULL;
>>  }
>> -static inline void of_dma_configure(struct device *dev, struct device_node *np)
>> -{}
>> +
>> +static inline int of_dma_configure(struct device *dev, struct device_node *np)
>> +{
>> +       return 0;
>> +}
>>  static inline void of_dma_deconfigure(struct device *dev)
>>  {}
>>  #endif /* CONFIG_OF */
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
