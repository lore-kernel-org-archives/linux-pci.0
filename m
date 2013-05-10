Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:8917 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab3EJVTP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 May 2013 17:19:15 -0400
Subject: [PATCH 2/3] intel-iommu: Convert to pci_walk_up_to_first_match
To: bhelgaas@google.com, stephen@networkplumber.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
	dwmw2@infradead.org, ddutile@redhat.com
Date: Fri, 10 May 2013 15:18:52 -0600
Message-ID: <20130510211852.32592.54120.stgit@bling.home>
In-Reply-To: <20130510210937.32592.21950.stgit@bling.home>
References: <20130510210937.32592.21950.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_find_upstream_pcie_bridge() attempts to return the PCIe-to-PCI
bridge upstream from the provided device.  It currently returns NULL
if 1) the provided device is PCIe (ie. it does not have such an
upstream bridge), 2) the device is on the root bus (a subtle case of
its claim to return the parent device when not connected to a PCIe
bridge), or 3) when it gets lost walking the bus and finds itself on
a PCIe device that is not a PCIe-to-PCI bridge.  This latter case not
only generates a WARN, but treats the provided device the same as if
it were PCIe.

We can replace 1) and 2) with explicit tests in the IOMMU code as this
is the code that knows the visibility of devices at the root bus.
That leaves the bus walk case 3), where the NULL return is actually an
error.

We hit this error because some PCIe-to-PCI bridge vendors ignore the
PCIe spec requirement that all PCIe devices must include a PCIe
capability, which is all that pci_is_pcie() actually tests.  When
quirks are enabled, pci_is_pcie_bridge() adds one more test by looking
at the next upstream device to test whether it is PCIe with a type
code of a PCIe-to-PCI/PCI-X bridge.  If it does not have this type
code, then by deduction, the current bridge must be a PCIe-to-PCI
bridge and thus be a PCIe bridge.

Therefore, pci_find_upstream_pcie_bridge() is replaced by an
explicit call to (pci_is_pcie() || pci_is_root_bus()) plus
pci_walk_up_to_first_match() with the pci_is_pcie_bridge() match
function.  This either returns the first PCIe bridge, which must
be a PCIe-to-PCI bridge or NULL if not found.  In the NULL case, we
know the original device is not on the root bus (already tested for
that), so we can safely walk from the provided device to the last
device and fall into the legacy PCI bridge code.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
 drivers/iommu/intel_irq_remapping.c |   13 ++++--
 2 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0099667..277c18f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1688,9 +1688,13 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 		return ret;
 
 	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
