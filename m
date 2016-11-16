Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753891AbcKPWN2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 17:13:28 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 41383203E1
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:27 +0000 (UTC)
Received: from localhost (unknown [69.71.4.155])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A87203C4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:26 +0000 (UTC)
Subject: [PATCH 3/4] PCI: pciehp: Remove loading message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2016 16:13:24 -0600
Message-ID: <20161116221324.15842.69345.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the "PCI Express Hot Plug Controller Driver" version message.  I
don't think it contains any useful information.  Remove unused #defines
and move the author information to a comment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 7d32fa33..35d8484 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -25,6 +25,10 @@
  *
  * Send feedback to <greg@kroah.com>, <kristen.c.accardi@intel.com>
  *
+ * Authors:
+ *   Dan Zink <dan.zink@compaq.com>
+ *   Greg Kroah-Hartman <greg@kroah.com>
+ *   Dely Sy <dely.l.sy@intel.com>"
  */
 
 #include <linux/moduleparam.h>
@@ -42,10 +46,6 @@ bool pciehp_poll_mode;
 int pciehp_poll_time;
 static bool pciehp_force;
 
-#define DRIVER_VERSION	"0.4"
-#define DRIVER_AUTHOR	"Dan Zink <dan.zink@compaq.com>, Greg Kroah-Hartman <greg@kroah.com>, Dely Sy <dely.l.sy@intel.com>"
-#define DRIVER_DESC	"PCI Express Hot Plug Controller Driver"
-
 /*
  * not really modular, but the easiest way to keep compat with existing
  * bootargs behaviour is to continue using module_param here.
@@ -333,7 +333,6 @@ static int __init pcied_init(void)
 
 	retval = pcie_port_service_register(&hpdriver_portdrv);
 	dbg("pcie_port_service_register = %d\n", retval);
-	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	if (retval)
 		dbg("Failure to register service\n");
 

