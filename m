Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
To: Will Deacon <will.deacon@arm.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170103184444.GP6986@arm.com>
Message-ID: <ead2ff8d-fbd3-3109-51e2-41937e9c944d@cogentembedded.com>
Date: Tue, 3 Jan 2017 22:01:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170103184444.GP6986@arm.com>
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

>> It is possible that PCI device supports 64-bit DMA addressing, and thus
>> it's driver sets device's dma_mask to DMA_BIT_MASK(64), however PCI host
>> bridge has limitations on inbound transactions addressing. Example of
>> such setup is NVME SSD device connected to RCAR PCIe controller.
>>
>> Previously there was attempt to handle this via bus notifier: after
>> driver is attached to PCI device, bridge driver gets notifier callback,
>> and resets dma_mask from there. However, this is racy: PCI device driver
>> could already allocate buffers and/or start i/o in probe routine.
>> In NVME case, i/o is started in workqueue context, and this race gives
>> "sometimes works, sometimes not" effect.
>>
>> Proper solution should make driver's dma_set_mask() call to fail if host
>> bridge can't support mask being set.
>>
>> This patch makes __swiotlb_dma_supported() to check mask being set for
>> PCI device against dma_mask of struct device corresponding to PCI host
>> bridge (one with name "pciXXXX:YY"), if that dma_mask is set.
>>
>> This is the least destructive approach: currently dma_mask of that device
>> object is not used anyhow, thus all existing setups will work as before,
>> and modification is required only in actually affected components -
>> driver of particular PCI host bridge, and dma_map_ops of particular
>> platform.
>>
>> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>> ---
>>  arch/arm64/mm/dma-mapping.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>> index 290a84f..49645277 100644
>> --- a/arch/arm64/mm/dma-mapping.c
>> +++ b/arch/arm64/mm/dma-mapping.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/dma-contiguous.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/swiotlb.h>
>> +#include <linux/pci.h>
>>  
>>  #include <asm/cacheflush.h>
>>  
>> @@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>>  
>>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>>  {
>> +#ifdef CONFIG_PCI
>> +	if (dev_is_pci(hwdev)) {
>> +		struct pci_dev *pdev = to_pci_dev(hwdev);
>> +		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
>> +
>> +		if (br->dev.dma_mask && (*br->dev.dma_mask) &&
>> +				(mask & (*br->dev.dma_mask)) != mask)
>> +			return 0;
>> +	}
>> +#endif
> 
> Hmm, but this makes it look like the problem is both arm64 and swiotlb
> specific, when in reality it's not. Perhaps another hack you could try
> would be to register a PCI bus notifier in the host bridge looking for
> BUS_NOTIFY_BIND_DRIVER, then you could proxy the DMA ops for each child
> device before the driver has probed, but adding a dma_set_mask callback
> to limit the mask to what you need?

This is what Renesas BSP tries to do and it does not work.

BUS_NOTIFY_BIND_DRIVER arrives after driver's probe routine exits, but
i/o can be started before that.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
