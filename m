Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [193.47.165.129] ([193.47.165.129]:33980 "EHLO mellanox.co.il"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933305AbcBDI3o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 03:29:44 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: kvm@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	noaos@mellanox.com, haggaie@mellanox.com, ogerlitz@mellanox.com,
	liranl@mellanox.com, ilyal@mellanox.com
Subject: [RFC V2 3/4] PCI: Expose iov_set_numvfs and iov_resource_size for modules.
Date: Thu,  4 Feb 2016 10:28:56 +0200
Message-Id: <1454574537-123466-4-git-send-email-ilyal@mellanox.com>
In-Reply-To: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
References: <1454574537-123466-1-git-send-email-ilyal@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Expose iov_set_numvfs and iov_resource_size to make them available
for VFIO-PCI sriov support.

Signed-off-by: Ilya Lesokhin <ilyal@mellanox.com>
Signed-off-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Haggai Eran <haggaie@mellanox.com>
---
 drivers/pci/iov.c   | 4 +++-
 include/linux/pci.h | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ee0ebff..f296bd3 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -41,7 +41,7 @@ int pci_iov_virtfn_devfn(struct pci_dev *dev, int vf_id)
  *
  * Update iov->offset and iov->stride when NumVFs is written.
  */
-static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
+inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 {
 	struct pci_sriov *iov = dev->sriov;
 
@@ -49,6 +49,7 @@ static inline void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &iov->offset);
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &iov->stride);
 }
+EXPORT_SYMBOL(pci_iov_set_numvfs);
 
 /*
  * The PF consumes one bus number.  NumVFs, First VF Offset, and VF Stride
@@ -107,6 +108,7 @@ resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 
 	return dev->sriov->barsz[resno - PCI_IOV_RESOURCES];
 }
+EXPORT_SYMBOL(pci_iov_resource_size);
 
 static int virtfn_add(struct pci_dev *dev, int id, int reset)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6330327..4dda3fe 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1725,6 +1725,8 @@ int pci_vfs_assigned(struct pci_dev *dev);
 int pci_sriov_set_totalvfs(struct pci_dev *dev, u16 numvfs);
 int pci_sriov_get_totalvfs(struct pci_dev *dev);
 resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno);
+
+void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn);
 #else
 static inline int pci_iov_virtfn_bus(struct pci_dev *dev, int id)
 {
@@ -1746,6 +1748,8 @@ static inline int pci_sriov_get_totalvfs(struct pci_dev *dev)
 { return 0; }
 static inline resource_size_t pci_iov_resource_size(struct pci_dev *dev, int resno)
 { return 0; }
+
+void pci_iov_set_numvfs(struct pci_dev *dev, int nr_virtfn) { }
 #endif
 
 #if defined(CONFIG_HOTPLUG_PCI) || defined(CONFIG_HOTPLUG_PCI_MODULE)
-- 
1.8.3.1

