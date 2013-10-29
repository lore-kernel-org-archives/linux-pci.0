Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:10480
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752638Ab3J2LeV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 07:34:21 -0400
From: Bharat Bhushan <r65777@freescale.com>
To: <alex.williamson@redhat.com>, <joro@8bytes.org>,
	<galak@kernel.crashing.org>, <scottwood@freescale.com>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <agraf@suse.de>,
	<stuart.yoder@freescale.com>
CC: Bharat Bhushan <Bharat.Bhushan@freescale.com>,
	Bharat Bhushan <bharat.bhushan@freescale.com>
Subject: [PATCH 4/5 RFC] pci: msi: expose msi region information functions
Date: Tue, 29 Oct 2013 16:57:38 +0530
Message-ID: <1383046062-16520-2-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1383046062-16520-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

So by now we have defined all the interfaces for getting the msi region,
this patch expose the interface to linux subsystem. These will be used by
vfio subsystem for setting up iommu for MSI interrupt of direct assignment
devices.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 include/linux/pci.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index da172f9..c587034 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1142,6 +1142,7 @@ struct msix_entry {
 	u16	entry;	/* driver uses to specify entry, OS writes */
 };
 
+struct msi_region;
 
 #ifndef CONFIG_PCI_MSI
 static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec)
@@ -1184,6 +1185,16 @@ static inline int pci_msi_enabled(void)
 {
 	return 0;
 }
+
+static inline int msi_get_region_count(void)
+{
+	return 0;
+}
+
+static inline int msi_get_region(int region_num, struct msi_region *region)
+{
+	return 0;
+}
 #else
 int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
 int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int *maxvec);
@@ -1196,6 +1207,8 @@ void pci_disable_msix(struct pci_dev *dev);
 void msi_remove_pci_irq_vectors(struct pci_dev *dev);
 void pci_restore_msi_state(struct pci_dev *dev);
 int pci_msi_enabled(void);
+int msi_get_region_count(void);
+int msi_get_region(int region_num, struct msi_region *region);
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
1.7.0.4


