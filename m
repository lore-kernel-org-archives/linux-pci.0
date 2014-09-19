Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Sep 2014 10:45:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [GIT PULL] PCI fixes for v3.17
Message-ID: <20140919164518.GA19374@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

These fix:

  - Boot video device detection on dual-GPU Apple systems
  - Hotplug fiascos on VGA switcheroo with radeon & nouveau drivers
  - Boot hang on Freescale i.MX6 systems
  - Excessive "no hotplug settings from platform" warnings

Bjorn



The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.17-fixes-2

for you to fetch changes up to 649ae75286793304130e747efa7d1a88daaf7e2e:

  Merge branch 'pci/vga'; commit '6a73336bde29' into for-linus (2014-09-18 23:05:06 -0600)

----------------------------------------------------------------
PCI updates for v3.17:

  Enumeration
    - Don't default exclusively to first video device (Bruno Prémont)

  PCI device hotplug
    - Remove "no hotplug settings from platform" warning (Bjorn Helgaas)
    - Add pci_ignore_hotplug() for VGA switcheroo (Bjorn Helgaas)

  Freescale i.MX6
    - Put LTSSM in "Detect" state before disabling (Lucas Stach)

----------------------------------------------------------------
Bjorn Helgaas (6):
      Merge branch 'pci/host-imx6' into for-linus
      PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device
      PCI: Remove "no hotplug settings from platform" warning
      ACPIPHP / radeon / nouveau: Remove acpi_bus_no_hotplug()
      Merge branch 'pci/hotplug-vga' into for-linus
      Merge branch 'pci/vga'; commit '6a73336bde29' into for-linus

Bruno Prémont (2):
      vgaarb: Don't default exclusively to first video device with mem+io
      vgaarb: Drop obsolete #ifndef

Lucas Stach (2):
      MAINTAINERS: Add Lucas Stach as co-maintainer for i.MX6 PCI driver
      PCI: imx6: Put LTSSM in "Detect" state before disabling it

 MAINTAINERS                                  |  2 +-
 arch/ia64/pci/fixup.c                        | 24 +--------------
 arch/x86/pci/fixup.c                         | 24 +--------------
 drivers/acpi/bus.c                           | 10 ------
 drivers/gpu/drm/nouveau/nouveau_acpi.c       | 16 ++--------
 drivers/gpu/drm/nouveau/nouveau_drm.c        |  1 +
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 16 ++--------
 drivers/gpu/drm/radeon/radeon_drv.c          |  1 +
 drivers/gpu/vga/vgaarb.c                     | 46 ++++++++++++++++++++++------
 drivers/pci/host/pci-imx6.c                  | 38 +++++++++++++++++++++++
 drivers/pci/hotplug/acpiphp_glue.c           | 16 ++++------
 drivers/pci/hotplug/pciehp_hpc.c             | 12 ++++++++
 drivers/pci/hotplug/pcihp_slot.c             |  6 +---
 include/acpi/acpi_bus.h                      |  4 +--
 include/linux/pci.h                          |  6 ++++
 include/linux/vgaarb.h                       |  2 --
 16 files changed, 110 insertions(+), 114 deletions(-)
