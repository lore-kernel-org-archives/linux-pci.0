Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab2KEUU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Nov 2012 15:20:56 -0500
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 2/4] PCI,sys: Use is_visible() with boot_vga attribute for pci_dev
Date: Mon,  5 Nov 2012 15:20:35 -0500
Message-Id: <1352146841-64458-3-git-send-email-ddutile@redhat.com>
In-Reply-To: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
References: <1352146841-64458-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>

Should make pci_creae_sysfs_dev_files simpler.
Also fix possible memleak in remove path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/pci-sysfs.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 3d160aa..fbbb97f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1303,29 +1303,20 @@ int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
 		pdev->rom_attr = attr;
 	}
 
-	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA) {
-		retval = device_create_file(&pdev->dev, &vga_attr);
-		if (retval)
-			goto err_rom_file;
-	}
-
 	/* add platform-specific attributes */
 	retval = pcibios_add_platform_entries(pdev);
 	if (retval)
-		goto err_vga_file;
+		goto err_rom_file;
 
 	/* add sysfs entries for various capabilities */
 	retval = pci_create_capabilities_sysfs(pdev);
 	if (retval)
-		goto err_vga_file;
+		goto err_rom_file;
 
 	pci_create_firmware_label_files(pdev);
 
 	return 0;
 
-err_vga_file:
-	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
-		device_remove_file(&pdev->dev, &vga_attr);
 err_rom_file:
 	if (rom_size) {
 		sysfs_remove_bin_file(&pdev->dev.kobj, pdev->rom_attr);
@@ -1413,12 +1404,20 @@ static int __init pci_sysfs_init(void)
 late_initcall(pci_sysfs_init);
 
 static struct attribute *pci_dev_dev_attrs[] = {
+	&vga_attr.attr,
 	NULL,
 };
 
 static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 						struct attribute *a, int n)
 {
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (a == &vga_attr.attr)
+		if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+			return 0;
+
 	return a->mode;
 }
 
-- 
1.7.10.2.552.gaa3bb87

