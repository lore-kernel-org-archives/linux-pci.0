Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbcGUL6p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2016 07:58:45 -0400
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<linux@armlinux.org.uk>, <linux-omap@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<kishon@ti.com>, <nsekhar@ti.com>
Subject: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
Date: Thu, 21 Jul 2016 17:27:56 +0530
Message-ID: <1469102276-14777-3-git-send-email-kishon@ti.com>
In-Reply-To: <1469102276-14777-1-git-send-email-kishon@ti.com>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI_DOMAINS is required for DRA7x SoCs since there are 2 PCIe
controllers and without PCI_DOMAINS config, only one PCIe
controller gets registered.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 1a648e9..8e6e2c0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -86,6 +86,7 @@ config SOC_DRA7XX
 	select OMAP_INTERCONNECT_BARRIER
 	select PM_OPP if PM
 	select ZONE_DMA if ARM_LPAE
+	select PCI_DOMAINS if PCI
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.7.9.5

