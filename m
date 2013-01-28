Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:58384 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3A1S5V (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 13:57:21 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH v2 24/27] arm: mvebu: PCIe Device Tree informations for Armada XP DB
Date: Mon, 28 Jan 2013 19:56:33 +0100
Message-Id: <1359399397-29729-25-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

