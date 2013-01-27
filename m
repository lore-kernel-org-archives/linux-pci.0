Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:31167 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab3A0TYX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 14:24:23 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 11/22] PCI, drm: Kill pci_root_buses in alpha hose setting
Date: Sun, 27 Jan 2013 11:23:38 -0800
Message-Id: <1359314629-18651-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359314629-18651-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQXHG01NjnYNDbC-KEpbcvY-q4pBe97CxTOGS7W4vZQBYQ@mail.gmail.com>
 <1359314629-18651-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Replace that with hotplug-safe version.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/drm_fops.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fops.c b/drivers/gpu/drm/drm_fops.c
index 133b413..b92a9cc 100644
--- a/drivers/gpu/drm/drm_fops.c
+++ b/drivers/gpu/drm/drm_fops.c
@@ -356,9 +356,13 @@ static int drm_open_helper(struct inode *inode, struct file *filp,
 			pci_dev_put(pci_dev);
 		}
 		if (!dev->hose) {
-			struct pci_bus *b = pci_bus_b(pci_root_buses.next);
-			if (b)
-				dev->hose = b->sysdata;
+			struct pci_host_bridge *host_bridge;
+
+			host_bridge = pci_next_host_bridge(NULL);
+			if (host_bridge) {
+				dev->hose = host_bridge->bus->sysdata;
+				put_device(&host_bridge->dev);
+			}
 		}
 	}
 #endif
-- 
1.7.10.4

