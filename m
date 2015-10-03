Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:36893 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbJCSN1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 3 Oct 2015 14:13:27 -0400
In-Reply-To: <20151003181228.GI21513@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
To: Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/9] pci: mvebu: use devm_kcalloc() to allocate an array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ZiRJ7-0004Iy-Le@rmk-PC.arm.linux.org.uk>
Date: Sat, 03 Oct 2015 19:13:17 +0100
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rather than using devm_kzalloc() and multiplying the element and number,
use the provided devm_kcalloc() helper for this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 00467c5a58ac..7282bb06c7a8 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1075,8 +1075,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 
 	num = of_get_available_child_count(pdev->dev.of_node);
 
-	pcie->ports = devm_kzalloc(&pdev->dev, num *
-				   sizeof(struct mvebu_pcie_port),
+	pcie->ports = devm_kcalloc(&pdev->dev, num, sizeof(*pcie->ports),
 				   GFP_KERNEL);
 	if (!pcie->ports)
 		return -ENOMEM;
-- 
2.1.0

