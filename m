Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41210 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab3DLUsJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:48:09 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so852099iea.32
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:48:09 -0700 (PDT)
Subject: [PATCH 4/6] PCI: Remove __must_check from definitions
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:48:07 -0600
Message-ID: <20130412204807.5237.67316.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The __must_check (gcc "warn_unused_result") attribute only makes sense
when compiling the *caller* of the function, so the attribute should
appear on the declaration in the header file, not on the definition.

The declarations of these functions are already annotated with
__must_check.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c |    4 ++--
 drivers/pci/hotplug/shpchp_sysfs.c     |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index d9a528f..d0f9eda 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -524,8 +524,8 @@ int pci_hp_deregister(struct hotplug_slot *hotplug)
  *
  * Returns 0 if successful, anything else for an error.
  */
-int __must_check pci_hp_change_slot_info(struct hotplug_slot *hotplug,
-					 struct hotplug_slot_info *info)
+int pci_hp_change_slot_info(struct hotplug_slot *hotplug,
+			    struct hotplug_slot_info *info)
 {
 	if (!hotplug || !info)
 		return -ENODEV;
diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index eeb23ce..e8c31fe 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -85,7 +85,7 @@ static ssize_t show_ctrl (struct device *dev, struct device_attribute *attr, cha
 }
 static DEVICE_ATTR (ctrl, S_IRUGO, show_ctrl, NULL);
 
-int __must_check shpchp_create_ctrl_files (struct controller *ctrl)
+int shpchp_create_ctrl_files (struct controller *ctrl)
 {
 	return device_create_file (&ctrl->pci_dev->dev, &dev_attr_ctrl);
 }

