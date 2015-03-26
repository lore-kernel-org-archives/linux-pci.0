Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53102 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751498AbbCZLhd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Mar 2015 07:37:33 -0400
Date: Thu, 26 Mar 2015 12:37:27 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v4 01/10] pci: export functions for msi/msix ctrl
Message-ID: <1427369811-11721-2-git-send-email-mst@redhat.com>
References: <1427369811-11721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427369811-11721-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

move pci_msi_set_enable and pci_msix_clear_and_set_ctrl out of msi.c, so
we can use them will be used which MSI isn't configured in kernel.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci.h | 21 +++++++++++++++++++++
 drivers/pci/msi.c | 45 ++++++++++++---------------------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82..17f213d 100644
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
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c3e7dfc..9942f68 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -185,27 +185,6 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
 
-static void msi_set_enable(struct pci_dev *dev, int enable)
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
-static void msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
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
@@ -452,7 +431,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	entry = irq_get_msi_desc(dev->irq);
 
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, 0);
+	pci_msi_set_enable(dev, 0);
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
@@ -473,14 +452,14 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
 	/* route the table */
 	pci_intx_for_msi(dev, 0);
-	msix_clear_and_set_ctrl(dev, 0,
+	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	arch_restore_msi_irqs(dev);
 	list_for_each_entry(entry, &dev->msi_list, list)
 		msix_mask_irq(entry, entry->masked);
 
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
 void pci_restore_msi_state(struct pci_dev *dev)
@@ -647,7 +626,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	int ret;
 	unsigned mask;
 
-	msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
 	entry = msi_setup_entry(dev, nvec);
 	if (!entry)
@@ -683,7 +662,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, 1);
+	pci_msi_set_enable(dev, 1);
 	dev->msi_enabled = 1;
 
 	dev->irq = entry->irq;
@@ -775,7 +754,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	void __iomem *base;
 
 	/* Ensure MSI-X is disabled while it is set up */
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
@@ -801,7 +780,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	 * MSI-X registers.  We need to mask all the vectors to prevent
 	 * interrupts coming in before they're fully set up.
 	 */
-	msix_clear_and_set_ctrl(dev, 0,
+	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
 
 	msix_program_entries(dev, entries);
@@ -814,7 +793,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
 
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	return 0;
 
@@ -919,7 +898,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	BUG_ON(list_empty(&dev->msi_list));
 	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
 
-	msi_set_enable(dev, 0);
+	pci_msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
@@ -1027,7 +1006,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 		__pci_msix_desc_mask_irq(entry, 1);
 	}
 
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msix_enabled = 0;
 }
@@ -1069,11 +1048,11 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
 	 */
 	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	if (dev->msi_cap)
-		msi_set_enable(dev, 0);
+		pci_msi_set_enable(dev, 0);
 
 	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
 	if (dev->msix_cap)
-		msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
 /**
-- 
MST

