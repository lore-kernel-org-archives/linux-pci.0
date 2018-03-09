Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeCITBG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Mar 2018 14:01:06 -0500
Subject: [PATCH v2 13/13] PCI/portdrv: Rename and reverse sense of
 pcie_ports_auto
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>
Date: Fri, 09 Mar 2018 13:01:05 -0600
Message-ID: <152062205984.77693.16740685304948811604.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152062141493.77693.9630397416694091342.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The platform may restrict the OS's use of PCIe services, e.g., via the ACPI
_OSC method.  The user may use "pcie_ports=native" to force the port driver
to use PCIe services even if the platform asked us not to.

The "pcie_ports=native" parameter determines the setting of
pcie_ports_auto.  Rename this to pcie_ports_native and reverse the
sense to simplify the code.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.h      |    2 +-
 drivers/pci/pcie/portdrv_core.c |   15 ++++-----------
 drivers/pci/pcie/portdrv_pci.c  |   10 +++++-----
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 62e28b5afa51..3e0058a5500f 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -12,7 +12,7 @@
 
 #include <linux/compiler.h>
 
-extern bool pcie_ports_auto;
+extern bool pcie_ports_native;
 
 /* Service Type */
 #define PCIE_PORT_SERVICE_PME_SHIFT	0	/* Power Management Event */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ed24a407518a..a1f838f2646a 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -193,17 +193,10 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 static int get_port_device_capability(struct pci_dev *dev)
 {
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
-	bool native;
 	int services = 0;
 
-	/*
-	 * If the user specified "pcie_ports=native", use the PCIe services
-	 * regardless of whether the platform has given us permission.  On
-	 * ACPI systems, this means we ignore _OSC.
-	 */
-	native = !pcie_ports_auto;
-
-	if (dev->is_hotplug_bridge && (native || host->use_hotplug)) {
+	if (dev->is_hotplug_bridge &&
+	    (pcie_ports_native || host->use_hotplug)) {
 		services |= PCIE_PORT_SERVICE_HP;
 
 		/*
@@ -215,7 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR) &&
-	    pci_aer_available() && (native || host->use_aer)) {
+	    pci_aer_available() && (pcie_ports_native || host->use_aer)) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
@@ -231,7 +224,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	 * those yet.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
-	    (native || host->use_pme)) {
+	    (pcie_ports_native || host->use_pme)) {
 		services |= PCIE_PORT_SERVICE_PME;
 
 		/*
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 8b62192342ac..569fd636b3c4 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -25,18 +25,18 @@
 bool pcie_ports_disabled;
 
 /*
- * If this switch is set, ACPI _OSC will be used to determine whether or not to
- * enable PCIe port native services.
+ * If the user specified "pcie_ports=native", use the PCIe services regardless
+ * of whether the platform has given us permission.  On ACPI systems, this
+ * means we ignore _OSC.
  */
-bool pcie_ports_auto = true;
+bool pcie_ports_native;
 
 static int __init pcie_port_setup(char *str)
 {
 	if (!strncmp(str, "compat", 6)) {
 		pcie_ports_disabled = true;
 	} else if (!strncmp(str, "native", 6)) {
-		pcie_ports_disabled = false;
-		pcie_ports_auto = false;
+		pcie_ports_native = true;
 	}
 
 	return 1;
