Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com,
        alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com,
        thunder.leizhen@huawei.com, xieyisheng1@huawei.com,
        xuzaibo@huawei.com, ilias.apalodimas@linaro.org,
        jonathan.cameron@huawei.com, shunyong.yang@hxt-semitech.com,
        nwatters@codeaurora.org, okaya@codeaurora.org,
        jcrouse@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        ashok.raj@intel.com, robdclark@gmail.com, christian.koenig@amd.com,
        bharatku@xilinx.com
Subject: [PATCH 00/37] Shared Virtual Addressing for the IOMMU
Date: Mon, 12 Feb 2018 18:33:15 +0000
Message-Id: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Shared Virtual Addressing (SVA) is the ability to share process address
spaces with devices. It is called "SVM" (Shared Virtual Memory) by
OpenCL and some IOMMU architectures, but since that abbreviation is
already used for AMD virtualisation in Linux (Secure Virtual Machine),
we prefer the less ambiguous "SVA".

Sharing process address spaces with devices allows to rely on core kernel
memory management for DMA, removing some complexity from application and
device drivers. After binding to a device, applications can instruct it to
perform DMA on buffers obtained with malloc.

The device, buses and the IOMMU must support the following features:

* Multiple address spaces per device, for example using the PCI PASID
  (Process Address Space ID) extension. The IOMMU driver allocates a
  PASID and the device uses it in DMA transactions.

* I/O Page Faults (IOPF), for example PCI PRI (Page Request Interface) or
  Arm SMMU stall. The core mm handles translation faults from the IOMMU.

* MMU and IOMMU implement compatible page table formats.

This series requires to support all three features. I tried to
facilitate using only a subset of them but enabling it requires more
work. Upcoming patches will enable private PASID management, which
allows device driver to use an API similar to classical DMA,
map()/unmap() on PASIDs. In the future device drivers should also be
able to use SVA without IOPF by pinning all pages, or without PASID by
sharing the single device address space with a process.

Although we don't have any performance measurement at the moment, SVA
will likely be slower than classical DMA since it relies on page faults,
whereas classical DMA pins all pages in memory. SVA mostly aims at
simplifying DMA management, but also improves security by isolating
address spaces in devices.

Intel and AMD IOMMU drivers already offer slightly differing public
functions that bind process address spaces to devices. Because they don't
go through an architecture-agnostic API, only integrated devices could
use them so far.
                                ---

The series adds an SVA API to the IOMMU core, an example implementation
(SMMUv3), and an example user (VFIO). Since last version, sent as RFCv2
in October [1], I reworked the API and fixed some bugs.

Patches 1-6 introduce the bind API and track address spaces. This
version of the patchset improves documentation, adds device_init()/
shutdown(), and per-bond device driver data. Functions available to
device drivers are:

	iommu_sva_device_init(dev, features, max_pasid)
	iommu_sva_device_shutdown(dev)
	iommu_register_mm_exit_handler(dev, handler)
	iommu_unregister_mm_exit_handler(dev)
	iommu_sva_bind_device(dev, mm, *pasid, flags, drvdata)
	iommu_sva_unbind_device(dev, pasid)

Patches 7-10 add a generic fault handler. This version reuses the
structures introduced by Jacob Pan's vSVA series [2] (with some changes
to match the most recent comments in that thread).

Patches 11-36 add complete SVA support to the SMMUv3 driver, for both
platform and PCI devices. If you don't care about SMMU I advise to only
look at patches 25, 27, 29 and 35, which use the tools introduced
earlier.

In this version, context code for SMMUv3 moved to a separate module,
behind an interface reusable by other IOMMU drivers, and easily
extensible for private PASIDs. There are complicated interactions
between private and shared contexts (they have a common ASID space), so
moving it all to a separate file also helps making sense of refs and
locks.

Finally, patch 37 adds an ioctl to VFIO providing SVA to userspace
drivers. Since last version I fixed a few bugs.

