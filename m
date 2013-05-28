Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53821 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752548Ab3E1Skw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 May 2013 14:40:52 -0400
Subject: [PATCH v2 2/2] intel-iommu: Convert to iommu_pci_find_upstream +
 iommu_pci_is_pcie_bridge
To: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org
From: Alex Williamson <alex.williamson@redhat.com>
Cc: stephen@networkplumber.org, linux-pci@vger.kernel.org,
	ddutile@redhat.com
Date: Tue, 28 May 2013 12:40:26 -0600
Message-ID: <20130528184026.3318.52167.stgit@bling.home>
In-Reply-To: <20130528183527.3318.5365.stgit@bling.home>
References: <20130528183527.3318.5365.stgit@bling.home>
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
PCI quirks are enabled, iommu_pci_is_pcie_bridge() adds one more test
by looking at the next upstream device to test whether it is PCIe with
a type code of a PCIe-to-PCI/PCI-X bridge.  If it does not have this
type code, then by deduction, the current bridge must be a PCIe-to-PCI
bridge and thus be a PCIe bridge.

Therefore, pci_find_upstream_pcie_bridge() is replaced by an
explicit call to (pci_is_pcie() || pci_is_root_bus()) plus
iommu_pci_find_upstream() with the iommu_pci_is_pcie_bridge() match
function.  This either returns the first PCIe bridge, which must
be a PCIe-to-PCI bridge or NULL if not found.  In the NULL case, we
know the original device is not on the root bus (already tested for
that), so we can safely walk from the provided device to the last
device and fall into the legacy PCI bridge code.

Fixes https://bugzilla.kernel.org/show_bug.cgi?id=44881

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/iommu/Kconfig               |    2 +
 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-------------
 drivers/iommu/intel_irq_remapping.c |   15 +++++--
 3 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a591794..71ec2d5 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -85,6 +85,7 @@ config INTEL_IOMMU
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
 	select IOMMU_API
 	select DMAR_TABLE
+	select IOMMU_PCI
 	help
 	  DMA remapping (DMAR) devices support enables independent address
 	  translations for Direct Memory Access (DMA) from devices.
@@ -125,6 +126,7 @@ config IRQ_REMAP
 	bool "Support for Interrupt Remapping"
 	depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
 	select DMAR_TABLE
+	select IOMMU_PCI
 	---help---
 	  Supports Interrupt remapping for IO-APIC and MSI devices.
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index b4f0e28..3748187 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1689,9 +1689,13 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 		return ret;
 
 	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (!tmp)
