Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:32912 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756666AbcHVWAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Aug 2016 18:00:25 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH 6/8] PCI: designware: make host support explicitly non-modular
Date: Mon, 22 Aug 2016 17:59:46 -0400
Message-ID: <20160822215948.27251-7-paul.gortmaker@windriver.com>
In-Reply-To: <20160822215948.27251-1-paul.gortmaker@windriver.com>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Kconfig entry controlling compilation of this code is:

drivers/pci/host/Kconfig:config PCIE_DW
drivers/pci/host/Kconfig:       bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular infrastructure use, so that
when reading the driver there is no doubt it is builtin-only.

We delete the MODULE_LICENSE tag etc. since all that information
is already contained at the top of the file in the comments.

We don't end up adding init.h to this file, since it isn't actually
using __init or any initcalls directly.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/pci/host/pcie-designware.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 12afce19890b..16374202cb8b 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -14,7 +14,6 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
@@ -802,7 +801,3 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 }
-
-MODULE_AUTHOR("Jingoo Han <jg1.han@samsung.com>");
-MODULE_DESCRIPTION("Designware PCIe host controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.8.4

