Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: RE: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
Date: Mon, 6 Mar 2017 08:20:25 +0000
Message-ID: <A2975661238FB949B60364EF0F2C2574390186B8@shsmsx102.ccr.corp.intel.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>,
 Will Deacon <will.deacon@arm.com>, Harv
 Abdulhamid <harba@qti.qualcomm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
> bounces@lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
> Sent: Tuesday, February 28, 2017 3:54 AM
> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>; kvm@vger.kernel.org;
> Catalin Marinas <catalin.marinas@arm.com>; Sinan Kaya
> <okaya@qti.qualcomm.com>; Will Deacon <will.deacon@arm.com>;
> iommu@lists.linux-foundation.org; Harv Abdulhamid <harba@qti.qualcomm.com>;
> linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; David
> Woodhouse <dwmw2@infradead.org>; linux-arm-kernel@lists.infradead.org; Nate
> Watterson <nwatters@qti.qualcomm.com>
> Subject: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
> 
> Hi,
> 
> This series adds support for PCI ATS, PRI and PASID extensions to the
> SMMUv3 driver. In systems that support it, it is now possible for some high-end
> devices to perform DMA into process address spaces. Page tables are shared
> between MMU and SMMU; page faults from devices are recoverable and handled by
> the mm subsystem.
> 
> We propose an extension to the IOMMU API that unifies existing SVM
> implementations (AMD, Intel and ARM) in patches 22 and 24. Nothing is set in stone,
> the goal is to start discussions and find an intersection between implementations.
> 
> We also propose a VFIO interface in patches 29 and 30, that allows userspace device
> drivers to make use of SVM. It would also serve as example implementation for
> other device drivers.
> 
> Overview of the patches:
> 
> * 1 and 2 prepare the SMMUv3 structures for ATS,
> * 3 to 5 enable ATS for devices that support it.
> * 6 to 10 prepare the SMMUv3 structures for PASID and PRI. Patch 9,
>   in particular, provides details on the structure requirements.
> * 11 introduces an interface for sharing ASIDs on ARM64,
> * 12 to 17 add more infrastructure for sharing page tables,
> * 18 and 19 add minor helpers to PCI,
> * 20 enables PASID in devices that support it,

Jean, supposedly, you will introduce a PASID management mechanism in
SMMU v3 driver. Here I have a question about PASID management on ARM.
Will there be a system wide PASID table? Or there is equivalent implementation.

Thanks,
Yi L 

