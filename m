Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41388 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758212Ab3HHWST (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 18:18:19 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCHv8 08/10] ARM: mvebu: the MPIC now provides MSI controller features
Date: Fri,  9 Aug 2013 00:17:46 +0200
Message-Id: <1376000268-18397-9-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the 'msi-controller' property to the main interrupt controller
Device Tree node, to indicate that it can now behave as a MSI
controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Tested-by: Daniel Price <daniel.price@gmail.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 90b1176..ac0bbc0 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -56,6 +56,7 @@
 				#interrupt-cells = <1>;
 				#size-cells = <1>;
 				interrupt-controller;
+				msi-controller;
 			};
 
 			coherency-fabric@20200 {
-- 
1.8.1.2

