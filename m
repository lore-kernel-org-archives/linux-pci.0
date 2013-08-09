Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43904 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753754Ab3HIKhK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 06:37:10 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: mvebu: make Marvell PCIe driver depend on OF
Date: Fri,  9 Aug 2013 12:35:50 +0200
Message-Id: <1376044550-30572-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Marvell PCIe host controller driver is heavily tied to Device Tree
APIs, and can only be used on platforms where the Device Tree is
used. Therefore, it should "depends on OF" to avoid build failures on
!OF configurations.

Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Bjorn, you can take this one through your tree. Either for 3.11 or
3.12, at your preference.
---
 drivers/pci/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index 1184ff6..e5ba4eb 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -4,6 +4,7 @@ menu "PCI host controller drivers"
 config PCI_MVEBU
 	bool "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_KIRKWOOD
+	depends on OF
 
 config PCIE_DW
 	bool
-- 
1.8.1.2

