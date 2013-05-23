Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45249 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758807Ab3EWOdM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2013 10:33:12 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>
Subject: [PATCH v2 2/3] pci: mvebu: allow the enumeration of devices beyond physical bridges
Date: Thu, 23 May 2013 16:32:52 +0200
Message-Id: <1369319573-19927-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1369319573-19927-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369319573-19927-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Until now, the Marvell PCIe driver was only allowing the enumeration
of the devices in the secondary bus of the emulated PCI-to-PCI
bridge. This works fine when a PCIe device is directly connected into
a PCIe slot of the Marvell board.

However, when the device connected in the PCIe slot is a physical PCIe
bridge, beyond which a real PCIe device is connected, it no longer
worked, as the driver was preventing the Linux PCI core from seeing
such devices.

This commit fixes that by ensuring that configuration transactions on
subordinate busses are properly forwarded on the right PCIe interface.

Thanks to this patch, a PCIe card beyond a PCIe bridge, itself beyond
the emulated PCI-to-PCI bridge is properly detected, with the
following layout:

-[0000:00]-+-01.0-[01]----00.0
           +-09.0-[02-07]----00.0-[03-07]--+-01.0-[04]--
           |                               +-05.0-[05]--
           |                               +-07.0-[06]--
           |                               \-09.0-[07]----00.0
           \-0a.0-[08]----00.0

Where the PCIe interface that sits beyond the emulated PCI-to-PCI
bridge at 09.0 allows to access the secondary bus 02, on which there
is a PCIe bridge that allows to access the 3 to 7 busses, that are
subordinates to this bridge. And on one of this bus (bus 7), there is
one real PCIe device connected.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0bc21b0..a3c4638 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -554,7 +554,8 @@ mvebu_pcie_find_port(struct mvebu_pcie *pcie, struct pci_bus *bus,
 		if (bus->number == 0 && port->devfn == devfn)
 			return port;
 		if (bus->number != 0 &&
-		    port->bridge.secondary_bus == bus->number)
+		    bus->number >= port->bridge.secondary_bus &&
+		    bus->number <= port->bridge.subordinate_bus)
 			return port;
 	}
 
@@ -578,7 +579,18 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
 	if (bus->number == 0)
 		return mvebu_sw_pci_bridge_write(port, where, size, val);
 
-	if (!port->haslink || PCI_SLOT(devfn) != 0)
+	if (!port->haslink)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/*
+	 * On the secondary bus, we don't want to expose any other
+	 * device than the device physically connected in the PCIe
+	 * slot, visible in slot 0. In slot 1, there's a special
+	 * Marvell device that only makes sense when the Armada is
+	 * used as a PCIe endpoint.
+	 */
+	if (bus->number == port->bridge.secondary_bus &&
+	    PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/* Access the real PCIe interface */
@@ -609,7 +621,20 @@ static int mvebu_pcie_rd_conf(struct pci_bus *bus, u32 devfn, int where,
 	if (bus->number == 0)
 		return mvebu_sw_pci_bridge_read(port, where, size, val);
 
-	if (!port->haslink || PCI_SLOT(devfn) != 0) {
+	if (!port->haslink) {
+		*val = 0xffffffff;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	/*
+	 * On the secondary bus, we don't want to expose any other
+	 * device than the device physically connected in the PCIe
+	 * slot, visible in slot 0. In slot 1, there's a special
+	 * Marvell device that only makes sense when the Armada is
+	 * used as a PCIe endpoint.
+	 */
+	if (bus->number == port->bridge.secondary_bus &&
+	    PCI_SLOT(devfn) != 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
-- 
1.7.9.5

