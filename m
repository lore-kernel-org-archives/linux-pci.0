Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/9] PCI: Fix /sys warning when sriov enabled card is hot removed
Date: Sat,  4 Feb 2012 22:55:01 -0800
Message-Id: <1328424908-6385-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
References: <1328424908-6385-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During recent strick checking about sysfs_remove from Eric.
it will spit more bitter warning.

For SRIOV hotplug, we are calling pci_stop_dev() for VF at first.
(after we update pci_stop_bus_devices).

that pci_stop_dev will calling device_unregiste for that VF, so that directory
in VF is removed already.

We double checking if that VF dir in /sys is there, before try removing that
 physfn link.

Signed-of-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/iov.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 0321fa3..dfc7d65 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -173,7 +173,12 @@ static void virtfn_remove(struct pci_dev *dev, int id, int reset)
 
 	sprintf(buf, "virtfn%u", id);
 	sysfs_remove_link(&dev->dev.kobj, buf);
-	sysfs_remove_link(&virtfn->dev.kobj, "physfn");
+	/*
+	 * pci_stop_dev() could be called for this virtfn before already
+	 *  so directory for the virtfn is removed before.
+	 */
+	if (virtfn->dev.kobj.sd)
+		sysfs_remove_link(&virtfn->dev.kobj, "physfn");
 
 	mutex_lock(&iov->dev->sriov->lock);
 	pci_remove_bus_device(virtfn);
-- 
1.7.7

