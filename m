Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53606 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964850Ab3CZQS6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:18:58 -0400
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
Subject: [PATCHv6 09/17] arm: mvebu: PCIe support is now available on mvebu
Date: Tue, 26 Mar 2013 17:18:31 +0100
Message-Id: <1364314719-1049-10-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
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
index c3715a5..d353249 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -14,6 +14,8 @@ config ARCH_MVEBU
 	select MVEBU_CLK_CPU
 	select MVEBU_CLK_GATING
 	select MVEBU_MBUS
+	select MIGHT_HAVE_PCI
+	select PCI_QUIRKS if PCI
 
 if ARCH_MVEBU
 
-- 
1.7.9.5

