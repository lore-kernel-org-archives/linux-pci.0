Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdJ3AHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Oct 2017 20:07:13 -0400
To: linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: fix kernel-doc build warning
Message-ID: <85dcffe7-1e6b-5735-2552-d35d127e392b@infradead.org>
Date: Sun, 29 Oct 2017 17:07:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in kernel-doc notation:

../drivers/pci/pci.c:3479: ERROR: Unexpected indentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Bjorn Helgaas <bhelgaas@google.com>
Cc:	linux-pci@vger.kernel.org
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-414-rc7.orig/drivers/pci/pci.c
+++ lnx-414-rc7/drivers/pci/pci.c
@@ -3471,7 +3471,7 @@ EXPORT_SYMBOL(devm_pci_remap_cfgspace);
  * All operations are managed and will be undone on driver detach.
  *
  * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example:
+ * on failure. Usage example::
  *
  *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
