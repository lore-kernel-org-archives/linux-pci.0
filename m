Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58568 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab3DLUsD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:48:03 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so851417iea.18
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:48:02 -0700 (PDT)
Subject: [PATCH 3/6] PCI: Fix __must_check annotation on
 pci_create_sysfs_dev_files()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:48:00 -0600
Message-ID: <20130412204800.5237.60312.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The __must_check (gcc "warn_unused_result") attribute only makes sense
when compiling the *caller* of the function, so the annotation of the
pci_create_sysfs_dev_files() definition did nothing.

This moves the annotation to the declaration and fixes the resulting
warning.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c       |    4 +++-
 drivers/pci/pci-sysfs.c |    2 +-
 drivers/pci/pci.h       |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 8647dc6..e54ddb5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -174,7 +174,9 @@ int pci_bus_add_device(struct pci_dev *dev)
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
 	 */
-	pci_create_sysfs_dev_files(dev);
+	retval = pci_create_sysfs_dev_files(dev);
+	if (retval)
+		return retval;
 
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9c6e9bb..aa551e2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1299,7 +1299,7 @@ error:
 	return retval;
 }
 
-int __must_check pci_create_sysfs_dev_files (struct pci_dev *pdev)
+int pci_create_sysfs_dev_files (struct pci_dev *pdev)
 {
 	int retval;
 	int rom_size = 0;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7346ee6..91b9ce6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -8,7 +8,7 @@
 
 /* Functions internal to the PCI core code */
 
-extern int pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev);
 extern void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
 #if !defined(CONFIG_DMI) && !defined(CONFIG_ACPI)
 static inline void pci_create_firmware_label_files(struct pci_dev *pdev)

