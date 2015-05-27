Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57497 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbbE0VMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:12:14 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 13/13] PCI: Don't adjust settings for statically enumerated
Date: Wed, 27 May 2015 20:59:59 +0000
Message-ID: <266e0f1d2fb843bd92486f79c7281cb4@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Once a PCI device's memory settings have been fixed through a static
enumeration profile, do not allow other parts of the PCI subsystem
to reset those settings.  Specifically,
pci_reassigndev_resource_alignment() will remove the memory behind a
bridge if there are no devices downstream.  With static enumeration,
devices may appear downstream later on, after the initial scan. Thus,
do not remove resources explicitly set by the static enumeration
profile.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci.h             |   12 ++++++++++++
 drivers/pci/pci_static_enum.c |    4 ++++
 drivers/pci/probe.c           |    3 ++-
 include/linux/pci.h           |    4 ++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index db710ac..6233998 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -336,6 +336,14 @@ static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return bus->subordinate;
 }
+/**
+ * pci_static_enum_set() - return %true if @dev's bridge and BAR
+ * settings have been set by a static enumeration profile
+ */
+static inline bool pci_static_enum_set(struct pci_dev *dev)
+{
+	return dev->is_static_enum;
+}
 #else
 static inline void pci_static_enum_set_opt(const char *str) { return; }
 static inline int pci_static_enum_exists(void) { return 0; }
@@ -350,6 +358,10 @@ static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return 0;
 }
+static inline bool pci_static_enum_set(struct pci_dev *dev)
+{
+	return false;
+}
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index 14626cd..7b78a85 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -372,6 +372,8 @@ static void pci_static_enum_set_bridge_memory(struct pci_dev *dev, struct pci_st
 	   memory */
 	if (root)
 		pci_walk_bus(root, pci_static_enum_invalidate, setting);
+
+	dev->is_static_enum = 1;
 }
 
 /**
@@ -515,6 +517,8 @@ static void pci_static_enum_set_mmio_bars(struct pci_dev *dev, struct pci_static
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
 		pci_static_enum_reset_mmio_bar(dev, setting, reg);
 	}
+
+	dev->is_static_enum = 1;
 }
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 418fb59..5bbc11d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1553,7 +1553,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	pci_fixup_device(pci_fixup_header, dev);
 
 	/* moved out from quirk header fixup code */
-	pci_reassigndev_resource_alignment(dev);
+	if (!pci_static_enum_set(dev))
+		pci_reassigndev_resource_alignment(dev);
 
 	/* Clear the state_saved flag. */
 	dev->state_saved = false;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b82503b..aa208f0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -334,6 +334,10 @@ struct pci_dev {
 	unsigned int	multifunction:1;/* Part of multi-function device */
 	/* keep track of device state */
 	unsigned int	is_added:1;
+#ifdef CONFIG_PCI_STATIC_ENUMERATION
+	unsigned int	is_static_enum:1;	/* static enumeration applied */
+#endif
+
 	unsigned int	is_busmaster:1; /* device is busmaster */
 	unsigned int	no_msi:1;	/* device may not use msi */
 	unsigned int	no_64bit_msi:1; /* device may only use 32-bit MSIs */
-- 
1.7.9.5

