Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37812 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754548AbeDBWrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Apr 2018 18:47:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id v5-v6so4139704plo.4
        for <linux-pci@vger.kernel.org>; Mon, 02 Apr 2018 15:47:00 -0700 (PDT)
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Sathya Perla <sathya.perla@broadcom.com>,
        Felix Manlunas <felix.manlunas@caviumnetworks.com>,
        alexander.duyck@gmail.com, john.fastabend@gmail.com,
        Jacob Keller <jacob.e.keller@intel.com>,
        Donald Dutile <ddutile@redhat.com>, oss-drivers@netronome.com,
        Christoph Hellwig <hch@infradead.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH] PCI: allow drivers to limit the number of VFs to 0
Date: Mon,  2 Apr 2018 15:46:52 -0700
Message-Id: <20180402224652.4058-1-jakub.kicinski@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some user space depends on enabling sriov_totalvfs number of VFs
to not fail, e.g.:

$ cat .../sriov_totalvfs > .../sriov_numvfs

For devices which VF support depends on loaded FW we have the
pci_sriov_{g,s}et_totalvfs() API.  However, this API uses 0 as
a special "unset" value, meaning drivers can't limit sriov_totalvfs
to 0.  Remove the special values completely and simply initialize
driver_max_VFs to total_VFs.  Then always use driver_max_VFs.
Add a helper for drivers to reset the VF limit back to total.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_main.c |  6 +++---
 drivers/pci/iov.c                             | 27 +++++++++++++++++++++------
 include/linux/pci.h                           |  2 ++
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_main.c b/drivers/net/ethernet/netronome/nfp/nfp_main.c
index c4b1f344b4da..a76d177e40dd 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_main.c
@@ -123,7 +123,7 @@ static int nfp_pcie_sriov_read_nfd_limit(struct nfp_pf *pf)
 		return pci_sriov_set_totalvfs(pf->pdev, pf->limit_vfs);
 
 	pf->limit_vfs = ~0;
-	pci_sriov_set_totalvfs(pf->pdev, 0); /* 0 is unset */
+	pci_sriov_reset_totalvfs(pf->pdev);
 	/* Allow any setting for backwards compatibility if symbol not found */
 	if (err == -ENOENT)
 		return 0;
@@ -537,7 +537,7 @@ static int nfp_pci_probe(struct pci_dev *pdev,
 err_net_remove:
 	nfp_net_pci_remove(pf);
 err_sriov_unlimit:
-	pci_sriov_set_totalvfs(pf->pdev, 0);
+	pci_sriov_reset_totalvfs(pf->pdev);
 err_fw_unload:
 	kfree(pf->rtbl);
 	nfp_mip_close(pf->mip);
@@ -570,7 +570,7 @@ static void nfp_pci_remove(struct pci_dev *pdev)
 	nfp_hwmon_unregister(pf);
 
 	nfp_pcie_sriov_disable(pdev);
-	pci_sriov_set_totalvfs(pf->pdev, 0);
+	pci_sriov_reset_totalvfs(pf->pdev);
 
 	nfp_net_pci_remove(pf);
 
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 677924ae0350..c63ea870d8be 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -443,6 +443,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	iov->nres = nres;
 	iov->ctrl = ctrl;
 	iov->total_VFs = total;
+	iov->driver_max_VFs = total;
 	pci_read_config_word(dev, pos + PCI_SRIOV_VF_DID, &iov->vf_device);
 	iov->pgsz = pgsz;
 	iov->self = dev;
@@ -788,12 +789,29 @@ int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 }
 EXPORT_SYMBOL_GPL(pci_sriov_set_totalvfs);
 
+/**
+ * pci_sriov_reset_totalvfs -- return the TotalVFs value to the default
+ * @dev: the PCI PF device
+ *
+ * Should be called from PF driver's remove routine with
+ * device's mutex held.
+ */
+void pci_sriov_reset_totalvfs(struct pci_dev *dev)
+{
+	/* Shouldn't change if VFs already enabled */
+	if (!dev->is_physfn || dev->sriov->ctrl & PCI_SRIOV_CTRL_VFE)
+		return;
+
+	dev->sriov->driver_max_VFs = dev->sriov->total_VFs;
+}
+EXPORT_SYMBOL_GPL(pci_sriov_reset_totalvfs);
+
 /**
  * pci_sriov_get_totalvfs -- get total VFs supported on this device
  * @dev: the PCI PF device
  *
- * For a PCIe device with SRIOV support, return the PCIe
- * SRIOV capability value of TotalVFs or the value of driver_max_VFs
+ * For a PCIe device with SRIOV support, return the value of driver_max_VFs
+ * which can be equal to the PCIe SRIOV capability value of TotalVFs or lower
  * if the driver reduced it.  Otherwise 0.
  */
 int pci_sriov_get_totalvfs(struct pci_dev *dev)
@@ -801,9 +819,6 @@ int pci_sriov_get_totalvfs(struct pci_dev *dev)
 	if (!dev->is_physfn)
 		return 0;
 
-	if (dev->sriov->driver_max_VFs)
-		return dev->sriov->driver_max_VFs;
-
-	return dev->sriov->total_VFs;
+	return dev->sriov->driver_max_VFs;
 }
 EXPORT_SYMBOL_GPL(pci_sriov_get_totalvfs);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..95fde8850393 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1952,6 +1952,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id);
 int pci_num_vf(struct pci_dev *dev);
 int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
+void pci_sriov_reset_totalvfs(struct pci_dev *dev);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
 void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool probe);
@@ -1978,6 +1979,7 @@ static inline int pci_vfs_assigned(struct pci_dev *dev)
 { return 0; }
 static inline int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs)
 { return 0; }
+static inline void pci_sriov_reset_totalvfs(struct pci_dev *dev) { }
 static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
-- 
2.16.2
