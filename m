Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:60621 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbcHIJwp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2016 05:52:45 -0400
Message-Id: <0be33af4eef7e2ef328360c3622bb0581e69f437.1470735088.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 9 Aug 2016 11:53:11 +0200
Subject: [PATCH] PCI: Drop CONFIG_KEXEC_CORE ifdeffery
To: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 2b94ed245861 ("kexec: define kexec_in_progress in !CONFIG_KEXEC
case") has made this unnecessary.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e39a67c..edd78e0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -466,7 +466,6 @@ static void pci_device_shutdown(struct device *dev)
 	pci_msi_shutdown(pci_dev);
 	pci_msix_shutdown(pci_dev);
 
-#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
 	 * device to tell it to not continue to do DMA. Don't touch
@@ -476,7 +475,6 @@ static void pci_device_shutdown(struct device *dev)
 	 */
 	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
 		pci_clear_master(pci_dev);
-#endif
 }
 
 #ifdef CONFIG_PM
-- 
2.8.1

