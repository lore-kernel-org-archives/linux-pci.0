Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43607 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab3EaEVs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 00:21:48 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa12so1520389pbc.25
        for <linux-pci@vger.kernel.org>; Thu, 30 May 2013 21:21:48 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Xudong Hao <xudong.hao@intel.com>
Cc: Yijing Wang <wangyijing@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <jiang.liu@huawei.com>
Subject: [PATCH 1/3] PCI: set correct value for iov device before device
Date: Fri, 31 May 2013 12:21:29 +0800
Message-Id: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Xudong Hao <xudong.hao@intel.com>

Commit 4f535093cf8f6da8 "PCI: Put pci_dev in device tree as early as
possible" moves device registering from pci_bus_add_devices() to
pci_device_add(). That change causes troubles to PCI virtual functions
because device_add(&virtfn->dev) is called before setting
virtfn->is_virtfn flag, which then causes Xen to report PCI virtual
functions as PCI physical functions.

So fix it by setting virtfn->is_virtfn before calling pci_device_add().

[Jiang Liu]:
move the setting of virtfn->is_virtfn ahead further for better readability
and modify changelog.

Signed-off-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: <stable@vger.kernel.org> # 3.9+
---
Hi Bjorn and Yinghai,
    How about this? I split out the bugfix patch as separate patch
so it could be easily back ported to stable branches.
Regards!
Gerry
---
 drivers/pci/iov.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 5fffca9..de8ffac 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -82,6 +82,8 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_DID, &virtfn->device);
 	pci_setup_device(virtfn);
 	virtfn->dev.parent = dev->dev.parent;
+	virtfn->physfn = pci_dev_get(dev);
+	virtfn->is_virtfn = 1;
 
 	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
 		res = dev->resource + PCI_IOV_RESOURCES + i;
@@ -103,9 +105,6 @@ static int virtfn_add(struct pci_dev *dev, int id, int reset)
 	pci_device_add(virtfn, virtfn->bus);
 	mutex_unlock(&iov->dev->sriov->lock);
 
-	virtfn->physfn = pci_dev_get(dev);
-	virtfn->is_virtfn = 1;
-
 	rc = pci_bus_add_device(virtfn);
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
-- 
1.8.1.2

