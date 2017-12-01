Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56272 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752297AbdLACxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Nov 2017 21:53:11 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V4 3/5] device property: Introduce a common API to fetch device match data
Date: Thu, 30 Nov 2017 21:52:54 -0500
Message-Id: <1512096776-22883-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There is an OF/ACPI function to obtain the driver data. We want to hide
OF/ACPI details from the device drivers and abstract following the device
family of functions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/base/property.c  | 14 ++++++++++++++
 include/linux/property.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7ed99c1..6adec89 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/property.h>
 #include <linux/etherdevice.h>
@@ -1335,3 +1336,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
 }
 EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
+
+void *device_get_match_data(struct device *dev)
+{
+	void *ret;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
+		ret = (void *)of_device_get_match_data(dev);
+	else
+		ret = acpi_get_match_data(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_get_match_data);
diff --git a/include/linux/property.h b/include/linux/property.h
index 6bebee1..01fa55b 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -275,6 +275,8 @@ int device_add_properties(struct device *dev,
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
 
+void *device_get_match_data(struct device *dev);
+
 int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
-- 
1.9.1
