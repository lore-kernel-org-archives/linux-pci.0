Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:63409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968792AbdDSRzM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2017 13:55:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: faraday: use %pap format string for printing resources
Date: Wed, 19 Apr 2017 19:54:46 +0200
Message-Id: <20170419175513.88138-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

resource_size_t may be either 32-bit or 64-bit wide, so we have to use
the special %pap format string to avoid warnings like:

drivers/pci/host/pci-ftpci100.c: In function 'faraday_res_to_memcfg':
drivers/pci/host/pci-ftpci100.c:174:586: error: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
drivers/pci/host/pci-ftpci100.c:174:586: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]

This relies on resource_size_t and phys_addr_t being the same width,
as other code already does.

Fixes: 5c18f2b240bd ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-ftpci100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 4ae5418a1aad..c0f29d1de341 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -171,8 +171,8 @@ static int faraday_res_to_memcfg(resource_size_t mem_base,
 		pr_warn("truncated PCI memory base\n");
 	/* Translate to bridge side address space */
 	outval |= (mem_base & FARADAY_PCI_MEMBASE_MASK);
-	pr_debug("Translated pci base @%08x, size %08x to config %08x\n",
-		 mem_base, mem_size, outval);
+	pr_debug("Translated pci base @%pap, size %pap to config %08x\n",
+		 &mem_base, &mem_size, outval);
 
 	*val = outval;
 	return 0;
-- 
2.9.0
