Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33096 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758938AbcG1QQ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2016 12:16:58 -0400
Received: by mail-pa0-f66.google.com with SMTP id q2so3786604pap.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Jul 2016 09:16:58 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, devel@linuxdriverproject.org,
	linux-pci@vger.kernel.org
Subject: [PATCH -next] PCI: hv: Use list_move_tail instead of list_del/list_add_tail
Date: Thu, 28 Jul 2016 16:16:48 +0000
Message-Id: <1469722608-14956-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Using list_move_tail() instead of list_del() + list_add_tail().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/pci/host/pci-hyperv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 6955ffdb..a8deeca 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1466,8 +1466,7 @@ static void pci_devices_present_work(struct work_struct *work)
 			if (hpdev->reported_missing) {
 				found = true;
 				put_pcichild(hpdev, hv_pcidev_ref_childlist);
-				list_del(&hpdev->list_entry);
-				list_add_tail(&hpdev->list_entry, &removed);
+				list_move_tail(&hpdev->list_entry, &removed);
 				break;
 			}
 		}



