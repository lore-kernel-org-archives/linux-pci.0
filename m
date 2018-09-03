Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33178 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICGuw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Sep 2018 02:50:52 -0400
To: LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: fix pci.c kernel-doc parameter warning
Message-ID: <1fe6f0c6-7ebb-7ddd-af91-659afad2d7da@infradead.org>
Date: Sun, 2 Sep 2018 19:32:50 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning:

../drivers/pci/pci.c:218: warning: Excess function parameter 'p' description in 'pci_dev_str_match_path'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-419-rc2.orig/drivers/pci/pci.c
+++ lnx-419-rc2/drivers/pci/pci.c
@@ -196,7 +196,7 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 /**
  * pci_dev_str_match_path - test if a path string matches a device
  * @dev:    the PCI device to test
- * @p:      string to match the device against
+ * @path:   string to match the device against
  * @endptr: pointer to the string after the match
  *
  * Test if a string (typically from a kernel parameter) formatted as a
