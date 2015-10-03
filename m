Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36888 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbJCSNV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:13:21 -0400
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/9] pci: mvebu: use gpio_set_value_cansleep()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZiRJ2-0004Ir-HU@rmk-PC.arm.linux.org.uk>
Date: Sat, 03 Oct 2015 19:13:12 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We are in a context where we can sleep, and the PCIe reset gpio may be
on an I2C expander.  Use the cansleep() variant when setting the GPIO
value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 92c777e1aa3c..00467c5a58ac 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1111,8 +1111,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			of_property_read_u32(child, "reset-delay-us",
 					     &reset_udelay);
 
-			gpio_set_value(port->reset_gpio,
-				       (port->reset_active_low) ? 1 : 0);
+			gpio_set_value_cansleep(port->reset_gpio,
+						!!port->reset_active_low);
 			msleep(reset_udelay/1000);
 		}
 
-- 
2.1.0

