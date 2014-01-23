Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:37975 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753008AbaAWK5i (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 05:57:38 -0500
From: Mohit Kumar <mohit.kumar@st.com>
To: <pratyush.anand@st.com>, <linux-arm-kernel@lists.infradead.org>,
	<spear-devel@list.st.com>, <linux-pci@vger.kernel.org>
Cc: Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH V2 0/8] PCI: Add SPEAr13xx PCIe support
Date: Thu, 23 Jan 2014 16:26:40 +0530
Message-ID: <cover.1390471111.git.mohit.kumar@st.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First five patches are improvement and fixes for SPEAr13xx support.

PCIe driver support for SPEAr1310/40 platform board is added.
These patches are tested with SPEAr1310 evaluation board:
	- INTEL PRO 100/100 EP card
	- USB xhci gen2 card
 	- Above cards connected through LeCROY PTC switch

Modifications for SATA are tested with SPEAr1340-evb board

Changes since v1:
- Few patches of the series are already accepted and applied to mainline e.g.
 pcie designware driver improvements,fixes for IO translation bug, PCIe dw
 driver maintainer. So dropped these from v2.
- Incorporated comment to move the common/reset PCIe code to the seperate driver
- PCIe and SATA share common PHY configuration registers, so move SATA
 platform code to the system config driver
- Incorporated comments for FUSE_FS option for defconfig 
- Incorporated comments to move back the SPEAr1340 definations from .h file

Mohit Kumar (3):
  SPEAr13xx: Set dt field entry <stmmac,phy-addr> for phy probe
  SPEAr13xx: defconfig: Update
  MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer

Pratyush Anand (5):
  ahci: Add a driver_data field to struct ahci_platform_data
  SPEAr13xx: Fixup: Move SPEAr1340 SATA platform code to system cfg
    driver
  clk: SPEAr13xx: Fix pcie clock name
  SPEAr13xx: Fix static mapping table
  pcie: SPEAr13xx: Add designware pcie support

 MAINTAINERS                              |    6 +
 arch/arm/boot/dts/spear13xx.dtsi         |   63 ++++-
 arch/arm/configs/spear13xx_defconfig     |   16 +
 arch/arm/mach-spear/Kconfig              |    2 +
 arch/arm/mach-spear/include/mach/spear.h |    4 +-
 arch/arm/mach-spear/spear1340.c          |  127 +---------
 arch/arm/mach-spear/spear13xx.c          |    2 +-
 drivers/clk/spear/spear1310_clock.c      |    6 +-
 drivers/clk/spear/spear1340_clock.c      |    2 +-
 drivers/mfd/Makefile                     |    1 +
 drivers/mfd/spear13xx-cfg.c              |  444 ++++++++++++++++++++++++++++++
 drivers/pci/host/Kconfig                 |    5 +
 drivers/pci/host/Makefile                |    1 +
 drivers/pci/host/pcie-spear13xx.c        |  394 ++++++++++++++++++++++++++
 include/linux/ahci_platform.h            |    1 +
 15 files changed, 939 insertions(+), 135 deletions(-)
 create mode 100644 drivers/mfd/spear13xx-cfg.c
 create mode 100644 drivers/pci/host/pcie-spear13xx.c

