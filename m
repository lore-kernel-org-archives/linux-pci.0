Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4173 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbbEUHJb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 03:09:31 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v4 3/3] PCI: Use pdev->has_secondary_link to identify pcie link
Date: Thu, 21 May 2015 15:05:04 +0800
Message-ID: <1432191904-16451-3-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
References: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We assumed pcie root port and downstream port always have
pcie link, but in some unusual pcie topology platform like
ATCA, it may has the following pcie tree:

root port ---- downstream port -----upstream port
                                   |
                                   |downstream port
Now we introduce a flag pdev->has_secondary_link to tag
a device whether has pcie link, use it instead.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aer/aerdrv_core.c |    3 +--
 drivers/pci/probe.c                |    2 +-
 drivers/pci/vc.c                   |    3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 5653ea9..9803e3d 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -425,8 +425,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 
 	if (driver && driver->reset_link) {
 		status = driver->reset_link(udev);
-	} else if (pci_pcie_type(udev) == PCI_EXP_TYPE_DOWNSTREAM ||
-		pci_pcie_type(udev) == PCI_EXP_TYPE_ROOT_PORT) {
+	} else if (udev->has_secondary_link) {
 		status = default_reset_link(udev);
 	} else {
 		dev_printk(KERN_DEBUG, &dev->dev,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 192c6b9..eba4928 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1645,7 +1645,7 @@ static int only_one_child(struct pci_bus *bus)
 		return 0;
 	if (pci_pcie_type(parent) == PCI_EXP_TYPE_ROOT_PORT)
 		return 1;
-	if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM &&
+	if (parent->has_secondary_link &&
 	    !pci_has_flag(PCI_SCAN_ALL_PCIE_DEVS))
 		return 1;
 	return 0;
diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 7e1304d..dfbab61 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -108,8 +108,7 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 	struct pci_dev *link = NULL;
 
 	/* Enable VCs from the downstream device */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
+	if (!dev->has_secondary_link)
 		return;
 
 	ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
-- 
1.7.1

