Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60822 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab3HEIzY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 04:55:24 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Rafael <rjw@sisk.pl>,
	Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH -v5 5/6] PCI: add inspection of device change in pci_scan_single_device
Date: Mon, 5 Aug 2013 16:54:57 +0800
Message-ID: <1375692898-27476-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add inspection of device change in pci_scan_single_device.
If device change found, print warning. Because the new device
bind the old device driver, so for safety, we do not remove this
device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Oliver Neukum <oneukum@suse.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/probe.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0c5da76..f2812db 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1389,6 +1389,8 @@ struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
 
 	dev = pci_get_slot(bus, devfn);
 	if (dev) {
+		if (pci_serial_number_changed(dev))
+			dev_warn(&dev->dev, "device serial number changed!");
 		pci_dev_put(dev);
 		return dev;
 	}
-- 
1.7.1


