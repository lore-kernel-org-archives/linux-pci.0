Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45620 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbcLFPvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2016 10:51:51 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH pci/next v3 2/3] PCI: rcar: Use gen2 fallback compatibility last
Date: Tue,  6 Dec 2016 16:51:30 +0100
Message-Id: <1481039491-30364-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1481039491-30364-1-git-send-email-horms+renesas@verge.net.au>
References: <1481039491-30364-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Improve readability by listing fallback compatibility strings
after the more-specific compatibility strings they provide a fallback for.

This does not effect run-time behaviour as it is the order in the DTB that
determines which compatibility string is used.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v3
* Reworded changelog: the ordering does not effect run-time behaviour
v2
* New patch
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 62700d1896f4..85971bc276c6 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1071,12 +1071,12 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
 static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
-	{ .compatible = "renesas,pcie-rcar-gen2",
-	  .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7790",
 	  .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7791",
 	  .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-rcar-gen2",
+	  .data = rcar_pcie_hw_init_gen2 },
 	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
-- 
2.7.0.rc3.207.g0ac5344

