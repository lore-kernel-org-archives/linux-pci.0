Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbcLEXZb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Dec 2016 18:25:31 -0500
Subject: [PATCH v11 01/15] ACPI: Add acpi_resource_consumer() to find device
 that claims a resource
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Mon, 05 Dec 2016 17:25:27 -0600
Message-ID: <20161205232526.3957.81144.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161205232117.3957.50546.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Add acpi_resource_consumer().  This takes a struct resource and searches
the ACPI namespace for a device whose current resource settings (_CRS)
includes the resource.  It returns the device if it exists, or NULL if no
device uses the resource.

If more than one device uses the resource (this may happen in the case of
bridges), acpi_resource_consumer() returns the first one found by
acpi_get_devices() in its modified depth-first walk of the namespace.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/resource.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h    |    7 ++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 56241eb..cb57962 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -664,3 +664,60 @@ int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 	return (type & types) ? 0 : 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_filter_resource_type);
+
+static int acpi_dev_consumes_res(struct acpi_device *adev, struct resource *res)
+{
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	int ret, found = 0;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (ret < 0)
+		return 0;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		if (resource_contains(rentry->res, res)) {
+			found = 1;
+			break;
+		}
+
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+	return found;
+}
+
+static acpi_status acpi_res_consumer_cb(acpi_handle handle, u32 depth,
+					 void *context, void **ret)
+{
+	struct resource *res = context;
+	struct acpi_device **consumer = (struct acpi_device **) ret;
+	struct acpi_device *adev;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+
+	if (acpi_dev_consumes_res(adev, res)) {
+		*consumer = adev;
+		return AE_CTRL_TERMINATE;
+	}
+
+	return AE_OK;
+}
+
+/**
+ * acpi_resource_consumer - Find the ACPI device that consumes @res.
+ * @res: Resource to search for.
+ *
+ * Search the current resource settings (_CRS) of every ACPI device node
+ * for @res.  If we find an ACPI device whose _CRS includes @res, return
+ * it.  Otherwise, return NULL.
+ */
+struct acpi_device *acpi_resource_consumer(struct resource *res)
+{
+	struct acpi_device *consumer = NULL;
+
+	acpi_get_devices(NULL, acpi_res_consumer_cb, res, (void **) &consumer);
+	return consumer;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddbeda6..b00ad73 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -419,6 +419,8 @@ static inline int acpi_dev_filter_resource_type_cb(struct acpi_resource *ares,
 	return acpi_dev_filter_resource_type(ares, (unsigned long)arg);
 }
 
+struct acpi_device *acpi_resource_consumer(struct resource *res);
+
 int acpi_check_resource_conflict(const struct resource *res);
 
 int acpi_check_region(resource_size_t start, resource_size_t n,
@@ -762,6 +764,11 @@ static inline int acpi_reconfig_notifier_unregister(struct notifier_block *nb)
 	return -EINVAL;
 }
 
+static inline struct acpi_device *acpi_resource_consumer(struct resource *res)
+{
+	return NULL;
+}
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC

