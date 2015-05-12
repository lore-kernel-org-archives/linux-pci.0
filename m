Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57453 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872AbbELNDs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 May 2015 09:03:48 -0400
Date: Tue, 12 May 2015 15:03:38 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v6 2/2] PCI/MSI: Make pci_msi_shutdown(), pci_msix_shutdown()
 static
Message-ID: <1431431730-25164-3-git-send-email-mst@redhat.com>
References: <1431431730-25164-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431431730-25164-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_msi_shutdown() and pci_msix_shutdown() are now internal to
drivers/pci/msi.c; make them static.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 4 ----
 drivers/pci/msi.c   | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 50b7c7d..bc50bb0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1213,11 +1213,9 @@ struct msix_entry {
 
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
@@ -1241,13 +1239,11 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
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
index f66be86..ea78a07 100644
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

