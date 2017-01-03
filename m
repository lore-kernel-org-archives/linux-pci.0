Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Grygorii Strashko <grygorii.strashko@ti.com>,
 Will Deacon <will.deacon@arm.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170103184444.GP6986@arm.com>
 <ead2ff8d-fbd3-3109-51e2-41937e9c944d@cogentembedded.com>
 <9382563b-44ab-47a8-14d0-1fdaf49f8c5d@ti.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <bd587495-0c88-005f-c1b6-9ce05e20fcbc@cogentembedded.com>
Date: Tue, 3 Jan 2017 23:23:06 +0300
MIME-Version: 1.0
In-Reply-To: <9382563b-44ab-47a8-14d0-1fdaf49f8c5d@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, artemi.ivanov@cogentembedded.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

>>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>>> index 290a84f..49645277 100644
>>>> --- a/arch/arm64/mm/dma-mapping.c
>>>> +++ b/arch/arm64/mm/dma-mapping.c
>>>> @@ -28,6 +28,7 @@
>>>>  #include <linux/dma-contiguous.h>
>>>>  #include <linux/vmalloc.h>
>>>>  #include <linux/swiotlb.h>
>>>> +#include <linux/pci.h>
>>>>  
>>>>  #include <asm/cacheflush.h>
>>>>  
>>>> @@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>>>>  
>>>>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>>>>  {
>>>> +#ifdef CONFIG_PCI
>>>> +	if (dev_is_pci(hwdev)) {
>>>> +		struct pci_dev *pdev = to_pci_dev(hwdev);
>>>> +		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
>>>> +
>>>> +		if (br->dev.dma_mask && (*br->dev.dma_mask) &&
>>>> +				(mask & (*br->dev.dma_mask)) != mask)
>>>> +			return 0;
>>>> +	}
>>>> +#endif
>>>
>>> Hmm, but this makes it look like the problem is both arm64 and swiotlb
>>> specific, when in reality it's not. Perhaps another hack you could try
>>> would be to register a PCI bus notifier in the host bridge looking for
>>> BUS_NOTIFY_BIND_DRIVER, then you could proxy the DMA ops for each child
>>> device before the driver has probed, but adding a dma_set_mask callback
>>> to limit the mask to what you need?
>>
>> This is what Renesas BSP tries to do and it does not work.
>>
>> BUS_NOTIFY_BIND_DRIVER arrives after driver's probe routine exits, but
>> i/o can be started before that.
> 
> Hm. This is strange statement:
>  really_probe
>  |->driver_sysfs_add
>     |-> blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>  					     BUS_NOTIFY_BIND_DRIVER, dev);
> ...
>  |- ret = drv->probe(dev);
> ...
>  |- driver_bound(dev);
>     |- blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
> 					     BUS_NOTIFY_BOUND_DRIVER, dev);
> 
> Am I missing smth?

I misinterpreted your message, sorry.

BSP attaches to BUS_NOTIFY_BOUND_DRIVER, not to BUS_NOTIFY_BIND_DRIVER,
and simply overwrites device's dma_mask there.  You are suggesting
something completely different.

I'll check if your approach is practical.


Currently powerpc architecture has one more approach implemented, they
use pci_controller structure provided by host bridge driver, and that
has a set_dma_mask() hook. Maybe extending this beyond powerpc could be
a good idea. However, that will require changing quite a few host bridge
drivers, without any gain for most of those...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
