Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	"Rafael J . Wysocki" <rjw@sisk.pl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Toshi Kani <toshi.kani@hp.com>,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2, part 2 13/18] PCI, DRM: use hotplug-safe iterators to walk PCI buses
Date: Wed, 15 May 2013 00:51:57 +0800
Message-Id: <1368550322-1045-13-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
References: <1368550322-1045-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enhance DRM drvier to use hotplug-safe iterators to walk PCI buses.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/drm_fops.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_fops.c b/drivers/gpu/drm/drm_fops.c
index 13fdcd1..04f3bcd 100644
--- a/drivers/gpu/drm/drm_fops.c
+++ b/drivers/gpu/drm/drm_fops.c
@@ -357,9 +357,11 @@ static int drm_open_helper(struct inode *inode, struct file *filp,
 			pci_dev_put(pci_dev);
 		}
 		if (!dev->hose) {
-			struct pci_bus *b = pci_bus_b(pci_root_buses.next);
-			if (b)
+			struct pci_bus *b = pci_get_next_root_bus(NULL);
+			if (b) {
 				dev->hose = b->sysdata;
+				pci_bus_put(b);
+			}
 		}
 	}
 #endif
-- 
1.8.1.2

