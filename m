Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933063AbcKPWNV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Nov 2016 17:13:21 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B9C22203E1
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:19 +0000 (UTC)
Received: from localhost (unknown [69.71.4.155])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7261F203C4
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2016 22:13:18 +0000 (UTC)
Subject: [PATCH 2/4] PCI: hotplug: Remove hotplug core message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 16 Nov 2016 16:13:17 -0600
Message-ID: <20161116221317.15842.3436.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161116221122.15842.77692.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove the "PCI Hot Plug PCI Core" version message.  I don't think it
contains any useful information.  Remove unused #defines and move the
author information to a comment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fea0b8b..56013d0 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -23,6 +23,9 @@
  *
  * Send feedback to <kristen.c.accardi@intel.com>
  *
+ * Authors:
+ *   Greg Kroah-Hartman <greg@kroah.com>
+ *   Scott Murray <scottm@somanetworks.com>
  */
 
 #include <linux/module.h>	/* try_module_get & module_put */
@@ -50,15 +53,9 @@
 #define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
 
-
 /* local variables */
 static bool debug;
 
-#define DRIVER_VERSION	"0.5"
-#define DRIVER_AUTHOR	"Greg Kroah-Hartman <greg@kroah.com>, Scott Murray <scottm@somanetworks.com>"
-#define DRIVER_DESC	"PCI Hot Plug PCI Core"
-
-
 static LIST_HEAD(pci_hotplug_slot_list);
 static DEFINE_MUTEX(pci_hp_mutex);
 
@@ -534,7 +531,6 @@ static int __init pci_hotplug_init(void)
 		return result;
 	}
 
-	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return result;
 }
 device_initcall(pci_hotplug_init);

