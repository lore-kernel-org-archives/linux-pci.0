Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751936AbdFLCKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Jun 2017 22:10:44 -0400
To: linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: endpoint: fix endpoint test build error
Message-ID: <89a5b4f8-69bb-a5bc-5400-06c24050595d@infradead.org>
Date: Sun, 11 Jun 2017 19:10:38 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

PCI endpoint test driver uses crc32_le() so it should select
CRC32. Fixes this build error (when CRC32=m):

  drivers/built-in.o: In function `pci_epf_test_cmd_handler':
  pci-epf-test.c:(.text+0x2d98d): undefined reference to `crc32_le'

Fixes 349e7a85b25f (PCI: endpoint: functions: Add an EP function to test PCI).

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/endpoint/functions/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-412-rc4.orig/drivers/pci/endpoint/functions/Kconfig
+++ lnx-412-rc4/drivers/pci/endpoint/functions/Kconfig
@@ -5,6 +5,7 @@
 config PCI_EPF_TEST
 	tristate "PCI Endpoint Test driver"
 	depends on PCI_ENDPOINT
+	select CRC32
 	help
 	   Enable this configuration option to enable the test driver
 	   for PCI Endpoint.
