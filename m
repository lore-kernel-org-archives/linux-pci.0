Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:47018 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751113Ab2J2HCL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:02:11 -0400
From: Pratyush Anand <pratyush.anand@st.com>
To: <arnd@arndb.de>, <shiraz.hashim@st.com>, <viresh.linux@gmail.com>
Cc: <spear-devel@list.st.com>, <linux-pci@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>, <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>
Subject: [PATCH 00/15] SPEAr13xx PCIe patches
Date: Mon, 29 Oct 2012 12:31:14 +0530
Message-ID: <cover.1351492562.git.pratyush.anand@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

-- First two patches are common for all platforms on ARM architecture.
-- Remaining patches belongs to SPEAr13xx architecture.
-- SPEAr13xx supports both RC and EP mode of PCIe interface. This patchset
	supports only RC mode.


Pratyush Anand (15):
  arm: source drivers/pci/pcie/kconfig
  arm: Call pcie_bus_configure_settings for pcie devices
  SPEAr13xx: Add mach/io.h
  SPEAr13xx: Add PCIe Root Complex driver support
  clk: SPEAr1340: Fix pcie0 clock name
  clk: SPEAr1310: Fix pcie clock name
  SPEAr1340: Add PCIe auxdata for miphy clock initialization
  SPEAr1310: Add PCIe auxdata for miphy clock initialization
  SPEAr13xx: dts: Fix PCIe core address ranges
  SPEAr13xx: DTS: Add auxiliary data for PCIe host
  SPEAr1340-evb: dts: Enable PCIe0
  SPEAr1310-EVB: DTS: Fix PCIe1 enable
  SPEAr13xx: update kconfig for PCIe selection
  SPEAR13xx: Update makefile for PCIe inclusion
  SPEAR13xx: update defconfig for PCIe compilation

 arch/arm/Kconfig                            |    1 +
 arch/arm/boot/dts/spear1310-evb.dts         |    4 -
 arch/arm/boot/dts/spear1340-evb.dts         |    4 +
 arch/arm/boot/dts/spear13xx.dtsi            |   33 +-
 arch/arm/configs/spear13xx_defconfig        |    1 +
 arch/arm/kernel/bios32.c                    |   12 +
 arch/arm/mach-spear13xx/Kconfig             |   12 +
 arch/arm/mach-spear13xx/Makefile            |    1 +
 arch/arm/mach-spear13xx/include/mach/io.h   |   35 +
 arch/arm/mach-spear13xx/include/mach/pcie.h |  233 ++++++
 arch/arm/mach-spear13xx/pcie.c              | 1145 +++++++++++++++++++++++++++
 arch/arm/mach-spear13xx/spear1310.c         |  148 ++++
 arch/arm/mach-spear13xx/spear1340.c         |   26 +
 drivers/clk/spear/spear1310_clock.c         |    6 +-
 drivers/clk/spear/spear1340_clock.c         |    2 +-
 15 files changed, 1651 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/pcie.h
 create mode 100644 arch/arm/mach-spear13xx/pcie.c

-- 
1.7.5.4

