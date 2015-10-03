Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36914 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbJCSNs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:13:48 -0400
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] pci: mvebu: remove code restricting accesses to slot 0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZiRJS-0004JN-6A@rmk-PC.arm.linux.org.uk>
Date: Sat, 03 Oct 2015 19:13:38 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Now that we advertise a PCIe capability, the Linux PCI layer will not
scan the bus for devices other than in slot 0.  This makes the
work-around to trap accesses to devices other than slot 0 unnecessary.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6310f2a84cfd..53b79c5f0559 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -794,17 +794,6 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (!mvebu_pcie_link_up(port))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	/*
-	 * On the secondary bus, we don't want to expose any other
-	 * device than the device physically connected in the PCIe
-	 * slot, visible in slot 0. In slot 1, there's a special
-	 * Marvell device that only makes sense when the Armada is
-	 * used as a PCIe endpoint.
-	 */
-	if (bus->number == port->bridge.secondary_bus &&
-	    PCI_SLOT(devfn) != 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	/* Access the real PCIe interface */
 	ret = mvebu_pcie_hw_wr_conf(port, bus, devfn,
 				    where, size, val);
@@ -835,19 +824,6 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 
-	/*
-	 * On the secondary bus, we don't want to expose any other
-	 * device than the device physically connected in the PCIe
-	 * slot, visible in slot 0. In slot 1, there's a special
-	 * Marvell device that only makes sense when the Armada is
-	 * used as a PCIe endpoint.
-	 */
-	if (bus->number == port->bridge.secondary_bus &&
-	    PCI_SLOT(devfn) != 0) {
-		*val = 0xffffffff;
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
 	/* Access the real PCIe interface */
 	ret = mvebu_pcie_hw_rd_conf(port, bus, devfn,
 				    where, size, val);
-- 
2.1.0

