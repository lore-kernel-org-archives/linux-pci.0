Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:40801 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbeGXKpR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2018 06:45:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: fix unused variable warning
Date: Tue, 24 Jul 2018 11:39:03 +0200
Message-Id: <20180724093924.1752416-1-arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The newly introduced function produces a warning without CONFIG_PCI_QUIRKS:

drivers/pci/probe.c: In function 'pci_bus_read_dev_vendor_id':
drivers/pci/probe.c:2221:18: error: unused variable 'bridge' [-Werror=unused-variable]

Move the variable declaration into that #ifdef to avoid the warning.

Fixes: ac5ea104a279 ("PCI: Workaround IDT switch ACS Source Validation erratum")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1c581346c5b9..7a5323798312 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2218,9 +2218,9 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
 				int timeout)
 {
+#ifdef CONFIG_PCI_QUIRKS
 	struct pci_dev *bridge = bus->self;
 
-#ifdef CONFIG_PCI_QUIRKS
 	/*
 	 * Certain IDT switches have an issue where they improperly trigger
 	 * ACS Source Validation errors on completions for config reads.
-- 
2.18.0
