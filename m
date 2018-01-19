Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42650 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeASSFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 13:05:09 -0500
Date: Fri, 19 Jan 2018 19:05:04 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] PCI: Fix double mem region release in
 devm_pci_remap_cfg_resource()
Message-ID: <20180119180504.GC31540@lenoch>
References: <20180119180310.GA31540@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119180310.GA31540@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_release_mem_region() is called explicitely in case
devm_pci_remap_cfgspace() fails, however the same release
function is later called also as devres release of
devm_request_mem_region() causing double resource free.

Fixes: 490cb6ddb17d ("PCI: Implement devm_pci_remap_cfgspace()")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/pci/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 764ca7b8840d..8f9d81a23ca5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3607,7 +3607,6 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
 		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
 	}
 
-- 
2.15.1
