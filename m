Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26207 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbeAQFSy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 00:18:54 -0500
From: Keith Busch <keith.busch@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Maik Broemme <mbroemme@libmpq.org>,
        Pawandeep Oza <poza@codeaurora.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 3/6] PCI/DPC: Enable DPC in conjuction with AER
Date: Tue, 16 Jan 2018 22:22:03 -0700
Message-Id: <20180117052206.7703-4-keith.busch@intel.com>
In-Reply-To: <20180117052206.7703-1-keith.busch@intel.com>
References: <20180117052206.7703-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCI Express Base Specification's implementation note on "Determination
of DPC Control" recommends the operating system always link DPC control to
the control of AER, as the two functionalities are strongly connected. To
avoid conflicts over whether platform firmware or the OS control DPC,
this patch enables DPC only if AER is enabled in the OS, and the device's
error handling does not have a firmware-first AER handling.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/Kconfig        | 2 +-
 drivers/pci/pcie/pcie-dpc.c     | 4 ++++
 drivers/pci/pcie/portdrv_core.c | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index ac53edbc9613..d658dfa53b87 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -92,7 +92,7 @@ config PCIE_PME
 
 config PCIE_DPC
 	bool "PCIe Downstream Port Containment support"
-	depends on PCIEPORTBUS
+	depends on PCIEPORTBUS && PCIEAER
 	default n
 	help
 	  This enables PCI Express Downstream Port Containment (DPC)
diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index f7cf5ae7dec2..d1fbd83cd240 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 #include <linux/pcieport_if.h>
 #include "../pci.h"
+#include "aer/aerdrv.h"
 
 struct rp_pio_header_log_regs {
 	u32 dw0;
@@ -309,6 +310,9 @@ static int dpc_probe(struct pcie_device *dev)
 	int status;
 	u16 ctl, cap;
 
+	if (pcie_aer_get_firmware_first(pdev))
+		return -ENOTSUPP;
+
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
 		return -ENOMEM;
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index a59210350c44..ef3bad4ad010 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -216,9 +216,9 @@ static int get_port_device_capability(struct pci_dev *dev)
 		return 0;
 
 	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
-			| PCIE_PORT_SERVICE_VC | PCIE_PORT_SERVICE_DPC;
+			| PCIE_PORT_SERVICE_VC;
 	if (pci_aer_available())
-		cap_mask |= PCIE_PORT_SERVICE_AER;
+		cap_mask |= PCIE_PORT_SERVICE_AER | PCIE_PORT_SERVICE_DPC;
 
 	if (pcie_ports_auto)
 		pcie_port_platform_notify(dev, &cap_mask);
-- 
2.13.6