+	if (pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
 		return 0;
+
+	tmp = pci_walk_up_to_first_match(pdev, pci_is_pcie_bridge, &parent);
+	if (!tmp)
+		tmp = parent;
+
 	/* Secondary interface's bus number and devfn 0 */
 	parent = pdev->bus->self;
 	while (parent != tmp) {
@@ -1702,7 +1706,7 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 			return ret;
 		parent = parent->bus->self;
 	}
-	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
+	if (pci_is_pcie_bridge(tmp)) /* this is a PCIe-to-PCI bridge */
 		return domain_context_mapping_one(domain,
 					pci_domain_nr(tmp->subordinate),
 					tmp->subordinate->number, 0,
@@ -1729,10 +1733,15 @@ static int domain_context_mapped(struct pci_dev *pdev)
 	ret = device_context_mapped(iommu, pdev->bus->number, pdev->devfn);
 	if (!ret)
 		return ret;
+
 	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
+	if (pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
+		return 0;
+
+	tmp = pci_walk_up_to_first_match(pdev, pci_is_pcie_bridge, &parent);
 	if (!tmp)
-		return ret;
+		tmp = parent;
+
 	/* Secondary interface's bus number and devfn 0 */
 	parent = pdev->bus->self;
 	while (parent != tmp) {
@@ -1742,7 +1751,7 @@ static int domain_context_mapped(struct pci_dev *pdev)
 			return ret;
 		parent = parent->bus->self;
 	}
-	if (pci_is_pcie(tmp))
+	if (pci_is_pcie_bridge(tmp))
 		return device_context_mapped(iommu, tmp->subordinate->number,
 					     0);
 	else
@@ -1973,7 +1982,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	struct intel_iommu *iommu;
 	struct dmar_drhd_unit *drhd;
 	struct device_domain_info *info, *tmp;
-	struct pci_dev *dev_tmp;
+	struct pci_dev *dev_tmp = NULL;
 	unsigned long flags;
 	int bus = 0, devfn = 0;
 	int segment;
@@ -1985,9 +1994,15 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	segment = pci_domain_nr(pdev->bus);
 
-	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (dev_tmp) {
-		if (pci_is_pcie(dev_tmp)) {
+	if (!pci_is_pcie(pdev) && !pci_is_root_bus(pdev->bus)) {
+		struct pci_dev *last;
+
+		dev_tmp = pci_walk_up_to_first_match(pdev, pci_is_pcie_bridge,
+						     &last);
+		if (!dev_tmp)
+			dev_tmp = last;
+
+		if (pci_is_pcie_bridge(dev_tmp)) {
 			bus = dev_tmp->subordinate->number;
 			devfn = 0;
 		} else {
@@ -3738,26 +3753,24 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 {
 	struct pci_dev *tmp, *parent;
 
-	if (!iommu || !pdev)
+	if (!iommu || !pdev || pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
 		return;
 
 	/* dependent device detach */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
+	tmp = pci_walk_up_to_first_match(pdev, pci_is_pcie_bridge, &parent);
+	if (!tmp)
+		tmp = parent;
+
 	/* Secondary interface's bus number and devfn 0 */
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
+	parent = pdev->bus->self;
+	while (parent != tmp) {
+		iommu_detach_dev(iommu, parent->bus->number, parent->devfn);
+		parent = parent->bus->self;
 	}
+	if (pci_is_pcie_bridge(tmp)) /* this is a PCIe-to-PCI bridge */
+		iommu_detach_dev(iommu, tmp->subordinate->number, 0);
+	else /* this is a legacy PCI bridge */
+		iommu_detach_dev(iommu, tmp->bus->number, tmp->devfn);
 }
 
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
@@ -4148,7 +4161,7 @@ static void swap_pci_ref(struct pci_dev **from, struct pci_dev *to)
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev = NULL;
+	struct pci_dev *dma_pdev = NULL;
 	struct iommu_group *group;
 	int ret;
 
@@ -4156,9 +4169,15 @@ static int intel_iommu_add_device(struct device *dev)
 			     pdev->bus->number, pdev->devfn))
 		return -ENODEV;
 
-	bridge = pci_find_upstream_pcie_bridge(pdev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))
+	if (!pci_is_pcie(pdev) && !pci_is_root_bus(pdev->bus)) {
+		struct pci_dev *bridge, *last;
+
+		bridge = pci_walk_up_to_first_match(pdev, pci_is_pcie_bridge,
+						    &last);
+		if (!bridge)
+			bridge = last;
+
+		if (pci_is_pcie_bridge(bridge))
 			dma_pdev = pci_get_domain_bus_and_slot(
 						pci_domain_nr(pdev->bus),
 						bridge->subordinate->number, 0);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index f3b8f23..873da76 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -373,7 +373,6 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 
 static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 {
-	struct pci_dev *bridge;
 
 	if (!irte || !dev)
 		return -1;
@@ -385,9 +384,15 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		return 0;
 	}
 
-	bridge = pci_find_upstream_pcie_bridge(dev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))/* this is a PCIe-to-PCI/PCIX bridge */
+	if (!pci_is_pcie(dev) && !pci_is_root_bus(dev->bus)) {
+		struct pci_dev *bridge, *last;
+
+		bridge = pci_walk_up_to_first_match(dev,
+						    pci_is_pcie_bridge, &last);
+		if (!bridge)
+			bridge = last;
+
+		if (pci_is_pcie_bridge(bridge)) /* PCIe-to-PCI/PCIX bridge */
 			set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
 				(bridge->bus->number << 8) | dev->bus->number);
 		else /* this is a legacy PCI bridge */

