Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35504 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933178AbbDITpn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 15:45:43 -0400
Received: by obbfy7 with SMTP id fy7so31140481obb.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 12:45:42 -0700 (PDT)
Subject: [PATCH] PCI: keystone: Don't dereference possible NULL pointer
To: Murali Karicheri <m-karicheri2@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Date: Thu, 09 Apr 2015 14:45:40 -0500
Message-ID: <20150409194540.18977.25638.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Check for failure from platform_get_resource() (this check actually happens
inside devm_ioremap_resource()) before dereferencing the pointer returned
from platform_get_resource().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-keystone-dw.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
index 66d8ea41b972..f34892e0edb4 100644
--- a/drivers/pci/host/pci-keystone-dw.c
+++ b/drivers/pci/host/pci-keystone-dw.c
@@ -496,11 +496,12 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
 
 	/* Index 1 is the application reg. space address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	ks_pcie->app = *res;
 	ks_pcie->va_app_base = devm_ioremap_resource(pp->dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
 		return PTR_ERR(ks_pcie->va_app_base);
 
+	ks_pcie->app = *res;
+
 	/* Create legacy IRQ domain */
 	ks_pcie->legacy_irq_domain =
 			irq_domain_add_linear(ks_pcie->legacy_intc_np,

