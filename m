Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [pci PATCH v6 3/5] ena: Migrate over to unmanaged SR-IOV support
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Date: Tue, 13 Mar 2018 14:30:28 -0700
Message-ID: <20180313212955.3553.16026.stgit@localhost.localdomain>
In-Reply-To: <20180313212508.3553.65326.stgit@localhost.localdomain>
References: <20180313212508.3553.65326.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Instead of implementing our own version of a SR-IOV configuration stub in
the ena driver we can just reuse the existing
pci_sriov_configure_simple function.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

v5: Replaced call to pci_sriov_configure_unmanaged with
        pci_sriov_configure_simple
v6: Dropped "#ifdef" checks for IOV wrapping sriov_configure definition

 drivers/net/ethernet/amazon/ena/ena_netdev.c |   28 +-------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 6975150d144e..6054deb1e6aa 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -3385,32 +3385,6 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -3525,7 +3499,7 @@ static int ena_resume(struct pci_dev *pdev)
 	.suspend    = ena_suspend,
 	.resume     = ena_resume,
 #endif
-	.sriov_configure = ena_sriov_configure,
+	.sriov_configure = pci_sriov_configure_simple,
 };
 
 static int __init ena_init(void)
