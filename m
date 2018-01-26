Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751237AbeAZVcW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jan 2018 16:32:22 -0500
Subject: [PATCH 0/4] PCI: Add SPDX tags
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 26 Jan 2018 15:32:17 -0600
Message-ID: <20180126212536.31503.43805.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier to
files with no license") added SPDX GPL-2.0 tags to several PCI files.

These patches add SPDX tags to almost all remaining PCI files.  For ease of
reviewing they're split into several cases (GPL v2, GPL v2+, etc.)

One file (drivers/pci/hotplug/s390_pci_hpc.c) specifies only "GPL"; I don't
know what to do with that, so I left it unchanged.

These are on my pci/spdx branch [1], and if they're non-controversial, I'll
include them for v4.16.  If they *are* controversial or you have other
plans, I'll hold off.  I couldn't tell if you have a grand scheme or if you
want maintainers to step up and finish things.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/spdx

---

Bjorn Helgaas (4):
      PCI: Add SPDX GPL-2.0 when no license was specified
      PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate
      PCI: Add SPDX GPL-2.0 to replace COPYING boilerplate
      PCI: Add SPDX GPL-2.0+ to replace GPL v2 or later boilerplate


 drivers/pci/Kconfig                           |    1 +
 drivers/pci/access.c                          |    1 +
 drivers/pci/ats.c                             |    1 +
 drivers/pci/bus.c                             |    1 +
 drivers/pci/dwc/Kconfig                       |    2 ++
 drivers/pci/dwc/pci-dra7xx.c                  |    5 +----
 drivers/pci/dwc/pci-exynos.c                  |    5 +----
 drivers/pci/dwc/pci-imx6.c                    |    5 +----
 drivers/pci/dwc/pci-keystone-dw.c             |    6 +-----
 drivers/pci/dwc/pci-keystone.c                |    5 +----
 drivers/pci/dwc/pci-keystone.h                |    6 +-----
 drivers/pci/dwc/pci-layerscape.c              |    5 +----
 drivers/pci/dwc/pcie-armada8k.c               |    5 +----
 drivers/pci/dwc/pcie-artpec6.c                |    5 +----
 drivers/pci/dwc/pcie-designware-ep.c          |   13 +------------
 drivers/pci/dwc/pcie-designware-host.c        |    5 +----
 drivers/pci/dwc/pcie-designware-plat.c        |    5 +----
 drivers/pci/dwc/pcie-designware.c             |    5 +----
 drivers/pci/dwc/pcie-designware.h             |    5 +----
 drivers/pci/dwc/pcie-hisi.c                   |    5 +----
 drivers/pci/dwc/pcie-histb.c                  |    5 +----
 drivers/pci/dwc/pcie-kirin.c                  |    5 +----
 drivers/pci/dwc/pcie-qcom.c                   |   10 +---------
 drivers/pci/dwc/pcie-spear13xx.c              |    5 +----
 drivers/pci/ecam.c                            |   13 +------------
 drivers/pci/endpoint/Kconfig                  |    1 +
 drivers/pci/endpoint/Makefile                 |    1 +
 drivers/pci/endpoint/functions/Kconfig        |    1 +
 drivers/pci/endpoint/functions/Makefile       |    1 +
 drivers/pci/endpoint/functions/pci-epf-test.c |   13 +------------
 drivers/pci/endpoint/pci-ep-cfs.c             |   13 +------------
 drivers/pci/endpoint/pci-epc-core.c           |   13 +------------
 drivers/pci/endpoint/pci-epc-mem.c            |   13 +------------
 drivers/pci/endpoint/pci-epf-core.c           |   13 +------------
 drivers/pci/host-bridge.c                     |    1 +
 drivers/pci/host/Kconfig                      |    2 ++
 drivers/pci/host/pci-aardvark.c               |    5 +----
 drivers/pci/host/pci-host-common.c            |   13 +------------
 drivers/pci/host/pci-host-generic.c           |   13 +------------
 drivers/pci/host/pci-hyperv.c                 |   12 +-----------
 drivers/pci/host/pci-mvebu.c                  |    5 +----
 drivers/pci/host/pci-rcar-gen2.c              |    5 +----
 drivers/pci/host/pci-tegra.c                  |   15 +--------------
 drivers/pci/host/pci-thunder-ecam.c           |    5 +----
 drivers/pci/host/pci-thunder-pem.c            |   13 +------------
 drivers/pci/host/pci-v3-semi.c                |    1 +
 drivers/pci/host/pci-versatile.c              |   10 +---------
 drivers/pci/host/pci-xgene-msi.c              |   11 +----------
 drivers/pci/host/pci-xgene.c                  |   12 +-----------
 drivers/pci/host/pcie-altera-msi.c            |   13 +------------
 drivers/pci/host/pcie-altera.c                |   13 +------------
 drivers/pci/host/pcie-iproc-bcma.c            |   10 +---------
 drivers/pci/host/pcie-iproc-msi.c             |   10 +---------
 drivers/pci/host/pcie-iproc-platform.c        |   10 +---------
 drivers/pci/host/pcie-iproc.c                 |   10 +---------
 drivers/pci/host/pcie-iproc.h                 |   10 +---------
 drivers/pci/host/pcie-mediatek.c              |   10 +---------
 drivers/pci/host/pcie-rcar.c                  |    5 +----
 drivers/pci/host/pcie-rockchip.c              |    6 +-----
 drivers/pci/host/pcie-xilinx-nwl.c            |    6 +-----
 drivers/pci/host/pcie-xilinx.c                |    6 +-----
 drivers/pci/host/vmd.c                        |   10 +---------
 drivers/pci/hotplug/Kconfig                   |    1 +
 drivers/pci/hotplug/acpi_pcihp.c              |   16 +---------------
 drivers/pci/hotplug/acpiphp.h                 |   16 +---------------
 drivers/pci/hotplug/acpiphp_core.c            |   16 +---------------
 drivers/pci/hotplug/acpiphp_glue.c            |   16 +---------------
 drivers/pci/hotplug/acpiphp_ibm.c             |   16 +---------------
 drivers/pci/hotplug/cpci_hotplug.h            |   16 +---------------
 drivers/pci/hotplug/cpci_hotplug_core.c       |   16 +---------------
 drivers/pci/hotplug/cpci_hotplug_pci.c        |   16 +---------------
 drivers/pci/hotplug/cpcihp_generic.c          |   21 +--------------------
 drivers/pci/hotplug/cpcihp_zt5550.c           |   21 +--------------------
 drivers/pci/hotplug/cpcihp_zt5550.h           |   21 +--------------------
 drivers/pci/hotplug/cpqphp.h                  |   16 +---------------
 drivers/pci/hotplug/cpqphp_core.c             |   16 +---------------
 drivers/pci/hotplug/cpqphp_ctrl.c             |   16 +---------------
 drivers/pci/hotplug/cpqphp_nvram.c            |   16 +---------------
 drivers/pci/hotplug/cpqphp_nvram.h            |   16 +---------------
 drivers/pci/hotplug/cpqphp_pci.c              |   16 +---------------
 drivers/pci/hotplug/cpqphp_sysfs.c            |   16 +---------------
 drivers/pci/hotplug/ibmphp.h                  |   16 +---------------
 drivers/pci/hotplug/ibmphp_core.c             |   16 +---------------
 drivers/pci/hotplug/ibmphp_ebda.c             |   16 +---------------
 drivers/pci/hotplug/ibmphp_hpc.c              |   16 +---------------
 drivers/pci/hotplug/ibmphp_pci.c              |   16 +---------------
 drivers/pci/hotplug/ibmphp_res.c              |   16 +---------------
 drivers/pci/hotplug/pci_hotplug_core.c        |   16 +---------------
 drivers/pci/hotplug/pciehp.h                  |   16 +---------------
 drivers/pci/hotplug/pciehp_core.c             |   16 +---------------
 drivers/pci/hotplug/pciehp_ctrl.c             |   16 +---------------
 drivers/pci/hotplug/pciehp_hpc.c              |   16 +---------------
 drivers/pci/hotplug/pciehp_pci.c              |   16 +---------------
 drivers/pci/hotplug/pcihp_skeleton.c          |   16 +---------------
 drivers/pci/hotplug/pnv_php.c                 |    6 +-----
 drivers/pci/hotplug/rpadlpar.h                |    6 +-----
 drivers/pci/hotplug/rpadlpar_core.c           |    6 +-----
 drivers/pci/hotplug/rpadlpar_sysfs.c          |    6 +-----
 drivers/pci/hotplug/rpaphp.h                  |   16 +---------------
 drivers/pci/hotplug/rpaphp_core.c             |   16 +---------------
 drivers/pci/hotplug/rpaphp_pci.c              |   16 +---------------
 drivers/pci/hotplug/rpaphp_slot.c             |   16 +---------------
 drivers/pci/hotplug/sgi_hotplug.c             |    5 +----
 drivers/pci/hotplug/shpchp.h                  |   16 +---------------
 drivers/pci/hotplug/shpchp_core.c             |   16 +---------------
 drivers/pci/hotplug/shpchp_ctrl.c             |   16 +---------------
 drivers/pci/hotplug/shpchp_hpc.c              |   16 +---------------
 drivers/pci/hotplug/shpchp_pci.c              |   16 +---------------
 drivers/pci/hotplug/shpchp_sysfs.c            |   16 +---------------
 drivers/pci/iov.c                             |    1 +
 drivers/pci/mmap.c                            |    5 +----
 drivers/pci/msi.c                             |    1 +
 drivers/pci/of.c                              |    6 +-----
 drivers/pci/pci-acpi.c                        |    1 +
 drivers/pci/pci-driver.c                      |    4 +---
 drivers/pci/pci-mid.c                         |    5 +----
 drivers/pci/pci-stub.c                        |    3 +--
 drivers/pci/pci.c                             |    1 +
 drivers/pci/pcie/Kconfig                      |    1 +
 drivers/pci/pcie/aer/Kconfig                  |    1 +
 drivers/pci/pcie/aer/Kconfig.debug            |    1 +
 drivers/pci/pcie/aer/aer_inject.c             |    7 +------
 drivers/pci/pcie/aer/aerdrv.c                 |    5 +----
 drivers/pci/pcie/aer/aerdrv_core.c            |    5 +----
 drivers/pci/pcie/aer/aerdrv_errprint.c        |    5 +----
 drivers/pci/pcie/aer/ecrc.c                   |   16 +---------------
 drivers/pci/pcie/pcie-dpc.c                   |    5 +----
 drivers/pci/pcie/pme.c                        |    5 +----
 drivers/pci/pcie/portdrv_acpi.c               |    5 +----
 drivers/pci/pcie/portdrv_bus.c                |    1 +
 drivers/pci/pcie/ptm.c                        |   10 +---------
 drivers/pci/probe.c                           |    1 +
 drivers/pci/remove.c                          |    1 +
 drivers/pci/rom.c                             |    1 +
 drivers/pci/search.c                          |    1 +
 drivers/pci/setup-bus.c                       |    1 +
 drivers/pci/setup-irq.c                       |    1 +
 drivers/pci/slot.c                            |    1 +
 drivers/pci/switch/Kconfig                    |    2 ++
 drivers/pci/switch/Makefile                   |    1 +
 drivers/pci/switch/switchtec.c                |   11 +----------
 drivers/pci/vc.c                              |    5 +----
 drivers/pci/vpd.c                             |    1 +
 drivers/pci/xen-pcifront.c                    |    1 +
 include/asm-generic/pci_iomap.h               |    6 +-----
 include/linux/pci-ecam.h                      |   13 +------------
 include/linux/pci-ep-cfs.h                    |    5 +----
 include/linux/pci-epc.h                       |    5 +----
 include/linux/pci-epf.h                       |    5 +----
 include/linux/pci_hotplug.h                   |   16 +---------------
 lib/pci_iomap.c                               |    1 +
 151 files changed, 154 insertions(+), 1160 deletions(-)
