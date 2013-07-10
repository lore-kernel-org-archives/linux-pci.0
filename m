Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7494 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219Ab3GJWLM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 10 Jul 2013 18:11:12 -0400
Subject: [RFC PATCH 2/2] iommu/intel: Make use of PCIe requester ID interface
To: bhelgaas@google.com
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, joro@8bytes.org,
	iommu@lists.linux-foundation.org, acooks@gmail.com,
	ddutile@redhat.com, dwmw2@infradead.org
Date: Wed, 10 Jul 2013 16:10:45 -0600
Message-ID: <20130710221045.3045.59854.stgit@bling.home>
In-Reply-To: <20130710215954.3045.89568.stgit@bling.home>
References: <20130710215954.3045.89568.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This eliminates uses of pci_find_upstream_pcie_bridge() and
incorporates DMA quirks into dma_ops path.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel-iommu.c |  164 +++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 100 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b4f0e28..1e210e1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1675,80 +1675,59 @@ static int domain_context_mapping_one(struct dmar_domain *domain, int segment,
 	return 0;
 }
 
-static int
-domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
-			int translation)
+struct context_mapping_info {
+	struct dmar_domain *domain;
+	int translation;
+};
+
+static int context_mapping(struct pci_dev *dev, u16 requester_id, void *data)
 {
-	int ret;
-	struct pci_dev *tmp, *parent;
+	struct context_mapping_info *info = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
 
-	ret = domain_context_mapping_one(domain, pci_domain_nr(pdev->bus),
-					 pdev->bus->number, pdev->devfn,
-					 translation);
-	if (ret)
-		return ret;
+	return domain_context_mapping_one(info->domain, pci_domain_nr(dev->bus),
+					  bus, devfn, info->translation);
+}
 
-	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
-		return 0;
-	/* Secondary interface's bus number and devfn 0 */
-	parent = pdev->bus->self;
-	while (parent != tmp) {
-		ret = domain_context_mapping_one(domain,
-						 pci_domain_nr(parent->bus),
-						 parent->bus->number,
-						 parent->devfn, translation);
-		if (ret)
-			return ret;
-		parent = parent->bus->self;
-	}
-	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
-		return domain_context_mapping_one(domain,
-					pci_domain_nr(tmp->subordinate),
-					tmp->subordinate->number, 0,
-					translation);
-	else /* this is a legacy PCI bridge */
-		return domain_context_mapping_one(domain,
-						  pci_domain_nr(tmp->bus),
-						  tmp->bus->number,
-						  tmp->devfn,
-						  translation);
+static int domain_context_mapping(struct dmar_domain *domain,
+				  struct pci_dev *pdev, int translation)
+{
+	struct context_mapping_info info = {
+		.domain = domain,
+		.translation = translation,
+	};
+
+	return pcie_for_each_requester(pdev, NULL, context_mapping, &info);
+}
+
+static int is_context_mapped(struct pci_dev *dev, u16 requester_id, void *data)
+{
+	struct intel_iommu *iommu = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
+
+	if (!device_context_mapped(iommu, bus, devfn))
+		return 1; /* stop */
+
+	return 0;
 }
 
 static int domain_context_mapped(struct pci_dev *pdev)
 {
-	int ret;
-	struct pci_dev *tmp, *parent;
 	struct intel_iommu *iommu;
+	int ret;
 
-	iommu = device_to_iommu(pci_domain_nr(pdev->bus), pdev->bus->number,
-				pdev->devfn);
+	iommu = device_to_iommu(pci_domain_nr(pdev->bus),
+				pdev->bus->number, pdev->devfn);
 	if (!iommu)
 		return -ENODEV;
 
-	ret = device_context_mapped(iommu, pdev->bus->number, pdev->devfn);
-	if (!ret)
-		return ret;
-	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
+	ret = pcie_for_each_requester(pdev, NULL, is_context_mapped, iommu);
+	if (ret < 0)
 		return ret;
-	/* Secondary interface's bus number and devfn 0 */
-	parent = pdev->bus->self;
-	while (parent != tmp) {
-		ret = device_context_mapped(iommu, parent->bus->number,
-					    parent->devfn);
-		if (!ret)
-			return ret;
-		parent = parent->bus->self;
-	}
-	if (pci_is_pcie(tmp))
-		return device_context_mapped(iommu, tmp->subordinate->number,
-					     0);
-	else
-		return device_context_mapped(iommu, tmp->bus->number,
-					     tmp->devfn);
+
+	return (ret == 0);
 }
 
 /* Returns a number of VTD pages, but aligned to MM page size */
