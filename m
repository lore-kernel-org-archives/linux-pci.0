Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:44648 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237Ab3IPIhr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Sep 2013 04:37:47 -0400
From: Sean Cross <xobs@kosagi.com>
To: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>, tharvey@gateworks.com,
	bhelgaas@google.com, Sean Cross <xobs@kosagi.com>
Subject: [PATCH v6 0/3] Add PCIe support for i.MX6q
Date: Mon, 16 Sep 2013 08:20:51 +0000
Message-Id: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset adds support for the PCI Express port present on
the i.MX6 SoC.  The port is based on Synopsis Designware IP with
a custom PHY.

Changes since v5:
 - Changed "compatible" to "fsl,imx6q-pcie"
 - Moved clock_prepare_enable calls back into driver
 - Removed clk lookups for lvds[12]_gate

Changes since v4:
 - Add an abort exception handler
 - Fix register ordering in imx6q-iomuxc-gpr.h
 - Enable sata_ref_100m during clock initialization
 - Minor changes to lvds[12]_gate definitions

Changes since v3:
 - Moved clock initialization to board clock file
 - Reworked memory range layout
 - Reduced the duration of several sleep calls

Changes since v2:
 - Reworked source file with Sascha Hauer's suggestions

Changes since v1:
 - Use the Designware controller code for BAR initialization

Sean Cross (3):
  ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
  ARM: imx6q: Add PCIe bits to GPR syscon definition
  PCI: imx6: Add support for i.MX6 PCIe controller

 .../devicetree/bindings/clock/imx6q-clock.txt      |    4 +
 .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   16 +
 arch/arm/mach-imx/Kconfig                          |    2 +
 arch/arm/mach-imx/clk-imx6q.c                      |   24 +-
 drivers/pci/host/Kconfig                           |    6 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-imx6.c                        |  576 ++++++++++++++++++++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    8 +
 9 files changed, 642 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/host/pci-imx6.c

-- 
1.7.9.5

