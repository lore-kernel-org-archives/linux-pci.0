Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xspv0103.northgrum.com ([134.223.120.78]:13364 "EHLO
	xspv0103.northgrum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbIQVWf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 17:22:35 -0400
From: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: [PATCH v1 2/7] PCI: Track subordinate values in struct pci_bus
Date: Thu, 17 Sep 2015 21:10:55 +0000
Message-ID: <2014ce5807474d70b101b601a29c3550@XCGVAG27.northgrum.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This commit adds the field 'subordinate' to struct pci_bus.  Normally,
the subordinate is automatically calculated while scanning children of
the bus and counting their downstream buses.

This heuristic fails for hot-added bridges.  A hot-added bridge will
need to increase its subordinate if additional bridges are hot-added
underneath it.  Without the 'subordinate' field, newly added bridges
will not have a valid secondary number, without reshuffling all
existing devices.

By storing the bus's intended subordinate number, the scanning
algorithm can skip over reserved numbers while enumerating devices.  A
subordinate value of 0 means to use the existing enumeration
algorithm.  An upcoming commit will set that subordinate field to a
non-zero value.

Signed-off-by: Jason Tang <jason.tang2@ngc.com>
---
 drivers/pci/probe.c | 23 ++++++++++++++++++++---
 include/linux/pci.h |  1 +
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c905db3..58ae892 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -863,8 +863,17 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			if (!child)
 				goto out;
 			pci_bus_insert_busn_res(child, child->number, 0xff);
+			/* child's subordinate bus will be calculated
+			   during pass 2 */
 		}
-		max++;
+
+		/* if the child bus has a subordinate value set, then
+		   use that bus's subordinate+1 as the next probed bus
+		   number */
+		if (max < child->subordinate)
+			max = child->subordinate + 1;
+		else
+			max++;
 		buses = (buses & 0xff000000)
 		      | ((unsigned int)(child->primary)     <<  0)
 		      | ((unsigned int)(child->busn_res.start)   <<  8)
@@ -921,8 +930,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 		/*
 		 * Set the subordinate bus number to its real value.
 		 */
-		pci_bus_update_busn_res_end(child, max);
-		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
+		child->subordinate = max;
+		pci_bus_update_busn_res_end(child, child->subordinate);
+		pci_write_config_byte(dev, PCI_SUBORDINATE_BUS,
+				      child->subordinate);
 	}
 
 	sprintf(child->name,
@@ -1896,6 +1907,12 @@ unsigned int pci_scan_child_bus(struct pci_bus *bus)
 		}
 
 	/*
+	 * Adjust max if this bus has a set subordinate number
+	 */
+	if (max < bus->subordinate)
+		max = bus->subordinate;
+
+	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
 	 * any devices.
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a..384106c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -458,6 +458,7 @@ struct pci_bus {
 
 	unsigned char	number;		/* bus number */
 	unsigned char	primary;	/* number of primary bridge */
+	unsigned char	subordinate;	/* subordinate number on secondary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-- 
1.8.3.1

