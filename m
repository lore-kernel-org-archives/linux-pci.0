Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54226 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3CZQwg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 12:52:36 -0400
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: [RFCv1 06/11] irqchip: armada-370-xp: use a separate mpic node
Date: Tue, 26 Mar 2013 17:52:21 +0100
Message-Id: <1364316746-8702-7-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In the Marvell hardware, MSI interrupts are supported using doorbells,
and those doorbells are handled through registers that are part of the
registers managed by the IRQ controller driver: they are the same
registers used for handling IPI interrupts. Therefore, it is clearly
the responsability of the Armada 370/XP IRQ controller driver to
expose the functionality of handling MSI interrupts.

However, we need the driver to expose two different IRQ domains: one
for the main interrupt controller itself, and one for the MSI
interrupt controller. In order to achieve this, we will create two
subnodes in the interrupt-controller@d0020000 node: one subnode for
the main interrupt controller, and one subnode for the MSI interrupt
controller. The two irq domains can't be registered on the same DT
node, otherwise when irq_find_host() gets used by of_irq_map_one() to
resolve IRQs of devices, they may find the MSI interrupt controller
instead of the main interrupt controller.

Note that both the parent and the child node need to have the
'interrupt-controller' empty property:

  * The interrupt-controller property is needed in the main interrupt
   controller node (interrupt-controller@d0020000) because the
   of_irq_init() function skips nodes that are matching the given
   compatible string, but that don't have the interrupt-controller
   property.

 * The interrupt-controller property is needed in the child interrupt
   controller node (main-intc@d0020000) otherwise the resolution done
   by of_irq_map_one() doesn't work.

This commit is a preparation to this, by adding the subnode for the
main interrupt controller, and by ensuring that the IRQ domain that
corresponds to this IRQ controller is associated to this IRQ node.

Note that the Device Tree binding documentation is updated in the
following patch, when the MSI interrupt support is added to the
armada-370-xp irqchip driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    9 ++++++---
 drivers/irqchip/irq-armada-370-xp.c  |    9 +++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7704829..de054ed 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -28,11 +28,14 @@
 		};
 	};
 
-	mpic: interrupt-controller@d0020000 {
+	interrupt-controller@d0020000 {
 	      compatible = "marvell,mpic";
-	      #interrupt-cells = <1>;
-	      #size-cells = <1>;
 	      interrupt-controller;
+
+	      mpic: main-intc@d0020000 {
+		    #interrupt-cells = <1>;
+		    interrupt-controller;
+	      };
 	};
 
 	coherency-fabric@d0020200 {
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ad1e642..4b2a6d7 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -254,6 +254,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 					     struct device_node *parent)
 {
+	struct device_node *mpic_node;
 	u32 control;
 
 	main_int_base = of_iomap(node, 0);
@@ -264,9 +265,13 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 	control = readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
 
+	mpic_node = of_get_child_by_name(node, "main-intc");
 	armada_370_xp_mpic_domain =
-		irq_domain_add_linear(node, (control >> 2) & 0x3ff,
-				&armada_370_xp_mpic_irq_ops, NULL);
+		irq_domain_add_linear(mpic_node, (control >> 2) & 0x3ff,
+				      &armada_370_xp_mpic_irq_ops, NULL);
+
+	if (!armada_370_xp_mpic_domain)
+		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
 
 	if (!armada_370_xp_mpic_domain)
 		panic("Unable to add Armada_370_Xp MPIC irq domain (DT)\n");
-- 
1.7.9.5

