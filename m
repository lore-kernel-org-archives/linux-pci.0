Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 1/2] ARM/PCI: bios32: Fix pcibios_init_resource() error return path
Date: Mon, 10 Jul 2017 13:34:08 +0100
Message-Id: <20170710123409.9043-1-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since commit 97ad2bdcbe85 ("ARM/PCI: Convert PCI scan API to
pci_scan_root_bus_bridge()") struct pci_sys_data is allocated through
pci_alloc_host_bridge() which implies that, if pcibios_init_resource()
fails, the pci_sys_data should be freed along with struct pci_host_bridge
members through pci_free_host_bridge() instead of a simple kfree.

Fix commit 97ad2bdcbe85 ("ARM/PCI: Convert PCI scan API to
pci_scan_root_bus_bridge()") by updating pcibios_init_resource()
error path.

Fixes: 97ad2bdcbe85 ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
CC: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/kernel/bios32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 56dc1a3..c1809fb 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -480,7 +480,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
-				kfree(sys);
+				pci_free_host_bridge(bridge);
 				break;
 			}
 
-- 
2.10.0
