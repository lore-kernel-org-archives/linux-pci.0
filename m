Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35579 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbbDJWy3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:29 -0400
Received: by iggg4 with SMTP id g4so9746582igg.0
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:28 -0700 (PDT)
Subject: [PATCH v6 01/10] PCI/MSI: Rename msi_set_enable(),
 msix_clear_and_set_ctrl()
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>, linux-pci@vger.kernel.org,
	stable@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>
Date: Fri, 10 Apr 2015 17:54:26 -0500
Message-ID: <20150410225426.20848.45696.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

Rename msi_set_enable() to pci_msi_set_enable() and
msix_clear_and_set_ctrl() to pci_msix_clear_and_set_ctrl().

No functional change.

[bhelgaas: changelog, split into separate patch]
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
CC: stable@vger.kernel.org
---
 drivers/pci/msi.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index c3e7dfcf9ff5..6cd366058ec4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -185,7 +185,7 @@ void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 	return default_restore_msi_irqs(dev);
 }
 
-static void msi_set_enable(struct pci_dev *dev, int enable)
+static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 {
 	u16 control;
 
@@ -196,7 +196,7 @@ static void msi_set_enable(struct pci_dev *dev, int enable)
 	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
 }
 
-static void msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
+static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
 {
 	u16 ctrl;
 
@@ -452,7 +452,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
 	entry = irq_get_msi_desc(dev->irq);
 
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, 0);
+	pci_msi_set_enable(dev, 0);
 	arch_restore_msi_irqs(dev);
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
@@ -473,14 +473,14 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
 
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
@@ -647,7 +647,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 	int ret;
 	unsigned mask;
 
-	msi_set_enable(dev, 0);	/* Disable MSI during set up */
+	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
 	entry = msi_setup_entry(dev, nvec);
 	if (!entry)
@@ -683,7 +683,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	/* Set MSI enabled bits	 */
 	pci_intx_for_msi(dev, 0);
-	msi_set_enable(dev, 1);
+	pci_msi_set_enable(dev, 1);
 	dev->msi_enabled = 1;
 
 	dev->irq = entry->irq;
@@ -775,7 +775,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	void __iomem *base;
 
 	/* Ensure MSI-X is disabled while it is set up */
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
@@ -801,7 +801,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	 * MSI-X registers.  We need to mask all the vectors to prevent
 	 * interrupts coming in before they're fully set up.
 	 */
-	msix_clear_and_set_ctrl(dev, 0,
+	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
 
 	msix_program_entries(dev, entries);
@@ -814,7 +814,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
 
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	return 0;
 
@@ -919,7 +919,7 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	BUG_ON(list_empty(&dev->msi_list));
 	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
 
-	msi_set_enable(dev, 0);
+	pci_msi_set_enable(dev, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msi_enabled = 0;
 
@@ -1027,7 +1027,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
 		__pci_msix_desc_mask_irq(entry, 1);
 	}
 
-	msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 	pci_intx_for_msi(dev, 1);
 	dev->msix_enabled = 0;
 }
@@ -1069,11 +1069,11 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
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

