Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:35970 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757954Ab3CHPTo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2013 10:19:44 -0500
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Olof Johansson <olof@lixom.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Russell King <linux@arm.linux.org.uk>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v4 10/18] arm: mvebu: PCIe support is now available on mvebu
Date: Fri,  8 Mar 2013 16:19:12 +0100
Message-Id: <1362755960-30791-11-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
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

