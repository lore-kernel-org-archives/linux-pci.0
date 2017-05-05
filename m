Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 2/3] iommu/pci: reserve iova for PCI masters
To: Oza Oza <oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
 <1493786795-28153-2-git-send-email-oza.oza@broadcom.com>
 <0c9a6b09-139c-df49-cf73-6a3935a6aacd@arm.com>
 <CAMSpPPdtfMMkTpi9cWn0QV2qnfBoHayQQg5cGANAswSwFoHX3w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <d063a61c-44f6-11f3-a25b-01cfb5d46172@arm.com>
Date: Fri, 5 May 2017 16:51:15 +0100
MIME-Version: 1.0
In-Reply-To: <CAMSpPPdtfMMkTpi9cWn0QV2qnfBoHayQQg5cGANAswSwFoHX3w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Oza Pawandeep <oza.pawandeep@gmail.com>,
 linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
 BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 04/05/17 19:52, Oza Oza wrote:
> On Thu, May 4, 2017 at 11:50 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 03/05/17 05:46, Oza Pawandeep wrote:
>>> this patch reserves the iova for PCI masters.
>>> ARM64 based SOCs may have scattered memory banks.
>>> such as iproc based SOC has
>>>
>>> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
>>> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
>>> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
>>> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
>>>
>>> but incoming PCI transcation addressing capability is limited
>>> by host bridge, for example if max incoming window capability
>>> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
>>>
>>> to address this problem, iommu has to avoid allocating iovas which
>>> are reserved. which inturn does not allocate iova if it falls into hole.
>>
>> I don't necessarily disagree with doing this, as we could do with facing
>> up to the issue of discontiguous DMA ranges in particular (I too have a
>> platform with this problem), but I'm still not overly keen on pulling DT
>> specifics into this layer. More than that, though, if we are going to do
>> it, then we should do it for all devices with a restrictive
>> "dma-ranges", not just PCI ones.
>>
> 
> How do you propose to do it ?
> 
> my thinking is this:
> iova_reserve_pci_windows is written specific for PCI, and I am adding there.
> 
> ideally
> struct pci_host_bridge should have new member:
> 
> struct list_head inbound_windows; /* resource_entry */
> 
> but somehow this resource have to be filled much before
> iommu_dma_init_domain happens.
> and use brdge resource directly in iova_reserve_pci_windows as it is
> already doing it for outbound memory.
> 
> this will detach the DT specifics from dma-immu layer.
> let me know how this sounds.

Please check the state of the code currently queued in Joerg's tree and
in linux-next - iommu_dma_get_resv_regions() has room for
device-agnostic stuff before the if (!dev_is_pci(dev)) check.

Furthermore, with the probe-deferral changes we end up with a common
dma_configure() routine to abstract the firmware-specifics of
of_dma_configure() vs. acpi_dma_configure(), so it would make sense to
give drivers etc. a similar interface for interrogating ranges. i.e.
some common function that abstracts the difference between parsing DT
dma-ranges vs. the ACPI _DMA object, either with a list-based get/put
model or perhaps an iterator with a user-provided callback (so users
could process in-place or create their own list as necessary). Unless of
course we go all the way to making the ranges an inherent part of the
device layer like some MIPS platforms currently do.

Robin.

>>> Bug: SOC-5216
>>> Change-Id: Icbfc99a045d730be143fef427098c937b9d46353
>>> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
>>> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40760
>>> Reviewed-by: vpx_checkpatch status <vpx_checkpatch@broadcom.com>
>>> Reviewed-by: CCXSW <ccxswbuild@broadcom.com>
>>> Tested-by: vpx_autobuild status <vpx_autobuild@broadcom.com>
>>> Tested-by: vpx_smoketest status <vpx_smoketest@broadcom.com>
>>> Tested-by: CCXSW <ccxswbuild@broadcom.com>
>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 48d36ce..08764b0 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -27,6 +27,7 @@
>>>  #include <linux/iova.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/mm.h>
>>> +#include <linux/of_pci.h>
>>>  #include <linux/pci.h>
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/vmalloc.h>
>>> @@ -171,8 +172,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>>>               struct iova_domain *iovad)
>>>  {
>>>       struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
>>> +     struct device_node *np = bridge->dev.parent->of_node;
>>>       struct resource_entry *window;
>>>       unsigned long lo, hi;
>>> +     int ret;
>>> +     dma_addr_t tmp_dma_addr = 0, dma_addr;
>>> +     LIST_HEAD(res);
>>>
>>>       resource_list_for_each_entry(window, &bridge->windows) {
>>>               if (resource_type(window->res) != IORESOURCE_MEM &&
>>> @@ -183,6 +188,36 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>>>               hi = iova_pfn(iovad, window->res->end - window->offset);
>>>               reserve_iova(iovad, lo, hi);
>>>       }
>>> +
>>> +     /* PCI inbound memory reservation. */
>>> +     ret = of_pci_get_dma_ranges(np, &res);
>>> +     if (!ret) {
>>> +             resource_list_for_each_entry(window, &res) {
>>> +                     struct resource *res_dma = window->res;
>>> +
>>> +                     dma_addr = res_dma->start - window->offset;
>>> +                     if (tmp_dma_addr > dma_addr) {
>>> +                             pr_warn("PCI: failed to reserve iovas; ranges should be sorted\n");
>>
>> I don't see anything in the DT spec about the entries having to be
>> sorted, and it's not exactly impossible to sort a list if you need it so
>> (and if I'm being really pedantic, one could still trigger this with a
>> list that *is* sorted, only by different criteria).
>>
> 
> we have to sort it the way we want then. I can make it sort then.
> thanks for the suggestion.
> 
>> Robin.
>>
>>> +                             return;
>>> +                     }
>>> +                     if (tmp_dma_addr != dma_addr) {
>>> +                             lo = iova_pfn(iovad, tmp_dma_addr);
>>> +                             hi = iova_pfn(iovad, dma_addr - 1);
>>> +                             reserve_iova(iovad, lo, hi);
>>> +                     }
>>> +                     tmp_dma_addr = window->res->end - window->offset;
>>> +             }
>>> +             /*
>>> +              * the last dma-range should honour based on the
>>> +              * 32/64-bit dma addresses.
>>> +              */
>>> +             if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
>>> +                     lo = iova_pfn(iovad, tmp_dma_addr);
>>> +                     hi = iova_pfn(iovad,
>>> +                                   DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
>>> +                     reserve_iova(iovad, lo, hi);
>>> +             }
>>> +     }
>>>  }
>>>
>>>  /**
>>>
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
