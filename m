Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:55284 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752449AbdLGKPZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Dec 2017 05:15:25 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] PCI: rcar: Handle rcar_pcie_parse_request_of_pci_ranges() failures
Date: Thu,  7 Dec 2017 11:15:20 +0100
Message-Id: <1512641720-4715-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

rcar_pcie_parse_request_of_pci_ranges() can fail and return an error
code, but this is not checked nor handled.

Fix this by adding the missing error handling.

Fixes: 5d2917d469faab72 ("PCI: rcar: Convert to DT resource parsing API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/host/pcie-rcar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 52ab3cb0a0bfe065..95ca4a1feba4b759 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1123,7 +1123,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&pcie->resources);
 
-	rcar_pcie_parse_request_of_pci_ranges(pcie);
+	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
+	if (err)
+		goto err_free_bridge;
 
 	err = rcar_pcie_get_resources(pcie);
 	if (err < 0) {
@@ -1178,6 +1180,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_free_resource_list:
 	pci_free_resource_list(&pcie->resources);
+err_free_bridge:
 	pci_free_host_bridge(bridge);
 
 	return err;
-- 
2.7.4
