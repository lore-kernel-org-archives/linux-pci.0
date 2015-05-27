Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:57391 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbbE0VLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 17:11:07 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v0 04/13] PCI: Track subordinate values in struct pci_bus
Date: Wed, 27 May 2015 20:58:59 +0000
Message-ID: <f63b916738c54437b9eed428872709b0@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the subordinate field to struct pci_bus. Normally,
the subordinate is automatically calculated while scanning children of
the bus and counting the number of downstream buses.

With static enumeration, a bus's subordinate may need to be greater than
the count, such as when a PCI device is powered on after initial
enumeration.  Without the subordinate field, if the newly powered device
is itself a bridge, then it will not have a valid secondary number
without reshuffling all existing devices.

By storing the bus's intended subordinate number, the scanning algorithm
can skip over reserved numbers while enumerating devices. The value 0
means to use the existing enumerating algorithm. An upcoming commit will
set that subordinate field to a non-zero value.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/pci.h   |   16 ++++++++++++++++
 drivers/pci/probe.c |   16 ++++++++++++++++
 include/linux/pci.h |    3 +++
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82..075bd9d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -321,4 +321,20 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+#ifdef CONFIG_PCI_STATIC_ENUMERATION
+/**
+ * pci_bus_subordinate() - return the subordinate bus number assigned
+ * to @dev by the static enumeration profile, or 0 if not set
+ */
+static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
+{
+	return bus->subordinate;
+}
+#else
+static inline unsigned char pci_bus_subordinate(struct pci_bus *bus)
+{
+	return 0;
+}
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 18bee64..9c3a9b2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -867,8 +867,17 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			if (!child)
 				goto out;
 			pci_bus_insert_busn_res(child, child->number, 0xff);
+			/* child's subordinate bus will be calculated
+			   during pass 2 */
 		}
+
+		/* if the child bus has a subordinate value set by a
+		   static enumeration profile, then use that bus's
+		   subordinate+1 as the next probed bus number */
+		if (max < pci_bus_subordinate(child))
+			max = pci_bus_subordinate(child);
 		max++;
+
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->busn_res.start)   <<  8)
@@ -1863,6 +1872,13 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		}
 
 	/*
+	 * Adjust max if this bus has a subordinate number specified
+	 * by the static enumeration profile
+	 */
+	if (max < pci_bus_subordinate(bus))
+		max = pci_bus_subordinate(bus);
+
+	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
 	 * any devices.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..b82503b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -461,6 +461,9 @@ struct pci_bus {
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif
+#ifdef CONFIG_PCI_STATIC_ENUMERATION
+	unsigned char	subordinate;	/* value set via static enumeration */
+#endif
 
 	char		name[48];
 
-- 
1.7.9.5
