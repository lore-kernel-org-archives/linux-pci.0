Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60235 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab3EPP6D (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2013 11:58:03 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: [PATCHv10 8/9] arm: mvebu: PCIe support is now available on mvebu
Date: Thu, 16 May 2013 17:55:23 +0200
Message-Id: <1368719725-21265-9-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368719725-21265-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that the PCIe driver for mvebu has been integrated and all its
relevant dependencies, we can mark the ARCH_MVEBU platform has
MIGHT_HAVE_PCI, which allows to select the PCI bus support if needed.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index e11acbb..381062d 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -15,6 +15,8 @@ config ARCH_MVEBU
 	select MVEBU_CLK_GATING
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 if ARCH_MVEBU
 
-- 
1.7.9.5

