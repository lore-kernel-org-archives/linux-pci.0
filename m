Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932985AbeFLVIY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jun 2018 17:08:24 -0400
Date: Tue, 12 Jun 2018 16:08:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [GIT PULL] PCI changes for v4.18, part 2
Message-ID: <20180612210820.GA70310@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI changes:

  - squash AER directory into drivers/pci/pcie/aer.c (Bjorn Helgaas)

  - collect all native hardware drivers under drivers/pci/controller/
    (Shawn Lin)


The following changes since commit 3a3869f1c443383ef8354ffa0e5fb8df65d8b549:

  Merge tag 'pci-v4.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2018-06-07 12:45:58 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.18-changes-2

for you to fetch changes up to ce4c7b241227ed49c0b6f0f1867653e1ee0007ef:

  Merge branch 'pci/aer-squash' (2018-06-11 08:14:42 -0500)

----------------------------------------------------------------
pci-v4.18-changes-2

----------------------------------------------------------------
Bjorn Helgaas (15):
      PCI/AER: Remove forward declarations
      PCI/AER: Reorder code to group probe/remove stuff together
      PCI/AER: Squash aerdrv_core.c into aerdrv.c
      PCI/AER: Squash aerdrv_errprint.c into aerdrv.c
      PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
      PCI/AER: Squash ecrc.c into aerdrv.c
      PCI/AER: Remove duplicate pcie_port_bus_type declaration
      PCI/AER: Move pcie_aer_get_firmware_first() to portdrv.h
      PCI/AER: Move aer_irq() declaration to portdrv.h
      PCI/AER: Move private AER things to aerdrv.c
      PCI/AER: Squash Kconfig.debug into Kconfig
      PCI/AER: Hoist aerdrv.c, aer_inject.c up to drivers/pci/pcie/
      PCI/AER: Use "PCI Express" consistently in Kconfig text
      Merge branch 'pci/renames'
      Merge branch 'pci/aer-squash'

