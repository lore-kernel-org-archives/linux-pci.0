Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:54065 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab3ILEUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 12 Sep 2013 00:20:23 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Sean Cross <xobs@kosagi.com>
Subject: [PATCH v3 0/3] Add PCIe support for i.MX6q
Date: Thu, 12 Sep 2013 04:03:28 +0000
Message-Id: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds support for the PCI Express port present on
the i.MX6 SoC.  The port is based on Synopsis Designware IP with
a custom PHY.

Changes since v2:
 - Reworked source file with Sascha Hauer's suggestions

Changes since v1:
 - Use the Designware controller code for BAR initialization

Sean Cross (3):
  ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
  ARM: imx6q: Add PCIe bits to GPR syscon definition
  PCI: imx6: Add support for i.MX6 PCIe controller

 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 +
 .../devicetree/bindings/pci/designware-pcie.txt    |    5 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   18 +
 arch/arm/mach-imx/Kconfig                          |    2 +
 arch/arm/mach-imx/clk-imx6q.c                      |   21 +-
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-imx6.c                        |  549 ++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    8 +
 9 files changed, 613 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/host/pci-imx6.c

-- 
1.7.9.5

