Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Mar 2015 12:37:41 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v4 05/10] pci: make msi/msix shutdown functions static
Message-ID: <1427369811-11721-6-git-send-email-mst@redhat.com>
References: <1427369811-11721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427369811-11721-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_msi_shutdown and pci_msix_shutdown are now internal to msi.c, drop
them from header and make them static.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/pci.h | 4 ----
 drivers/pci/msi.c   | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..a34df45 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1209,11 +1209,9 @@ struct msix_entry {
 
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
-void pci_msi_shutdown(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
 int pci_msix_vec_count(struct pci_dev *dev);
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec);
-void pci_msix_shutdown(struct pci_dev *dev);
 void pci_disable_msix(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
@@ -1237,13 +1235,11 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 }
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
-static inline void pci_msi_shutdown(struct pci_dev *dev) { }
 static inline void pci_disable_msi(struct pci_dev *dev) { }
 static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline int pci_enable_msix(struct pci_dev *dev,
 				  struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
-static inline void pci_msix_shutdown(struct pci_dev *dev) { }
 static inline void pci_disable_msix(struct pci_dev *dev) { }
 static inline void pci_restore_msi_state(struct pci_dev *dev) { }
 static inline int pci_msi_enabled(void) { return 0; }
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ae3f7cc..a353222 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -887,7 +887,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_msi_vec_count);
 
-void pci_msi_shutdown(struct pci_dev *dev)
+static void pci_msi_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *desc;
 	u32 mask;
@@ -993,7 +993,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 }
 EXPORT_SYMBOL(pci_enable_msix);
 
-void pci_msix_shutdown(struct pci_dev *dev)
+static void pci_msix_shutdown(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 
-- 
MST

