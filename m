Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0077.outbound.protection.outlook.com ([104.47.33.77]:5138
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751170AbdH1NK1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Aug 2017 09:10:27 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "Tian, Kevin" <kevin.tian@intel.com>,
        valmiki <valmikibow@gmail.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Lan, Tianyu" <tianyu.lan@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: Support SVM without PASID
Date: Mon, 28 Aug 2017 13:10:25 +0000
Message-ID: <BLUPR0201MB15051529B1A13F03B4CE7342A59E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
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
 <9b8611ca-3e39-90ec-e18e-7455115b38b3@arm.com>
 <e5be8314-dd3c-703a-3d46-cd180d404627@gmail.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D190D71673@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D71673@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: RE: Support SVM without PASID
>=20
> > From: valmiki [mailto:valmikibow@gmail.com]
> > Sent: Saturday, August 12, 2017 8:11 PM
> >
> > On 8/7/2017 4:01 PM, Jean-Philippe Brucker wrote:
> > > On 05/08/17 06:14, valmiki wrote:
> > > [...]
> > >> Hi Jean, Thanks a lot, now i understood the flow. From vfio kernel
> > >> documentation we fill vaddr and iova in struct
> > vfio_iommu_type1_dma_map
> > >> and pass them to VFIO. But if we use dynamic allocation in
> > >> application (say malloc), do we need to use dma API to get iova and
> > >> then call VFIO_IOMMU_MAP ioctl ?
> > >> If application needs multiple such dynamic allocations, then it
> > >> need to allocate large chunk and program it via VFIO_IOMMU_MAP
> > >> ioctl and
> > then
> > >> manage rest allocations requirements from this buffer ?
> > >
> > > Yes, without SVM, the application allocates large buffers, allocates
> > > IOVAs itself, and maps them with VFIO_IOMMU_MAP. Userspace doesn't
> > > rely
> > on the
> > > DMA API at all, it manages IOVAs as it wants. Sizes passed to
> > > VFIO_IOMMU_MAP have to be multiples of the MMU or IOMMU page
> > granularity
> > > (that is at least 4kB), and both iova and vaddr have to be aligned
> > > on that granularity as well. So malloc isn't really suitable in this
> > > case, you'll need mmap. The application can then implement a small
> > > allocator to
> > manage
> > > the DMA pool created with VFIO_IOMMU_MAP.
> >
> > Thanks Jean, I have a confusion allocate IOVA's in userspace means,
> > how can user application decide IOVA address, can user application
> > pick any random IOVA address ?
> >
>=20
> yes, any address. In this mode the whole IOVA address space is owned by
> application, which just needs to use VFIO_IOMMU_MAP to setup
> IOVA->PA mapping in IOMMU (As Jean pointed out, input paramters
> are iova and vaddr. VFIO will figure out pa corresponding to vaddr).
>=20
Hi Kevin, I have a doubt in this case, what if someone assigns mmap returne=
d virtual address as iova address, then=20
EP will assume it is generating request on IOVA but in reality we are using=
 application allocated virtual address, then
it looks like we are working with application virtual address directly with=
out PASID. Is this valid ?

Regards,
Bharat
