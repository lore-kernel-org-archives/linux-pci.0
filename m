Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:60477 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbcHVWAl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2016 18:00:41 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 8/8] PCI: generic: make host-common explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:48 -0400
Message-ID: <20160822215948.27251-9-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCI_HOST_COMMON
drivers/pci/host/Kconfig:       bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple trivial modular references, so that when reading
the code there is no doubt it is builtin-only.

There are no modular init calls in this code, so no init ordering
issues to be concerned with here.

We don't replace module.h with init.h since the file does not have
any functions marked with the __init prefix.

We delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pci-host-common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 9d9d34e959b6..946382fd4ea1 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -1,4 +1,6 @@
 /*
+ * Generic PCI host driver common code
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -17,7 +19,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci-ecam.h>
@@ -162,7 +163,3 @@ int pci_host_common_probe(struct platform_device *pdev,
 	pci_bus_add_devices(bus);
 	return 0;
 }
-
-MODULE_DESCRIPTION("Generic PCI host driver common code");
-MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
-MODULE_LICENSE("GPL v2");
-- 
2.8.4

