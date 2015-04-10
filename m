Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:38792 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbbDJWy4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:56 -0400
Received: by igbqf9 with SMTP id qf9so9446240igb.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:55 -0700 (PDT)
Subject: [PATCH v6 05/10] PCI/MSI: Make pci_msi_shutdown(),
 pci_msix_shutdown() static
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:54:53 -0500
Message-ID: <20150410225453.20848.51301.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

pci_msi_shutdown() and pci_msix_shutdown() are now internal to
drivers/pci/msi.c; make them static.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c   |    4 ++--
 include/linux/pci.h |    4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index f66be868ad21..ea78a0746a42 100644
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
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da8a7d7..a34df456faf2 100644
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

