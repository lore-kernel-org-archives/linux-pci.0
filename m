Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33868 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbbDJWyW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:22 -0400
Received: by iget9 with SMTP id t9so22712803ige.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:21 -0700 (PDT)
Subject: [PATCH v6 00/10] PCI: Fix unhandled interrupt on shutdown
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 10 Apr 2015 17:54:19 -0500
Message-ID: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Michael,

I put your patches on my pci/msi branch and I hope to merge them for v4.1.
I didn't apply the acks from Fam and Eric because I made changes to those
patches that weren't completely trivial.  I think the end result is
equivalent, though.  The diff attached to this cover letter is the
difference between your v5 series and this v6 series.

As far as I'm concerned, this is ready to go except that I would like a
little more info about the virtio kernel hang to include in the changelog
for "PCI/MSI: Don't disable MSI/MSI-X at shutdown".

Changes from v5:
	Edit summaries and changelogs for consistency
	Split msi_set_enable() rename/export for reviewability
	Move pci_msi_setup_pci_dev() to its ultimate location to avoid
	    unnecessary diffs in subsequent patch
	Call pci_msi_setup_pci_dev() from its ultimate location to avoid
	    unnecessary diffs in subsequent patch
	Skip pci_msi_off() duplicate code removal since we can remove
	    it completely later
	Remove pci_msi_off() completely

v5 posting: http://lkml.kernel.org/r/1427641227-7574-1-git-send-email-mst@redhat.com

Bjorn
    
---

Bjorn Helgaas (1):
      PCI/MSI: Remove unused pci_msi_off()

Michael S. Tsirkin (9):
      PCI/MSI: Rename msi_set_enable(), msix_clear_and_set_ctrl()
      PCI/MSI: Export pci_msi_set_enable(), pci_msix_clear_and_set_ctrl()
      PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI
      PCI/MSI: Don't disable MSI/MSI-X at shutdown
      PCI/MSI: Make pci_msi_shutdown(), pci_msix_shutdown() static
      virtio_pci: drop pci_msi_off() call during probe
      ntb: Drop pci_msi_off() call during probe
      mic: Drop pci_msi_off() call during probe
      PCI/MSI: Drop pci_msi_off() calls from quirks


 drivers/misc/mic/host/mic_intr.c   |    2 -
 drivers/ntb/ntb_hw.c               |    2 -
 drivers/pci/msi.c                  |   57 ++++++++----------------------------
 drivers/pci/pci-driver.c           |    2 -
 drivers/pci/pci.c                  |   33 ---------------------
 drivers/pci/pci.h                  |   21 +++++++++++++
 drivers/pci/probe.c                |   18 +++++++++++
 drivers/pci/quirks.c               |    2 -
 drivers/virtio/virtio_pci_common.c |    3 --
 include/linux/pci.h                |    5 ---
 10 files changed, 51 insertions(+), 94 deletions(-)


--- This is "git diff v5 v6":

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 54cefb442d19..3d938a7d3b04 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3096,24 +3096,6 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
-/**
- * pci_msi_off - disables any MSI or MSI-X capabilities
- * @dev: the PCI device to operate on
- *
- * If you want to use MSI, see pci_enable_msi() and friends.
- * This is a lower-level primitive that allows us to disable
- * MSI operation at the device level.
- * Not for use by drivers.
- */
-void pci_msi_off(struct pci_dev *dev)
-{
-	if (dev->msi_cap)
-		pci_msi_set_enable(dev, 0);
-
-	if (dev->msix_cap)
-		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
-}
-
 int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
 {
 	return dma_set_max_seg_size(&dev->dev, size);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 620fcad1935d..17f213d494de 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -146,8 +146,6 @@ static inline void pci_no_msi(void) { }
 static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
 #endif
 
-void pci_msi_off(struct pci_dev *dev);
-
 static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
 {
 	u16 control;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 120772c219c7..740113b70ade 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1086,14 +1086,18 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 static void pci_msi_setup_pci_dev(struct pci_dev *dev)
 {
-	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-
-	/* Disable the msi hardware to avoid screaming interrupts
+	/*
+	 * Disable the MSI hardware to avoid screaming interrupts
 	 * during boot.  This is the power on reset default so
 	 * usually this should be a noop.
 	 */
-	pci_msi_off(dev);
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (dev->msi_cap)
+		pci_msi_set_enable(dev, 0);
+
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (dev->msix_cap)
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
 /**
@@ -1151,7 +1155,6 @@ int pci_setup_device(struct pci_dev *dev)
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
-	/* MSI/MSI-X setup has to be done early since it's used by quirks. */
 	pci_msi_setup_pci_dev(dev);
 
 	/* Early fixups, before probing the BARs */
