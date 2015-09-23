Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42286 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794AbbIWRRz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 13:17:55 -0400
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/6] pci: mvebu: report full node name when reporting a DT
 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1Zenfw-0004dN-8k@rmk-PC.arm.linux.org.uk>
Date: Wed, 23 Sep 2015 18:17:48 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we have a missing required property, report the full node name rather
than a vague "PCIe DT node" statement.  This allows the exact node in
error to be identified immediately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index d331d2664580..8c715444b722 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -987,7 +987,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		if (of_property_read_u32(child, "marvell,pcie-port",
 					 &port->port)) {
 			dev_warn(&pdev->dev,
-				 "ignoring PCIe DT node, missing pcie-port property\n");
+				 "ignoring %s, missing pcie-port property\n",
+				 of_node_full_name(child));
 			continue;
 		}
 
-- 
2.1.0

