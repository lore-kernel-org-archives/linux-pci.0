Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36669 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751465AbdBBRPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2017 12:15:38 -0500
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH v2] PCI: mvebu: change delay after reset to the PCIe spec mandated 100ms
Date: Thu,  2 Feb 2017 18:15:31 +0100
Message-Id: <20170202171531.11079-1-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current default of 20ms cause some devices, which are slow to initialize,
to not show up during the bus scanning. Change this to the PCIe spec mandated
100ms and document this in the DT binding.

>From PCIe base spec rev 3.0, chapter "6.6.1. Conventional Reset":

"To allow components to perform internal initialization, system software must
wait a specified minimum period following the end of a Conventional Reset of
one or more devices before it is permitted to issue Configuration Requests to
those devices.

With a Downstream Port that does not support Link speeds greater than
5.0 GT/s, software must wait a minimum of 100 ms before sending a
Configuration Request to the device immediately below that Port."

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
v2: use PCI_PM_D3COLD_WAIT define
---
 Documentation/devicetree/bindings/pci/mvebu-pci.txt | 3 ++-
 drivers/pci/host/pci-mvebu.c                        | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
index 08c716b2c6b6..2de6f65ecfb1 100644
--- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
+++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
@@ -78,7 +78,8 @@ and the following optional properties:
   multiple lanes. If this property is not found, we assume that the
   value is 0.
 - reset-gpios: optional gpio to PERST#
-- reset-delay-us: delay in us to wait after reset de-assertion
+- reset-delay-us: delay in us to wait after reset de-assertion, if not
+  specified will default to 100ms, as required by the PCIe specification.
 
 Example:
 
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 45a89d969700..3629ef7c714d 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1162,7 +1162,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
 		return ret;
 
 	if (port->reset_gpio) {
-		u32 reset_udelay = 20000;
+		u32 reset_udelay = PCI_PM_D3COLD_WAIT * 1000;
 
 		of_property_read_u32(port->dn, "reset-delay-us",
 				     &reset_udelay);
-- 
2.11.0
