Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:42650 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbeASSEQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jan 2018 13:04:16 -0500
Date: Fri, 19 Jan 2018 19:04:08 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] devres: Fix double mem region release in
 devm_ioremap_resource()
Message-ID: <20180119180408.GB31540@lenoch>
References: <20180119180310.GA31540@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119180310.GA31540@lenoch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

devm_release_mem_region() is called explicitely in case
devm_ioremap() fails, however the same release function
is later called also as devres release of
devm_request_mem_region() causing double resource free.

Fixes: 72f8c0bfa0de ("lib: devres: add convenience function to remap a resource")
Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 lib/devres.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/devres.c b/lib/devres.c
index 5f2aedd58bc5..584356a568d0 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -156,7 +156,6 @@ void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res)
 	dest_ptr = devm_ioremap(dev, res->start, size);
 	if (!dest_ptr) {
 		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
 		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
 	}
 
-- 
2.15.1
