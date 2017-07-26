Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48470 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbdGZLfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jul 2017 07:35:07 -0400
Message-ID: <1501068839.2792.27.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on
 iommu driver initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joerg Roedel <joro@8bytes.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alex Williamson <alex.williamson@redhat.com>,
        Yongji Xie <elohimes@gmail.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        Jike Song <jike.song@intel.com>,
        Paul Mackerras <paulus@samba.org>,
        linux-pci <linux-pci@vger.kernel.org>
Date: Wed, 26 Jul 2017 21:33:59 +1000
In-Reply-To: <20170726095053.GG15833@8bytes.org>
References: <20170630052436.15212-1-aik@ozlabs.ru>
         <20170630052436.15212-5-aik@ozlabs.ru>
         <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
         <b444851a-3240-f98f-04b9-0223649ea856@ozlabs.ru>
         <20170726095053.GG15833@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2017-07-26 at 11:50 +0200, Joerg Roedel wrote:
> > 3. Create IOMMU_DOMAIN_UNMANAGED IOMMU domains for PPC64/powernv IOMMU
> > groups and only define capable() hook to report IOMMU_CAP_INTR_REMAP;
> > others already use these IOMMU domains. VFIO-PCI's mmap() hook could then
> > check the capability via iommu_capable(bus). The problems is as Robin said:
> > "iommu_capable() is a fundamentally broken and unworkable interface
> > anyway"; however it is still not clear to me why it is unworkable in this
> > particular case of isolation checking.
> 
> That one is wrong, IRQ remapping is not a property of a domain. A domain
> is an abstraction for a device address space. Attaching IRQ information
> there is just wrong.

Except it somewhat is ... an MSI is a store in the device address
space, the way MSIs are handled and/or filtered can be considered a
property of the domain. In our case, it's the exact same piece of HW
that defines domains and which MSIs they are allowed to generate.

Cheers,
Ben.
