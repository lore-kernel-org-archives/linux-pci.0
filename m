Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753019AbeFHUFS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:18 -0400
Subject: [PATCH v1 05/13] PCI/AER: Squash aerdrv_acpi.c into aerdrv.c
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:16 -0500
Message-ID: <152848831661.11888.330564546588374373.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Squash aerdrv_acpi.c into aerdrv.c.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/Makefile      |    1 
 drivers/pci/pcie/aer/aerdrv.c      |  122 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_acpi.c |  141 ------------------------------------
 3 files changed, 122 insertions(+), 142 deletions(-)
 delete mode 100644 drivers/pci/pcie/aer/aerdrv_acpi.c

diff --git a/drivers/pci/pcie/aer/Makefile b/drivers/pci/pcie/aer/Makefile
index 662fb0d2abfe..80e77c686fb8 100644
--- a/drivers/pci/pcie/aer/Makefile
+++ b/drivers/pci/pcie/aer/Makefile
@@ -8,6 +8,5 @@ obj-$(CONFIG_PCIEAER) += aerdriver.o
 obj-$(CONFIG_PCIE_ECRC)	+= ecrc.o
 
 aerdriver-objs := aerdrv.o
-aerdriver-$(CONFIG_ACPI) += aerdrv_acpi.o
 
 obj-$(CONFIG_PCIEAER_INJECT) += aer_inject.o
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 3dca26681eec..f77f5df83676 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/kfifo.h>
 #include <linux/slab.h>
+#include <acpi/apei.h>
 #include <ras/ras_event.h>
 
 #include "aerdrv.h"
@@ -38,6 +39,127 @@ bool pci_aer_available(void)
 	return !pcie_aer_disable && pci_msi_enabled();
 }
 
