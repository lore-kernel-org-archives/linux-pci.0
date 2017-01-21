Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35623 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdAUEuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2017 23:50:03 -0500
Date: Sat, 21 Jan 2017 07:49:49 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Tanmay Inamdar <tinamdar@apm.com>, Duc Dang <dhdang@apm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] PCI: xgene: double free on init error
Message-ID: <20170121044949.GB15269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The "port" variable was allocated with devm_kzalloc() so if we free it
with kfree() it will be freed twice.  Also I changed it to propogate the
error from devm_ioremap_resource() instead of returning -ENOMEM.

Fixes: c5d460396100 ("PCI: Add MCFG quirks for X-Gene host controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7c3b54b..142a166 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -246,14 +246,11 @@ static int xgene_pcie_ecam_init(struct pci_config_window *cfg, u32 ipversion)
 	ret = xgene_get_csr_resource(adev, &csr);
 	if (ret) {
 		dev_err(dev, "can't get CSR resource\n");
-		kfree(port);
 		return ret;
 	}
 	port->csr_base = devm_ioremap_resource(dev, &csr);
-	if (IS_ERR(port->csr_base)) {
-		kfree(port);
-		return -ENOMEM;
-	}
+	if (IS_ERR(port->csr_base))
+		return PTR_ERR(port->csr_base);
 
 	port->cfg_base = cfg->win;
 	port->version = ipversion;
