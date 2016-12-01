Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753431AbcLAIbd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 03:31:33 -0500
Subject: [PATCH v10 08/12] PCI: Add MCFG quirks for Qualcomm QDF2432 host
 controller
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Thu, 01 Dec 2016 02:30:36 -0600
Message-ID: <20161201083036.12247.76741.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Christopher Covington <cov@codeaurora.org>

The Qualcomm Technologies QDF2432 SoC does not support accesses smaller
than 32 bits to the PCI configuration space.  Register the appropriate
quirk.

[bhelgaas: add QCOM_ECAM32 macro, ifdef for ACPI and PCI_QUIRKS]
Signed-off-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_mcfg.c  |   11 +++++++++++
 drivers/pci/ecam.c       |   12 ++++++++++++
 include/linux/pci-ecam.h |    4 ++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
index 1ef7285..c74c054 100644
--- a/drivers/acpi/pci_mcfg.c
+++ b/drivers/acpi/pci_mcfg.c
@@ -51,6 +51,17 @@ struct mcfg_fixup {
 
 static struct mcfg_fixup mcfg_quirks[] = {
 /*	{ OEM_ID, OEM_TABLE_ID, REV, SEGMENT, BUS_RANGE, ops, cfgres }, */
+
+#define QCOM_ECAM32(seg) \
+	{ "QCOM  ", "QDF2432 ", 1, seg, MCFG_BUS_ANY, &pci_32b_ops },
+	QCOM_ECAM32(0),
+	QCOM_ECAM32(1),
+	QCOM_ECAM32(2),
+	QCOM_ECAM32(3),
+	QCOM_ECAM32(4),
+	QCOM_ECAM32(5),
+	QCOM_ECAM32(6),
+	QCOM_ECAM32(7),
 };
 
 static char mcfg_oem_id[ACPI_OEM_ID_SIZE];
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 3805122..fc0baa5 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -183,3 +183,15 @@ struct pci_ecam_ops pci_generic_ecam_ops = {
 		.write		= pci_generic_config_write,
 	}
 };
+
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+/* ECAM ops for 32-bit access only (non-compliant) */
+struct pci_ecam_ops pci_32b_ops = {
+	.bus_shift	= 20,
+	.pci_ops	= {
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read32,
+		.write		= pci_generic_config_write32,
+	}
+};
+#endif
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 7adad20..739d233 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -59,6 +59,10 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern struct pci_ecam_ops pci_generic_ecam_ops;
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
+extern struct pci_ecam_ops pci_32b_ops;		/* 32-bit accesses only */
+#endif
+
 #ifdef CONFIG_PCI_HOST_GENERIC
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,

