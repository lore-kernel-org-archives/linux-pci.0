Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752766AbdHGK3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Aug 2017 06:29:38 -0400
Subject: Re: Support SVM without PASID
To: valmiki <valmikibow@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-pci@vger.kernel.org, tianyu.lan@intel.com,
        kevin.tian@intel.com, jacob.jun.pan@intel.com
References: <a30962a6-2240-9263-96cc-10da1b179fcc@gmail.com>
 <20170708140257.2de02d63@w520.home>
 <73619426-6fcc-21ce-cfd4-8c66bde63f9a@gmail.com>
 <eb132dfa-6708-5898-c2ce-ce7ab08809b1@arm.com>
 <ee41f5d9-e7fb-8f7c-4b85-87cdb951ec70@gmail.com>
 <ca0d9f94-f5e2-aaaf-2c64-0cd6ecc62754@arm.com>
 <41333a03-bf91-1152-4779-6579845609f6@gmail.com>
 <564ba70b-db95-7fe0-86bb-bb4eefcd87ec@arm.com>
 <32b6402d-40fb-d40c-32f3-1ed6b9a3185a@gmail.com>
 <c142fb8e-3618-152a-fbe3-521e6c8ff9bf@arm.com>
 <dd3a7852-cd9a-3797-9421-dff97f6d7213@gmail.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <9b8611ca-3e39-90ec-e18e-7455115b38b3@arm.com>
Date: Mon, 7 Aug 2017 11:31:38 +0100
MIME-Version: 1.0
In-Reply-To: <dd3a7852-cd9a-3797-9421-dff97f6d7213@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/08/17 06:14, valmiki wrote:
[...]
> Hi Jean, Thanks a lot, now i understood the flow. From vfio kernel
> documentation we fill vaddr and iova in struct vfio_iommu_type1_dma_map
> and pass them to VFIO. But if we use dynamic allocation in application
> (say malloc), do we need to use dma API to get iova and then call
> VFIO_IOMMU_MAP ioctl ?
> If application needs multiple such dynamic allocations, then it need to
> allocate large chunk and program it via VFIO_IOMMU_MAP ioctl and then
> manage rest allocations requirements from this buffer ?

Yes, without SVM, the application allocates large buffers, allocates IOVAs
itself, and maps them with VFIO_IOMMU_MAP. Userspace doesn't rely on the
DMA API at all, it manages IOVAs as it wants. Sizes passed to
VFIO_IOMMU_MAP have to be multiples of the MMU or IOMMU page granularity
(that is at least 4kB), and both iova and vaddr have to be aligned on that
granularity as well. So malloc isn't really suitable in this case, you'll
need mmap. The application can then implement a small allocator to manage
the DMA pool created with VFIO_IOMMU_MAP.

With SVM the application binds its address space to the device, and then
uses malloc for all DMA buffers, no need for VFIO_IOMMU_MAP.

Thanks,
Jean
