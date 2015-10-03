Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36904 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbbJCSNi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:13:38 -0400
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/9] pci: mvebu: better implementation of clock/reset handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZiRJH-0004JA-UC@rmk-PC.arm.linux.org.uk>
Date: Sat, 03 Oct 2015 19:13:27 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add an implementation to handle clock and reset handling that is
compliant with the PCIe specification.  The clock should be running
and stable for 100us prior to reset being released, and we should
re-assert reset prior to stopping the clock.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 56 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index ab619ee0ef49..97208233d901 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1042,6 +1042,46 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	return ret;
 }
 
+/*
+ * Power up a PCIe port.  PCIe requires the refclk to be stable for 100µs
+ * prior to releasing PERST.  See table 2-4 in section 2.6.2 AC Specifications
+ * of the PCI Express Card Electromechanical Specification, 1.1.
+ */
+static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
+{
+	int ret;
+
+	ret = clk_prepare_enable(port->clk);
+	if (ret < 0)
+		return ret;
+
+	if (port->reset_gpio) {
+		u32 reset_udelay = 20000;
+
+		of_property_read_u32(port->dn, "reset-delay-us",
+				     &reset_udelay);
+
+		udelay(100);
+
+		gpiod_set_value_cansleep(port->reset_gpio, 0);
+		msleep(reset_udelay / 1000);
+	}
+
+	return 0;
+}
+
+/*
+ * Power down a PCIe port.  Strictly, PCIe requires us to place the card
+ * in D3hot state before asserting PERST#.
+ */
+static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
+{
+	if (port->reset_gpio)
+		gpiod_set_value_cansleep(port->reset_gpio, 1);
+
+	clk_disable_unprepare(port->clk);
+}
+
 static int mvebu_pcie_probe(struct platform_device *pdev)
 {
 	struct mvebu_pcie *pcie;
@@ -1114,18 +1154,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		if (!child)
 			continue;
 
-		if (port->reset_gpio) {
-			u32 reset_udelay = 20000;
-
-			of_property_read_u32(child, "reset-delay-us",
-					     &reset_udelay);
-
-			gpiod_set_value_cansleep(port->reset_gpio, 0);
-			msleep(reset_udelay / 1000);
-		}
-
-		ret = clk_prepare_enable(port->clk);
-		if (ret)
+		ret = mvebu_pcie_powerup(port);
+		if (ret < 0)
 			continue;
 
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
@@ -1133,7 +1163,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "%s: cannot map registers\n",
 				port->name);
 			port->base = NULL;
-			clk_disable_unprepare(port->clk);
+			mvebu_pcie_powerdown(port);
 			continue;
 		}
 
-- 
2.1.0

