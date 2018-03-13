Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbeCMW1F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 18:27:05 -0400
Subject: [PATCH v1 4/4] PCI/VPD: Move VPD structures to vpd.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 13 Mar 2018 17:27:03 -0500
Message-ID: <152098002344.37832.5031118622737088208.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152097990638.37832.15000151673990461303.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The VPD-related structures are only used in vpd.c, so move them from
drivers/pci/pci.h to vpd.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h |   17 -----------------
 drivers/pci/vpd.c |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 1191320a44d5..9a41a6399967 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -104,23 +104,6 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
 	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
 }
 
-struct pci_vpd_ops {
-	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
-	int (*set_size)(struct pci_dev *dev, size_t len);
-};
-
-struct pci_vpd {
-	const struct pci_vpd_ops *ops;
-	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
-	struct mutex	lock;
-	unsigned int	len;
-	u16		flag;
-	u8		cap;
-	u8		busy:1;
-	u8		valid:1;
-};
-
 int pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
 void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 901b0bedcc5d..f24c3600be73 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -14,6 +14,23 @@
 
 /* VPD access through PCI 2.2+ VPD capability */
 
+struct pci_vpd_ops {
+	ssize_t (*read)(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
+	ssize_t (*write)(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
+	int (*set_size)(struct pci_dev *dev, size_t len);
+};
+
+struct pci_vpd {
+	const struct pci_vpd_ops *ops;
+	struct bin_attribute *attr;	/* Descriptor for sysfs VPD entry */
+	struct mutex	lock;
+	unsigned int	len;
+	u16		flag;
+	u8		cap;
+	unsigned int	busy:1;
+	unsigned int	valid:1;
+};
+
 /**
  * pci_read_vpd - Read one entry from Vital Product Data
  * @dev:	pci device struct
