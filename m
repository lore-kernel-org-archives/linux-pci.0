Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13581 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbbGVVyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jul 2015 17:54:09 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>
CC: <iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH v4 11/12] x86: add pci-nommu implementation of map_peer_resource
Date: Wed, 22 Jul 2015 16:39:56 -0500
Message-ID: <1437601197-6481-12-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
References: <1437601197-6481-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Perform various checks on whether the mapping should be allowed, based on
PCIe ACS (Access Control Services) settings and the topology between the
two peers.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 arch/x86/kernel/pci-nommu.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918..58f5296 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -38,6 +38,101 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	return bus;
 }
 
+static dma_peer_addr_t nommu_map_peer_resource(struct device *dev,
+					       struct device *peer,
+					       struct resource *res,
+					       unsigned long offset,
+					       size_t size,
+					       enum dma_data_direction dir,
+					       struct dma_attrs *attrs)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_dev *ppeer = to_pci_dev(peer);
+	struct pci_dev *rpdev, *rppeer, *common_upstream;
+	struct pci_host_bridge *dev_host_bridge;
+	struct pci_host_bridge *peer_host_bridge;
+	struct pci_bus_region region;
+	dma_peer_addr_t dma_address;
+	int pos;
+	u16 cap;
+
+	/*
+	 * Disallow the peer-to-peer mapping if the devices do not share a host
+	 * bridge.
+	 */
+	dev_host_bridge = pci_find_host_bridge(pdev->bus);
+	peer_host_bridge = pci_find_host_bridge(ppeer->bus);
+	if (dev_host_bridge != peer_host_bridge)
+		return DMA_ERROR_CODE;
+
+	if (!pci_is_pcie(pdev))
+		goto out;
+
+	/*
+	 * Access Control Services (ACS) Checks
+	 *
+	 * ACS has a capability bit for P2P Request Redirects, but
+	 * unfortunately it doesn't tell us much about the real capabilities of
+	 * the hardware.
+	 */
+	rpdev = pdev->bus->self;
+	rppeer = ppeer->bus->self;
+
+	while ((rpdev) && (pci_is_pcie(rpdev)) &&
+	       (pci_pcie_type(rpdev) != PCI_EXP_TYPE_ROOT_PORT))
+		rpdev = rpdev->bus->self;
+
+	while ((rppeer) && (pci_is_pcie(rppeer)) &&
+	       (pci_pcie_type(rppeer) != PCI_EXP_TYPE_ROOT_PORT))
+		rppeer = rppeer->bus->self;
+
+	common_upstream = pci_find_common_upstream_dev(pdev, ppeer);
+
+	/* If ACS is not implemented, we have no idea about P2P support. */
+	pos = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		goto out;
+
+	/*
+	 * If the devices are under the same root port and have a common
+	 * upstream device, allow if the root port is further upstream from the
+	 * common upstream device and the common upstream device has Upstream
+	 * Forwarding disabled, or if the root port is the common upstream
+	 * device and ACS is not implemented.
+	 */
+	pci_read_config_word(rpdev, pos + PCI_ACS_CAP, &cap);
+	if ((rpdev == rppeer && common_upstream) &&
+	    (((common_upstream != rpdev) &&
+	      !pci_acs_enabled(common_upstream, PCI_ACS_UF)) ||
+	     ((common_upstream == rpdev) && ((cap & PCI_ACS_RR) == 0))))
+		goto out;
+
+	if (cap & PCI_ACS_RR) {
+		/* If ACS RR is implemented and enabled, allow the mapping */
+		if (pci_acs_enabled(rpdev, PCI_ACS_RR))
+			goto out;
+
+		/*
+		 * If ACS RR is implemented and disabled, allow if the devices
+		 * are under the same root port.
+		 */
+		if (!pci_acs_enabled(rpdev, PCI_ACS_RR) && rpdev == rppeer)
+			goto out;
+	}
+
+	return DMA_ERROR_CODE;
+
+out:
+	pcibios_resource_to_bus(pdev->bus, &region, res);
+	dma_address = region.start + offset;
+	WARN_ON(size == 0);
+	if (!check_addr("map_peer_resource", dev, dma_address, size))
+		return DMA_ERROR_CODE;
+	flush_write_buffers();
+	return dma_address;
+}
+
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scatter-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -93,6 +188,7 @@ struct dma_map_ops nommu_dma_ops = {
 	.free			= dma_generic_free_coherent,
 	.map_sg			= nommu_map_sg,
 	.map_page		= nommu_map_page,
+	.map_peer_resource	= nommu_map_peer_resource,
 	.sync_single_for_device = nommu_sync_single_for_device,
 	.sync_sg_for_device	= nommu_sync_sg_for_device,
 	.is_phys		= 1,
-- 
2.4.6

