Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11351 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732458AbeHIS7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 14:59:55 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Keith Busch <keith.busch@intel.com>, stable@vger.kernel.org
Subject: [PATCH] pci/sriov: Hold rescan lock while enumerating
Date: Thu,  9 Aug 2018 10:33:56 -0600
Message-Id: <20180809163356.18650-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI enumeration/de-enumeration needs to run single threaded to prevent
race conditions with other threads changing the topology. Altering the
number of virtual functions was not taking the rescan/remove lock hile
adding or removing those virtual functions, so this patch adds that.

Reported-by: Krzysztof Wierzbicki <krzysztof.wierzbicki@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9ecfe13157c0..611abe220b6f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -591,6 +591,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	if (num_vfs > pci_sriov_get_totalvfs(pdev))
 		return -ERANGE;
 
+	pci_lock_rescan_remove();
 	device_lock(&pdev->dev);
 
 	if (num_vfs == pdev->sriov->num_VFs)
@@ -627,6 +628,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 
 exit:
 	device_unlock(&pdev->dev);
+	pci_unlock_rescan_remove();
 
 	if (ret < 0)
 		return ret;
-- 
2.14.4
