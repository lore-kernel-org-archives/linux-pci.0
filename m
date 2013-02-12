Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45849 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365Ab3BLQ3d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:33 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: [PATCH 13/32] arm: mach-dove: use ORION_ADDR_MAP_NO_REMAP
Date: Tue, 12 Feb 2013 17:28:47 +0100
Message-Id: <1360686546-24277-14-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Currently, the addr_map_info structure uses an "int remap" to allow
SoC-specific code to specify whether a given address decoding window
should be remapped, and if so, the remapping address. To do so, it
tests if the int is less than zero (no remap) or greater than
zero. Unfortunately, this prevents any remapping address that is
higher than 2 GB.

In this commit, we convert mach-dove addr_map_info definition to use
ORION_ADDR_MAP_NO_REMAP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-dove/addr-map.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-dove/addr-map.c
index 2a06c01..febb4dc 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-dove/addr-map.c
@@ -61,28 +61,28 @@ static const struct __initdata orion_addr_map_info addr_map_info[] = {
 	  TARGET_PCIE1, ATTR_PCIE_IO, DOVE_PCIE1_IO_BUS_BASE
 	},
 	{ 2, DOVE_PCIE0_MEM_PHYS_BASE, DOVE_PCIE0_MEM_SIZE,
-	  TARGET_PCIE0, ATTR_PCIE_MEM, -1
+	  TARGET_PCIE0, ATTR_PCIE_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	{ 3, DOVE_PCIE1_MEM_PHYS_BASE, DOVE_PCIE1_MEM_SIZE,
-	  TARGET_PCIE1, ATTR_PCIE_MEM, -1
+	  TARGET_PCIE1, ATTR_PCIE_MEM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window for CESA engine.
 	 */
 	{ 4, DOVE_CESA_PHYS_BASE, DOVE_CESA_SIZE,
-	  TARGET_CESA, ATTR_CESA, -1
+	  TARGET_CESA, ATTR_CESA, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window to the BootROM for Standby and Sleep Resume
 	 */
 	{ 5, DOVE_BOOTROM_PHYS_BASE, DOVE_BOOTROM_SIZE,
-	  TARGET_BOOTROM, ATTR_BOOTROM, -1
+	  TARGET_BOOTROM, ATTR_BOOTROM, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/*
 	 * Window to the PMU Scratch Pad space
 	 */
 	{ 6, DOVE_SCRATCHPAD_PHYS_BASE, DOVE_SCRATCHPAD_SIZE,
-	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, -1
+	  TARGET_SCRATCHPAD, ATTR_SCRATCHPAD, ORION_ADDR_MAP_NO_REMAP,
 	},
 	/* End marker */
 	{ -1, 0, 0, 0, 0, 0 }
-- 
1.7.9.5

