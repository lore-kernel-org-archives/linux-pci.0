Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42276 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbbIWRRn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Sep 2015 13:17:43 -0400
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] pci: mvebu: use of_get_available_child_count()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1Zenfl-0004dB-HA@rmk-PC.arm.linux.org.uk>
Date: Wed, 23 Sep 2015 18:17:37 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rather than open-coding of_get_available_child_count(), use the provided
helper instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0d9f3eae4315..0ed14f477bf8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -933,7 +933,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	struct mvebu_pcie *pcie;
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *child;
-	int i, ret;
+	int num, i, ret;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pcie),
 			    GFP_KERNEL);
@@ -969,14 +969,9 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	i = 0;
-	for_each_child_of_node(pdev->dev.of_node, child) {
-		if (!of_device_is_available(child))
-			continue;
-		i++;
-	}
+	num = of_get_available_child_count(pdev->dev.of_node);
 
-	pcie->ports = devm_kzalloc(&pdev->dev, i *
+	pcie->ports = devm_kzalloc(&pdev->dev, num *
 				   sizeof(struct mvebu_pcie_port),
 				   GFP_KERNEL);
 	if (!pcie->ports)
-- 
2.1.0

