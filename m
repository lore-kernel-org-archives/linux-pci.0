Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33078 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbbI3GfQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 02:35:16 -0400
Received: by pacex6 with SMTP id ex6so30722680pac.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 23:35:16 -0700 (PDT)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH repost 1/3] PCI: Support PCIe devices with short cfg_size
Date: Wed, 30 Sep 2015 15:35:05 +0900
Message-Id: <1443594907-16196-2-git-send-email-simon.horman@netronome.com>
In-Reply-To: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
References: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: "Jason S. McMullan" <jason.mcmullan@netronome.com>

If a PCIe device has a 'quirk' where the quirk modifies the
pci_dev->cfg_size to be less than PCI_CFG_SPACE_EXP_SIZE, but greater than
PCI_CFG_SPACE_SIZE then the pci sysfs interface truncates the readable size
to PCI_CFG_SPACE_SIZE.

This patch corrects this issue.

This is in preparation for adding a quirk for such a case.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>
[simon: edited changelog]
Signed-off-by: Simon Horman <simon.horman@netronome.com>
---
 drivers/pci/pci-sysfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 312f23a8429c..cf8eba5d8e14 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1369,10 +1369,10 @@ int __must_check pci_create_sysfs_dev_files(struct pci_dev *pdev)
 	if (!sysfs_initialized)
 		return -EACCES;
 
-	if (pdev->cfg_size < PCI_CFG_SPACE_EXP_SIZE)
-		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
-	else
+	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
 		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+	else
+		retval = sysfs_create_bin_file(&pdev->dev.kobj, &pci_config_attr);
 	if (retval)
 		goto err;
 
@@ -1424,10 +1424,10 @@ err_rom_file:
 err_resource_files:
 	pci_remove_resource_files(pdev);
 err_config_file:
-	if (pdev->cfg_size < PCI_CFG_SPACE_EXP_SIZE)
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
-	else
+	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+	else
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 err:
 	return retval;
 }
@@ -1461,10 +1461,10 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 	pci_remove_capabilities_sysfs(pdev);
 
-	if (pdev->cfg_size < PCI_CFG_SPACE_EXP_SIZE)
-		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
-	else
+	if (pdev->cfg_size > PCI_CFG_SPACE_SIZE)
 		sysfs_remove_bin_file(&pdev->dev.kobj, &pcie_config_attr);
+	else
+		sysfs_remove_bin_file(&pdev->dev.kobj, &pci_config_attr);
 
 	pci_remove_resource_files(pdev);
 
-- 
2.1.4