+	if (pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
 		return 0;
+
+	tmp = iommu_pci_find_upstream(pdev, iommu_pci_is_pcie_bridge, &parent);
+	if (!tmp)
+		tmp = parent;
+
 	/* Secondary interface's bus number and devfn 0 */
 	parent = pdev->bus->self;
 	while (parent != tmp) {
@@ -1703,7 +1707,7 @@ domain_context_mapping(struct dmar_domain *domain, struct pci_dev *pdev,
 			return ret;
 		parent = parent->bus->self;
 	}
-	if (pci_is_pcie(tmp)) /* this is a PCIe-to-PCI bridge */
+	if (iommu_pci_is_pcie_bridge(tmp)) /* this is a PCIe-to-PCI bridge */
 		return domain_context_mapping_one(domain,
 					pci_domain_nr(tmp->subordinate),
 					tmp->subordinate->number, 0,
@@ -1731,9 +1735,13 @@ static int domain_context_mapped(struct pci_dev *pdev)
 	if (!ret)
 		return ret;
 	/* dependent device mapping */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
+	if (pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
+		return 0;
+
+	tmp = iommu_pci_find_upstream(pdev, iommu_pci_is_pcie_bridge, &parent);
 	if (!tmp)
-		return ret;
+		tmp = parent;
+
 	/* Secondary interface's bus number and devfn 0 */
 	parent = pdev->bus->self;
 	while (parent != tmp) {
@@ -1743,7 +1751,7 @@ static int domain_context_mapped(struct pci_dev *pdev)
 			return ret;
 		parent = parent->bus->self;
 	}
-	if (pci_is_pcie(tmp))
+	if (iommu_pci_is_pcie_bridge(tmp))
 		return device_context_mapped(iommu, tmp->subordinate->number,
 					     0);
 	else
@@ -1974,7 +1982,7 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 	struct intel_iommu *iommu;
 	struct dmar_drhd_unit *drhd;
 	struct device_domain_info *info, *tmp;
-	struct pci_dev *dev_tmp;
+	struct pci_dev *dev_tmp = NULL;
 	unsigned long flags;
 	int bus = 0, devfn = 0;
 	int segment;
@@ -1986,9 +1994,16 @@ static struct dmar_domain *get_domain_for_dev(struct pci_dev *pdev, int gaw)
 
 	segment = pci_domain_nr(pdev->bus);
 
-	dev_tmp = pci_find_upstream_pcie_bridge(pdev);
-	if (dev_tmp) {
-		if (pci_is_pcie(dev_tmp)) {
+	if (!pci_is_pcie(pdev) && !pci_is_root_bus(pdev->bus)) {
+		struct pci_dev *last;
+
+		dev_tmp = iommu_pci_find_upstream(pdev,
+						  iommu_pci_is_pcie_bridge,
+						  &last);
+		if (!dev_tmp)
+			dev_tmp = last;
+
+		if (iommu_pci_is_pcie_bridge(dev_tmp)) {
 			bus = dev_tmp->subordinate->number;
 			devfn = 0;
 		} else {
@@ -3754,26 +3769,24 @@ static void iommu_detach_dependent_devices(struct intel_iommu *iommu,
 {
 	struct pci_dev *tmp, *parent;
 
-	if (!iommu || !pdev)
+	if (!iommu || !pdev || pci_is_pcie(pdev) || pci_is_root_bus(pdev->bus))
 		return;
 
 	/* dependent device detach */
-	tmp = pci_find_upstream_pcie_bridge(pdev);
+	tmp = iommu_pci_find_upstream(pdev, iommu_pci_is_pcie_bridge, &parent);
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
+	if (iommu_pci_is_pcie_bridge(tmp)) /* this is a PCIe-to-PCI bridge */
+		iommu_detach_dev(iommu, tmp->subordinate->number, 0);
+	else /* this is a legacy PCI bridge */
+		iommu_detach_dev(iommu, tmp->bus->number, tmp->devfn);
 }
 
 static void domain_remove_one_dev_info(struct dmar_domain *domain,
@@ -4158,7 +4171,7 @@ static int intel_iommu_domain_has_cap(struct iommu_domain *domain,
 static int intel_iommu_add_device(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct pci_dev *bridge, *dma_pdev = NULL;
+	struct pci_dev *dma_pdev = NULL;
 	struct iommu_group *group;
 	int ret;
 
@@ -4166,9 +4179,15 @@ static int intel_iommu_add_device(struct device *dev)
 			     pdev->bus->number, pdev->devfn))
 		return -ENODEV;
 
-	bridge = pci_find_upstream_pcie_bridge(pdev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))
+	if (!pci_is_pcie(pdev) && !pci_is_root_bus(pdev->bus)) {
+		struct pci_dev *bridge, *last;
+
+		bridge = iommu_pci_find_upstream(pdev,iommu_pci_is_pcie_bridge,
+						 &last);
+		if (!bridge)
+			bridge = last;
+
+		if (iommu_pci_is_pcie_bridge(bridge))
 			dma_pdev = pci_get_domain_bus_and_slot(
 						pci_domain_nr(pdev->bus),
 						bridge->subordinate->number, 0);
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 5b19b2d..2a6d27f 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -16,6 +16,7 @@
 #include <asm/msidef.h>
 
 #include "irq_remapping.h"
+#include "pci.h"
 
 struct ioapic_scope {
 	struct intel_iommu *iommu;
@@ -373,7 +374,6 @@ static int set_hpet_sid(struct irte *irte, u8 id)
 
 static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 {
-	struct pci_dev *bridge;
 
 	if (!irte || !dev)
 		return -1;
@@ -385,9 +385,16 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
 		return 0;
 	}
 
-	bridge = pci_find_upstream_pcie_bridge(dev);
-	if (bridge) {
-		if (pci_is_pcie(bridge))/* this is a PCIe-to-PCI/PCIX bridge */
+	if (!pci_is_pcie(dev) && !pci_is_root_bus(dev->bus)) {
+		struct pci_dev *bridge, *last;
+
+		bridge = iommu_pci_find_upstream(dev, iommu_pci_is_pcie_bridge,
+						 &last);
+		if (!bridge)
+			bridge = last;
+
+		/* PCIe-to-PCI/PCIX bridge */
+		if (iommu_pci_is_pcie_bridge(bridge))
 			set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
 				(bridge->bus->number << 8) | dev->bus->number);
 		else /* this is a legacy PCI bridge */

