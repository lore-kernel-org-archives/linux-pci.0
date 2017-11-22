Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V2 00/29] PCI: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:48:55 -0500
Message-Id: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Deprecate pci_get_bus_and_slot() in favor of pci_get_domain_bus_and_slot()
in order to remove domain 0 assumptions in the kernel.

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Changes since v1:
* remove include/linux/i7300_idle.h file.
* atomisp: update the commit text to include domain 0 assumption
* alpha/PCI: use pci_domain_nr(bus) in sys_nautilus.c as bus pointer is
  available
* ata: use domain number from pdev
* rts5208: remove unused rtsx_read_pci_cfg_byte() in rtsx.c
* video: fbdev: intelfb: find domain number from passed pdev
* gma500: add domain parameter to CDV_MSG_READ32, CDV_MSG_WRITE32,
MRST_MSG_READ32, MRST_MSG_WRITE32, MDFLD_MSG_READ32, MDFLD_MSG_WRITE32
extract pci_dev from struct drm_device and use pdev to find the domain
number.
* i915: extract the domain number from drm_device.
* nouveau: try to use the domain number where available.
* PCI/quirks: use the domain number from pdev
* video: fbdev: riva: Change the function signature for CalcStateExt and
RivaGetConfig to pass in struct pci_dev in addition to RIVA_HW_INST so that
code inside the riva_hw.c can also calculate domain number and pass it to
pci_get_domain_bus_and_slot().
* video: fbdev: nvidia: struct nvidia_par has a pointer to struct pci_dev.
Use the pci_dev member to extract the domain information and pass it
to pci_get_domain_bus_and_slot() function.

v1:
https://www.spinics.net/lists/linux-pci/msg66616.html

Sinan Kaya (29):
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
  i7300_idle: remove unused file
  PCI: remove pci_get_bus_and_slot() function

 arch/alpha/kernel/pci.c                            |  2 +-
 arch/alpha/kernel/sys_nautilus.c                   |  2 +-
 arch/powerpc/kernel/pci_32.c                       |  3 +-
 arch/powerpc/platforms/powermac/feature.c          |  2 +-
 arch/powerpc/sysdev/mv64x60_pci.c                  |  4 +-
 arch/x86/pci/irq.c                                 |  3 +-
 drivers/ata/pata_ali.c                             |  3 +-
 drivers/char/agp/nvidia-agp.c                      | 12 +++-
 drivers/char/agp/sworks-agp.c                      |  3 +-
 drivers/firmware/edd.c                             |  8 +--
 drivers/firmware/iscsi_ibft.c                      |  5 +-
 drivers/gpu/drm/gma500/cdv_device.c                | 16 +++--
 drivers/gpu/drm/gma500/gma_device.c                |  3 +-
 drivers/gpu/drm/gma500/mid_bios.c                  | 11 ++-
 drivers/gpu/drm/gma500/psb_drv.c                   | 10 ++-
 drivers/gpu/drm/gma500/psb_drv.h                   | 18 ++---
 drivers/gpu/drm/i915/i915_drv.c                    |  5 +-
 drivers/gpu/drm/nouveau/dispnv04/arb.c             |  4 +-
 drivers/gpu/drm/nouveau/dispnv04/hw.c              | 10 ++-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c   | 10 ++-
 drivers/ide/sl82c105.c                             |  5 +-
 drivers/iommu/amd_iommu.c                          |  3 +-
 drivers/iommu/amd_iommu_init.c                     |  9 +--
 drivers/iommu/amd_iommu_v2.c                       |  3 +-
 drivers/macintosh/via-pmu.c                        |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c  | 10 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.h  |  1 +
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   |  6 +-
 drivers/pci/hotplug/cpqphp_pci.c                   | 18 +++--
 drivers/pci/hotplug/ibmphp_core.c                  |  7 +-
 drivers/pci/quirks.c                               |  3 +-
 drivers/pci/syscall.c                              |  4 +-
 drivers/pci/xen-pcifront.c                         |  3 +-
 drivers/sbus/char/openprom.c                       |  5 +-
 .../media/atomisp/pci/atomisp2/atomisp_v4l2.c      |  2 +-
 .../platform/intel-mid/intel_mid_pcihelpers.c      |  2 +-
 drivers/staging/rts5208/rtsx.c                     | 17 -----
 drivers/staging/rts5208/rtsx.h                     |  2 -
 drivers/video/backlight/apple_bl.c                 |  2 +-
 drivers/video/fbdev/intelfb/intelfbhw.c            |  4 +-
 drivers/video/fbdev/nvidia/nv_hw.c                 | 11 +--
 drivers/video/fbdev/nvidia/nv_setup.c              |  3 +-
 drivers/video/fbdev/riva/fbdev.c                   |  2 +-
 drivers/video/fbdev/riva/nv_driver.c               |  7 +-
 drivers/video/fbdev/riva/riva_hw.c                 | 20 ++++--
 drivers/video/fbdev/riva/riva_hw.h                 |  3 +-
 include/linux/i7300_idle.h                         | 84 ----------------------
 include/linux/pci.h                                |  8 ---
 49 files changed, 179 insertions(+), 204 deletions(-)
 delete mode 100644 include/linux/i7300_idle.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
