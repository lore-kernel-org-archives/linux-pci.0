Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
Subject: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Fri,  6 Oct 2017 14:31:27 +0100
Message-Id: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com,
 catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, rfranz@cavium.com, lenb@kernel.org,
 jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org,
 thunder.leizhen@huawei.com, bhelgaas@google.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, robdclark@gmail.com,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 nwatters@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Following discussions at plumbers and elsewhere, it seems like we need to
unify some of the Shared Virtual Memory (SVM) code, in order to define
clear semantics for the SVM API.

My previous RFC [1] was centered on the SMMUv3, but some of this code will
need to be reused by the SMMUv2 and virtio-iommu drivers. This second
proposal focuses on abstracting a little more into the core IOMMU API, and
also trying to find common ground for all SVM-capable IOMMUs.

SVM is, in the context of the IOMMU, sharing page tables between a process
and a device. Traditionally it requires IO Page Fault and Process Address
Space ID capabilities in device and IOMMU.

* A device driver can bind a process to a device, with iommu_process_bind.
  Internally we hold on to the mm and get notified of its activity with an
  mmu_notifier. The bond is removed by exit_mm, by a call to
  iommu_process_unbind or iommu_detach_device.

* iommu_process_bind returns a 20-bit PASID (PCI terminology) to the
  device driver, which programs it into the device to access the process
  address space.

* The device and the IOMMU support recoverable page faults. This can be
  either ATS+PRI for PCI, or platform-specific mechanisms such as Stall
  for SMMU.

Ideally systems wanting to use SVM have to support these three features,
but in practice we'll see implementations supporting just a subset of
them, especially in validation environments. So even if this particular
patchset assumes all three capabilities, it should also be possible to
support PASID without IOPF (by pinning everything, see non-system SVM in
OpenCL), or IOPF without PASID (sharing the single device address space
with a process, could be useful for DPDK+VFIO).

Implementing both these cases would enable PT sharing alone. Some people
would also like IOPF alone without SVM (covered by this series) or process
management without shared PT (not covered). Using these features
individually is also important for testing, as SVM is in its infancy and
providing easy ways to test is essential to reduce the number of quirks
down the line.

  Process management
  ==================

The first part of this series introduces boilerplate code for managing
PASIDs and processes bound to devices. It's something any IOMMU driver
that wants to support bind/unbind will have to do, and it is difficult to
get right.

Patches
1: iommu_process and PASID allocation, attach and release
2: process_exit callback for device drivers
3: iommu_process search by PASID
4: track process changes with an MMU notifiers
5: bind and unbind operations

My proposal uses the following model:

* The PASID space is system-wide. This means that a Linux process will
  have a single PASID. I introduce the iommu_process structure and a
  global IDR to manage this.

* An iommu_process can be bound to multiple domains, and a domain can have
  multiple iommu_process.

* IOMMU groups share same PASID table. IOMMU groups are a convenient way
  to cover various hardware weaknesses that prevent a group of device to
  be isolated by the IOMMU (untrusted bridge, for instance). It's foolish
  to assume that all PASID implementations will perfectly isolate devices
  within a bus and functions within a device, so let's assume all devices
  within an IOMMU group have to share PASID traffic as well. In general
  there will be a single device per group.

* It's up to the driver implementation to decide where to implement the
  PASID tables. For SMMU it's more convenient to have a single PASID table
  per domain. And I think the model fits better with the existing IOMMU
  API: IOVA traffic is shared by all devices in a domain, so should PASID
  traffic.

  This isn't a hard requirement though, an implementation can still have a
  PASID table for each device.

  Fault handling
  ==============

The second part adds a few helpers for distributing recoverable and
unrecoverable faults to other parts of the kernel:

* to the mm subsystem, when process page tables are shared with a device,
* to VFIO allowing it to forward translation faults to guests, and let
  them to recover from it,
* to device drivers that need to do something a bit more complex than just
  displaying a fault on dmesg.

You'll notice that this overlaps the work carried out by Jacob Pan for
vSVM fault reporting (published a few hours ago! [2]), which goes in the
same direction. For iommu_fault definition and handler registration it's
probably best to go with his more complete patchset, but I needed some
code to present the full solution and a way to describe both PRI and stall
data.

Patches
6: a new fault handler registration for device drivers (see also [2])
7: report faults to device drivers or add them to a workqueue (ditto)
8: call handle_mm_fault for recoverable faults
9: allow device driver to register blocking handlers

For the moment the interactions between process and fault queue are the
following. Hopefully it should be sufficient.

* When unbinding a process, the fault queue has to be flushed to ensure
  that no old fault will hit a future process that obtains the same PASID.

* When handling a fault, find a process by PASID and handle the fault on
  its mm. The process structure is refcounted, so releasing it in the
  fault handler might free the process.

