Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:54909 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933837Ab3HIOtg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:49:36 -0400
From: Thierry Reding <thierry.reding@gmail.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v6 00/14] Rewrite Tegra PCIe driver
Date: Fri,  9 Aug 2013 16:49:18 +0200
Message-Id: <1376059772-16669-1-git-send-email-treding@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Stephen,

This is the latest version of the Tegra PCIe driver patch series. I've
dropped the PCI xclk clamping code as discussed and successfully tested
on Beaver. The patches that touch the PCI subsystem have Bjorn's
Acked-by and I've tested this on top of next-20130809, which has Jason's
common branch. Once he's comfortable with making the branch stable you
should be able to merge that branch and apply these patches on top.

Thierry

Jay Agarwal (3):
  PCI: tegra: Add Tegra 30 PCIe support
  ARM: tegra: Enable PCIe controller on Cardhu
  ARM: dts: tegra: Increase prefetchable PCI memory space

Stephen Warren (2):
  PCI: tegra: set up PADS_REFCLK_CFG1
  ARM: tegra: Fix Beaver's PCIe lane configuration

Thierry Reding (9):
  PCI: tegra: Move PCIe driver to drivers/pci/host
  ARM: tegra: tamonten: Add PCIe support
  ARM: tegra: tec: Add PCIe support
  ARM: tegra: harmony: Initialize PCIe from DT
  ARM: tegra: trimslice: Initialize PCIe from DT
  ARM: tegra: Add Tegra30 PCIe support
  ARM: tegra: Enable PCIe controller on Beaver
  ARM: tegra: Update default configuration (PCIe)
  MAINTAINERS: Add myself as Tegra PCIe maintainer

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  163 ++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/tegra20-harmony.dts              |   20 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   17 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |    8 +
 arch/arm/boot/dts/tegra20-trimslice.dts            |   28 +
 arch/arm/boot/dts/tegra20.dtsi                     |   55 +
 arch/arm/boot/dts/tegra30-beaver.dts               |   21 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   20 +
 arch/arm/boot/dts/tegra30.dtsi                     |   70 +
 arch/arm/configs/tegra_defconfig                   |    5 +-
 arch/arm/mach-tegra/Kconfig                        |    7 +-
 arch/arm/mach-tegra/Makefile                       |    3 -
 arch/arm/mach-tegra/board-harmony-pcie.c           |   89 -
 arch/arm/mach-tegra/board.h                        |    8 -
 arch/arm/mach-tegra/iomap.h                        |    3 -
 arch/arm/mach-tegra/pcie.c                         |  886 ----------
 arch/arm/mach-tegra/tegra.c                        |   24 -
 drivers/pci/host/Kconfig                           |    4 +
 drivers/pci/host/Makefile                          |    1 +
 drivers/pci/host/pci-tegra.c                       | 1697 ++++++++++++++++++++
 21 files changed, 2112 insertions(+), 1024 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
 delete mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
 delete mode 100644 arch/arm/mach-tegra/pcie.c
 create mode 100644 drivers/pci/host/pci-tegra.c

-- 
1.8.3.4