+#ifdef CONFIG_ACPI_APEI
+static inline int hest_match_pci(struct acpi_hest_aer_common *p,
+				 struct pci_dev *pci)
+{
+	return   ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
+		 ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
+		 p->device                 == PCI_SLOT(pci->devfn) &&
+		 p->function               == PCI_FUNC(pci->devfn);
+}
+
+static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
+				struct pci_dev *dev)
+{
+	u16 hest_type = hest_hdr->type;
+	u8 pcie_type = pci_pcie_type(dev);
+
+	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
+		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
+		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
+	    (hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
+		(dev->class >> 16) == PCI_BASE_CLASS_BRIDGE))
+		return true;
+	return false;
+}
+
+struct aer_hest_parse_info {
+	struct pci_dev *pci_dev;
+	int firmware_first;
+};
+
+static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
+{
+	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
+	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
+	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
+		return 1;
+	return 0;
+}
+
+static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
+{
+	struct aer_hest_parse_info *info = data;
+	struct acpi_hest_aer_common *p;
+	int ff;
+
+	if (!hest_source_is_pcie_aer(hest_hdr))
+		return 0;
+
+	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
+	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
+
+	/*
+	 * If no specific device is supplied, determine whether
+	 * FIRMWARE_FIRST is set for *any* PCIe device.
+	 */
+	if (!info->pci_dev) {
+		info->firmware_first |= ff;
+		return 0;
+	}
+
+	/* Otherwise, check the specific device */
+	if (p->flags & ACPI_HEST_GLOBAL) {
+		if (hest_match_type(hest_hdr, info->pci_dev))
+			info->firmware_first = ff;
+	} else
+		if (hest_match_pci(p, info->pci_dev))
+			info->firmware_first = ff;
+
+	return 0;
+}
+
+static void aer_set_firmware_first(struct pci_dev *pci_dev)
+{
+	int rc;
+	struct aer_hest_parse_info info = {
+		.pci_dev	= pci_dev,
+		.firmware_first	= 0,
+	};
+
+	rc = apei_hest_parse(aer_hest_parse, &info);
+
+	if (rc)
+		pci_dev->__aer_firmware_first = 0;
+	else
+		pci_dev->__aer_firmware_first = info.firmware_first;
+	pci_dev->__aer_firmware_first_valid = 1;
+}
+
+int pcie_aer_get_firmware_first(struct pci_dev *dev)
+{
+	if (!pci_is_pcie(dev))
+		return 0;
+
+	if (!dev->__aer_firmware_first_valid)
+		aer_set_firmware_first(dev);
+	return dev->__aer_firmware_first;
+}
+
+static bool aer_firmware_first;
+
+/**
+ * aer_acpi_firmware_first - Check if APEI should control AER.
+ */
+bool aer_acpi_firmware_first(void)
+{
+	static bool parsed = false;
+	struct aer_hest_parse_info info = {
+		.pci_dev	= NULL,	/* Check all PCIe devices */
+		.firmware_first	= 0,
+	};
+
+	if (!parsed) {
+		apei_hest_parse(aer_hest_parse, &info);
+		aer_firmware_first = info.firmware_first;
+		parsed = true;
+	}
+	return aer_firmware_first;
+}
+#endif
+
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
diff --git a/drivers/pci/pcie/aer/aerdrv_acpi.c b/drivers/pci/pcie/aer/aerdrv_acpi.c
deleted file mode 100644
index 08c87de13cb8..000000000000
--- a/drivers/pci/pcie/aer/aerdrv_acpi.c
+++ /dev/null
@@ -1,141 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Access ACPI _OSC method
- *
- * Copyright (C) 2006 Intel Corp.
- *	Tom Long Nguyen (tom.l.nguyen@intel.com)
- *	Zhang Yanmin (yanmin.zhang@intel.com)
- */
-
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/pm.h>
-#include <linux/suspend.h>
-#include <linux/acpi.h>
-#include <linux/pci-acpi.h>
-#include <linux/delay.h>
-#include <acpi/apei.h>
-#include "aerdrv.h"
-
-#ifdef CONFIG_ACPI_APEI
-static inline int hest_match_pci(struct acpi_hest_aer_common *p,
-				 struct pci_dev *pci)
-{
-	return   ACPI_HEST_SEGMENT(p->bus) == pci_domain_nr(pci->bus) &&
-		 ACPI_HEST_BUS(p->bus)     == pci->bus->number &&
-		 p->device                 == PCI_SLOT(pci->devfn) &&
-		 p->function               == PCI_FUNC(pci->devfn);
-}
-
-static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
-				struct pci_dev *dev)
-{
-	u16 hest_type = hest_hdr->type;
-	u8 pcie_type = pci_pcie_type(dev);
-
-	if ((hest_type == ACPI_HEST_TYPE_AER_ROOT_PORT &&
-		pcie_type == PCI_EXP_TYPE_ROOT_PORT) ||
-	    (hest_type == ACPI_HEST_TYPE_AER_ENDPOINT &&
-		pcie_type == PCI_EXP_TYPE_ENDPOINT) ||
-	    (hest_type == ACPI_HEST_TYPE_AER_BRIDGE &&
-		(dev->class >> 16) == PCI_BASE_CLASS_BRIDGE))
-		return true;
-	return false;
-}
-
-struct aer_hest_parse_info {
-	struct pci_dev *pci_dev;
-	int firmware_first;
-};
-
-static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
-{
-	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
-		return 1;
-	return 0;
-}
-
-static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
-{
-	struct aer_hest_parse_info *info = data;
-	struct acpi_hest_aer_common *p;
-	int ff;
-
-	if (!hest_source_is_pcie_aer(hest_hdr))
-		return 0;
-
-	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
-	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
-
-	/*
-	 * If no specific device is supplied, determine whether
-	 * FIRMWARE_FIRST is set for *any* PCIe device.
-	 */
-	if (!info->pci_dev) {
-		info->firmware_first |= ff;
-		return 0;
-	}
-
-	/* Otherwise, check the specific device */
-	if (p->flags & ACPI_HEST_GLOBAL) {
-		if (hest_match_type(hest_hdr, info->pci_dev))
-			info->firmware_first = ff;
-	} else
-		if (hest_match_pci(p, info->pci_dev))
-			info->firmware_first = ff;
-
-	return 0;
-}
-
-static void aer_set_firmware_first(struct pci_dev *pci_dev)
-{
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
-
-	rc = apei_hest_parse(aer_hest_parse, &info);
-
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
-	pci_dev->__aer_firmware_first_valid = 1;
-}
-
-int pcie_aer_get_firmware_first(struct pci_dev *dev)
-{
-	if (!pci_is_pcie(dev))
-		return 0;
-
-	if (!dev->__aer_firmware_first_valid)
-		aer_set_firmware_first(dev);
-	return dev->__aer_firmware_first;
-}
-
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
-#endif
