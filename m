Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38939 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759764AbcLPLuN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2016 06:50:13 -0500
From: Simon Horman <horms+renesas@verge.net.au>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH pci/next] PCI: rcar: return ENODEV code when PCIe card does not insert
Date: Fri, 16 Dec 2016 12:50:04 +0100
Message-Id: <1481889004-26124-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

R-Car PCIe does not support hotplug so it is appropriate to
treat the absence of a PCIe card as an ENODEV error.

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
[simon: updated changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index aca85be101f8..0d9b96c3c49d 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1165,7 +1165,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(dev, "PCIe link down\n");
-		err = 0;
+		err = -ENODEV;
 		goto err_pm_put;
 	}
 
-- 
2.7.0.rc3.207.g0ac5344

