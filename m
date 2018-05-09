Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:47861 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932988AbeEIBTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 May 2018 21:19:41 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v7 0/7] Add EP driver for Rockchip PCIe controller
Date: Wed,  9 May 2018 09:11:18 +0800
Message-Id: <1525828278-69800-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

This's the 7th try to upstream EP driver for Rockchip PCIe
controller. V7 is the same with V6 but with some minor adjustment
for commit title and commit log.

Thanks.


Changes in v7:
- check and update commit log

Changes in v6:
- rebase

Changes in v5:
- export symbol to fix error reported by Kbuild robot
- PCIE_ROCKCHIP depends on PCI

Changes in v4:
- remove empty line
- keep rockchip's order next to cadence and dwc, but
  we will try to resort it later when reconstructing
  the directories

Shawn Lin (7):
  PCI: rockchip: Separate common code from RC driver
  PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT
  PCI: rockchip: Split out common function to init controller
  dt-bindings: PCI: rockchip: Rename rockchip-pcie.txt to
    rockchip-pcie-host.txt
  PCI: rockchip: Add EP driver for Rockchip PCIe controller
  dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe EP
    driver
  arm64: defconfig: update config for Rockchip PCIe

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |   62 +
 .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |    0
 MAINTAINERS                                        |    4 +-
 arch/arm64/configs/defconfig                       |    3 +-
 drivers/pci/host/Kconfig                           |   19 +-
 drivers/pci/host/Makefile                          |    2 +
 drivers/pci/host/pcie-rockchip-ep.c                |  639 ++++++++
 drivers/pci/host/pcie-rockchip-host.c              | 1141 +++++++++++++
 drivers/pci/host/pcie-rockchip.c                   | 1683 +++-----------------
 drivers/pci/host/pcie-rockchip.h                   |  338 ++++
 10 files changed, 2403 insertions(+), 1488 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (100%)
 create mode 100644 drivers/pci/host/pcie-rockchip-ep.c
 create mode 100644 drivers/pci/host/pcie-rockchip-host.c
 create mode 100644 drivers/pci/host/pcie-rockchip.h

-- 
1.9.1
