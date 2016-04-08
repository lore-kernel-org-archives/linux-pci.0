Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: rjw@rjwysocki.net
Cc: Jon Derrick <jonathan.derrick@intel.com>, helgaas@kernel.org,
	keith.busch@intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCHv2 2/2] PCI/PCIe: Fixups for acpi port setup not being allowed to fail
Date: Fri,  8 Apr 2016 11:35:51 -0600
Message-Id: <1460136951-28217-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1460136951-28217-1-git-send-email-jonathan.derrick@intel.com>
References: <1460136951-28217-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that pcie_port_acpi_setup cannot fail, the callers do not need to
check the return values of it and pcie_port_platform_notify.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/pcie/portdrv.h      | 11 ++++-------
 drivers/pci/pcie/portdrv_acpi.c | 10 ++++------
 drivers/pci/pcie/portdrv_core.c |  8 ++------
 3 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index d525548..463b609 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -67,17 +67,14 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
 #ifdef CONFIG_ACPI
-int pcie_port_acpi_setup(struct pci_dev *port, int *mask);
+void pcie_port_acpi_setup(struct pci_dev *port, int *mask);
 
-static inline int pcie_port_platform_notify(struct pci_dev *port, int *mask)
+static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask)
 {
-	return pcie_port_acpi_setup(port, mask);
+	pcie_port_acpi_setup(port, mask);
 }
 #else /* !CONFIG_ACPI */
-static inline int pcie_port_platform_notify(struct pci_dev *port, int *mask)
-{
-	return 0;
-}
+static inline void pcie_port_platform_notify(struct pci_dev *port, int *mask){}
 #endif /* !CONFIG_ACPI */
 
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index f097a73..9f4ed71 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -32,22 +32,22 @@
  * NOTE: It turns out that we cannot do that for individual port services
  * separately, because that would make some systems work incorrectly.
  */
-int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
+void pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 {
 	struct acpi_pci_root *root;
 	acpi_handle handle;
 	u32 flags;
 
 	if (acpi_pci_disabled)
-		return 0;
+		return;
 
 	handle = acpi_find_root_bridge_handle(port);
 	if (!handle)
-		return 0;
+		return;
 
 	root = acpi_pci_find_root(handle);
 	if (!root)
-		return 0;
+		return;
 
 	flags = root->osc_control_set;
 
@@ -58,6 +58,4 @@ int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 		*srv_mask |= PCIE_PORT_SERVICE_PME;
 	if (flags & OSC_PCI_EXPRESS_AER_CONTROL)
 		*srv_mask |= PCIE_PORT_SERVICE_AER;
-
-	return 0;
 }
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 88122dc..de7a85b 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -256,7 +256,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 	u32 reg32;
 	int cap_mask = 0;
-	int err;
 
 	if (pcie_ports_disabled)
 		return 0;
@@ -266,11 +265,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	if (pci_aer_available())
 		cap_mask |= PCIE_PORT_SERVICE_AER;
 
-	if (pcie_ports_auto) {
-		err = pcie_port_platform_notify(dev, &cap_mask);
-		if (err)
-			return 0;
-	}
+	if (pcie_ports_auto)
+		pcie_port_platform_notify(dev, &cap_mask);
 
 	/* Hot-Plug Capable */
 	if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
-- 
1.8.3.1

