Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10431 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbdJLSvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2017 14:51:42 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>
Subject: [PATCH 0/6] Tegra PCIe end point config space map code refactoring
Date: Fri, 13 Oct 2017 00:20:05 +0530
Message-ID: <1507834211-24922-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCIe host controller in Tegra SoCs has 1GB of aperture available
for mapping end points config space, IO and BARs. In that, currently
256MB is being reserved for mapping end points configuration space
which leaves less memory space available for mapping end points BARs
on some of the platforms.
This patch series attempts to use only 4K space from 1GB aperture to
access end points configuration space.

Currently, this change benefits T20 and future chips in saving (i.e. repurposed
to use for BAR mapping) physical space as well as kernel virtual mapping space,
it saves only kernel virtual address space in T30, T124, T132 and T210.

Testing Done on T210:
 Enumeration is and basic functionality of immediate devices
 Enumeration of devices behind a PCIe switch
 Complete 4K configuration space access

Vidya Sagar (6):
  PCI: tegra: refactor config space mapping code
  ARM: tegra: limit PCIe config space mapping to 4K for T20
  ARM: tegra: limit PCIe config space mapping to 4K for T30
  ARM: tegra: limit PCIe config space mapping to 4K for T124
  ARM64: tegra: limit PCIe config space mapping to 4K for T132
  ARM64: tegra: limit PCIe config space mapping to 4K for T210

 arch/arm/boot/dts/tegra124.dtsi          |  2 +-
 arch/arm/boot/dts/tegra20.dtsi           |  8 +--
 arch/arm/boot/dts/tegra30.dtsi           |  2 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi |  2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi |  2 +-
 drivers/pci/host/pci-tegra.c             | 85 +++++++++-----------------------
 6 files changed, 31 insertions(+), 70 deletions(-)

-- 
2.7.4
