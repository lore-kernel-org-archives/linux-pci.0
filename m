Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:46333 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754344AbeCRM6R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Mar 2018 08:58:17 -0400
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] PCI: always define the of_node helpers
Date: Sun, 18 Mar 2018 13:58:06 +0100
Message-Id: <20180318125806.12364-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Simply move these inline functions outside the ifdef instead of duplicating
them as stubs in the !OF case.  The struct device of_node field does not
depend on OF.

This also fixes the missing stubbed pci_bus_to_OF_node().

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
I noticed this as a missing pci_bus_to_OF_node stub. But adding a
stub which does pretty much the same as the real thing didn't make much
sense to me.  Same goes for the existing pci_device_to_OF_node stub,
which is why I replace that too.


 include/linux/pci.h | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 024a1beda008..d0396da9160e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2182,24 +2182,11 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 /* Arch may override this (weak) */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
 
-static inline struct device_node *
-pci_device_to_OF_node(const struct pci_dev *pdev)
-{
-	return pdev ? pdev->dev.of_node : NULL;
-}
-
-static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
-{
-	return bus ? bus->dev.of_node : NULL;
-}
-
 #else	/* CONFIG_OF */
 static inline void pci_set_of_node(struct pci_dev *dev) { }
 static inline void pci_release_of_node(struct pci_dev *dev) { }
 static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
 static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
-static inline struct device_node *
-pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
 static inline struct irq_domain *
 pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline int pci_parse_request_of_pci_ranges(struct device *dev,
@@ -2210,6 +2197,17 @@ static inline int pci_parse_request_of_pci_ranges(struct device *dev,
 }
 #endif  /* CONFIG_OF */
 
+static inline struct device_node *
+pci_device_to_OF_node(const struct pci_dev *pdev)
+{
+	return pdev ? pdev->dev.of_node : NULL;
+}
+
+static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
+{
+	return bus ? bus->dev.of_node : NULL;
+}
+
 #ifdef CONFIG_ACPI
 struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 
-- 
2.11.0
