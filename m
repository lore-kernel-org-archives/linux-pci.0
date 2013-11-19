Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:47426
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751381Ab3KSFX0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 00:23:26 -0500
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
	<bhelgaas@google.com>, <agraf@suse.de>, <scottwood@freescale.com>,
	<stuart.yoder@freescale.com>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Bharat Bhushan <Bharat.Bhushan@freescale.com>,
	Bharat Bhushan <bharat.bhushan@freescale.com>
Subject: [PATCH 1/9 v2] pci:msi: add weak function for returning msi region info
Date: Tue, 19 Nov 2013 10:47:05 +0530
Message-ID: <1384838233-24847-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1384838233-24847-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In Aperture type of IOMMU (like FSL PAMU), VFIO-iommu system need to know
the MSI region to map its window in h/w. This patch just defines the
required weak functions only and will be used by followup patches.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v1->v2
 - Added description on "struct msi_region" 

 drivers/pci/msi.c   |   22 ++++++++++++++++++++++
 include/linux/msi.h |   14 ++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d5f90d6..2643a29 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -67,6 +67,28 @@ int __weak arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
 	return chip->check_device(chip, dev, nvec, type);
 }
 
+int __weak arch_msi_get_region_count(void)
+{
+	return 0;
+}
+
+int __weak arch_msi_get_region(int region_num, struct msi_region *region)
+{
+	return 0;
+}
+
+int msi_get_region_count(void)
+{
+	return arch_msi_get_region_count();
+}
+EXPORT_SYMBOL(msi_get_region_count);
+
+int msi_get_region(int region_num, struct msi_region *region)
+{
+	return arch_msi_get_region(region_num, region);
+}
+EXPORT_SYMBOL(msi_get_region);
+
 int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b17ead8..ade1480 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -51,6 +51,18 @@ struct msi_desc {
 };
 
 /*
+ * This structure is used to get
+ * - physical address
+ * - size
+ * of a msi region
+ */
+struct msi_region {
+	int region_num; /* MSI region number */
+	dma_addr_t addr; /* Address of MSI region */
+	size_t size; /* Size of MSI region */
+};
+
+/*
  * The arch hooks to setup up msi irqs. Those functions are
  * implemented as weak symbols so that they /can/ be overriden by
  * architecture specific code if needed.
@@ -64,6 +76,8 @@ void arch_restore_msi_irqs(struct pci_dev *dev, int irq);
 
 void default_teardown_msi_irqs(struct pci_dev *dev);
 void default_restore_msi_irqs(struct pci_dev *dev, int irq);
+int arch_msi_get_region_count(void);
+int arch_msi_get_region(int region_num, struct msi_region *region);
 
 struct msi_chip {
 	struct module *owner;
-- 
1.7.0.4


