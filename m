Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:43730 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab3DLUrq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Apr 2013 16:47:46 -0400
Received: by mail-ia0-f182.google.com with SMTP id u20so2768815iag.13
        for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2013 13:47:46 -0700 (PDT)
Subject: [PATCH 1/6] PCI: Make local functions/structs static
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 12 Apr 2013 14:47:43 -0600
Message-ID: <20130412204743.5237.31153.stgit@bhelgaas-glaptop>
In-Reply-To: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
References: <20130412204510.5237.25443.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This fixes "no previous prototype" warnings found via "make W=1".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi.c       |    4 ++--
 drivers/pci/pci.c       |    8 ++++----
 drivers/pci/setup-bus.c |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 00cc78c..bbff7d5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -484,12 +484,12 @@ static struct msi_attribute mode_attribute =
 	__ATTR(mode, S_IRUGO, show_msi_mode, NULL);
 
 
-struct attribute *msi_irq_default_attrs[] = {
+static struct attribute *msi_irq_default_attrs[] = {
 	&mode_attribute.attr,
 	NULL
 };
 
-void msi_kobj_release(struct kobject *kobj)
+static void msi_kobj_release(struct kobject *kobj)
 {
 	struct msi_desc *entry = to_msi_desc(kobj);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b099e00..f0ef399 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2619,7 +2619,7 @@ void pci_release_selected_regions(struct pci_dev *pdev, int bars)
 			pci_release_region(pdev, i);
 }
 
-int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
+static int __pci_request_selected_regions(struct pci_dev *pdev, int bars,
 				 const char *res_name, int excl)
 {
 	int i;
@@ -3699,7 +3699,7 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
+static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
 	resource_size_t align = 0;
@@ -3812,7 +3812,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	}
 }
 
-ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
+static ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
 {
 	if (count > RESOURCE_ALIGNMENT_PARAM_SIZE - 1)
 		count = RESOURCE_ALIGNMENT_PARAM_SIZE - 1;
@@ -3823,7 +3823,7 @@ ssize_t pci_set_resource_alignment_param(const char *buf, size_t count)
 	return count;
 }
 
-ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
+static ssize_t pci_get_resource_alignment_param(char *buf, size_t size)
 {
 	size_t count;
 	spin_lock(&resource_alignment_lock);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7e8739e..502a75e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1044,7 +1044,7 @@ handle_done:
 	;
 }
 
-void __ref __pci_bus_size_bridges(struct pci_bus *bus,
+static void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head)
 {
 	struct pci_dev *dev;

