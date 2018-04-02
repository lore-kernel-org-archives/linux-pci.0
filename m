Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:60337 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeDBBIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Apr 2018 21:08:23 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 0/10] Add endpoint driver for Rockchip PCIe controller
Date: Mon,  2 Apr 2018 09:01:05 +0800
Message-Id: <1522630865-151344-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Lorenzo,

    This's the 5th try to upstream endpoint driver for Rockchip PCIe
controller. In previous discussion, we both agree to do some directory
reconstruction as soon as possible in 4.17 cycle. So the first 3 patches
attempt to move forward with that.

Then patch 4-9 are mostly the same as previous version, but just
fold in the fixes found by Kbuild Robot.

And patch 10 will update the defconfig for arm64 to avoid the warning,
which may go via linux-rockchip tree.

Hope it looks good to you. :)

Changes in v5:
- fix all issues found by Kbuild Robot
- rename directory from host to controller, and move back dwc and cadence

Changes in v4:
- remove empty line
- keep rockchip's order next to cadence and dwc, but we will
  try to resort it later when reconstructing the directories

Changes in v2:
- remove rockchip,rk3399-pcie-host compatible(Suggested by Rob)
- fix some error handling



Shawn Lin (10):
  PCI: Rename directory from host to controller
  PCI: cadence: Move cadence drivers back to controller directory
  PCI: dwc: Move dwc drivers back to controller directory
  PCI: rockchip: Factor out common code and host code
  PCI: rockchip: Split out common function to parse DT
  PCI: rockchip: Split out common function to init controller
  dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
    rockchip-pcie-host.txt
  PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
    controller
  dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
    controller
  arm64: defconfig: update config for Rockchip PCIe

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |  62 ++
 .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |   0
 MAINTAINERS                                        |  65 ++-
 arch/arm64/configs/defconfig                       |   3 +-
 drivers/pci/Kconfig                                |   4 +-
 drivers/pci/Makefile                               |   6 +-
 drivers/pci/cadence/Kconfig                        |  27 -
 drivers/pci/cadence/Makefile                       |   4 -
 drivers/pci/{host => controller}/Kconfig           |  50 +-
 drivers/pci/{host => controller}/Makefile          |   7 +
 drivers/pci/{ => controller}/dwc/Kconfig           |   0
 drivers/pci/{ => controller}/dwc/Makefile          |   0
 drivers/pci/{ => controller}/dwc/pci-dra7xx.c      |   0
 drivers/pci/{ => controller}/dwc/pci-exynos.c      |   0
 drivers/pci/{ => controller}/dwc/pci-imx6.c        |   0
 drivers/pci/{ => controller}/dwc/pci-keystone-dw.c |   0
 drivers/pci/{ => controller}/dwc/pci-keystone.c    |   0
 drivers/pci/{ => controller}/dwc/pci-keystone.h    |   0
 drivers/pci/{ => controller}/dwc/pci-layerscape.c  |   0
 drivers/pci/{ => controller}/dwc/pcie-armada8k.c   |   0
 drivers/pci/{ => controller}/dwc/pcie-artpec6.c    |   0
 .../pci/{ => controller}/dwc/pcie-designware-ep.c  |   0
 .../{ => controller}/dwc/pcie-designware-host.c    |   0
 .../{ => controller}/dwc/pcie-designware-plat.c    |   0
 drivers/pci/{ => controller}/dwc/pcie-designware.c |   0
 drivers/pci/{ => controller}/dwc/pcie-designware.h |   0
 drivers/pci/{ => controller}/dwc/pcie-hisi.c       |   2 +-
 drivers/pci/{ => controller}/dwc/pcie-histb.c      |   0
 drivers/pci/{ => controller}/dwc/pcie-kirin.c      |   0
 drivers/pci/{ => controller}/dwc/pcie-qcom.c       |   0
 drivers/pci/{ => controller}/dwc/pcie-spear13xx.c  |   0
 drivers/pci/{host => controller}/pci-aardvark.c    |   0
 drivers/pci/{host => controller}/pci-ftpci100.c    |   0
 drivers/pci/{host => controller}/pci-host-common.c |   0
 .../pci/{host => controller}/pci-host-generic.c    |   0
 drivers/pci/{host => controller}/pci-hyperv.c      |   0
 drivers/pci/{host => controller}/pci-mvebu.c       |   0
 drivers/pci/{host => controller}/pci-rcar-gen2.c   |   0
 drivers/pci/{host => controller}/pci-tegra.c       |   0
 .../pci/{host => controller}/pci-thunder-ecam.c    |   0
 drivers/pci/{host => controller}/pci-thunder-pem.c |   0
 drivers/pci/{host => controller}/pci-v3-semi.c     |   0
 drivers/pci/{host => controller}/pci-versatile.c   |   0
 drivers/pci/{host => controller}/pci-xgene-msi.c   |   0
 drivers/pci/{host => controller}/pci-xgene.c       |   0
 drivers/pci/{host => controller}/pcie-altera-msi.c |   0
 drivers/pci/{host => controller}/pcie-altera.c     |   0
 .../pci/{cadence => controller}/pcie-cadence-ep.c  |   0
 .../{cadence => controller}/pcie-cadence-host.c    |   0
 drivers/pci/{cadence => controller}/pcie-cadence.c |   0
 drivers/pci/{cadence => controller}/pcie-cadence.h |   0
 drivers/pci/{host => controller}/pcie-iproc-bcma.c |   0
 drivers/pci/{host => controller}/pcie-iproc-msi.c  |   0
 .../pci/{host => controller}/pcie-iproc-platform.c |   0
 drivers/pci/{host => controller}/pcie-iproc.c      |   0
 drivers/pci/{host => controller}/pcie-iproc.h      |   0
 drivers/pci/{host => controller}/pcie-mediatek.c   |   0
 drivers/pci/{host => controller}/pcie-rcar.c       |   0
 drivers/pci/controller/pcie-rockchip-ep.c          | 639 +++++++++++++++++++++
 .../pcie-rockchip-host.c}                          | 600 +------------------
 drivers/pci/controller/pcie-rockchip.c             | 423 ++++++++++++++
 drivers/pci/controller/pcie-rockchip.h             | 338 +++++++++++
 drivers/pci/{host => controller}/pcie-tango.c      |   0
 drivers/pci/{host => controller}/pcie-xilinx-nwl.c |   0
 drivers/pci/{host => controller}/pcie-xilinx.c     |   0
 drivers/pci/{host => controller}/vmd.c             |   0
 66 files changed, 1571 insertions(+), 659 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
 delete mode 100644 drivers/pci/cadence/Kconfig
 delete mode 100644 drivers/pci/cadence/Makefile
 rename drivers/pci/{host => controller}/Kconfig (84%)
 rename drivers/pci/{host => controller}/Makefile (84%)
 rename drivers/pci/{ => controller}/dwc/Kconfig (100%)
 rename drivers/pci/{ => controller}/dwc/Makefile (100%)
 rename drivers/pci/{ => controller}/dwc/pci-dra7xx.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-exynos.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-imx6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone-dw.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.c (100%)
 rename drivers/pci/{ => controller}/dwc/pci-keystone.h (100%)
 rename drivers/pci/{ => controller}/dwc/pci-layerscape.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-armada8k.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-artpec6.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-ep.c (100%)
 rename drivers/pci/{ => controller}/dwc/pcie-designware-host.c (100%)
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
 rename drivers/pci/{host => controller}/pcie-rcar.c (100%)
 create mode 100644 drivers/pci/controller/pcie-rockchip-ep.c
 rename drivers/pci/{host/pcie-rockchip.c => controller/pcie-rockchip-host.c} (61%)
 create mode 100644 drivers/pci/controller/pcie-rockchip.c
 create mode 100644 drivers/pci/controller/pcie-rockchip.h
 rename drivers/pci/{host => controller}/pcie-tango.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx-nwl.c (100%)
 rename drivers/pci/{host => controller}/pcie-xilinx.c (100%)
 rename drivers/pci/{host => controller}/vmd.c (100%)

-- 
1.9.1
