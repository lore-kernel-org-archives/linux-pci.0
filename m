Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 5/5] iov: Update sriov_enable to correctly handle offset and
 stride
From: Alexander Duyck <aduyck@mirantis.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Oct 2015 13:52:40 -0700
Message-ID: <20151027205240.14626.85603.stgit@localhost.localdomain>
In-Reply-To: <20151027204607.14626.59671.stgit@localhost.localdomain>
References: <20151027204607.14626.59671.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As per the SR-IOV spec the values for offset and stride are undefined until
ARI and numVFs have been set.  As such we should not be reading them until
the values have been assigned to the hardware.  In addition if numVFs is 0
the values for offset and stride are defined as unused.

This change corrects a spot where we were reading the offset and stride
even though we had left numVFs set to 0.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/pci/iov.c |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c0fc88fa7c4d..030568520772 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -241,11 +241,11 @@ int __weak pcibios_sriov_disable(struct pci_dev *pdev)
 
 static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 {
-	u16 offset, stride, initial;
 	struct resource *res;
 	struct pci_dev *pdev;
 	struct pci_sriov *iov = dev->sriov;
 	int rc, i, nres, bars, bus;
+	u16 initial;
 
 	if (!nr_virtfn)
 		return 0;
@@ -262,11 +262,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	    (!(iov->cap & PCI_SRIOV_CAP_VFM) && (nr_virtfn > initial)))
 		return -EINVAL;
 
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &offset);
-	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &stride);
-	if (!offset || (nr_virtfn > 1 && !stride))
-		return -EIO;
-
 	for (nres = 0, bars = 0, i = PCI_SRIOV_NUM_BARS; i--;) {
 		bars |= (1 << (i + PCI_IOV_RESOURCES));
 		res = &dev->resource[i + PCI_IOV_RESOURCES];
@@ -278,16 +273,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 		return -ENOMEM;
 	}
 
-	iov->offset = offset;
-	iov->stride = stride;
-
-	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
-	if (bus > dev->bus->busn_res.end) {
-		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
-			nr_virtfn, bus, &dev->bus->busn_res);
-		return -ENOMEM;
-	}
-
 	if (pci_enable_resources(dev, bars)) {
 		dev_err(&dev->dev, "SR-IOV: IOV BARS not allocated\n");
 		return -ENOMEM;
@@ -311,6 +296,15 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	}
 
 	pci_iov_set_numvfs(dev, nr_virtfn);
+
+	bus = pci_iov_virtfn_bus(dev, nr_virtfn - 1);
+	if (bus > dev->bus->busn_res.end) {
+		dev_err(&dev->dev, "can't enable %d VFs (bus %02x out of range of %pR)\n",
+			nr_virtfn, bus, &dev->bus->busn_res);
+		rc = -ENOMEM;
+		goto err_bus;
+	}
+
 	iov->ctrl |= PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE;
 	pci_cfg_access_lock(dev);
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
@@ -350,7 +344,7 @@ err_pcibios:
 	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
 	ssleep(1);
 	pci_cfg_access_unlock(dev);
-
+err_bus:
 	if (iov->link != dev->devfn)
 		sysfs_remove_link(&dev->dev.kobj, "dep_link");
 

