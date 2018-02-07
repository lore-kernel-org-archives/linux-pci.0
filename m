Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:35021 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeBGCww (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Feb 2018 21:52:52 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/6] Add endpoint driver for Rockchip PCIe controller
Date: Wed,  7 Feb 2018 10:47:24 +0800
Message-Id: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Patch 1 firstly moves the whole Rockchip PCIe host driver from
drivers/pci/host to a new folder, driver/pci/rockchip/, and renames
pcie-rockchip.c to pcie-rockchip-host.c. It also updates the
Kconfig/Makefile etc, to repect this change.

Then patch 2 and patch 3 are trying to spilt out some common code in
preparation for adding endponit controller driver support.

Patch 4 rename rockchip-pcie.txt to rockchip-pcie-host.txt and update
the compatible of_device_id. To keep the backward compatibility for
old dtb, we add new "rockchip,rk3399-pcie-host". That means DT uses
"rockchip,rk3399-pcie" would be bound to host controller driver by
default.

Patch 5 adds endpoint controller driver support as well as the new
documentation, rockchip-pcie-ep.txt, introduced by patch 6.



Shawn Lin (6):
  PCI: rockchip: Create individual folder for rockchip drivers
  PCI: rockchip: Split out common function to parse DT
  PCI: rockchip: Spilt out common function to init controller
  PCI: rockchip: Add rockchip,rk3399-pcie-host compatible
  PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe
    controller
  dt-bindings: PCI: rockchip: Add DT bindings for Rockchip PCIe endpoint
    controller

 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |  60 ++
 .../{rockchip-pcie.txt => rockchip-pcie-host.txt}  |   3 +-
 MAINTAINERS                                        |   4 +-
 drivers/pci/Kconfig                                |   1 +
 drivers/pci/Makefile                               |   2 +
 drivers/pci/host/Kconfig                           |  11 -
 drivers/pci/host/Makefile                          |   1 -
 drivers/pci/rockchip/Kconfig                       |  32 ++
 drivers/pci/rockchip/Makefile                      |   4 +
 drivers/pci/rockchip/pcie-rockchip-ep.c            | 629 +++++++++++++++++++++
 .../pcie-rockchip-host.c}                          | 595 +------------------
 drivers/pci/rockchip/pcie-rockchip.c               | 418 ++++++++++++++
 drivers/pci/rockchip/pcie-rockchip.h               | 343 +++++++++++
 13 files changed, 1507 insertions(+), 596 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (98%)
 create mode 100644 drivers/pci/rockchip/Kconfig
 create mode 100644 drivers/pci/rockchip/Makefile
 create mode 100644 drivers/pci/rockchip/pcie-rockchip-ep.c
 rename drivers/pci/{host/pcie-rockchip.c => rockchip/pcie-rockchip-host.c} (61%)
 create mode 100644 drivers/pci/rockchip/pcie-rockchip.c
 create mode 100644 drivers/pci/rockchip/pcie-rockchip.h

-- 
1.9.1
