Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753685AbdEDSUZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 May 2017 14:20:25 -0400
Subject: Re: [PATCH 2/3] iommu/pci: reserve iova for PCI masters
To: Oza Pawandeep <oza.oza@broadcom.com>
References: <1493786795-28153-1-git-send-email-oza.oza@broadcom.com>
 <1493786795-28153-2-git-send-email-oza.oza@broadcom.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.pawandeep@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0c9a6b09-139c-df49-cf73-6a3935a6aacd@arm.com>
Date: Thu, 4 May 2017 19:20:19 +0100
MIME-Version: 1.0
In-Reply-To: <1493786795-28153-2-git-send-email-oza.oza@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/17 05:46, Oza Pawandeep wrote:
> this patch reserves the iova for PCI masters.
> ARM64 based SOCs may have scattered memory banks.
> such as iproc based SOC has
> 
> <0x00000000 0x80000000 0x0 0x80000000>, /* 2G @ 2G */
> <0x00000008 0x80000000 0x3 0x80000000>, /* 14G @ 34G */
> <0x00000090 0x00000000 0x4 0x00000000>, /* 16G @ 576G */
> <0x000000a0 0x00000000 0x4 0x00000000>; /* 16G @ 640G */
> 
> but incoming PCI transcation addressing capability is limited
> by host bridge, for example if max incoming window capability
> is 512 GB, then 0x00000090 and 0x000000a0 will fall beyond it.
> 
> to address this problem, iommu has to avoid allocating iovas which
> are reserved. which inturn does not allocate iova if it falls into hole.

I don't necessarily disagree with doing this, as we could do with facing
up to the issue of discontiguous DMA ranges in particular (I too have a
platform with this problem), but I'm still not overly keen on pulling DT
specifics into this layer. More than that, though, if we are going to do
it, then we should do it for all devices with a restrictive
"dma-ranges", not just PCI ones.

> Bug: SOC-5216
> Change-Id: Icbfc99a045d730be143fef427098c937b9d46353
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-on: http://gerrit-ccxsw.broadcom.net/40760
> Reviewed-by: vpx_checkpatch status <vpx_checkpatch@broadcom.com>
> Reviewed-by: CCXSW <ccxswbuild@broadcom.com>
> Tested-by: vpx_autobuild status <vpx_autobuild@broadcom.com>
> Tested-by: vpx_smoketest status <vpx_smoketest@broadcom.com>
> Tested-by: CCXSW <ccxswbuild@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 48d36ce..08764b0 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -27,6 +27,7 @@
>  #include <linux/iova.h>
>  #include <linux/irq.h>
>  #include <linux/mm.h>
> +#include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/scatterlist.h>
>  #include <linux/vmalloc.h>
> @@ -171,8 +172,12 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  		struct iova_domain *iovad)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> +	struct device_node *np = bridge->dev.parent->of_node;
>  	struct resource_entry *window;
>  	unsigned long lo, hi;
> +	int ret;
> +	dma_addr_t tmp_dma_addr = 0, dma_addr;
> +	LIST_HEAD(res);
>  
>  	resource_list_for_each_entry(window, &bridge->windows) {
>  		if (resource_type(window->res) != IORESOURCE_MEM &&
> @@ -183,6 +188,36 @@ static void iova_reserve_pci_windows(struct pci_dev *dev,
>  		hi = iova_pfn(iovad, window->res->end - window->offset);
>  		reserve_iova(iovad, lo, hi);
>  	}
> +
> +	/* PCI inbound memory reservation. */
> +	ret = of_pci_get_dma_ranges(np, &res);
> +	if (!ret) {
> +		resource_list_for_each_entry(window, &res) {
> +			struct resource *res_dma = window->res;
> +
> +			dma_addr = res_dma->start - window->offset;
> +			if (tmp_dma_addr > dma_addr) {
> +				pr_warn("PCI: failed to reserve iovas; ranges should be sorted\n");

I don't see anything in the DT spec about the entries having to be
sorted, and it's not exactly impossible to sort a list if you need it so
(and if I'm being really pedantic, one could still trigger this with a
list that *is* sorted, only by different criteria).

Robin.

> +				return;
> +			}
> +			if (tmp_dma_addr != dma_addr) {
> +				lo = iova_pfn(iovad, tmp_dma_addr);
> +				hi = iova_pfn(iovad, dma_addr - 1);
> +				reserve_iova(iovad, lo, hi);
> +			}
> +			tmp_dma_addr = window->res->end - window->offset;
> +		}
> +		/*
> +		 * the last dma-range should honour based on the
> +		 * 32/64-bit dma addresses.
> +		 */
> +		if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
> +			lo = iova_pfn(iovad, tmp_dma_addr);
> +			hi = iova_pfn(iovad,
> +				      DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
> +			reserve_iova(iovad, lo, hi);
> +		}
> +	}
>  }
>  
>  /**
> 
