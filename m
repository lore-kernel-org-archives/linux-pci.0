Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:51755 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753229AbaARPgy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jan 2014 10:36:54 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR RE...),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
Subject: [PATCH] pci-rcar-gen2: add of match table
Date: Sat, 18 Jan 2014 15:10:21 +0000
Message-Id: <1390057821-14604-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390057420-13226-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1390057420-13226-2-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add OF match table for pci-rcar-gen2 driver for device tree support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
Cc: Simon Horman <horms@verge.net.au> (maintainer:PCI DRIVER FOR RE...)
Cc: linux-pci@vger.kernel.org (open list:PCI DRIVER FOR RE...)
Cc: linux-sh@vger.kernel.org (open list:PCI DRIVER FOR RE...)
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
---
 drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index ceec147..ea65bac 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -311,9 +311,17 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
 	return rcar_pci_add_controller(priv);
 }
 
+static struct of_device_id rcar_pci_of_match[] = {
+	{ .compatible = "renesas,pci-r8a7790", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
+
 static struct platform_driver rcar_pci_driver = {
 	.driver = {
 		.name = "pci-rcar-gen2",
+		.of_match_table = rcar_pci_of_match,
 	},
 };
 
-- 
1.8.5.2

