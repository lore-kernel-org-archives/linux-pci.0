Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 82-68-191-81.dsl.posilan.com ([82.68.191.81]:51234 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754054AbaA1Jr6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jan 2014 04:47:58 -0500
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 1/3] PCI: rcar: check platform_get_irq() return code
Date: Tue, 28 Jan 2014 09:47:46 +0000
Message-Id: <1390902468-7753-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The current code does not check the return from platform_get_irq()
so add an error check and return if this call does fail.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 drivers/pci/host/pci-rcar-gen2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index ea65bac..674f7fe 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -308,6 +308,11 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
 	priv->reg = reg;
 	priv->dev = &pdev->dev;
 
+	if (priv->irq < 0) {
+		dev_err(&pdev->dev, "no valid irq found\n");
+		return priv->irq;
+	}
+
 	return rcar_pci_add_controller(priv);
 }
 
-- 
1.8.5.2

