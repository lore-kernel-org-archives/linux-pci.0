Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760116Ab2JYSim (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 14:38:42 -0400
From: Donald Dutile <ddutile@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	yinghai@kernel.org, davem@davemloft.net, ddutile@redhat.com
Subject: [PATCH 2/8] Yinghai's second patch for vga attr
Date: Thu, 25 Oct 2012 14:38:24 -0400
Message-Id: <1351190310-5043-3-git-send-email-ddutile@redhat.com>
In-Reply-To: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
References: <1351190310-5043-1-git-send-email-ddutile@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

