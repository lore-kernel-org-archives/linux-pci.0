Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12616 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbbERSig (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 14:38:36 -0400
From: <wdavis@nvidia.com>
To: <joro@8bytes.org>, <bhelgaas@google.com>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<tripperda@nvidia.com>, <jhubbard@nvidia.com>,
	<jglisse@redhat.com>, <konrad.wilk@oracle.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH v2 7/7] x86: add pci-nommu implementation of map_resource
Date: Mon, 18 May 2015 13:25:04 -0500
Message-ID: <1431973504-5903-8-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
References: <1431973504-5903-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Will Davis <wdavis@nvidia.com>

Lookup the bus address of the resource by finding the parent host bridge,
which may be different than the parent host bridge of the target device.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/kernel/pci-nommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918..6384482 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -38,6 +38,37 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
+static dma_addr_t nommu_map_resource(struct device *dev, struct resource *res,
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir,
+				     struct dma_attrs *attrs)
+{
+	struct pci_bus *bus;
+	struct pci_host_bridge *bridge;
+	struct resource_entry *window;
+	resource_size_t bus_offset = 0;
+	dma_addr_t dma_address;
+
+	/* Find the parent host bridge of the resource, and determine the
+	 * relative offset.
+	 */
+	list_for_each_entry(bus, &pci_root_buses, node) {
+		bridge = to_pci_host_bridge(bus->bridge);
+		resource_list_for_each_entry(window, &bridge->windows) {
+			if (resource_contains(window->res, res))
+				bus_offset = window->offset;
+		}
+	}
+
+	dma_address = (res->start - bus_offset) + offset;
+	WARN_ON(size == 0);
+	if (!check_addr("map_resource", dev, dma_address, size))
+		return DMA_ERROR_CODE;
+	flush_write_buffers();
+	return dma_address;
+}
+
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scatter-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -93,6 +124,7 @@ struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
+	.map_resource		= nommu_map_resource,
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
-- 
2.4.0

