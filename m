Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36013 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbcLXHdP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Dec 2016 02:33:15 -0500
Date: Sat, 24 Dec 2016 13:03:07 +0530
From: Rahul Krishnan <mrahul.krishnan@gmail.com>
To: bhelgaas@google.com
Cc: mpe@ellerman.id.au, mika.westerberg@linux.intel.com,
        gwshan@linux.vnet.ibm.com, mayurkumar.patel@intel.com,
        keith.busch@intel.com, julia.lawall@lip6.fr,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
Message-ID: <20161224073307.GA18826@rahul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch removes unnecessary return statement using spatch tool

Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index dc67f39..9d0e2e1 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -463,8 +463,7 @@ int __init rpadlpar_io_init(void)
 		return -EPERM;
 	}
 
-	rc = dlpar_sysfs_init();
-	return rc;
+	return dlpar_sysfs_init();
 }
 
 void rpadlpar_io_exit(void)
-- 
2.7.4

