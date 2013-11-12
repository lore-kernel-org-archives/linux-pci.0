Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:64168 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3KLLku (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2013 06:40:50 -0500
Received: by mail-pb0-f54.google.com with SMTP id ro12so3700016pbb.41
        for <linux-pci@vger.kernel.org>; Tue, 12 Nov 2013 03:40:49 -0800 (PST)
From: Chang Liu <cl91tp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Chang Liu <cl91tp@gmail.com>
Subject: [PATCH] PCI: add a quirk for keeping Bus Master bit on shutdown
Date: Tue, 12 Nov 2013 19:40:03 +0000
Message-Id: <1384285203-642-1-git-send-email-cl91tp@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=63861

Commit b566a22c2 and 7897e60227 made pci_device_shutdown()
unconditionally clear Bus Master bit for every pci devices.
While this works for most hardware, certain devices are not
compatible with this. Intel Lynx Point-LP SATA Controller,
for example, will hang the system if its Bus Master bit is
cleared during device shutdown. This patch adds a pci quirk
so that device drivers can instruct pci_device_shutdown()
to keep Bus Master from being cleared, and then implements
this mechanism for the Intel Lynx Point-LP AHCI driver.

Signed-off-by: Chang Liu <cl91tp@gmail.com>
---
As per Takao's suggestion, add a new member into struct pci_dev
and add a quirk in the ahci driver. I tested this on my
machine (Acer V5-573G) and it works fine.

 drivers/ata/ahci.c       |  8 ++++++++
 drivers/pci/pci-driver.c | 11 ++++++++---
 include/linux/pci.h      |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8e28f92..de6efcb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1385,6 +1385,14 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_master(pdev);
 
+	/* We normally clear Bus Master on pci device shutdown. However,
+	 * doing so for Intel Lynx Point-LP SATA Controller [AHCI mode]
+	 * hangs the system. Therefore keep it.
+	 * See bug report: https://bugzilla.kernel.org/show_bug.cgi?id=63861
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x9c03)
+		pdev->keep_busmaster_on_shutdown = 1;
+
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI)
 		return ahci_host_activate(host, pdev->irq, n_msis);
 
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 38f3c01..ff15b0c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -392,10 +392,15 @@ static void pci_device_shutdown(struct device *dev)
 	pci_msix_shutdown(pci_dev);
 
 	/*
-	 * Turn off Bus Master bit on the device to tell it to not
-	 * continue to do DMA. Don't touch devices in D3cold or unknown states.
+	 * If the hardware is okay with it, turn off Bus Master bit
+	 * on the device to tell it not to continue doing DMA.
+	 * Don't touch devices in D3cold or unknown states.
+	 * On certain hardware clearing Bus Master bit on shutdown
+	 * may hang the entire system. In these cases the driver of
+	 * these devices should set keep_busmaster_on_shutdown to 1.
 	 */
-	if (pci_dev->current_state <= PCI_D3hot)
+	if (!pci_dev->keep_busmaster_on_shutdown
+	    && pci_dev->current_state <= PCI_D3hot)
 		pci_clear_master(pci_dev);
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index da172f9..63db735 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -322,6 +322,7 @@ struct pci_dev {
 	/* keep track of device state */
 	unsigned int	is_added:1;
 	unsigned int	is_busmaster:1; /* device is busmaster */
+	unsigned int	keep_busmaster_on_shutdown:1; /* do not clear busmaster on shutdown */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	block_cfg_access:1;	/* config space access is blocked */
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
-- 
1.8.4.2

