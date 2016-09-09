Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:58904 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbcIIHpj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Sep 2016 03:45:39 -0400
From: Niklas Cassel <niklas.cassel@axis.com>
To: <bhelgaas@google.com>, <jespern@axis.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Niklas Cassel <niklass@axis.com>
Subject: [PATCH] PCI: artpec6: drop __init from artpec6_add_pcie_port
Date: Fri, 9 Sep 2016 09:45:30 +0200
Message-ID: <1473407130-21934-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

artpec6_add_pcie_port is called from artpec6_pcie_probe.
artpec6_pcie_probe does not have the __init section marker.
It is wrong to have the marker on artpec6_add_pcie_port
when the marker is not on artpec6_pcie_probe.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/pci/host/pcie-artpec6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-artpec6.c b/drivers/pci/host/pcie-artpec6.c
index 16ba70b7..39bf1a6 100644
--- a/drivers/pci/host/pcie-artpec6.c
+++ b/drivers/pci/host/pcie-artpec6.c
@@ -191,8 +191,8 @@ static irqreturn_t artpec6_pcie_msi_handler(int irq, void *arg)
 	return dw_handle_msi_irq(pp);
 }
 
-static int __init artpec6_add_pcie_port(struct pcie_port *pp,
-					struct platform_device *pdev)
+static int artpec6_add_pcie_port(struct pcie_port *pp,
+				 struct platform_device *pdev)
 {
 	int ret;
 
-- 
2.1.4

