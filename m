Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeCGGNr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 01:13:47 -0500
Subject: [PATCH v1 4/9] PCI/portdrv: Disable port driver in compat mode
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:13:45 -0600
Message-ID: <152040322576.240786.3375466676254382935.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The "pcie_ports=compat" kernel parameter sets pcie_ports_disabled, which is
intended to disable the PCIe port driver.  But even when it was disabled,
we registered pcie_portdriver so we could work around a BIOS PME issue (see
fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
resume")).

Registering the driver meant that the pcie_portdrv_probe() path called
pci_enable_device(), pci_save_state(), pm_runtime_set_autosuspend_delay(),
pm_runtime_use_autosuspend(), etc., even when the driver was disabled.

We've since moved the BIOS PME workaround from the port driver to the core,
so stop registering the PCIe port driver in compat mode.

This means "pcie_ports=compat" will now be basically the same as turning
off CONFIG_PCIEPORTBUS completely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_core.c |    3 ---
 drivers/pci/pcie/portdrv_pci.c  |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index ef3bad4ad010..9db77c683732 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -212,9 +212,6 @@ static int get_port_device_capability(struct pci_dev *dev)
 	int services = 0;
 	int cap_mask = 0;
 
-	if (pcie_ports_disabled)
-		return 0;
-
 	cap_mask = PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP
 			| PCIE_PORT_SERVICE_VC;
 	if (pci_aer_available())
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index f91afd09e356..c08ebd237242 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -262,7 +262,7 @@ static int __init pcie_portdrv_init(void)
 	int retval;
 
 	if (pcie_ports_disabled)
-		return pci_register_driver(&pcie_portdriver);
+		return -EACCES;
 
 	dmi_check_system(pcie_portdrv_dmi_table);
 
