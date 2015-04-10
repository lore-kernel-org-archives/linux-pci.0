Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36173 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbbDJWym (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2015 18:54:42 -0400
Received: by igblo3 with SMTP id lo3so9663512igb.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2015 15:54:41 -0700 (PDT)
Subject: [PATCH v6 03/10] PCI/MSI: Disable MSI at enumeration even if kernel
 doesn't support MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fam Zheng <famz@redhat.com>, linux-pci@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>, stable@kernel.org
Date: Fri, 10 Apr 2015 17:54:40 -0500
Message-ID: <20150410225440.20848.16347.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Michael S. Tsirkin <mst@redhat.com>

If we enable MSI, then kexec a new kernel, the new kernel may receive MSIs
it is not prepared for.  Commit d5dea7d95c48 ("PCI: msi: Disable msi
interrupts when we initialize a pci device") prevents this, but only if the
new kernel is built with CONFIG_PCI_MSI=y.

Move the "disable MSI" functionality from drivers/pci/msi.c to a new
pci_msi_setup_pci_dev() in drivers/pci/probe.c so we can disable MSIs when
we enumerate devices even if the kernel doesn't include full MSI support.

[bhelgaas: changelog, disable MSIs in pci_setup_device(), put
pci_msi_setup_pci_dev() at its final destination]
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@kernel.org
---
 drivers/pci/msi.c   |   12 ------------
 drivers/pci/probe.c |   18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9942f6827a4a..f66be868ad21 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1041,18 +1041,6 @@ EXPORT_SYMBOL(pci_msi_enabled);
 void pci_msi_init_pci_dev(struct pci_dev *dev)
 {
 	INIT_LIST_HEAD(&dev->msi_list);
-
-	/* Disable the msi hardware to avoid screaming interrupts
-	 * during boot.  This is the power on reset default so
-	 * usually this should be a noop.
-	 */
-	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
-	if (dev->msi_cap)
-		pci_msi_set_enable(dev, 0);
-
-	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
-	if (dev->msix_cap)
-		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
 }
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400e96cb..740113b70ade 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1084,6 +1084,22 @@ int pci_cfg_space_size(struct pci_dev *dev)
 
 #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
 
+static void pci_msi_setup_pci_dev(struct pci_dev *dev)
+{
+	/*
+	 * Disable the MSI hardware to avoid screaming interrupts
+	 * during boot.  This is the power on reset default so
+	 * usually this should be a noop.
+	 */
+	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
+	if (dev->msi_cap)
+		pci_msi_set_enable(dev, 0);
+
+	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (dev->msix_cap)
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+}
+
 /**
  * pci_setup_device - fill in class and map information of a device
  * @dev: the device structure to fill
@@ -1139,6 +1155,8 @@ int pci_setup_device(struct pci_dev *dev)
 	/* "Unknown power state" */
 	dev->current_state = PCI_UNKNOWN;
 
+	pci_msi_setup_pci_dev(dev);
+
 	/* Early fixups, before probing the BARs */
 	pci_fixup_device(pci_fixup_early, dev);
 	/* device class may be changed after fixup */

