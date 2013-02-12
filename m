Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:46007 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933381Ab3BLQ3y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2013 11:29:54 -0500
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
Subject: [PATCH 29/32] arm: mvebu: PCIe Device Tree informations for Armada XP DB
Date: Tue, 12 Feb 2013 17:29:03 +0100
Message-Id: <1360686546-24277-30-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Marvell evaluation board (DB) for the Armada XP SoC has 6
physicals full-size PCIe slots, so we enable the corresponding PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 8e53b25..7dcc36c 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -90,5 +90,32 @@
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * All 6 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie@0,0 {
+				status = "okay";
+			};
+			pcie@0,1 {
+				status = "okay";
+			};
+			pcie@0,2 {
+				status = "okay";
+			};
+			pcie@0,3 {
+				status = "okay";
+			};
+			pcie@2,0 {
+				status = "okay";
+			};
+			pcie@3,0 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5

