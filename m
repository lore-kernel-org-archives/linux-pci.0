Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36275 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933523AbcLBKh0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2016 05:37:26 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 1/3 pci/next] PCI: rcar-gen2: Use gen2 fallback compatibility last
Date: Fri,  2 Dec 2016 11:36:58 +0100
Message-Id: <1480675020-26346-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au>
References: <1480675020-26346-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Fallback compatibility strings should be used only if more specific ones
are matched and the order of compatibility strings in the corresponding
struct of_device_id should implement this.

This does not have a run-time effect as current all relevant compatibility
strings result in the same initialisation.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* New patch

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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

