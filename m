Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:56297 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeCHTEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Mar 2018 14:04:09 -0500
Subject: [pci PATCH v4 4/4] nvme: Migrate over to "unmanaged SR-IOV" support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Date: Thu, 08 Mar 2018 11:04:06 -0800
Message-ID: <20180308190401.5433.13861.stgit@localhost.localdomain>
In-Reply-To: <20180308185507.5433.98830.stgit@localhost.localdomain>
References: <20180308185507.5433.98830.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the nvme driver we can just reuse the existing
pci_sriov_configure_unmanaged function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/nvme/host/pci.c |   22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af00a1f4..2c753ccc1771 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2570,24 +2570,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_pci_sriov_configure(struct pci_dev *pdev, int numvfs)
-{
-	int ret = 0;
-
-	if (numvfs == 0) {
-		if (pci_vfs_assigned(pdev)) {
-			dev_warn(&pdev->dev,
-				"Cannot disable SR-IOV VFs while assigned\n");
-			return -EPERM;
-		}
-		pci_disable_sriov(pdev);
-		return 0;
-	}
-
-	ret = pci_enable_sriov(pdev, numvfs);
-	return ret ? ret : numvfs;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
@@ -2706,7 +2688,9 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-	.sriov_configure = nvme_pci_sriov_configure,
+#ifdef CONFIG_PCI_IOV
+	.sriov_configure = pci_sriov_configure_unmanaged,
+#endif
 	.err_handler	= &nvme_err_handler,
 };
 
