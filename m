Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v2 7/9] PCI: hotplug: Remove hotplug core message
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Date: Mon, 21 Nov 2016 15:46:02 -0600
Message-ID: <20161121214602.21036.2749.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
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
