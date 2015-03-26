Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 26 Mar 2015 12:37:34 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v4 03/10] pci: drop some duplicate code
Message-ID: <1427369811-11721-4-git-send-email-mst@redhat.com>
References: <1427369811-11721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427369811-11721-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_msi_init_pci_dev and pci_msi_off share a lot of code.
This used to be justified since pci_msi_init_pci_dev
wasn't compiled in when CONFIG_PCI_MSI is off.
Now that it is, let's reuse code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci.c   | 23 ++++-------------------
 drivers/pci/probe.c | 11 ++++-------
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 81f06e8..fcee8ea 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3106,26 +3106,11 @@ EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
  */
 void pci_msi_off(struct pci_dev *dev)
 {
-	int pos;
-	u16 control;
+	if (dev->msi_cap)
+		pci_msi_set_enable(dev, 0);
 
-	/*
-	 * This looks like it could go in msi.c, but we need it even when
-	 * CONFIG_PCI_MSI=n.  For the same reason, we can't use
-	 * dev->msi_cap or dev->msix_cap here.
-	 */
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
-		control &= ~PCI_MSI_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
-	}
-	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (pos) {
-		pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
-		control &= ~PCI_MSIX_FLAGS_ENABLE;
-		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
-	}
+	if (dev->msix_cap)
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 EXPORT_SYMBOL_GPL(pci_msi_off);
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 45d6d5c..baf8ddd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1489,17 +1489,14 @@ static void pci_msi_init_pci_dev(struct pci_dev *dev)
 	INIT_LIST_HEAD(&dev->msi_list);
 #endif
 
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+
 	/* Disable the msi hardware to avoid screaming interrupts
 	 * during boot.  This is the power on reset default so
 	 * usually this should be a noop.
 	 */
-	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (dev->msi_cap)
-		pci_msi_set_enable(dev, 0);
-
-	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (dev->msix_cap)
-		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+	pci_msi_off(dev);
 }
 
 static void pci_init_capabilities(struct pci_dev *dev)
-- 
MST

