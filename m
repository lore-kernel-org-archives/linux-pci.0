Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:40781 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab2LLQhy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Dec 2012 11:37:54 -0500
Date: Wed, 12 Dec 2012 16:37:50 +0000
From: Andrew Murray <Andrew.Murray@arm.com>
To: linux-pci@vger.kernel.org
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robherring2@gmail.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Liviu Dudau <liviu.dudau@arm.com>
Subject: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20121212163749.GA17371@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

DT bindings for PCI host bridges often use the ranges property to describe
memory and IO ranges - this binding tends to be the same across architectures
yet several parsing implementations exist, e.g. arch/mips/pci/pci.c,
arch/powerpc/kernel/pci-common.c, arch/sparc/kernel/pci.c and
arch/microblaze/pci/pci-common.c (clone of PPC). Some of these duplicate
functionality provided by drivers/of/address.c.

This patch provides a common iterator-based parser for the ranges property, it
is hoped this will reduce DT representation differences between architectures
and that architectures will migrate in part to this new parser.

It is also hoped (and the motativation for the patch) that this patch will
reduce duplication of code when writing host bridge drivers that are supported
by multiple architectures.

This patch provides struct resources from a device tree node, e.g.:

	u32 *last = NULL;
	struct resource res;
	while ((last = of_pci_process_ranges(np, res, last))) {
		//do something with res
	}

Platforms with quirks can then do what they like with the resource or migrate
common quirk handling to the parser. In an ideal world drivers can just request
the obtained resources and pass them on (e.g. pci_add_resource_offset).

Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
---
 drivers/of/address.c       |   53 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/of_address.h |    7 +++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 7e262a6..03bfe61 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -219,6 +219,57 @@ int of_pci_address_to_resource(struct device_node *dev, int bar,
 	return __of_address_to_resource(dev, addrp, size, flags, NULL, r);
 }
 EXPORT_SYMBOL_GPL(of_pci_address_to_resource);
+
+const __be32 *of_pci_process_ranges(struct device_node *node,
+				    struct resource *res, const __be32 *from)
+{
+	const __be32 *start, *end;
+	int na, ns, np, pna;
+	int rlen;
+	struct of_bus *bus;
+	WARN_ON(!res);
+
+	bus = of_match_bus(node);
+	bus->count_cells(node, &na, &ns);
+	if (!OF_CHECK_COUNTS(na, ns)) {
+		pr_err("Bad cell count for %s\n", node->full_name);
+		return NULL;
+	}
+
+	pna = of_n_addr_cells(node);
+	np = pna + na + ns;
+
+	start = of_get_property(node, "ranges", &rlen);
+	if (start == NULL)
+		return NULL;
+
+	end = start + rlen;
+
+	if (!from)
+		from = start;
+
+	while (from + np <= end) {
+		u64 cpu_addr, size;
+
+		cpu_addr = of_translate_address(node, from + na);
+		size = of_read_number(from + na + pna, ns);
+		res->flags = bus->get_flags(from);
+		from += np;
+
+		if (cpu_addr == OF_BAD_ADDR || size == 0)
+			continue;
+
+		res->name = node->full_name;
+		res->start = cpu_addr;
+		res->end = res->start + size - 1;
+		res->parent = res->child = res->sibling = NULL;
+		return from;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(of_pci_process_ranges);
+
 #endif /* CONFIG_PCI */
 
 /*
@@ -421,7 +472,7 @@ u64 __of_translate_address(struct device_node *dev, const __be32 *in_addr,
 		goto bail;
 	bus = of_match_bus(parent);
 
-	/* Cound address cells & copy address locally */
+	/* Count address cells & copy address locally */
 	bus->count_cells(dev, &na, &ns);
 	if (!OF_CHECK_COUNTS(na, ns)) {
 		printk(KERN_ERR "prom_parse: Bad cell count for %s\n",
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index 01b925a..4582b20 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -26,6 +26,8 @@ static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
 #define pci_address_to_pio pci_address_to_pio
 #endif
 
+const __be32 *of_pci_process_ranges(struct device_node *node,
+				    struct resource *res, const __be32 *from);
 #else /* CONFIG_OF_ADDRESS */
 static inline int of_address_to_resource(struct device_node *dev, int index,
 					 struct resource *r)
@@ -48,6 +50,11 @@ static inline const u32 *of_get_address(struct device_node *dev, int index,
 {
 	return NULL;
 }
+const __be32 *of_pci_process_ranges(struct device_node *node,
+				    struct resource *res, const __be32 *from)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF_ADDRESS */
 
 
-- 
1.7.0.4


