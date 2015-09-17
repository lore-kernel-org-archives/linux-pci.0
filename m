Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13364 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbbIQVWj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:22:39 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 7/7] PCI: Override firmware settings if static enumeration
 is set
Date: Thu, 17 Sep 2015 21:11:45 +0000
Message-ID: <613697bdfcbd46d98d11718a41b8bc49@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI scanning algorithm currently preserves any bus numbers set by
the firmware.  If there exists static enumeration settings, then
ignore those numbers and reenumerate everything.  This may move
devices around based upon the value of "hpbuses".

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci.h             | 2 ++
 drivers/pci/pci_static_enum.c | 9 +++++++++
 drivers/pci/probe.c           | 4 +++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e1a1cce..36b358d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -337,9 +337,11 @@ struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
 
 #ifdef CONFIG_PCI_STATIC_ENUMERATION
 void pci_static_enum_set_opt(const char *str);
+bool pci_static_enum_is_set(void);
 void pci_static_enum_bridge(struct pci_bus *bus);
 #else
 static inline void pci_static_enum_set_opt(const char *str) { return; }
+static inline bool pci_static_enum_is_set(void) { return 0; }
 static inline void pci_static_enum_bridge(struct pci_bus *bus) { };
 #endif
 
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 47b7bd5..a7c595b 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -38,6 +38,15 @@ void __init pci_static_enum_set_opt(const char *str)
 }
 
 /**
+ * pci_static_enum_is_set() - return true if static enumeration
+ * options are set
+ */
+bool pci_static_enum_is_set(void)
+{
+	return pci_static_enum_param[0] != '\0';
+}
+
+/**
  * pci_static_enum_find_setting() - find requested bridge within options
  * @bus: bridge to find
  * @setting: found static enumeration settings
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7cc80c3..91311e7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -802,6 +802,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 	pci_enable_crs(dev);
 
 	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	    !pci_static_enum_is_set() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax;
 		/*
@@ -840,7 +841,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (pcibios_assign_all_busses() || broken ||
+			    is_cardbus || pci_static_enum_is_set())
 				/* Temporarily disable forwarding of the
 				   configuration cycles on all bridges in
 				   this bus segment to avoid possible
-- 
1.8.3.1

