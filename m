Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5385 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595AbcCWWDZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Mar 2016 18:03:25 -0400
From: Jon Derrick <jonathan.derrick@intel.com>
To: helgaas@kernel.org
Cc: Jon Derrick <jonathan.derrick@intel.com>, keith.busch@intel.com,
	linux-pci@vger.kernel.org
Subject: [PATCH] pci: Added flag to pci_host_bridge to hint not to use acpi
Date: Wed, 23 Mar 2016 16:01:58 -0600
Message-Id: <1458770518-10203-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a hint, no_acpi, to the pci_host_bridge struct which
informs the hotplug driver to not try and release the host bridge from
acpi.

The VMD driver creates a root port which does not have an acpi entry.
This patch will allow the hotplug driver to bypass acpi release when
enumerating the VMD root port as a hotplug slot.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 arch/x86/pci/vmd.c              | 4 ++++
 drivers/pci/pcie/portdrv_acpi.c | 5 +++++
 include/linux/pci.h             | 1 +
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
index 7792aba..a196be3 100644
--- a/arch/x86/pci/vmd.c
+++ b/arch/x86/pci/vmd.c
@@ -531,6 +531,7 @@ static int vmd_find_free_domain(void)
 static int vmd_enable_domain(struct vmd_dev *vmd)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
+	struct pci_host_bridge *host_bridge;
 	struct resource *res;
 	u32 upper_bits;
 	unsigned long flags;
@@ -609,6 +610,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
 		return -ENODEV;
 	}
 
+	host_bridge = to_pci_host_bridge(vmd->bus->bridge);
+	host_bridge->no_acpi = true;
+
 	vmd_attach_resources(vmd);
 	vmd_setup_dma_ops(vmd);
 	dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index b4d2894..0e6fa69 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -35,12 +35,17 @@
 int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 {
 	struct acpi_pci_root *root;
+	struct pci_host_bridge *host_bridge;
 	acpi_handle handle;
 	u32 flags;
 
 	if (acpi_pci_disabled)
 		return 0;
 
+	host_bridge = pci_find_host_bridge(port->bus);
+	if (host_bridge && host_bridge->no_acpi)
+		return 0;
+
 	handle = acpi_find_root_bridge_handle(port);
 	if (!handle)
 		return -EINVAL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 15f466e..a6958e9b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -407,6 +407,7 @@ struct pci_host_bridge {
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
 	unsigned int ignore_reset_delay:1;	/* for entire hierarchy */
+	unsigned int no_acpi:1;			/* bypasses acpi release */
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
 			const struct resource *res,
-- 
1.8.3.1

