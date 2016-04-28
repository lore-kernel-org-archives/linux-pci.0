Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44829 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbcD1V2J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 17:28:09 -0400
From: Christopher Covington <cov@codeaurora.org>
To: Timur Tabi <timur@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>,
	Mark Salter <msalter@redhat.com>,
	Mark Langsdorf <mlangsdo@redhat.com>,
	Jon Masters <jcm@redhat.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Christopher Covington <cov@codeaurora.org>
Subject: [PATCH] acpi: pci: QDF2432 32 bit config space accessors
Date: Thu, 28 Apr 2016 17:27:38 -0400
Message-Id: <1461878858-23798-1-git-send-email-cov@codeaurora.org>
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Qualcomm Technologies QDF2432 SoCs require 32 bit accessors to be used
for the PCI configuration space. Register the appropriate quirk.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
Depends on Tomasz Nowicki's latest series:
[PATCH V6 00/13] Support for generic ACPI based PCI host controller
---
 drivers/acpi/pci_gen_host.c | 13 +++++++++++++
 drivers/pci/ecam.c          | 10 ++++++++++
 drivers/pci/ecam.h          |  3 +++
 3 files changed, 26 insertions(+)

diff --git a/drivers/acpi/pci_gen_host.c b/drivers/acpi/pci_gen_host.c
index e55dfca..daf8a86 100644
--- a/drivers/acpi/pci_gen_host.c
+++ b/drivers/acpi/pci_gen_host.c
@@ -257,3 +257,16 @@ int raw_pci_write(unsigned int domain, unsigned int busn, unsigned int devfn,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	return bus->ops->write(bus, devfn, reg, len, val);
 }
+
+static const struct dmi_system_id qcom_qdf2432[] = {
+	{
+		.ident = "Qualcomm Technologies QDF2432",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Qualcomm"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "QDF2432"),
+		},
+	},
+	{ }
+};
+
+DECLARE_ACPI_MCFG_FIXUP(qcom_qdf2432, NULL, &pci_generic_ecam_32b_ops, PCI_MCFG_DOMAIN_ANY, PCI_MCFG_BUS_ANY);
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index ff04c01..720a038 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -135,3 +135,13 @@ struct pci_generic_ecam_ops pci_generic_ecam_default_ops = {
 		.write		= pci_generic_config_write,
 	}
 };
+
+/* ECAM ops with 32 bit config space access quirk */
+struct pci_generic_ecam_ops pci_generic_ecam_32b_ops = {
+	.bus_shift	= 20,
+	.pci_ops		= {
+		.map_bus	= pci_generic_ecam_map_bus,
+		.read		= pci_generic_config_read32,
+		.write		= pci_generic_config_write32,
+	}
+};
diff --git a/drivers/pci/ecam.h b/drivers/pci/ecam.h
index 706621a..4af764f 100644
--- a/drivers/pci/ecam.h
+++ b/drivers/pci/ecam.h
@@ -58,6 +58,9 @@ void __iomem *pci_generic_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops, bus shift 20, generic read and write */
 extern struct pci_generic_ecam_ops pci_generic_ecam_default_ops;
 
+/* ECAM ops with 32 bit config space access quirk */
+extern struct pci_generic_ecam_ops pci_generic_ecam_32b_ops;
+
 #ifdef CONFIG_PCI_HOST_GENERIC
 /* for DT based pci controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev,
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

