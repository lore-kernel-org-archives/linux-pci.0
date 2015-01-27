Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:44138 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754850AbbA0SBq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jan 2015 13:01:46 -0500
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] drivers: of: fix resources freeing in of_pci_get_host_bridge_resources()
Date: Tue, 27 Jan 2015 18:01:45 +0000
Message-Id: <1422381705-5380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the function of_pci_get_host_bridge_resources() if the parsing of
ranges fails, previously allocated resources inclusive of bus_range
are not freed and are not expected to be freed by the function caller
on error return.

This patch fixes the issues by adding code that properly frees resources
and bus_range before exiting the function with an error return value.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 drivers/of/of_pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index 88471d3..60dc36c 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -140,6 +140,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 			unsigned char busno, unsigned char bus_max,
 			struct list_head *resources, resource_size_t *io_base)
 {
+	struct pci_host_bridge_window *window;
 	struct resource *res;
 	struct resource *bus_range;
 	struct of_pci_range range;
@@ -225,7 +226,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 conversion_failed:
 	kfree(res);
 parse_failed:
+	list_for_each_entry(window, resources, list)
+		kfree(window->res);
 	pci_free_resource_list(resources);
+	kfree(bus_range);
 	return err;
 }
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
-- 
2.2.1

