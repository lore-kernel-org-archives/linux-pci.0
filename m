Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 8 Apr 2016 15:22:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: rjw@rjwysocki.net, keith.busch@intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCHv2 0/2] Fixups for mixed pcie_ports=auto and native
Message-ID: <20160408202231.GA23622@localhost>
References: <1460136951-28217-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1460136951-28217-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 08, 2016 at 11:35:49AM -0600, Jon Derrick wrote:
> This set introduces a fixup that lets non-acpi pcie ports subscribe to
> native port services. The theory is that on an acpi system, native
> services will require acpi to release control of the port instance.
> 
> Rather than failing on non-acpi devices, we should continue as if they
> were native to begin with, and try to subscribe to native services just
> the same.
> 
> No change from v1 - the emails just didn't reach all of their targets
> 
> Jon Derrick (2):
>   PCI/ACPI: Do not fail ports without ACPI entries
>   PCI/PCIe: Fixups for acpi port setup not being allowed to fail
> 
>  drivers/pci/pcie/portdrv.h      | 11 ++++-------
>  drivers/pci/pcie/portdrv_acpi.c | 10 ++++------
>  drivers/pci/pcie/portdrv_core.c |  8 ++------
>  3 files changed, 10 insertions(+), 19 deletions(-)

Strange.  I see both patches in my mailbox this time, but only one in
patchwork.  In any case, I applied both to pci/host-vmd for v4.7.

Here they are for completeness and because I tweaked the changelogs:

commit 52966bd1c2a09fdd3149f00568cc18f45cc09785
Author: Jon Derrick <jonathan.derrick@intel.com>
Date:   Fri Apr 8 14:44:24 2016 -0500

    PCI/ACPI: Allow all PCIe services on non-ACPI host bridges
    
    Host bridges we discover via ACPI, i.e., PNP0A03 and PNP0A08 devices, may
    have an _OSC method by which the OS can ask the platform for control of
    PCIe features like native hotplug, power management events, AER, etc.
    
    Previously, if we found a bridge without an ACPI device, we assumed we did
    not have permission to use any of these PCIe features.  That seems
    unreasonably restrictive.
    
    If we find no ACPI device, assume we can take control of all PCIe features.
    
    The Intel Volume Management Device (VMD) is one such bridge with no ACPI
    device.  Prior to this change, users had to boot with "pcie_ports=native"
    to get hotplug and other services to work below the VMD Root Port.
    
    [bhelgaas: changelog]
    Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
    Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/portdrv_acpi.c b/drivers/pci/pcie/portdrv_acpi.c
index b4d2894..f097a73 100644
--- a/drivers/pci/pcie/portdrv_acpi.c
+++ b/drivers/pci/pcie/portdrv_acpi.c
@@ -43,11 +43,11 @@ int pcie_port_acpi_setup(struct pci_dev *port, int *srv_mask)
 
 	handle = acpi_find_root_bridge_handle(port);
 	if (!handle)
-		return -EINVAL;
+		return 0;
 
 	root = acpi_pci_find_root(handle);
 	if (!root)
-		return -ENODEV;
+		return 0;
 
 	flags = root->osc_control_set;
 

commit 88a97da1eab7587036d8bc937d6bc874b8210df1
Author: Jon Derrick <jonathan.derrick@intel.com>
Date:   Fri Apr 8 11:35:51 2016 -0600

    PCI: Remove return values from pcie_port_platform_notify() and relatives
    
    Now that pcie_port_acpi_setup() always returns 0, make it and its callers
    void functions and stop checking the return values.
    
    [bhelgaas: changelog]
    Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

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
