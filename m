Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:47417 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205AbaA3Kt7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 05:49:59 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <arnd@arndb.de>
Cc: Mohit Kumar <mohit.kumar@st.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <spear-devel@list.st.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH V3 0/8] PCI:Add SPEAr13xx PCie support
Date: Thu, 30 Jan 2014 16:18:42 +0530
Message-ID: <cover.1391077731.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First three patches are improvement and fixes for SPEAr13xx support.
Next patch modify phy-core driver for its initialization during
subsys_initcall(). Platform ahci driver is modified for phy hooks.
Patch#6 and 7 modify/add support for SPEAr13xx SATA and PCIe.

These patches are tested with SPEAr1310 evaluation board:
	- INTEL PRO 100/100 EP card
	- USB xhci gen2 card
 	- Above cards connected through LeCROY PTC switch

Modifications for SATA are tested with SPEAr1340-evb board

Changes since v2:
- Incorporated comments to move SPEAr13xx PCIe and SATA phy specific routines to
  the phy framework
- Modify ahci driver to include phy hooks
- phy-core driver modifications for subsys_initcall() 
 
Changes since v1:
- Few patches of the series are already accepted and applied to mainline e.g.
 pcie designware driver improvements,fixes for IO translation bug, PCIe dw
 driver maintainer. So dropped these from v2.
- Incorporated comment to move the common/reset PCIe code to the seperate driver
- PCIe and SATA share common PHY configuration registers, so move SATA
 platform code to the system config driver
Fourth patch is improves pcie designware driver and fixes the IO
translation bug. IO translation bug fix leads to the working of PCIe EP devices
connected to RC through switch.

PCIe driver support for SPEAr1310/40 platform board is added.

These patches are tested with SPEAr1310 evaluation board:
	- INTEL PRO 100/100 EP card
	- USB xhci gen2 card
 	- Above cards connected through LeCROY PTC switch

Mohit Kumar (2):
  SPEAr13xx: defconfig: Update
  MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer

Pratyush Anand (6):
  clk: SPEAr13xx: Fix pcie clock name
  SPEAr13xx: Fix static mapping table
  phy: Initialize phy core with subsys_initcall
  ata: ahci platform: Add phy hooks to make it more generic
  SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to phy driver
  pcie: SPEAr13xx: Add designware pcie support

Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-ide@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: spear-devel@list.st.com
Cc: Tejun Heo <tj@kernel.org>

 .../devicetree/bindings/ata/ahci-platform.txt      |    2 +
 .../devicetree/bindings/pci/spear13xx-pcie.txt     |    7 +
 .../devicetree/bindings/phy/spear13xx-miphy.txt    |    8 +
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/spear1310-evb.dts                |    4 +
 arch/arm/boot/dts/spear1310.dtsi                   |   87 ++++-
 arch/arm/boot/dts/spear1340-evb.dts                |    4 +
 arch/arm/boot/dts/spear1340.dtsi                   |   29 ++-
 arch/arm/boot/dts/spear13xx.dtsi                   |   10 +-
 arch/arm/configs/spear13xx_defconfig               |   16 +
 arch/arm/mach-spear/Kconfig                        |    3 +
 arch/arm/mach-spear/include/mach/spear.h           |    4 +-
 arch/arm/mach-spear/spear1340.c                    |  127 +-----
 arch/arm/mach-spear/spear13xx.c                    |    2 +-
 drivers/ata/ahci.h                                 |    2 +
 drivers/ata/ahci_platform.c                        |   20 +
 drivers/clk/spear/spear1310_clock.c                |    6 +-
 drivers/clk/spear/spear1340_clock.c                |    2 +-
 drivers/pci/host/Kconfig                           |    5 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pcie-spear13xx.c                  |  407 +++++++++++++++++
 drivers/phy/Kconfig                                |    6 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-core.c                             |    2 +-
 drivers/phy/phy-spear13xx-sata-pcie.c              |  481 ++++++++++++++++++++
 25 files changed, 1102 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
 create mode 100644 drivers/pci/host/pcie-spear13xx.c
 create mode 100644 drivers/phy/phy-spear13xx-sata-pcie.c