Patch 10 adds a VFIO interface for binding a device owned by a userspace
driver to processes. I didn't add capability detection now, leaving that
discussion for later (also needed by vSVM).

  ARM SMMUv3 support
  ==================

The third part adds an example user, the SMMUv3 driver. A lot of
preparatory work is still needed to support these features, I only
extracted a small part of the previous series to make it common.

If you don't care about SMMU I advise to look at patches 21, which uses
the new process management interface. Patches 27, 29 and 35 use the new
fault queue for PRI and Stall.

Patches:
11:     track domain-master links (for ATS and CD invalidation)
12-13   add stall and PASID properties to the device tree
     -> New.
14-15:  add SSID support to the SMMU
     -> Now initializes the CD tables from the value found in DT.
16-20:  share ASID and page tables part 1
21:     implement iommu-process operations
     -> New.
22-26:  share ASID and page tables part 2
27:     use the new fault queue
     -> New.
28:     find masters by SID
     -> New.
29:     add stall support
     -> New.
30-36:  add PCI ATS, PRI and PASID
     -> Now uses mostly core code

This series is available on my svm/rfc2 branch [3]. It is based on v4.14
with Yisheng's stall fix [4]. Patch 8 also requires mmput_async which
should be added back soon enough [5]. Updates and fixes will go on
branch svm/current until next version.

Hoping this helps,
Jean

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-February/020599.html
[2] https://patchwork.kernel.org/patch/9988089/
[3] git://linux-arm.org/linux-jpb svm/rfc2
[4] https://patchwork.kernel.org/patch/9963863/
[5] https://patchwork.kernel.org/patch/9952257/

Jean-Philippe Brucker (36):
  iommu: Keep track of processes and PASIDs
  iommu: Add a process_exit callback for device drivers
  iommu/process: Add public function to search for a process
  iommu/process: Track process changes with an mmu_notifier
  iommu/process: Bind and unbind process to and from devices
  iommu: Extend fault reporting
  iommu: Add a fault handler
  iommu/fault: Handle mm faults
  iommu/fault: Allow blocking fault handlers
  vfio: Add support for Shared Virtual Memory
  iommu/arm-smmu-v3: Link domains and devices
  dt-bindings: document stall and PASID properties for IOMMU masters
  iommu/of: Add stall and pasid properties to iommu_fwspec
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Support broadcast TLB maintenance
  iommu/arm-smmu-v3: Add SVM feature checking
  arm64: mm: Pin down ASIDs for sharing contexts with devices
  iommu/arm-smmu-v3: Track ASID state
  iommu/arm-smmu-v3: Implement process operations
  iommu/io-pgtable-arm: Factor out ARM LPAE register defines
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Steal private ASID from a domain
  iommu/arm-smmu-v3: Use shared ASID set
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
  iommu/arm-smmu-v3: Register fault workqueue
  iommu/arm-smmu-v3: Maintain a SID->device structure
  iommu/arm-smmu-v3: Add stall support for platform devices
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Hook ATC invalidation to process ops
  iommu/arm-smmu-v3: Disable tagged pointers
  PCI: Make "PRG Response PASID Required" handling common
  iommu/arm-smmu-v3: Add support for PRI
  iommu/arm-smmu-v3: Add support for PCI PASID

 Documentation/devicetree/bindings/iommu/iommu.txt |   24 +
 MAINTAINERS                                       |    1 +
 arch/arm64/include/asm/mmu.h                      |    1 +
 arch/arm64/include/asm/mmu_context.h              |   11 +-
 arch/arm64/mm/context.c                           |   80 +-
 drivers/acpi/arm64/iort.c                         |   11 +
 drivers/iommu/Kconfig                             |   19 +
 drivers/iommu/Makefile                            |    2 +
 drivers/iommu/amd_iommu.c                         |   19 +-
 drivers/iommu/arm-smmu-v3.c                       | 1990 ++++++++++++++++++---
 drivers/iommu/io-pgfault.c                        |  421 +++++
 drivers/iommu/io-pgtable-arm.c                    |   48 +-
 drivers/iommu/io-pgtable-arm.h                    |   67 +
 drivers/iommu/iommu-process.c                     |  604 +++++++
 drivers/iommu/iommu.c                             |  113 ++
 drivers/iommu/of_iommu.c                          |   10 +
 drivers/pci/ats.c                                 |   17 +
 drivers/vfio/vfio_iommu_type1.c                   |  243 ++-
 include/linux/iommu.h                             |  254 ++-
 include/linux/pci-ats.h                           |    8 +
 include/uapi/linux/pci_regs.h                     |    1 +
 include/uapi/linux/vfio.h                         |   69 +
 22 files changed, 3690 insertions(+), 323 deletions(-)
 create mode 100644 drivers/iommu/io-pgfault.c
 create mode 100644 drivers/iommu/io-pgtable-arm.h
 create mode 100644 drivers/iommu/iommu-process.c

-- 
2.13.3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
