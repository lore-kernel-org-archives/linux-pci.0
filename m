Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:49507 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab2JCFIB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 01:08:01 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/2] PCI, sys: Use is_visable() with boot_vga attribute for pci_dev
Date: Tue,  2 Oct 2012 22:07:53 -0700
Message-Id: <1349240873-1031-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349240873-1031-1-git-send-email-yinghai@kernel.org>
References: <20121003031018.GB13391@kroah.com>
 <1349240873-1031-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

That could let pci_create_sysfs_dev_files more simple.

also fix possible fix memleak during removing path.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/pci-sysfs.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: linux-2.6/drivers/pci/pci-sysfs.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-sysfs.c
+++ linux-2.6/drivers/pci/pci-sysfs.c
@@ -1303,29 +1303,20 @@ int __must_check pci_create_sysfs_dev_fi
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
 
