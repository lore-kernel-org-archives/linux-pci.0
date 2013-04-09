Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53158 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936437Ab3DIVHP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 17:07:15 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [PATCHv8 15/19] arm: mvebu: PCIe Device Tree informations for Armada XP DB
Date: Tue,  9 Apr 2013 23:06:36 +0200
Message-Id: <1365541601-14095-16-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1365541601-14095-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Marvell evaluation board (DB) for the Armada XP SoC has 6
physicals full-size PCIe slots, so we enable the corresponding PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index e83505e..54cc5bb 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -121,5 +121,38 @@
 				spi-max-frequency = <20000000>;
 			};
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * All 6 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie@1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+			pcie@2,0 {
+				/* Port 0, Lane 1 */
+				status = "okay";
+			};
+			pcie@3,0 {
+				/* Port 0, Lane 2 */
+				status = "okay";
+			};
+			pcie@4,0 {
+				/* Port 0, Lane 3 */
+				status = "okay";
+			};
+			pcie@9,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+			pcie@10,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5

