Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933302AbcJLNVa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Oct 2016 09:21:30 -0400
Subject: [PATCH v2 2/2] PCI: mvebu: Use existing of_node pointer
To: Jason Cooper <jason@lakedaemon.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Wed, 12 Oct 2016 07:56:06 -0500
Message-ID: <20161012125606.24580.89263.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012125403.24580.74990.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use the existing "np" pointer instead of looking up dev->of_node again.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 2515200..45a89d9 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -1228,14 +1228,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	num = of_get_available_child_count(dev->of_node);
+	num = of_get_available_child_count(np);
 
 	pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
 	if (!pcie->ports)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node(np, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 
 		ret = mvebu_pcie_parse_port(pcie, port, child);

