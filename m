Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36883 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbbJCSNQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:13:16 -0400
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/9] pci: mvebu: split port parsing and resource claiming from
 port setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZiRIx-0004Ik-Da@rmk-PC.arm.linux.org.uk>
Date: Sat, 03 Oct 2015 19:13:07 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Split the PCIe port DT parsing and resource claiming from setting up
the actual ports.  This allows us to gather all the resources first,
before touching the hardware.  This is important as some of these
resources (such as the GPIO for the PCIe reset) may defer probing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index e8c51bb58e99..92c777e1aa3c 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1093,6 +1093,18 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		port->dn = child;
+		i++;
+	}
+	pcie->nports = i;
+
+	for (i = 0; i < pcie->nports; i++) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+
+		child = port->dn;
+		if (!child)
+			continue;
+
 		if (gpio_is_valid(port->reset_gpio)) {
 			u32 reset_udelay = 20000;
 
@@ -1118,10 +1130,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		}
 
 		mvebu_pcie_set_local_dev_nr(port, 1);
-
-		port->dn = child;
 		mvebu_sw_pci_bridge_init(port);
-		i++;
 	}
 
 	pcie->nports = i;
-- 
2.1.0

