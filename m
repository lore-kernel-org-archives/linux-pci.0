Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:43321 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbaDQRsN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Apr 2014 13:48:13 -0400
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Thu, 17 Apr 2014 18:48:11 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D9931B08051
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 18:48:12 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3HHm9F161407378
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 17:48:09 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3HHm8dE013504
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2014 11:48:09 -0600
Date: Thu, 17 Apr 2014 19:48:07 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] pci: remove pcibios_add_platform_entries
Message-ID: <alpine.LFD.2.11.1404171947150.1588@denkbrett>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove pcibios_add_platform_entries. Architecture specific attributes
can be achieved by setting pdev->dev.groups .

Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
---
 drivers/pci/pci-sysfs.c |   10 ----------
 include/linux/pci.h     |    1 -
 2 files changed, 11 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1272,11 +1272,6 @@ static struct bin_attribute pcie_config_
 	.write = pci_write_config,
 };
 
-int __weak pcibios_add_platform_entries(struct pci_dev *dev)
-{
-	return 0;
-}
-
 static ssize_t reset_store(struct device *dev,
 			   struct device_attribute *attr, const char *buf,
 			   size_t count)
@@ -1392,11 +1387,6 @@ int __must_check pci_create_sysfs_dev_fi
 		pdev->rom_attr = attr;
 	}
 
-	/* add platform-specific attributes */
-	retval = pcibios_add_platform_entries(pdev);
-	if (retval)
-		goto err_rom_file;
-
 	/* add sysfs entries for various capabilities */
 	retval = pci_create_capabilities_sysfs(pdev);
 	if (retval)
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1572,7 +1572,6 @@ extern unsigned long pci_hotplug_io_size
 extern unsigned long pci_hotplug_mem_size;
 
 /* Architecture-specific versions may override these (weak) */
-int pcibios_add_platform_entries(struct pci_dev *dev);
 void pcibios_disable_device(struct pci_dev *dev);
 void pcibios_set_master(struct pci_dev *dev);
 int pcibios_set_pcie_reset_state(struct pci_dev *dev,