@@ -1986,15 +1965,12 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	segment = pci_domain_nr(pdev->bus);
 
-	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (dev_tmp) {
-		if (pci_is_pcie(dev_tmp)) {
-			bus = dev_tmp->subordinate->number;
-			devfn = 0;
-		} else {
-			bus = dev_tmp->bus->number;
-			devfn = dev_tmp->devfn;
-		}
+	dev_tmp = pci_get_visible_pcie_requester(pdev, NULL);
+	if (dev_tmp && dev_tmp != pdev) {
+		u16 requester_id = pci_requester_id(dev_tmp, pdev);
+		u8 bus = requester_id >> 8;
+		u8 devfn = requester_id & 0xFF;
+
 		spin_lock_irqsave(&device_domain_lock, flags);
 		list_for_each_entry(info, &device_domain_list, global) {
 			if (info->segment == segment &&
@@ -3749,31 +3725,24 @@ int __init intel_iommu_init(void)
 	return 0;
 }
 
+static int detach_requester(struct pci_dev *dev, u16 requester_id, void *data)
+{
+	struct intel_iommu *iommu = data;
+	u8 bus = requester_id >> 8;
+	u8 devfn = requester_id & 0xFF;
+
+	iommu_detach_dev(iommu, bus, devfn);
+	return 0;
+}
+
 static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 					   struct pci_dev *pdev)
 {
-	struct pci_dev *tmp, *parent;
-
 	if (!iommu || !pdev)
 		return;
 
-	/* dependent device detach */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	/* Secondary interface's bus number and devfn 0 */
-	if (tmp) {
-		parent = pdev->bus->self;
-		while (parent != tmp) {
-			iommu_detach_dev(iommu, parent->bus->number,
-					 parent->devfn);
-			parent = parent->bus->self;
-		}
-		if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
-			iommu_detach_dev(iommu,
-				tmp->subordinate->number, 0);
-		else /* this is a legacy PCI bridge */
-			iommu_detach_dev(iommu, tmp->bus->number,
-					 tmp->devfn);
-	}
+	/* XXX What if there's something else using his path? */
+	pcie_for_each_requester(pdev, NULL, detach_requester, iommu);
 }
 
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
@@ -4158,7 +4127,7 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev = NULL;
+	struct pci_dev *dma_pdev = NULL;
 	struct iommu_group *group;
 	int ret;
 
@@ -4166,16 +4135,11 @@ static int intel_iommu_add_device(struct device *dev)
 			     pdev->bus->number, pdev->devfn))
 		return -ENODEV;
 
-	bridge = pci_find_upstream_pcie_bridge(pdev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))
-			dma_pdev = pci_get_domain_bus_and_slot(
-						pci_domain_nr(pdev->bus),
-						bridge->subordinate->number, 0);
-		if (!dma_pdev)
-			dma_pdev = pci_dev_get(bridge);
-	} else
-		dma_pdev = pci_dev_get(pdev);
+	dma_pdev = pci_get_visible_pcie_requester(pdev, NULL);
+	if (!dma_pdev)
+		return -EINVAL;
+
+	dma_pdev = pci_dev_get(dma_pdev);
 
 	/* Account for quirked devices */
 	swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));

