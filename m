Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41833 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeDTQh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 12:37:56 -0400
Subject: [pci PATCH v8 3/4] nvme: Migrate over to unmanaged SR-IOV support
From: Alexander Duyck <alexander.h.duyck@intel.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Date: Fri, 20 Apr 2018 12:31:03 -0400
Message-ID: <20180420163027.46077.93925.stgit@ahduyck-green-test.jf.intel.com>
In-Reply-To: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of implementing our own version of a SR-IOV configuration stub in
the nvme driver we can just reuse the existing
pci_sriov_configure_simple function.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple
v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
v7: No code change, added Reviewed-by

 drivers/nvme/host/pci.c |   20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b6f43b7..ad85cf35 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2581,24 +2581,6 @@ static void nvme_remove(struct pci_dev *pdev)
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
@@ -2717,7 +2699,7 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-	.sriov_configure = nvme_pci_sriov_configure,
+	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
 };
 
