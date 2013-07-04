Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:56677 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab3GDUp3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jul 2013 16:45:29 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH] PCI: PCIE: Rename option title to something less confusing
Date: Thu,  4 Jul 2013 17:45:20 -0300
Message-Id: <1372970720-14016-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The previous option title "PCI Express support" is confusing.
The name seems to imply this option is required to get PCIe support,
which is not true.

Fix it to "PCI Express Port Bus support" which is more accurate.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/pci/pcie/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 569f82f..a82e70a 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -2,7 +2,7 @@
 # PCI Express Port Bus Configuration
 #
 config PCIEPORTBUS
-	bool "PCI Express support"
+	bool "PCI Express Port Bus support"
 	depends on PCI
 	help
 	  This automatically enables PCI Express Port Bus support. Users can
-- 
1.8.1.5

