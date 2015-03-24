Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Mar 2015 16:43:00 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: [PATCH v3 10/10] pci: unexport pci_msi_off
Message-ID: <1427211032-2270-11-git-send-email-mst@redhat.com>
References: <1427211032-2270-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427211032-2270-1-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now one should be using pci_msi_off now, unexport it and move the
declaration to internal header to prevent misuse.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 1 -
 drivers/pci/pci.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a964569..dd17615 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -144,6 +144,8 @@ void pci_no_msi(void);
 static inline void pci_no_msi(void) { }
 #endif
 
+void pci_msi_off(struct pci_dev *dev);
+
 static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
 {
 	u16 control;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a34df45..ef15f91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -970,7 +970,6 @@ void pci_intx(struct pci_dev *dev, int enable);
 bool pci_intx_mask_supported(struct pci_dev *dev);
 bool pci_check_and_mask_intx(struct pci_dev *dev);
 bool pci_check_and_unmask_intx(struct pci_dev *dev);
-void pci_msi_off(struct pci_dev *dev);
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size);
 int pci_set_dma_seg_boundary(struct pci_dev *dev, unsigned long mask);
 int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d5f297a..04063cc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3103,6 +3103,7 @@ EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
  * If you want to use MSI, see pci_enable_msi() and friends.
  * This is a lower-level primitive that allows us to disable
  * MSI operation at the device level.
+ * Not for use by drivers.
  */
 void pci_msi_off(struct pci_dev *dev)
 {
@@ -3113,7 +3114,6 @@ void pci_msi_off(struct pci_dev *dev)
 	if (dev->msix_cap)
 		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
-EXPORT_SYMBOL_GPL(pci_msi_off);
 
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
 {
-- 
MST

