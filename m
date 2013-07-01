Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:41194 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975Ab3GANnH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2013 09:43:07 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
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
Subject: [PATCHv4 09/11] arm: mvebu: the MPIC now provides MSI controller features
Date: Mon,  1 Jul 2013 15:42:14 +0200
Message-Id: <1372686136-1370-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Adds the 'msi-controller' property to the main interrupt controller
Device Tree node, to indicate that it can now behave as a MSI
controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index bb6224c..9020478 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -52,6 +52,7 @@
 				#interrupt-cells = <1>;
 				#size-cells = <1>;
 				interrupt-controller;
+				msi-controller;
 			};
 
 			coherency-fabric@20200 {
-- 
1.8.1.2

