Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38635 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbbDJWyf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:35 -0400
Received: by igbqf9 with SMTP id qf9so9442400igb.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:35 -0700 (PDT)
Subject: [PATCH v6 02/10] PCI/MSI: Export pci_msi_set_enable(),
 pci_msix_clear_and_set_ctrl()
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>, linux-pci@vger.kernel.org,
	stable@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Fri, 10 Apr 2015 17:54:33 -0500
Message-ID: <20150410225433.20848.65505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

Move pci_msi_set_enable() and pci_msix_clear_and_set_ctrl() to
drivers/pci/pci.h so they're available even when MSI isn't configured
into the kernel.

No functional change.

[bhelgaas: changelog, split into separate patch]
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
CC: stable@vger.kernel.org
---
 drivers/pci/msi.c |   21 ---------------------
 drivers/pci/pci.h |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6cd366058ec4..9942f6827a4a 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -185,27 +185,6 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
 
-static void pci_msi_set_enable(struct pci_dev *dev, int enable)
-{
-	u16 control;
-
-	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
-	control &= ~PCI_MSI_FLAGS_ENABLE;
-	if (enable)
-		control |= PCI_MSI_FLAGS_ENABLE;
-	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
-}
-
-static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
-{
-	u16 ctrl;
-
-	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
-	ctrl &= ~clear;
-	ctrl |= set;
-	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
-}
-
 static inline __attribute_const__ u32 msi_mask(unsigned x)
 {
 	/* Don't shift by >= width of type */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82239cd..17f213d494de 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -146,6 +146,27 @@ static inline void pci_no_msi(void) { }
 static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
 #endif
 
+static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
+{
+	u16 control;
+
+	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
+	control &= ~PCI_MSI_FLAGS_ENABLE;
+	if (enable)
+		control |= PCI_MSI_FLAGS_ENABLE;
+	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
+}
+
+static inline void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~clear;
+	ctrl |= set;
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+
 void pci_realloc_get_opt(char *);
 
 static inline int pci_no_d1d2(struct pci_dev *dev)

