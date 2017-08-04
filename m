Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:46013 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751910AbdHDDdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2017 23:33:35 -0400
From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
To: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
Subject: [PATCH v2 2/2] PCI: rcar-pcie: Fix memory leak when no PCIe card is inserted
Date: Fri,  4 Aug 2017 12:32:55 +0900
Message-Id: <20170804033255.27171-3-harunobu.kurokawa.dn@renesas.com>
In-Reply-To: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
References: <20170804033255.27171-1-harunobu.kurokawa.dn@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When no PCIe card is inserted, there is a memory leak as
pci_free_resource_list is not called before returning.

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6b73981..70b487c 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1196,6 +1196,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 
 err_free_bridge:
 	pci_free_host_bridge(bridge);
+	pci_free_resource_list(&pcie->resources);
 
 	return err;
 }
-- 
2.9.2
