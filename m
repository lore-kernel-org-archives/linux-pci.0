Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbdACSoq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Jan 2017 13:44:46 -0500
Date: Tue, 3 Jan 2017 18:44:44 +0000
From: Will Deacon <will.deacon@arm.com>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        artemi.ivanov@cogentembedded.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dma_mapping: allow PCI host driver to limit
 DMA mask
Message-ID: <20170103184444.GP6986@arm.com>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 29, 2016 at 11:45:03PM +0300, Nikita Yushchenko wrote:
> It is possible that PCI device supports 64-bit DMA addressing, and thus
> it's driver sets device's dma_mask to DMA_BIT_MASK(64), however PCI host
> bridge has limitations on inbound transactions addressing. Example of
> such setup is NVME SSD device connected to RCAR PCIe controller.
> 
> Previously there was attempt to handle this via bus notifier: after
> driver is attached to PCI device, bridge driver gets notifier callback,
> and resets dma_mask from there. However, this is racy: PCI device driver
> could already allocate buffers and/or start i/o in probe routine.
> In NVME case, i/o is started in workqueue context, and this race gives
> "sometimes works, sometimes not" effect.
> 
> Proper solution should make driver's dma_set_mask() call to fail if host
> bridge can't support mask being set.
> 
> This patch makes __swiotlb_dma_supported() to check mask being set for
> PCI device against dma_mask of struct device corresponding to PCI host
> bridge (one with name "pciXXXX:YY"), if that dma_mask is set.
> 
> This is the least destructive approach: currently dma_mask of that device
> object is not used anyhow, thus all existing setups will work as before,
> and modification is required only in actually affected components -
> driver of particular PCI host bridge, and dma_map_ops of particular
> platform.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 290a84f..49645277 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -28,6 +28,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/vmalloc.h>
>  #include <linux/swiotlb.h>
> +#include <linux/pci.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -347,6 +348,16 @@ static int __swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  
>  static int __swiotlb_dma_supported(struct device *hwdev, u64 mask)
>  {
> +#ifdef CONFIG_PCI
> +	if (dev_is_pci(hwdev)) {
> +		struct pci_dev *pdev = to_pci_dev(hwdev);
> +		struct pci_host_bridge *br = pci_find_host_bridge(pdev->bus);
> +
> +		if (br->dev.dma_mask && (*br->dev.dma_mask) &&
> +				(mask & (*br->dev.dma_mask)) != mask)
> +			return 0;
> +	}
> +#endif

Hmm, but this makes it look like the problem is both arm64 and swiotlb
specific, when in reality it's not. Perhaps another hack you could try
would be to register a PCI bus notifier in the host bridge looking for
BUS_NOTIFY_BIND_DRIVER, then you could proxy the DMA ops for each child
device before the driver has probed, but adding a dma_set_mask callback
to limit the mask to what you need?

I agree that it would be better if dma_set_mask handled all of this
transparently, but it's all based on the underlying ops rather than the
bus type.

Will
