Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tomasz Nowicki <tn@semihalf.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v3 04/13] drivers: platform: add fwnode base platform devices retrieval
Date: Wed, 20 Jul 2016 12:23:26 +0100
Message-Id: <1469013815-24380-5-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The platform device kernel API does not provide functions to
retrieve a platform device through the corresponding struct
device fwnode pointer.

Implement the fwnode platform_device look-up in drivers core
code by using the bus_find_device() API and a corresponding
matching function. The OF equivalent (eg of_find_device_by_node())
will reuse the newly introduced function when OF code will
take care of setting up the device->fwnode value that is
currently left dangling for platform devices instantiated out
of device tree nodes.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/base/platform.c         | 23 +++++++++++++++++++++++
 include/linux/platform_device.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6482d47..3ef150d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -760,6 +760,29 @@ err_out:
 }
 EXPORT_SYMBOL_GPL(__platform_create_bundle);
 
+static int fwnode_dev_match(struct device *dev, void *data)
+{
+	return dev->fwnode == data;
+}
+
+/**
+ * platform_find_device_by_fwnode() - Find the platform_device associated
+ *				      with a fwnode
+ * @fwnode: Pointer to firmware node
+ *
+ * Returns platform_device pointer, or NULL if not found
+ */
+struct platform_device *
+platform_find_device_by_fwnode(struct fwnode_handle *fwnode)
+{
+	struct device *dev;
+
+	dev = bus_find_device(&platform_bus_type, NULL, fwnode,
+			      fwnode_dev_match);
+	return dev ? to_platform_device(dev) : NULL;
+}
+EXPORT_SYMBOL(platform_find_device_by_fwnode);
+
 /**
  * __platform_register_drivers - register an array of platform drivers
  * @drivers: an array of drivers to register
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 98c2a7c..01a3eb2 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -276,6 +276,9 @@ extern struct platform_device *__platform_create_bundle(
 	struct resource *res, unsigned int n_res,
 	const void *data, size_t size, struct module *module);
 
+extern struct platform_device *
+platform_find_device_by_fwnode(struct fwnode_handle *fwnode);
+
 int __platform_register_drivers(struct platform_driver * const *drivers,
 				unsigned int count, struct module *owner);
 void platform_unregister_drivers(struct platform_driver * const *drivers,
-- 
2.6.4
