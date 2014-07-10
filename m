Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45761 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbaGJVl6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Jul 2014 17:41:58 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 09/12] PCI: Remove ARCH_KIRKWOOD dependency
Date: Thu, 10 Jul 2014 23:36:29 +0200
Message-Id: <1405028192-9623-10-git-send-email-andrew@lunn.ch>
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 21df477be0c8..88f4862fa452 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -3,7 +3,7 @@ menu "PCI host controller drivers"
 
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE || ARCH_KIRKWOOD
+	depends on ARCH_MVEBU || ARCH_DOVE
 	depends on OF
 
 config PCIE_DW
-- 
2.0.1

