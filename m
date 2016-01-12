Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49376 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbcALVdR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 16:33:17 -0500
From: Jacob Keller <jacob.e.keller@intel.com>
To: linux-pci@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] driver: add manual_bind_only option for virtual stub drivers
Date: Tue, 12 Jan 2016 13:33:10 -0800
Message-Id: <1452634390-17729-2-git-send-email-jacob.e.keller@intel.com>
In-Reply-To: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
References: <1452634390-17729-1-git-send-email-jacob.e.keller@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The vfio-pci and vfio-platform drivers are intended to be used as stub
drivers which can bind to any pci or platform device and are used to
enable direct assignment of a host device to a guest virtual machine
using IOMMU. However, today, these drivers will bind on device or driver
attach, once given a dynamic id to match against. This can cause
problems as the drivers may attach to devices that match an id but
haven't specifically been requested using the sysfs bind interface.

Add a boolean "manual_bind_only" which can be set by drivers which
should only bind to devices if they have been explicitly added using the
sysfs bind flow. This prevents these drivers from taking control of
devices unintentionally.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/base/dd.c                     | 6 ++++++
 drivers/vfio/pci/vfio_pci.c           | 3 +++
 drivers/vfio/platform/vfio_platform.c | 1 +
 include/linux/device.h                | 1 +
 4 files changed, 11 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a641cf3ccad6..e21bf1d67168 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -491,6 +491,9 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	struct device *dev = data->dev;
 	bool async_allowed;
 
+	if (drv->manual_bind_only)
+		return 0;
+
 	/*
 	 * Check if device has already been claimed. This may
 	 * happen with driver loading, device discovery/registration,
@@ -632,6 +635,9 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
+	if (drv->manual_bind_only)
+		return 0;
+
 	if (!driver_match_device(drv, dev))
 		return 0;
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 56bf6dbb93db..82f139854b56 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1045,6 +1045,9 @@ static struct pci_driver vfio_pci_driver = {
 	.probe		= vfio_pci_probe,
 	.remove		= vfio_pci_remove,
 	.err_handler	= &vfio_err_handlers,
+	.driver = {
+		.manual_bind_only = true;
+	},
 };
 
 struct vfio_devices {
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index b1cc3a768784..91138ac6d1a8 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -92,6 +92,7 @@ static struct platform_driver vfio_platform_driver = {
 	.remove		= vfio_platform_remove,
 	.driver	= {
 		.name	= "vfio-platform",
+		.manual_bind_only = true;
 	},
 };
 
diff --git a/include/linux/device.h b/include/linux/device.h
index b8f411b57dcb..de755bb64994 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -264,6 +264,7 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool manual_bind_only;		/* prevent bind on driver_attach */
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
-- 
2.6.3.505.g5cc1fd1

