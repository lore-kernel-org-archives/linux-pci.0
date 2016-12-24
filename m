Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34162 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcLXJiI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Dec 2016 04:38:08 -0500
Date: Sat, 24 Dec 2016 15:08:00 +0530
From: Rahul Krishnan <mrahul.krishnan@gmail.com>
To: benh@kernel.crashing.org
Cc: paulus@samba.org, mpe@ellerman.id.au, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
Message-ID: <20161224093800.GA24893@rahul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This patch removes unnecessary return statement using spatch tool

Signed-off-by: Rahul Krishnan <mrahul.krishnan@gmail.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index dc67f39..78ce2c7 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -455,7 +455,6 @@ static inline int is_dlpar_capable(void)
 
 int __init rpadlpar_io_init(void)
 {
-	int rc = 0;
 
 	if (!is_dlpar_capable()) {
 		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
@@ -463,8 +462,7 @@ int __init rpadlpar_io_init(void)
 		return -EPERM;
 	}
 
-	rc = dlpar_sysfs_init();
-	return rc;
+	return dlpar_sysfs_init();
 }
 
 void rpadlpar_io_exit(void)
-- 
2.7.4

