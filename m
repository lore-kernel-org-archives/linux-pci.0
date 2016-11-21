Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754494AbcKUVqT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 16:46:19 -0500
Subject: [PATCH v2 8/9] PCI: pciehp: Remove loading message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:46:10 -0600
Message-ID: <20161121214610.21036.40058.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
 

