Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57391 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbbE0VLJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:09 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 07/13] PCI: Calculate child's bus number based upon
 enumeration
Date: Wed, 27 May 2015 20:59:15 +0000
Message-ID: <241508a7908d4b82952d292d01c8ebc6@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

While scanning a bridge, pci_scan_bridge() checks if a child pci_bus
already exists by looking up its bus number. It uses the value
'max+1' as the expected child bus number. If the child does not exist,
pci_scan_bridge() will create a new pci_bus for the child.

While rescanning the same bridge, pci_scan_bridge() assumes an existing
child's bus number is 'max+1'. This is not always true, given a static
enumeration profile. The profile may intentionally skip bus numbers.
Thus, the child's number is not necessarily 'max+1'.

This commit changes the scanning behavior slightly. If the device being
scanned has an enumeration profile, then pci_scan_bridge() will use
that number when searching for it. Otherwise it falls back to the
default 'max+1' bus number.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci.h             |    7 +++++++
 drivers/pci/pci_static_enum.c |   24 ++++++++++++++++++++++++
 drivers/pci/probe.c           |    6 ++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 7a051f5..665c798 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -325,6 +325,8 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 void pci_static_enum_set_opt(const char *str);
 int pci_static_enum_exists(void);
 void pci_static_enum_bus_nums(struct pci_bus *bus);
+int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
+			      int default_busnr);
 /**
  * pci_bus_subordinate() - return the subordinate bus number assigned
  * to @dev by the static enumeration profile, or 0 if not set
@@ -337,6 +339,11 @@ static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 static inline void pci_static_enum_set_opt(const char *str) { return; }
 static inline int pci_static_enum_exists(void) { return 0; }
 static inline void pci_static_enum_bus_nums(struct pci_bus *bus) { return; }
+static inline int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
+					    int default_busnr)
+{
+	return default_busnr;
+}
 static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
 {
 	return 0;
diff --git a/drivers/pci/pci_static_enum.c b/drivers/pci/pci_static_enum.c
index dda9055..dbdc973 100644
--- a/drivers/pci/pci_static_enum.c
+++ b/drivers/pci/pci_static_enum.c
@@ -225,3 +225,27 @@ void pci_static_enum_bus_nums(struct pci_bus *bus)
 	bus->number = bus->busn_res.start = setting->secondary_bus;
 	bus->subordinate = setting->subordinate_bus;
 }
+
+/**
+ * pci_static_enum_get_busnr() - calculate bus number for a device
+ * @bus: bus contain @dev
+ * @dev: PCI device to lookup
+ * @default_num: default bus number
+ * Return: expected bus number for @dev, or @default_num if @dev has
+ * no if @dev has no static enumeration profile
+ */
+int pci_static_enum_get_busnr(struct pci_bus *bus, struct pci_dev *dev,
+			      int default_num)
+{
+	struct pci_static_enum_setting *setting;
+
+	if (!bus || !dev)
+		return default_num;
+
+	setting =
+	    pci_static_enum_find_setting(pci_domain_nr(bus), bus->number,
+					 dev->devfn);
+	if (setting)
+		return setting->secondary_bus;
+	return default_num;
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a7bf7c5..b3e7db4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -777,6 +777,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 	u16 bctl;
 	u8 primary, secondary, subordinate;
 	int broken = 0;
+	int child_busnr;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 	primary = buses & 0xFF;
@@ -867,9 +868,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		/* Prevent assigning a bus number that already exists.
 		 * This can happen when a bridge is hot-plugged, so in
 		 * this case we only re-scan this bus. */
-		child = pci_find_bus(pci_domain_nr(bus), max+1);
+		child_busnr  = pci_static_enum_get_busnr(bus, dev, max+1);
+		child = pci_find_bus(pci_domain_nr(bus), child_busnr);
 		if (!child) {
-			child = pci_add_new_bus(bus, dev, max+1);
+			child = pci_add_new_bus(bus, dev, child_busnr);
 			if (!child)
 				goto out;
 			pci_bus_insert_busn_res(child, child->number, 0xff);
-- 
1.7.9.5

