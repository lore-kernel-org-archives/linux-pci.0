Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8871 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbFSICM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jun 2015 04:02:12 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 3/3] PCI: Use usleep_range() instead of msleep() for better accuracy
Date: Fri, 19 Jun 2015 15:57:46 +0800
Message-ID: <1434700666-6346-4-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
References: <1434700666-6346-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Msleep < 20ms can sleep for up to 20ms, see
Documentation/timers/timers-howto.txt, so we could
use usleep_range instead.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index daf54be..4553728 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -118,7 +118,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 		}
 		if (timeout < 0)
 			break;
-		msleep(10);
+		usleep_range(10000, 11000);
 		timeout -= 10;
 	}
 	return 0;	/* timeout */
-- 
1.7.1

