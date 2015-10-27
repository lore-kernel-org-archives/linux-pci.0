Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/5] iov: Update virtfn_max_buses to validate offset and
 stride
From: Alexander Duyck <aduyck@mirantis.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2015 13:52:15 -0700
Message-ID: <20151027205215.14626.93504.stgit@localhost.localdomain>
In-Reply-To: <20151027204607.14626.59671.stgit@localhost.localdomain>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch pulls the validation of offset and stride into virtfn_max_buses.
The general idea is to validate offset and stride for each possible value
of numvfs in addition to still determining the maximum bus value for the
VFs.

I also reversed the loop as the most likely maximum will be when numvfs is
set to total_VFs.  In addition this makes it so that we loop down to a
value of 0 for numvfs which should be the resting state for the register.

Fixes: 8e20e89658f2 ("PCI: Set SR-IOV NumVFs to zero after enumeration")
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/pci/iov.c |   42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index f8bfc1d39845..099050d78a39 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -54,24 +54,33 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
  * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
  * determine how many additional bus numbers will be consumed by VFs.
  *
- * Iterate over all valid NumVFs and calculate the maximum number of bus
- * numbers that could ever be required.
+ * Iterate over all valid NumVFs, validate offset and stride, and calculate
+ * the maximum number of bus numbers that could ever be required.
  */
-static inline u8 virtfn_max_buses(struct pci_dev *dev)
+static int virtfn_max_buses(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
-	int nr_virtfn;
-	u8 max = 0;
+	int nr_virtfn = iov->total_VFs;
 	int busnr;
 
-	for (nr_virtfn = 1; nr_virtfn <= iov->total_VFs; nr_virtfn++) {
-		pci_iov_set_numvfs(dev, nr_virtfn);
+	pci_iov_set_numvfs(dev, nr_virtfn);
+
+	while (nr_virtfn--) {
+		if (!iov->offset || !iov->stride)
+			goto err;
+
 		busnr = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
-		if (busnr > max)
-			max = busnr;
+		if (busnr > iov->max_VF_buses)
+			iov->max_VF_buses = busnr;
+
+		pci_iov_set_numvfs(dev, nr_virtfn);
 	}
 
-	return max;
+	return 0;
+err:
+	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, 0);
+
+	return -EIO;
 }
 
 static struct pci_bus *virtfn_add_bus(struct pci_bus *bus, int busnr)
@@ -467,22 +476,19 @@ found:
 
 	dev->sriov = iov;
 	dev->is_physfn = 1;
-	iov->max_VF_buses = virtfn_max_buses(dev);
-	pci_iov_set_numvfs(dev, 0);
-	if (!iov->offset || (total > 1 && !iov->stride)) {
-		rc = -EIO;
-		goto failed;
-	}
 
-	return 0;
+	rc = virtfn_max_buses(dev);
+	if (!rc)
+		return 0;
 
+	dev->sriov = NULL;
+	dev->is_physfn = 0;
 failed:
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
 		res->flags = 0;
 	}
 
-	dev->sriov = NULL;
 	kfree(iov);
 	return rc;
 }

