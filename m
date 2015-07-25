Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:59968 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932104AbbGYTP3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 25 Jul 2015 15:15:29 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, zajec5@gmail.com, rjui@broadcom.com.com,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] PCI: iproc_bcma: allow build as module
Date: Sat, 25 Jul 2015 21:15:24 +0200
Message-Id: <1437851724-10519-1-git-send-email-hauke@hauke-m.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes this to tristate to make it possible to build this driver as a
module.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/pci/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
index c132bdd..e339a8c 100644
--- a/drivers/pci/host/Kconfig
+++ b/drivers/pci/host/Kconfig
@@ -135,7 +135,7 @@ config PCIE_IPROC_PLATFORM
 	  through the generic platform bus interface
 
 config PCIE_IPROC_BCMA
-	bool "Broadcom iProc PCIe BCMA bus driver"
+	tristate "Broadcom iProc PCIe BCMA bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
 	select PCIE_IPROC
 	select BCMA
-- 
2.1.4

