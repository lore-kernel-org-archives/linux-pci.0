Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
        lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc: sricharan@codeaurora.org
Subject: [PATCH V7 00/11] IOMMU probe deferral support
Date: Mon, 23 Jan 2017 21:48:02 +0530
Message-Id: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series calls the dma ops configuration for the devices
at a generic place so that it works for all busses.
The dma_configure_ops for a device is now called during
the device_attach callback just before the probe of the
bus/driver is called. Similarly dma_deconfigure is called during
device/driver_detach path.

pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
       |                         |
pci_bus_add_device     (device_add/driver_register)
       |                         |
device_attach           device_initial_probe
       |                         |
__device_attach_driver    __device_attach_driver
       |
driver_probe_device
       |
really_probe
       |
dma_configure

Similarly on the device/driver_unregister path __device_release_driver is
called which inturn calls dma_deconfigure.

Took the reworked patches [2] from Robin's branch and
rebased on top of Lorenzo's ACPI IORT ARM support series [3].

* Tested with platform and pci devices for probe deferral
  and reprobe on arm64 based platform.
* Need help for testing with ACPI.

Previous post of this series [6]. 

 [V7]
     * Updated the subject and commit log for patch #6 as per
       comments from Lorenzo. No functional changes.

 [V6]
     * Fixed a bug in dma_configure function pointed out by
       Robin.
     * Reordered the patches as per comments from Robin and
       Lorenzo.
     * Added Tags.

 [V5]
     * Reworked the pci configuration code hanging outside and
       pushed it to dma_configure as in PATCH#5,6,7.
       Also added a couple of patches that Lorenzo provided for
       correcting the Probe deferring mechanism in case of
       ACPI devices from here [5].

 [V4]
     * Took the reworked patches [2] from Robin's branch and
       rebased on top of Lorenzo's ACPI IORT ARM support series [3].

     * Added the patches for moving the dma ops configuration of
       acpi based devices to probe time as well.
 [V3]
     * Removed the patch to split dma_masks/dma_ops configuration
       separately based on review comments that both masks and ops are
       required only during the device probe time.

     * Reworked the series based on Generic DT bindings series.

     * Added call to iommu's remove_device in the cleanup path for arm and
       arm64.

     * Removed the notifier trick in arm64 to handle early device
       registration.

     * Added reset of dma_ops in cleanup path for arm based on comments.

     * Fixed the pci_iommu_configure path and tested with PCI device as
       well.
 
     * Fixed a bug to return the correct iommu_ops from patch 7 [4] in
       last post.

     * Fixed few other cosmetic comments.
  
 [V2]
     * Updated the Initial post to call dma_configure/deconfigure from
       generic code
 
     * Added iommu add_device callback from of_iommu_configure path

 [V1]
     * Initial post from Laurent Pinchart [1]

[1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html
[2] http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/defer
[3] https://lkml.org/lkml/2016/11/21/141
[4] https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg13940.html
[5] git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git iommu/probe-deferral
[6] https://www.spinics.net/lists/arm-kernel/msg556546.html

Laurent Pinchart (3):
  of: dma: Move range size workaround to of_dma_get_range()
  of: dma: Make of_dma_deconfigure() public
  iommu: of: Handle IOMMU lookup failure with deferred probing or error

Lorenzo Pieralisi (2):
  ACPI/IORT: Add function to check SMMUs drivers presence
  ACPI/IORT: Remove linker section for IORT entries probing

Robin Murphy (3):
  iommu/of: Refactor of_iommu_configure() for error handling
  iommu/of: Prepare for deferred IOMMU configuration
  iommu/arm-smmu: Clean up early-probing workarounds

Sricharan R (3):
  of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices
  drivers: acpi: Handle IOMMU lookup failure with deferred probing or
    error
  arm64: dma-mapping: Remove the notifier trick to handle early setting
    of dma_ops

 arch/arm64/mm/dma-mapping.c       | 132 ++++----------------------------------
 drivers/acpi/arm64/iort.c         |  40 +++++++++++-
 drivers/acpi/glue.c               |   5 --
 drivers/acpi/scan.c               |   7 +-
 drivers/base/dd.c                 |   9 +++
 drivers/base/dma-mapping.c        |  41 ++++++++++++
 drivers/iommu/arm-smmu-v3.c       |  46 +------------
 drivers/iommu/arm-smmu.c          |  58 +++--------------
 drivers/iommu/of_iommu.c          | 114 +++++++++++++++++++++++---------
 drivers/of/address.c              |  20 +++++-
 drivers/of/device.c               |  36 ++++++-----
 drivers/of/platform.c             |  10 +--
 drivers/pci/probe.c               |  28 --------
 include/acpi/acpi_bus.h           |   2 +-
 include/asm-generic/vmlinux.lds.h |   1 -
 include/linux/acpi.h              |   7 +-
 include/linux/acpi_iort.h         |   3 -
 include/linux/dma-mapping.h       |   3 +
 include/linux/of_device.h         |  10 ++-
 19 files changed, 252 insertions(+), 320 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