Shawn Lin (1):
      PCI: Collect all native drivers under drivers/pci/controller/

 MAINTAINERS                                        |   70 +-
 drivers/pci/Kconfig                                |    4 +-
 drivers/pci/Makefile                               |    6 +-
 drivers/pci/cadence/Kconfig                        |   27 -
 drivers/pci/cadence/Makefile                       |    4 -
 drivers/pci/{host => controller}/Kconfig           |   31 +-
 drivers/pci/{host => controller}/Makefile          |    6 +
 drivers/pci/{ => controller}/dwc/Kconfig           |    0
 drivers/pci/{ => controller}/dwc/Makefile          |    0
 drivers/pci/{ => controller}/dwc/pci-dra7xx.c      |    2 +-
 drivers/pci/{ => controller}/dwc/pci-exynos.c      |    0
 drivers/pci/{ => controller}/dwc/pci-imx6.c        |    0
 drivers/pci/{ => controller}/dwc/pci-keystone-dw.c |    0
 drivers/pci/{ => controller}/dwc/pci-keystone.c    |    0
 drivers/pci/{ => controller}/dwc/pci-keystone.h    |    0
 drivers/pci/{ => controller}/dwc/pci-layerscape.c  |    0
 drivers/pci/{ => controller}/dwc/pcie-armada8k.c   |    0
 drivers/pci/{ => controller}/dwc/pcie-artpec6.c    |    0
 .../pci/{ => controller}/dwc/pcie-designware-ep.c  |    0
 .../{ => controller}/dwc/pcie-designware-host.c    |    2 +-
 .../{ => controller}/dwc/pcie-designware-plat.c    |    0
 drivers/pci/{ => controller}/dwc/pcie-designware.c |    0
 drivers/pci/{ => controller}/dwc/pcie-designware.h |    0
 drivers/pci/{ => controller}/dwc/pcie-hisi.c       |    2 +-
 drivers/pci/{ => controller}/dwc/pcie-histb.c      |    0
 drivers/pci/{ => controller}/dwc/pcie-kirin.c      |    0
 drivers/pci/{ => controller}/dwc/pcie-qcom.c       |    0
 drivers/pci/{ => controller}/dwc/pcie-spear13xx.c  |    0
 drivers/pci/{host => controller}/pci-aardvark.c    |    0
 drivers/pci/{host => controller}/pci-ftpci100.c    |    0
 drivers/pci/{host => controller}/pci-host-common.c |    0
 .../pci/{host => controller}/pci-host-generic.c    |    0
 drivers/pci/{host => controller}/pci-hyperv.c      |    0
 drivers/pci/{host => controller}/pci-mvebu.c       |    0
 drivers/pci/{host => controller}/pci-rcar-gen2.c   |    0
 drivers/pci/{host => controller}/pci-tegra.c       |    0
 .../pci/{host => controller}/pci-thunder-ecam.c    |    0
 drivers/pci/{host => controller}/pci-thunder-pem.c |    0
 drivers/pci/{host => controller}/pci-v3-semi.c     |    0
 drivers/pci/{host => controller}/pci-versatile.c   |    0
 drivers/pci/{host => controller}/pci-xgene-msi.c   |    0
 drivers/pci/{host => controller}/pci-xgene.c       |    0
 drivers/pci/{host => controller}/pcie-altera-msi.c |    0
 drivers/pci/{host => controller}/pcie-altera.c     |    0
 .../pci/{cadence => controller}/pcie-cadence-ep.c  |    0
 .../{cadence => controller}/pcie-cadence-host.c    |    0
 drivers/pci/{cadence => controller}/pcie-cadence.c |    0
 drivers/pci/{cadence => controller}/pcie-cadence.h |    0
 drivers/pci/{host => controller}/pcie-iproc-bcma.c |    0
 drivers/pci/{host => controller}/pcie-iproc-msi.c  |    0
 .../pci/{host => controller}/pcie-iproc-platform.c |    0
 drivers/pci/{host => controller}/pcie-iproc.c      |    0
 drivers/pci/{host => controller}/pcie-iproc.h      |    0
 drivers/pci/{host => controller}/pcie-mediatek.c   |    0
 drivers/pci/{host => controller}/pcie-mobiveil.c   |    0
 drivers/pci/{host => controller}/pcie-rcar.c       |    0
 .../pci/{host => controller}/pcie-rockchip-ep.c    |    0
 .../pci/{host => controller}/pcie-rockchip-host.c  |    0
 drivers/pci/{host => controller}/pcie-rockchip.c   |    0
 drivers/pci/{host => controller}/pcie-rockchip.h   |    0
 drivers/pci/{host => controller}/pcie-tango.c      |    0
 drivers/pci/{host => controller}/pcie-xilinx-nwl.c |    0
 drivers/pci/{host => controller}/pcie-xilinx.c     |    0
 drivers/pci/{host => controller}/vmd.c             |    0
 drivers/pci/pcie/Kconfig                           |   41 +-
 drivers/pci/pcie/Makefile                          |    3 +-
 drivers/pci/pcie/aer.c                             | 1377 ++++++++++++++++++++
 drivers/pci/pcie/aer/Kconfig                       |   29 -
 drivers/pci/pcie/aer/Kconfig.debug                 |   19 -
 drivers/pci/pcie/aer/Makefile                      |   13 -
 drivers/pci/pcie/aer/aerdrv.c                      |  371 ------
 drivers/pci/pcie/aer/aerdrv.h                      |   95 --
 drivers/pci/pcie/aer/aerdrv_acpi.c                 |  141 --
 drivers/pci/pcie/aer/aerdrv_core.c                 |  496 -------
 drivers/pci/pcie/aer/aerdrv_errprint.c             |  260 ----
 drivers/pci/pcie/aer/ecrc.c                        |  117 --
 drivers/pci/pcie/{aer => }/aer_inject.c            |    3 +-
 drivers/pci/pcie/dpc.c                             |    1 -
 drivers/pci/pcie/portdrv.h                         |   15 +
 79 files changed, 1509 insertions(+), 1626 deletions(-)
 delete mode 100644 drivers/pci/cadence/Kconfig
 delete mode 100644 drivers/pci/cadence/Makefile
 rename drivers/pci/{host => controller}/Kconfig (90%)
 rename drivers/pci/{host => controller}/Makefile (89%)
 rename drivers/pci/{ => controller}/dwc/Kconfig (100%)
 rename drivers/pci/{ => controller}/dwc/Makefile (100%)
 rename drivers/pci/{ => controller}/dwc/pci-dra7xx.c (99%)
 rename drivers/pci/{ => controller}/dwc/pci-exynos.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-imx6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone-dw.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.h (100%)
 rename drivers/pci/{ => controller}/dwc/pci-layerscape.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-armada8k.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-artpec6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-ep.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-host.c (99%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-plat.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware.h (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-hisi.c (99%)
 rename drivers/pci/{ => controller}/dwc/pcie-histb.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-kirin.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-qcom.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-spear13xx.c (100%)
 rename drivers/pci/{host => controller}/pci-aardvark.c (100%)
 rename drivers/pci/{host => controller}/pci-ftpci100.c (100%)
 rename drivers/pci/{host => controller}/pci-host-common.c (100%)
 rename drivers/pci/{host => controller}/pci-host-generic.c (100%)
 rename drivers/pci/{host => controller}/pci-hyperv.c (100%)
 rename drivers/pci/{host => controller}/pci-mvebu.c (100%)
 rename drivers/pci/{host => controller}/pci-rcar-gen2.c (100%)
 rename drivers/pci/{host => controller}/pci-tegra.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-ecam.c (100%)
 rename drivers/pci/{host => controller}/pci-thunder-pem.c (100%)
 rename drivers/pci/{host => controller}/pci-v3-semi.c (100%)
 rename drivers/pci/{host => controller}/pci-versatile.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene-msi.c (100%)
 rename drivers/pci/{host => controller}/pci-xgene.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-altera.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence-ep.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence-host.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence.c (100%)
 rename drivers/pci/{cadence => controller}/pcie-cadence.h (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-bcma.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-msi.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc-platform.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.c (100%)
 rename drivers/pci/{host => controller}/pcie-iproc.h (100%)
 rename drivers/pci/{host => controller}/pcie-mediatek.c (100%)
 rename drivers/pci/{host => controller}/pcie-mobiveil.c (100%)
 rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip-ep.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip-host.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip.c (100%)
 rename drivers/pci/{host => controller}/pcie-rockchip.h (100%)
 rename drivers/pci/{host => controller}/pcie-tango.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
 rename drivers/pci/{host => controller}/vmd.c (100%)
 create mode 100644 drivers/pci/pcie/aer.c
 delete mode 100644 drivers/pci/pcie/aer/Kconfig
 delete mode 100644 drivers/pci/pcie/aer/Kconfig.debug
 delete mode 100644 drivers/pci/pcie/aer/Makefile
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv.h
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_acpi.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_core.c
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_errprint.c
 delete mode 100644 drivers/pci/pcie/aer/ecrc.c
 rename drivers/pci/pcie/{aer => }/aer_inject.c (99%)
