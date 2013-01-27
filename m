Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47623 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab3A0Fi3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 27 Jan 2013 00:38:29 -0500
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 11/22] PCI, drm: Kill pci_root_buses in alpha hose setting
Date: Sat, 26 Jan 2013 21:36:32 -0800
Message-Id: <1359265003-16166-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1359265003-16166-1-git-send-email-yinghai@kernel.org>
References: <CAE9FiQUhrVPNKcdWbiqHLa5PzH7Dg-uduVc9BP-OjM-eCqSXdw@mail.gmail.com>
 <1359265003-16166-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

