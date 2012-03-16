Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-fa0-f74.google.com ([209.85.161.74]:51086 "EHLO
	mail-fa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946291Ab2CPXsQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Mar 2012 19:48:16 -0400
Received: by mail-fa0-f74.google.com with SMTP id a19so214757faa.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Mar 2012 16:48:15 -0700 (PDT)
Subject: [PATCH v2 4/7] powerpc/PCI: convert devtree bus addresses to resource
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 16 Mar 2012 17:48:14 -0600
Message-ID: <20120316234814.6649.47469.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Normal PCI enumeration via PCI config space uses __pci_read_base(), where
the PCI core applies any bus-to-resource offset.  But powerpc doesn't use
that path when enumerating via the device tree.

In 6c5705fec63d, I converted powerpc to use the PCI core bus-to-resource
conversion, but I missed these powerpc-specific paths.  Some powerpc
platforms fail to boot ("Cannot allocate resource region," "device not
available," etc.) between that commit and this one.

This adds the corresponding bus-to-resource conversion in the paths that
read BAR values from the OF device tree.

CC: Anton Blanchard <anton@samba.org>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/kernel/pci_of_scan.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b37d0b5..89dde17 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -75,6 +75,7 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 {
 	u64 base, size;
 	unsigned int flags;
+	struct pci_bus_region region;
 	struct resource *res;
 	const u32 *addrs;
 	u32 i;
@@ -106,10 +107,11 @@ static void of_pci_parse_addrs(struct device_node *node, struct pci_dev *dev)
 			printk(KERN_ERR "PCI: bad cfg reg num 0x%x\n", i);
 			continue;
 		}
-		res->start = base;
-		res->end = base + size - 1;
 		res->flags = flags;
 		res->name = pci_name(dev);
+		region.start = base;
+		region.end = base + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 }
 
@@ -209,6 +211,7 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 	struct pci_bus *bus;
 	const u32 *busrange, *ranges;
 	int len, i, mode;
+	struct pci_bus_region region;
 	struct resource *res;
 	unsigned int flags;
 	u64 size;
@@ -270,9 +273,10 @@ void __devinit of_scan_pci_bridge(struct pci_dev *dev)
 			res = bus->resource[i];
 			++i;
 		}
-		res->start = of_read_number(&ranges[1], 2);
-		res->end = res->start + size - 1;
 		res->flags = flags;
+		region.start = of_read_number(&ranges[1], 2);
+		region.end = region.start + size - 1;
+		pcibios_bus_to_resource(dev, res, &region);
 	}
 	sprintf(bus->name, "PCI Bus %04x:%02x", pci_domain_nr(bus),
 		bus->number);

