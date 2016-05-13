Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:36501 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbcEMLQU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2016 07:16:20 -0400
Message-Id: <3e694101e5fa1551e07b5ecf92157087922e952f.1463134231.git.lukas@wunner.de>
In-Reply-To: <cover.1463134231.git.lukas@wunner.de>
References: <cover.1463134231.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 13 May 2016 13:15:31 +0200
Subject: [PATCH v2 03/13] PCI: Add Thunderbolt portdrv service type
To: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A Thunderbolt controller is a PCIe switch which, as defined in the PCIe
spec, appears to the OS "as a collection of virtual PCI-to-PCI bridges".

We're about to add support for Apple's nonstandard ACPI methods to power
Thunderbolt controllers up and down.  To facilitate that, allocate a
port service for every PCI bridge belonging to a Thunderbolt controller.

This port service might come in handy for other use cases, e.g. device
initialization of Thunderbolt controllers.

To understand when and how this port service will be allocated, consider
the PCI devices exposed by a Thunderbolt host controller:

  (Root Port) ---- Upstream Bridge --+-- Downstream Bridge 0 ---- NHI
                                     +-- Downstream Bridge 1 --
                                     +-- Downstream Bridge 2 --
                                     ...

The upstream and downstream bridges represent the PCIe switch and a
Thunderbolt port service will be allocated for each of them.  Hotplugged
devices will appear behind the downstream bridges.  The NHI (Native Host
Interface) is a virtual PCI device to manage the switch fabric and is
not relevant here.  It uses class 0x88000, so it is not a PCIe port.

Next, consider the PCI devices exposed by Thunderbolt controllers built
into hotplugged devices:

  -- Upstream Bridge ---- Downstream Bridge ---- Hotplugged device

Again, Thunderbolt port services will be allocated for the upstream and
downstream bridge, but not for the hotplugged device, which might use
e.g. class 0x20000 if it's a Thunderbolt Ethernet adapter.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/portdrv.h      | 2 +-
 drivers/pci/pcie/portdrv_core.c | 2 ++
 include/linux/pcieport_if.h     | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 587aef3..a0d9973 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -11,7 +11,7 @@
 
 #include <linux/compiler.h>
 
-#define PCIE_PORT_DEVICE_MAXSERVICES   5
+#define PCIE_PORT_DEVICE_MAXSERVICES	6
 /*
  * According to the PCI Express Base Specification 2.0, the indices of
  * the MSI-X table entries used by port services must not exceed 31
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index d04fb58..8cd9db8 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -310,6 +310,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC))
 		services |= PCIE_PORT_SERVICE_DPC;
+	if (dev->is_thunderbolt)
+		services |= PCIE_PORT_SERVICE_TBT;
 
 	return services;
 }
diff --git a/include/linux/pcieport_if.h b/include/linux/pcieport_if.h
index afcd130..d205bd6 100644
--- a/include/linux/pcieport_if.h
+++ b/include/linux/pcieport_if.h
@@ -23,6 +23,8 @@
 #define PCIE_PORT_SERVICE_VC		(1 << PCIE_PORT_SERVICE_VC_SHIFT)
 #define PCIE_PORT_SERVICE_DPC_SHIFT	4	/* Downstream Port Containment */
 #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
+#define PCIE_PORT_SERVICE_TBT_SHIFT	5	/* Thunderbolt */
+#define PCIE_PORT_SERVICE_TBT		(1 << PCIE_PORT_SERVICE_TBT_SHIFT)
 
 struct pcie_device {
 	int		irq;	    /* Service IRQ/MSI/MSI-X Vector */
-- 
2.8.1

