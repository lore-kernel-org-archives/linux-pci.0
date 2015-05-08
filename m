Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41332 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbEHUVo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2015 16:21:44 -0400
Date: Fri, 8 May 2015 16:21:34 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: wdavis@nvidia.com
Cc: joro@8bytes.org, jglisse@redhat.com, linux-pci@vger.kernel.org,
	iommu@lists.linux-foundation.org, jhubbard@nvidia.com,
	tripperda@nvidia.com
Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
Message-ID: <20150508202134.GB26795@l.oracle.com>
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430505138-2877-1-git-send-email-wdavis@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis@nvidia.com wrote:
> From: Will Davis <wdavis@nvidia.com>
> 
> Hi,
> 
> This patch series adds DMA APIs to map and unmap a struct resource to and from
> a PCI device's IOVA domain, and implements the AMD, Intel, and nommu versions
> of these interfaces.
> 
> This solves a long-standing problem with the existing DMA-remapping interfaces,
> which require that a struct page be given for the region to be mapped into a
> device's IOVA domain. This requirement cannot support peer device BAR ranges,
> for which no struct pages exist.
> 
> The underlying implementations of map_page and map_sg convert the struct page
> into its physical address anyway, so we just need a way to route the physical
> address of the BAR region to these implementations. The new interfaces do this
> by taking the struct resource describing a device's BAR region, from which the
> physical address is derived.
> 
> The Intel and nommu versions have been verified on a dual Intel Xeon E5405
> workstation. I'm in the process of obtaining hardware to test the AMD version
> as well. Please review.

Does it work if you boot with 'iommu=soft swiotlb=force' which will mandate
an strict usage of the DMA API?

> 
> Thanks,
> Will
> 
> Will Davis (6):
>   dma-debug: add checking for map/unmap_resource
>   DMA-API: Introduce dma_(un)map_resource
>   dma-mapping: pci: add pci_(un)map_resource
>   iommu/amd: Implement (un)map_resource
>   iommu/vt-d: implement (un)map_resource
>   x86: add pci-nommu implementation of map_resource
> 
>  arch/x86/kernel/pci-nommu.c              | 17 +++++++
>  drivers/iommu/amd_iommu.c                | 76 ++++++++++++++++++++++++++------
>  drivers/iommu/intel-iommu.c              | 18 ++++++++
>  include/asm-generic/dma-mapping-broken.h |  9 ++++
>  include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++
>  include/asm-generic/pci-dma-compat.h     | 14 ++++++
>  include/linux/dma-debug.h                | 20 +++++++++
>  include/linux/dma-mapping.h              |  7 +++
>  lib/dma-debug.c                          | 48 ++++++++++++++++++++
>  9 files changed, 230 insertions(+), 13 deletions(-)
> 
> -- 
> 2.3.7
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
