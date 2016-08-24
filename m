Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:36388 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754012AbcHXU6Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Aug 2016 16:58:16 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 2/9] PCI: PCIe pme: make it explicitly non-modular
Date: Wed, 24 Aug 2016 16:57:45 -0400
Message-ID: <20160824205752.12024-3-paul.gortmaker@windriver.com>
In-Reply-To: <20160824205752.12024-1-paul.gortmaker@windriver.com>
References: <20160824205752.12024-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig for this option is currently:

config PCIE_PME
        def_bool y
        depends on PCIEPORTBUS && PM

...where both dependencies are also bool items.  That means it currently
 is not being built as a module by anyone.  Lets remove all traces of
modularity, so that when reading the code, there is no doubt it is
builtin-only.

As part of that, we delete the .remove function, since that doesn't
seem to have a sensible use case.  With "normal" endpoint drivers,
we have in the past set the suppress_bind_attrs bit to make it clear
that the use of ".remove" in a built-in driver was deleted, but here
for PCI, it would seem to be overkill to jump through the
pcie_port_service_driver and into the struct device_driver in order
to finally try and do something similar with the bind setting.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

We don't exchange module.h for init.h since this file already has it.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/pcie/pme.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 1ae4c73e7a3c..884bad5320f8 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -10,7 +10,6 @@
  * for more details.
  */
 
-#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -449,17 +448,6 @@ static int pcie_pme_resume(struct pcie_device *srv)
 	return 0;
 }
 
-/**
- * pcie_pme_remove - Prepare PCIe PME service device for removal.
- * @srv - PCIe service device to remove.
- */
-static void pcie_pme_remove(struct pcie_device *srv)
-{
-	pcie_pme_suspend(srv);
-	free_irq(srv->irq, srv);
-	kfree(get_service_data(srv));
-}
-
 static struct pcie_port_service_driver pcie_pme_driver = {
 	.name		= "pcie_pme",
 	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
@@ -468,7 +456,6 @@ static struct pcie_port_service_driver pcie_pme_driver = {
 	.probe		= pcie_pme_probe,
 	.suspend	= pcie_pme_suspend,
 	.resume		= pcie_pme_resume,
-	.remove		= pcie_pme_remove,
 };
 
 /**
@@ -478,5 +465,4 @@ static int __init pcie_pme_service_init(void)
 {
 	return pcie_port_service_register(&pcie_pme_driver);
 }
-
-module_init(pcie_pme_service_init);
+device_initcall(pcie_pme_service_init);
-- 
2.8.4

