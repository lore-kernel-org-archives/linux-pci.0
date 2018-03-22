Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:59549 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752706AbeCVLsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 07:48:50 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v4 0/6] Add endpoint driver for Rockchip PCIe controller
Date: Thu, 22 Mar 2018 19:42:05 +0800
Message-Id: <1521718925-160084-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Patch 1 firstly move the whole Rockchip PCIe host driver from
drivers/pci/host to a new folder, driver/pci/rockchip/, and rename
pcie-rockchip.c to pcie-rockchip-host.c. It also updates the
Kconfig/Makefile etc to repect this change.

Then patch 2 and patch 3 are trying to spilt out some common code in
preparation for adding endponit controller driver support.

Patch 4 rename rockchip-pcie.txt to rockchip-pcie-host.txt.

Patch 5 adds endpoint controller driver support as well as the new
documentation, rockchip-pcie-ep.txt, introduced by patch 6.


Changes in v4:
- remove empty line
- keep rockchip's order next to cadence and dwc, but we will
  try to resort it later when reconstructing the directories

Changes in v2:
- remove rockchip,rk3399-pcie-host compatible(Suggested by Rob)
- fix some error handling
Series-changes: 3
- fix all issues suggested by Lorenzo

Shawn Lin (6):
  PCI: rockchip: Create individual folder for rockchip drivers
  PCI: rockchip: Split out common function to parse DT
  PCI: rockchip: Split out common function to init controller
  dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
    rockchip-pcie-host.txt
  PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
    controller
  dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
    controller

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |  62 ++
 .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |   0
 MAINTAINERS                                        |   4 +-
 drivers/pci/Kconfig                                |   1 +
 drivers/pci/Makefile                               |   1 +
 drivers/pci/host/Kconfig                           |  11 -
 drivers/pci/host/Makefile                          |   1 -
 drivers/pci/rockchip/Kconfig                       |  32 ++
 drivers/pci/rockchip/Makefile                      |   4 +
 drivers/pci/rockchip/pcie-rockchip-ep.c            | 638 +++++++++++++++++++++
 .../pcie-rockchip-host.c}                          | 594 +------------------
 drivers/pci/rockchip/pcie-rockchip.c               | 416 ++++++++++++++
 drivers/pci/rockchip/pcie-rockchip.h               | 341 +++++++++++
 13 files changed, 1510 insertions(+), 595 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
 create mode 100644 drivers/pci/rockchip/Kconfig
 create mode 100644 drivers/pci/rockchip/Makefile
 create mode 100644 drivers/pci/rockchip/pcie-rockchip-ep.c
 rename drivers/pci/{host/pcie-rockchip.c => rockchip/pcie-rockchip-host.c} (61%)
 create mode 100644 drivers/pci/rockchip/pcie-rockchip.c
 create mode 100644 drivers/pci/rockchip/pcie-rockchip.h

-- 
1.9.1
