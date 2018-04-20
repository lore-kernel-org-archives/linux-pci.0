Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:5909 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDTQhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Apr 2018 12:37:14 -0400
Subject: [pci PATCH v8 2/4] ena: Migrate over to unmanaged SR-IOV support
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
Date: Fri, 20 Apr 2018 12:30:21 -0400
Message-ID: <20180420162841.46077.17967.stgit@ahduyck-green-test.jf.intel.com>
In-Reply-To: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Instead of implementing our own version of a SR-IOV configuration stub in
the ena driver we can just reuse the existing
pci_sriov_configure_simple function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple
v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition
v7: No change

 drivers/net/ethernet/amazon/ena/ena_netdev.c |   28 +-------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index a822e70..f2af87d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3386,32 +3386,6 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 
 /*****************************************************************************/
-static int ena_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	int rc;
-
-	if (numvfs > 0) {
-		rc = pci_enable_sriov(dev, numvfs);
-		if (rc != 0) {
-			dev_err(&dev->dev,
-				"pci_enable_sriov failed to enable: %d vfs with the error: %d\n",
-				numvfs, rc);
-			return rc;
-		}
-
-		return numvfs;
-	}
-
-	if (numvfs == 0) {
-		pci_disable_sriov(dev);
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-/*****************************************************************************/
-/*****************************************************************************/
 
 /* ena_remove - Device Removal Routine
  * @pdev: PCI device information struct
@@ -3526,7 +3500,7 @@ static int ena_resume(struct pci_dev *pdev)
 	.suspend    = ena_suspend,
 	.resume     = ena_resume,
 #endif
-	.sriov_configure = ena_sriov_configure,
+	.sriov_configure = pci_sriov_configure_simple,
 };
 
 static int __init ena_init(void)
