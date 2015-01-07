Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:56822 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbAGP3v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jan 2015 10:29:51 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH 2/3] drivers: of: of_pci_get_host_bridge_resources() range parsing update
Date: Wed,  7 Jan 2015 15:29:30 +0000
Message-Id: <1420644571-18928-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some host controllers require local bus physical addresses to
programme inbound/outbound requests from the bus hierarchy to be routed
properly through the PCI bus beyond the host controller. Owing
to bus address size conversion, the bus local addresses may be different
from the addresses as seen from the CPU (which are translated by DT core
code), so the PCI range parsing function:

of_pci_get_host_bridge_resources()

should be augmented in order to store the range parser along
with the parsed resource so that the CPU untranslated address can
be retrieved by the driver from the corresponding PCI range if needed.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/of/of_pci.c        | 38 +++++++++++++++++++++++++++++---------
 include/linux/of_address.h |  5 +++++
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 6fbfe99..f0e576f 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -144,6 +144,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	struct resource *bus_range;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
+	struct of_pci_resource *of_pci_res;
 	char range_type[4];
 	int err;
 	struct pci_host_bridge_window *window;
@@ -151,12 +152,14 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	if (io_base)
 		*io_base = (resource_size_t)OF_BAD_ADDR;
 
-	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
-	if (!bus_range)
+	of_pci_res = kzalloc(sizeof(*of_pci_res), GFP_KERNEL);
+	if (!of_pci_res)
 		return -ENOMEM;
 
 	pr_info("PCI host bridge %s ranges:\n", dev->full_name);
 
+	bus_range = &of_pci_res->res;
+
 	err = of_pci_parse_bus_range(dev, bus_range);
 	if (err) {
 		bus_range->start = busno;
@@ -195,17 +198,29 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;
 
-		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
-		if (!res) {
+		of_pci_res = kzalloc(sizeof(*of_pci_res), GFP_KERNEL);
+		if (!of_pci_res) {
 			err = -ENOMEM;
 			goto parse_failed;
 		}
+		res = &of_pci_res->res;
 
 		err = of_pci_range_to_resource(&range, dev, res);
 		if (err)
 			goto conversion_failed;
 
-		if (resource_type(res) == IORESOURCE_IO) {
+		/* Stash the range parser */
+		of_pci_res->parser = parser;
+		/*
+		 * for_each_of_pci_range increments the range pointer
+		 * in the parser, so that it is ready to parse the
+		 * following range while looping; rewind the range pointer
+		 * to its current value to pass it to the drivers with its
+		 * initial value.
+		 */
+		of_pci_res->parser.range -= parser.np;
+
+		if  (resource_type(res) == IORESOURCE_IO) {
 			if (!io_base) {
 				pr_err("I/O range found for %s. Please provide an io_base pointer to save CPU base address\n",
 					dev->full_name);
@@ -224,12 +239,17 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 	return 0;
 
 conversion_failed:
-	kfree(res);
+	kfree(of_pci_res);
 parse_failed:
-	list_for_each_entry(window, resources, list)
-		kfree(window->res);
+	list_for_each_entry(window, resources, list) {
+		of_pci_res = container_of(window->res, struct of_pci_resource,
+					  res);
+		kfree(of_pci_res);
+	}
 	pci_free_resource_list(resources);
-	kfree(bus_range);
+	of_pci_res = container_of(bus_range, struct of_pci_resource,
+				  res);
+	kfree(of_pci_res);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index d88e81b..e4005be 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -20,6 +20,11 @@ struct of_pci_range {
 	u32 flags;
 };
 
+struct of_pci_resource {
+	struct resource res;
+	struct of_pci_range_parser parser;
+};
+
 #define for_each_of_pci_range(parser, range) \
 	for (; of_pci_range_parser_one(parser, range);)
 
-- 
2.2.1

