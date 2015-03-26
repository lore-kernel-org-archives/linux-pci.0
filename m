Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40665 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbbCZLhe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 26 Mar 2015 07:37:34 -0400
Date: Thu, 26 Mar 2015 12:37:30 +0100
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Fam Zheng <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v4 02/10] pci: move pci_msi_init_pci_dev to pci.c
Message-ID: <1427369811-11721-3-git-send-email-mst@redhat.com>
References: <1427369811-11721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427369811-11721-1-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0
    "PCI: msi: Disable msi interrupts when we initialize a pci device"
fixes kexec when the booting kernel does not enable msi interupts.

Unfortunately the relevant functionality is in msi.c so it isn't
compiled in when CONFIG_PCI_MSI is off, which means such configurations
would still get interrupt storms.

Fix by moving the function to pci.c, and compiling it unconditionally.

Cc: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/pci/pci.h   |  2 --
 drivers/pci/msi.c   | 17 -----------------
 drivers/pci/probe.c | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17f213d..a964569 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -140,10 +140,8 @@ extern unsigned int pci_pm_d3_delay;
 
 #ifdef CONFIG_PCI_MSI
 void pci_no_msi(void);
-void pci_msi_init_pci_dev(struct pci_dev *dev);
 #else
 static inline void pci_no_msi(void) { }
-static inline void pci_msi_init_pci_dev(struct pci_dev *dev) { }
 #endif
 
 static inline void pci_msi_set_enable(struct pci_dev *dev, int enable)
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9942f68..ae3f7cc 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1038,23 +1038,6 @@ int pci_msi_enabled(void)
 }
 EXPORT_SYMBOL(pci_msi_enabled);
 
-void pci_msi_init_pci_dev(struct pci_dev *dev)
-{
-	INIT_LIST_HEAD(&dev->msi_list);
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
-}
-
 /**
  * pci_enable_msi_range - configure device's MSI capability structure
  * @dev: device to configure
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8d2f400..45d6d5c 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1483,6 +1483,25 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 	return dev;
 }
 
+static void pci_msi_init_pci_dev(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCI_MSI
+	INIT_LIST_HEAD(&dev->msi_list);
+#endif
+
+	/* Disable the msi hardware to avoid screaming interrupts
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
 static void pci_init_capabilities(struct pci_dev *dev)
 {
 	/* MSI/MSI-X list */
-- 
MST