You can pull the full series based onto v4.16-rc1+fault patches at:
git://linux-arm.org/linux-jpb.git sva/v1

I tested this code on a software model implementing an SMMUv3 and a
dummy DMA devices. Any testing report would be greatly appreciated!

[1] [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
    https://www.spinics.net/lists/arm-kernel/msg609771.html
[2] [PATCH v3 00/16] IOMMU driver support for SVM virtualization
    https://www.spinics.net/lists/kernel/msg2651481.html

Jean-Philippe Brucker (37):
  iommu: Introduce Shared Virtual Addressing API
  iommu/sva: Bind process address spaces to devices
  iommu/sva: Manage process address spaces
  iommu/sva: Add a mm_exit callback for device drivers
  iommu/sva: Track mm changes with an MMU notifier
  iommu/sva: Search mm by PASID
  iommu: Add a page fault handler
  iommu/fault: Handle mm faults
  iommu/fault: Let handler return a fault response
  iommu/fault: Allow blocking fault handlers
  dt-bindings: document stall and PASID properties for IOMMU masters
  iommu/of: Add stall and pasid properties to iommu_fwspec
  arm64: mm: Pin down ASIDs for sharing mm with devices
  iommu/arm-smmu-v3: Link domains and devices
  iommu/io-pgtable-arm: Factor out ARM LPAE register defines
  iommu: Add generic PASID table library
  iommu/arm-smmu-v3: Move context descriptor code
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Seize private ASID
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Enable broadcast TLB maintenance
  iommu/arm-smmu-v3: Add SVA feature checking
  iommu/arm-smmu-v3: Implement mm operations
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Register fault workqueue
  iommu/arm-smmu-v3: Maintain a SID->device structure
  iommu/arm-smmu-v3: Add stall support for platform devices
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
  iommu/arm-smmu-v3: Disable tagged pointers
  PCI: Make "PRG Response PASID Required" handling common
  iommu/arm-smmu-v3: Add support for PRI
  iommu/arm-smmu-v3: Add support for PCI PASID
  vfio: Add support for Shared Virtual Addressing

 Documentation/devicetree/bindings/iommu/iommu.txt |   24 +
 MAINTAINERS                                       |    3 +-
 arch/arm64/include/asm/mmu.h                      |    1 +
 arch/arm64/include/asm/mmu_context.h              |   11 +-
 arch/arm64/mm/context.c                           |   87 +-
 drivers/acpi/arm64/iort.c                         |   11 +
 drivers/iommu/Kconfig                             |   42 +
 drivers/iommu/Makefile                            |    4 +
 drivers/iommu/amd_iommu.c                         |   19 +-
 drivers/iommu/arm-smmu-v3-context.c               |  728 +++++++++++
 drivers/iommu/arm-smmu-v3.c                       | 1395 ++++++++++++++++++---
 drivers/iommu/io-pgfault.c                        |  384 ++++++
 drivers/iommu/io-pgtable-arm.c                    |   48 +-
 drivers/iommu/io-pgtable-arm.h                    |   67 +
 drivers/iommu/iommu-pasid.c                       |   54 +
 drivers/iommu/iommu-pasid.h                       |  173 +++
 drivers/iommu/iommu-sva.c                         |  795 ++++++++++++
 drivers/iommu/iommu.c                             |  109 +-
 drivers/iommu/of_iommu.c                          |   12 +
 drivers/pci/ats.c                                 |   17 +
 drivers/vfio/vfio_iommu_type1.c                   |  399 ++++++
 include/linux/iommu.h                             |  217 +++-
 include/linux/pci-ats.h                           |    8 +
 include/uapi/linux/pci_regs.h                     |    1 +
 include/uapi/linux/vfio.h                         |   76 ++
 25 files changed, 4381 insertions(+), 304 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-v3-context.c
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-pasid.c
 create mode 100644 drivers/iommu/iommu-pasid.h
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.15.1

