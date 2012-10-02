Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31262 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab2JBGdJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Oct 2012 02:33:09 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 01/10] device: add drivers_autoprobe in struct device
Date: Mon,  1 Oct 2012 23:32:59 -0700
Message-Id: <1349159588-15029-2-git-send-email-yinghai@kernel.org>
In-Reply-To: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
References: <1349159588-15029-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

To use to control the delay attach driver for specific device.

Will use bus notifier to toggle this bits when needed.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c     |    2 +-
 drivers/base/core.c    |    1 +
 include/linux/device.h |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 181ed26..22b826a 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -538,7 +538,7 @@ void bus_probe_device(struct device *dev)
 	if (!bus)
 		return;
 
-	if (bus->p->drivers_autoprobe) {
+	if (bus->p->drivers_autoprobe && dev->drivers_autoprobe) {
 		ret = device_attach(dev);
 		WARN_ON(ret < 0);
 	}
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5e6e00b..8a71f88 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -656,6 +656,7 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_pm_init(dev);
 	set_dev_node(dev, -1);
+	dev->drivers_autoprobe = true;
 }
 
 static struct kobject *virtual_device_parent(struct device *dev)
diff --git a/include/linux/device.h b/include/linux/device.h
index 52a5f15..e08db26 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -647,6 +647,7 @@ struct device {
 	struct bus_type	*bus;		/* type of bus device is on */
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
+	bool	drivers_autoprobe;
 	void		*platform_data;	/* Platform specific data, device
 					   core doesn't touch it */
 	struct dev_pm_info	power;
-- 
1.7.7

