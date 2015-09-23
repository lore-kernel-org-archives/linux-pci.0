Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42291 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbbIWRSA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 13:18:00 -0400
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] pci: mvebu: use port->name rather than "PCIe%d.%d"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1Zeng1-0004dT-KL@rmk-PC.arm.linux.org.uk>
Date: Wed, 23 Sep 2015 18:17:53 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the port->name string which we previously formatted when referring
to the name of a port, rather than manually creating the port name each
time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 8c715444b722..19144ed7bdad 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1006,8 +1006,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		ret = mvebu_get_tgt_attr(np, port->devfn, IORESOURCE_MEM,
 					 &port->mem_target, &port->mem_attr);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot get tgt/attr for mem window\n",
-				port->port, port->lane);
+			dev_err(&pdev->dev, "%s: cannot get tgt/attr for mem window\n",
+				port->name);
 			continue;
 		}
 
@@ -1025,8 +1025,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			u32 reset_udelay = 20000;
 
 			port->reset_active_low = flags & OF_GPIO_ACTIVE_LOW;
-			port->reset_name = kasprintf(GFP_KERNEL,
-				     "pcie%d.%d-reset", port->port, port->lane);
+			port->reset_name = kasprintf(GFP_KERNEL, "%s-reset",
+						     port->name);
 			of_property_read_u32(child, "reset-delay-us",
 					     &reset_udelay);
 
@@ -1045,8 +1045,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		port->clk = of_clk_get_by_name(child, NULL);
 		if (IS_ERR(port->clk)) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
-			       port->port, port->lane);
+			dev_err(&pdev->dev, "%s: cannot get clock\n",
+				port->name);
 			continue;
 		}
 
@@ -1056,8 +1056,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (IS_ERR(port->base)) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
-				port->port, port->lane);
+			dev_err(&pdev->dev, "%s: cannot map registers\n",
+				port->name);
 			port->base = NULL;
 			clk_disable_unprepare(port->clk);
 			continue;
-- 
2.1.0

