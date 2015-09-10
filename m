Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:4514 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbbIJKoz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 06:44:55 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
CC: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
	"Tianhong Ding" <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Yijing Wang" <wangyijing@huawei.com>,
	Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PCI: remove an unnecessary if statement
Date: Thu, 10 Sep 2015 18:40:31 +0800
Message-ID: <1441881631-5044-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch have no functional change. Successful return count, otherwise
return -ENODEV.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/pci/pci-driver.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 52a880c..02919ec 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -172,7 +172,7 @@ static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
 	__u32 vendor, device, subvendor = PCI_ANY_ID,
 		subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
 	int fields = 0;
-	int retval = -ENODEV;
+	size_t retval = -ENODEV;

 	fields = sscanf(buf, "%x %x %x %x %x %x",
 			&vendor, &device, &subvendor, &subdevice,
@@ -190,15 +190,13 @@ static ssize_t store_remove_id(struct device_driver *driver, const char *buf,
 		    !((id->class ^ class) & class_mask)) {
 			list_del(&dynid->node);
 			kfree(dynid);
-			retval = 0;
+			retval = count;
 			break;
 		}
 	}
 	spin_unlock(&pdrv->dynids.lock);

-	if (retval)
-		return retval;
-	return count;
+	return retval;
 }
 static DRIVER_ATTR(remove_id, S_IWUSR, NULL, store_remove_id);

--
2.5.0


