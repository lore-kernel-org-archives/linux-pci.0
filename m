Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:36194 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdKVFbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:31:21 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH 00/30] PCI: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:30:45 -0500
Message-Id: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate pci_get_bus_and_slot() in favor of
pci_get_domain_bus_and_slot() in order to remove domain 0 assumptions in
the kernel.

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Sinan Kaya (30):
  alpha/PCI: deprecate pci_get_bus_and_slot()
  powerpc/PCI: deprecate pci_get_bus_and_slot()
  x86/PCI: deprecate pci_get_bus_and_slot()
  ata: deprecate pci_get_bus_and_slot()
  agp: nvidia: deprecate pci_get_bus_and_slot()
  edd: deprecate pci_get_bus_and_slot()
  ibft: deprecate pci_get_bus_and_slot()
  drm/gma500: deprecate pci_get_bus_and_slot()
  drm/i915: deprecate pci_get_bus_and_slot()
  drm/nouveau: deprecate pci_get_bus_and_slot()
  hwmon: (coretemp) deprecate pci_get_bus_and_slot()
  Drivers: ide: deprecate pci_get_bus_and_slot()
  iommu/amd: deprecate pci_get_bus_and_slot()
  powerpc/powermac: deprecate pci_get_bus_and_slot()
  bnx2x: deprecate pci_get_bus_and_slot()
  pch_gbe: deprecate pci_get_bus_and_slot()
  PCI: cpqhp: deprecate pci_get_bus_and_slot()
  PCI: ibmphp: deprecate pci_get_bus_and_slot()
  PCI/quirks: deprecate pci_get_bus_and_slot()
  PCI/syscall: deprecate pci_get_bus_and_slot()
  xen: deprecate pci_get_bus_and_slot()
  openprom: deprecate pci_get_bus_and_slot()
  [media] atomisp: deprecate pci_get_bus_and_slot()
  staging: rts5208: deprecate pci_get_bus_and_slot()
  backlight: deprecate pci_get_bus_and_slot()
  video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
  video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
  video: fbdev: riva: deprecate pci_get_bus_and_slot()
  i7300_idle: deprecate pci_get_bus_and_slot()
  PCI: remove pci_get_bus_and_slot() function

 arch/alpha/kernel/pci.c                                |  2 +-
 arch/alpha/kernel/sys_nautilus.c                       |  2 +-
 arch/powerpc/kernel/pci_32.c                           |  3 ++-
 arch/powerpc/platforms/powermac/feature.c              |  2 +-
 arch/powerpc/sysdev/mv64x60_pci.c                      |  4 ++--
 arch/x86/pci/irq.c                                     |  3 ++-
 drivers/ata/pata_ali.c                                 |  2 +-
 drivers/char/agp/nvidia-agp.c                          | 12 +++++++++---
 drivers/char/agp/sworks-agp.c                          |  3 ++-
 drivers/firmware/edd.c                                 |  8 ++++----
 drivers/firmware/iscsi_ibft.c                          |  5 +++--
 drivers/gpu/drm/gma500/cdv_device.c                    |  4 ++--
 drivers/gpu/drm/gma500/gma_device.c                    |  2 +-
 drivers/gpu/drm/gma500/mid_bios.c                      |  8 +++++---
 drivers/gpu/drm/gma500/psb_drv.c                       |  7 +++++--
 drivers/gpu/drm/gma500/psb_drv.h                       |  8 ++++----
 drivers/gpu/drm/i915/i915_drv.c                        |  4 +++-
 drivers/gpu/drm/nouveau/dispnv04/arb.c                 |  3 ++-
 drivers/gpu/drm/nouveau/dispnv04/hw.c                  |  6 ++++--
 drivers/gpu/drm/nouveau/nouveau_drm.c                  |  3 ++-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c       |  2 +-
 drivers/hwmon/coretemp.c                               |  3 ++-
 drivers/ide/sl82c105.c                                 |  5 +++--
 drivers/iommu/amd_iommu.c                              |  3 ++-
 drivers/iommu/amd_iommu_init.c                         | 10 ++++++----
 drivers/iommu/amd_iommu_v2.c                           |  3 ++-
 drivers/macintosh/via-pmu.c                            |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c      | 10 +++++++++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h      |  1 +
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |  7 +++++--
 drivers/pci/hotplug/cpqphp_pci.c                       | 18 ++++++++++++++----
 drivers/pci/hotplug/ibmphp_core.c                      |  7 ++++---
 drivers/pci/quirks.c                                   |  2 +-
 drivers/pci/syscall.c                                  |  4 ++--
 drivers/pci/xen-pcifront.c                             |  3 ++-
 drivers/sbus/char/openprom.c                           |  5 +++--
 .../staging/media/atomisp/pci/atomisp2/atomisp_v4l2.c  |  2 +-
 .../atomisp/platform/intel-mid/intel_mid_pcihelpers.c  |  2 +-
 drivers/staging/rts5208/rtsx.c                         |  2 +-
 drivers/video/backlight/apple_bl.c                     |  2 +-
 drivers/video/fbdev/intelfb/intelfbhw.c                |  4 +++-
 drivers/video/fbdev/nvidia/nv_hw.c                     | 10 +++++-----
 drivers/video/fbdev/nvidia/nv_setup.c                  |  2 +-
 drivers/video/fbdev/riva/nv_driver.c                   |  4 ++--
 drivers/video/fbdev/riva/riva_hw.c                     |  8 ++++----
 include/linux/i7300_idle.h                             |  4 ++--
 include/linux/pci.h                                    |  8 --------
 47 files changed, 135 insertions(+), 89 deletions(-)

-- 
1.9.1
