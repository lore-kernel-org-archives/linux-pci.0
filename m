Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45017 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeEUNLl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 May 2018 09:11:41 -0400
From: Marek Vasut <marek.vasut@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/4] PCI: rcar: Rename rcar_pcie_parse_request_of_pci_ranges()
Date: Mon, 21 May 2018 15:11:20 +0200
Message-Id: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The function name is just too confusing, rename it, no functional change.
Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
it's matching failpath function is pci_free_resource_list() so the names
align much better and the new name also describes what the function does
much better.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index e403c5206b24..dbc80e457f95 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1051,7 +1051,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{},
 };
 
-static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
+static int rcar_pcie_alloc_and_parse_pci_resource_list(struct rcar_pcie *pci)
 {
 	int err;
 	struct device *dev = pci->dev;
@@ -1108,7 +1108,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&pcie->resources);
 
-	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
+	err = rcar_pcie_alloc_and_parse_pci_resource_list(pcie);
 	if (err)
 		goto err_free_bridge;
 
-- 
2.16.2
