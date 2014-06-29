Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:38858 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592AbaF2VFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 29 Jun 2014 17:05:10 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>,
	rmk+kernel@arm.linux.org.uk, Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 09/13] PCI: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
Date: Sun, 29 Jun 2014 22:59:58 +0200
Message-Id: <1404075603-31838-12-git-send-email-andrew@lunn.ch>
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mach-kirkwood and mach-dove have been removed, now that these SoCs
lives in mach-mvebu. ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 21df477be0c8..b9692deeb99a 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -3,7 +3,7 @@ menu "PCI host controller drivers"
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
+	depends on ARCH_MVEBU
 	depends on OF
 
 config PCIE_DW
-- 
2.0.0

