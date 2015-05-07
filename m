Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:52471 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbbEGBui (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 21:50:38 -0400
Message-ID: <554AC48A.2030209@huawei.com>
Date: Thu, 7 May 2015 09:48:58 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, <wdavis@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <tripperda@nvidia.com>,
	<jhubbard@nvidia.com>, <jglisse@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/6] IOMMU/DMA map_resource support for peer-to-peer
References: <1430505138-2877-1-git-send-email-wdavis@nvidia.com> <20150506221818.GH24643@google.com>
In-Reply-To: <20150506221818.GH24643@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/7 6:18, Bjorn Helgaas wrote:
> [+cc Yijing, Dave J, Dave M, Alex]
> 
> On Fri, May 01, 2015 at 01:32:12PM -0500, wdavis@nvidia.com wrote:
>> From: Will Davis <wdavis@nvidia.com>
>>
>> Hi,
>>
>> This patch series adds DMA APIs to map and unmap a struct resource to and from
>> a PCI device's IOVA domain, and implements the AMD, Intel, and nommu versions
>> of these interfaces.
>>
>> This solves a long-standing problem with the existing DMA-remapping interfaces,
>> which require that a struct page be given for the region to be mapped into a
>> device's IOVA domain. This requirement cannot support peer device BAR ranges,
>> for which no struct pages exist.
>>
>> The underlying implementations of map_page and map_sg convert the struct page
>> into its physical address anyway, so we just need a way to route the physical
>> address of the BAR region to these implementations. The new interfaces do this
>> by taking the struct resource describing a device's BAR region, from which the
>> physical address is derived.
>>
>> The Intel and nommu versions have been verified on a dual Intel Xeon E5405
>> workstation. I'm in the process of obtaining hardware to test the AMD version
>> as well. Please review.
> 
> I think we currently assume there's no peer-to-peer traffic.
> 
> I don't know whether changing that will break anything, but I'm concerned
> about these:
> 
>   - PCIe MPS configuration (see pcie_bus_configure_settings()).

I think it should be ok for PCIe MPS configuration, PCIE_BUS_PEER2PEER force every
device's MPS to 128B, what its concern is the TLP payload size. In this series, it
seems to only map a iova for device bar region.


> 
>   - PCIe ACS, e.g., pci_acs_enabled().  My guess is that this one is OK,
>     but Alex would know better.
> 
>   - dma_addr_t.  Currently dma_addr_t is big enough to hold any address
>     returned from the DMA API.  That's not necessarily big enough to hold a
>     PCI bus address, e.g., a raw BAR value.
> 
>> Will Davis (6):
>>   dma-debug: add checking for map/unmap_resource
>>   DMA-API: Introduce dma_(un)map_resource
>>   dma-mapping: pci: add pci_(un)map_resource
>>   iommu/amd: Implement (un)map_resource
>>   iommu/vt-d: implement (un)map_resource
>>   x86: add pci-nommu implementation of map_resource
>>
>>  arch/x86/kernel/pci-nommu.c              | 17 +++++++
>>  drivers/iommu/amd_iommu.c                | 76 ++++++++++++++++++++++++++------
>>  drivers/iommu/intel-iommu.c              | 18 ++++++++
>>  include/asm-generic/dma-mapping-broken.h |  9 ++++
>>  include/asm-generic/dma-mapping-common.h | 34 ++++++++++++++
>>  include/asm-generic/pci-dma-compat.h     | 14 ++++++
>>  include/linux/dma-debug.h                | 20 +++++++++
>>  include/linux/dma-mapping.h              |  7 +++
>>  lib/dma-debug.c                          | 48 ++++++++++++++++++++
>>  9 files changed, 230 insertions(+), 13 deletions(-)
>>
>> -- 
>> 2.3.7
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> .
> 


-- 
Thanks!
Yijing