> * 21 enables PRI and adds device fault handler,
> * 22 and 24 draft a possible interface for SVM in the IOMMU API
> * 23 and 25-28 finalize support for SVM in SMMUv3
> * 29 and 30 draft a possible interface for SVM in VFIO.
> 
> The series is available on git://linux-arm.org/linux-jpb.git svm/rfc1 Enable
> CONFIG_PCI_PASID, CONFIG_PCI_PRI and you should be good to go.
> 
> So far, this has only been tested with a software model of an SMMUv3 and a PCIe
> DMA engine. We don't intend to get this merged until it has been tested on silicon,
> but at least the driver implementation should be mature enough. I might split next
> versions depending on what is ready and what needs more work so we can merge it
> progressively.
> 
> A lot of open questions remain:
> 
> 1. Can we declare that PASID 0 is always invalid?
> 
> 2. For this prototype, I kept the interface simple from an implementation
>    perspective. At the moment is is "bind this device to that address
>    space". For consistency with the rest of VFIO and IOMMU, I think "bind
>    this container to that address space" would be more in line with VFIO,
>    and "bind that group to that address space" more in line with IOMMU.
>    VFIO would tell the IOMMU "for all groups in this container, bind to
>    that address space".
>    This raises the question of inconsistency between device capabilities.
>    When adding a device that supports less PASID bits to a group, what do
>    we do? What if we already allocated a PASID that is out of range for
>    the new device?
> 
> 3. How do we reconcile the IOMMU fault reporting infrastructure with the
>    SVM interface?
> 
> 4. SVM is the product of two features: handling device faults, and devices
>    having multiple address spaces. What about one feature without the
>    other?
>    a. If we cannot afford to have a device fault, can we at least share a
>       pinned address space? Pinning all current memory would be done by
>       vfio, but there also need to be pinning of all future mappings.
>       (mlock isn't sufficient, still allows for minor faults.)
>    b. If the device has a single address space, can we still bind it to a
>       process? The main issue with unifying DMA and process page tables is
>       reserved regions on the device side. What do we do if, for instance,
>       and MSI frame address clashes with a process mapping? Or if a
>       process mapping exists outside of the device's DMA window?
> 
> Please find more details in the IOMMU API and VFIO patches.
> 
> Thanks,
> Jean-Philippe
> 
> Cc: Harv Abdulhamid <harba@qti.qualcomm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sinan Kaya <okaya@qti.qualcomm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Nate Watterson <nwatters@qti.qualcomm.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> 
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> 
> Jean-Philippe Brucker (30):
>   iommu/arm-smmu-v3: Link groups and devices
>   iommu/arm-smmu-v3: Link groups and domains
>   PCI: Move ATS declarations outside of CONFIG_PCI
>   iommu/arm-smmu-v3: Add support for PCI ATS
>   iommu/arm-smmu-v3: Disable tagged pointers when ATS is in use
>   iommu/arm-smmu-v3: Add support for Substream IDs
>   iommu/arm-smmu-v3: Add second level of context descriptor table
>   iommu/arm-smmu-v3: Add support for VHE
>   iommu/arm-smmu-v3: Support broadcast TLB maintenance
>   iommu/arm-smmu-v3: Add task contexts
>   arm64: mm: Pin down ASIDs for sharing contexts with devices
>   iommu/arm-smmu-v3: Keep track of process address spaces
>   iommu/io-pgtable-arm: Factor out ARM LPAE register defines
>   iommu/arm-smmu-v3: Share process page tables
>   iommu/arm-smmu-v3: Steal private ASID from a domain
>   iommu/arm-smmu-v3: Use shared ASID set
>   iommu/arm-smmu-v3: Add SVM feature checking
>   PCI: Make "PRG Response PASID Required" handling common
>   PCI: Cache PRI and PASID bits in pci_dev
>   iommu/arm-smmu-v3: Enable PCI PASID in masters
>   iommu/arm-smmu-v3: Handle device faults from PRI
>   iommu: Bind/unbind tasks to/from devices
>   iommu/arm-smmu-v3: Bind/unbind device and task
>   iommu: Specify PASID state when unbinding a task
>   iommu/arm-smmu-v3: Safe invalidation and recycling of PASIDs
>   iommu/arm-smmu-v3: Fix PRI queue overflow acknowledgement
>   iommu/arm-smmu-v3: Handle PRI queue overflow
>   iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
>     at stage 1
>   vfio: Add support for Shared Virtual Memory
>   vfio: Allow to bind foreign task
> 
>  MAINTAINERS                          |    1 +
>  arch/arm64/include/asm/mmu.h         |    1 +
>  arch/arm64/include/asm/mmu_context.h |   11 +-
>  arch/arm64/mm/context.c              |   80 +-
>  drivers/iommu/amd_iommu.c            |   19 +-
>  drivers/iommu/arm-smmu-v3.c          | 2593 ++++++++++++++++++++++++++++++++-
> -
>  drivers/iommu/io-pgtable-arm.c       |   48 +-
>  drivers/iommu/io-pgtable-arm.h       |   67 +
>  drivers/iommu/iommu.c                |  116 ++
>  drivers/pci/ats.c                    |   40 +
>  drivers/vfio/pci/vfio_pci.c          |   24 +
>  drivers/vfio/vfio.c                  |  135 ++
>  include/linux/iommu.h                |   57 +
>  include/linux/pci-ats.h              |    8 +
>  include/linux/pci.h                  |   28 +-
>  include/uapi/linux/pci_regs.h        |    1 +
>  include/uapi/linux/vfio.h            |   70 +
>  17 files changed, 3084 insertions(+), 215 deletions(-)  create mode 100644
> drivers/iommu/io-pgtable-arm.h
> 
> --
> 2.11.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
