Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:3545 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbbCPDNU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 15 Mar 2015 23:13:20 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, <jiang.liu@linux.intel.com>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: versatile: Fix building error for resource_list_for_each_entry
Date: Mon, 16 Mar 2015 11:11:03 +0800
Message-ID: <1426475463-11352-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pci-versatile.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index e3a2450..4352ee9 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/resource_ext.h>
 
 static void __iomem *versatile_pci_base;
 static void __iomem *versatile_cfg_base[2];
@@ -80,7 +81,7 @@ static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
 	if (err)
 		return err;
 
-	resource_list_for_each_entry(win, res, list) {
+	resource_list_for_each_entry(win, res) {
 		struct resource *parent, *res = win->res;
 
 		switch (resource_type(res)) {
-- 
1.7.1

