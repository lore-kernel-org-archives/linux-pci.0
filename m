Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 0/2] dra7: add support for two PCIe ports
Date: Thu, 21 Jul 2016 17:27:54 +0530
Message-ID: <1469102276-14777-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series adds patches to support 2 PCIe ports simultaneously
on dra7 based boards.
None of the supported boards exposes 2 PCIe ports. However these are
mandatory changes that would be required in order to support
2 PCIe ports.

This series has been tested to see if there are regressions with 1
PCIe port. Though testing of 2 PCIe ports is not done
while sending this patch series, it has been verified in
few of the customer boards.

Kishon Vijay Abraham I (2):
  ARM: dts: DRA7: Add "linux,pci-domain" property for pci dt nodes
  ARM: DRA7: select PCI_DOMAINS config

 arch/arm/boot/dts/dra7.dtsi |    2 ++
 arch/arm/mach-omap2/Kconfig |    1 +
 2 files changed, 3 insertions(+)

-- 
1.7.9.5
