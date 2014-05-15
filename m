Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:44733 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752793AbaEOO2F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 15 May 2014 10:28:05 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH RFC 08/11] PCI: Remove ARCH_KIRKWOOD dependency
Date: Thu, 15 May 2014 16:23:53 +0200
Message-Id: <1400163836-9831-13-git-send-email-andrew@lunn.ch>
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index a6f67ec8882f..1b32836d435a 100644
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
2.0.0.rc2

