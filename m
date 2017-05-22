Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Emil Tantilov <emil.s.tantilov@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] pci: iov: use device lock to protect IOV sysfs accesses
Date: Mon, 22 May 2017 15:50:23 -0700
Message-Id: <20170522225023.14010-1-jakub.kicinski@netronome.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PCI core sets the driver pointer before calling ->probe() and only
clears it after ->remove().  This means driver's ->sriov_configure()
callback will happily race with probe() and remove(), most likely
leading to BUGs, since drivers don't expect this.

We could reorder pointer assignments, or try detecting races in all
drivers, but it seems simpler and cleaner to just hold the device lock
instead of special SR-IOV lock, since that lock is already supposed
to synchronize the driver callbacks.

Remove the iov lock completely, since we remove the last user.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/pci/iov.c       | 4 ----
 drivers/pci/pci-sysfs.c | 5 ++---
 drivers/pci/pci.h       | 1 -
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index d9dc7363ac77..120485d6f352 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -461,8 +461,6 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	else
 		iov->dev = dev;
 
-	mutex_init(&iov->lock);
-
 	dev->sriov = iov;
 	dev->is_physfn = 1;
 	rc = compute_max_vf_buses(dev);
@@ -491,8 +489,6 @@ static void sriov_release(struct pci_dev *dev)
 	if (dev != dev->sriov->dev)
 		pci_dev_put(dev->sriov->dev);
 
-	mutex_destroy(&dev->sriov->lock);
-
 	kfree(dev->sriov);
 	dev->sriov = NULL;
 }
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 31e99613a12e..7755559558df 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -472,7 +472,6 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 				  const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_sriov *iov = pdev->sriov;
 	int ret;
 	u16 num_vfs;
 
@@ -483,7 +482,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 	if (num_vfs > pci_sriov_get_totalvfs(pdev))
 		return -ERANGE;
 
-	mutex_lock(&iov->dev->sriov->lock);
+	device_lock(&pdev->dev);
 
 	if (num_vfs == pdev->sriov->num_VFs)
 		goto exit;
@@ -518,7 +517,7 @@ static ssize_t sriov_numvfs_store(struct device *dev,
 			 num_vfs, ret);
 
 exit:
-	mutex_unlock(&iov->dev->sriov->lock);
+	device_unlock(&pdev->dev);
 
 	if (ret < 0)
 		return ret;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index f8113e5b9812..93f4044b8f4b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -272,7 +272,6 @@ struct pci_sriov {
 	u16 driver_max_VFs;	/* max num VFs driver supports */
 	struct pci_dev *dev;	/* lowest numbered PF */
 	struct pci_dev *self;	/* this PF */
-	struct mutex lock;	/* lock for setting sriov_numvfs in sysfs */
 	resource_size_t barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
 	bool drivers_autoprobe;	/* auto probing of VFs by driver */
 };
-- 
2.11.0
