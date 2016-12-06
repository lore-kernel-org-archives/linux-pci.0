Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45620 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752839AbcLFPvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2016 10:51:49 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH pci/next v3 1/3] PCI: rcar-gen2: Use gen2 fallback compatibility last
Date: Tue,  6 Dec 2016 16:51:29 +0100
Message-Id: <1481039491-30364-2-git-send-email-horms+renesas@verge.net.au>
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
 drivers/pci/host/pci-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 1eeefa4df64c..85348590848b 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -430,10 +430,10 @@ static int rcar_pci_probe(struct platform_device *pdev)
 }
 
 static struct of_device_id rcar_pci_of_match[] = {
-	{ .compatible = "renesas,pci-rcar-gen2", },
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
+	{ .compatible = "renesas,pci-rcar-gen2", },
 	{ },
 };
 
-- 
2.7.0.rc3.207.g0ac5344

