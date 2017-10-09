Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from m12-14.163.com ([220.181.12.14]:35428 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdJIInd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Oct 2017 04:43:33 -0400
From: Jia-Ju Bai <baijiaju1990@163.com>
To: forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        simon@nikanor.nu, tvboxspy@gmail.com, scott@matheina.com,
        dan.a.cashman@gmail.com, golubev.mikhail@gmail.com
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>
Subject: [PATCH] vt6655: Fix a possible sleep-in-atomic bug in vt6655_suspend
Date: Mon,  9 Oct 2017 16:45:55 +0800
Message-Id: <1507538755-10217-1-git-send-email-baijiaju1990@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The driver may sleep under a spinlock, and the function call path is:
vt6655_suspend (acquire the spinlock)
  pci_set_power_state
    __pci_start_power_transition (drivers/pci/pci.c)
      msleep --> may sleep

To fix it, pci_set_power_state is called without having a spinlock.

This bug is found by my static analysis tool and my code review. 

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
---
 drivers/staging/vt6655/device_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 9fcf2e2..1123b4f 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1693,10 +1693,11 @@ static int vt6655_suspend(struct pci_dev *pcid, pm_message_t state)
 	MACbShutdown(priv);
 
 	pci_disable_device(pcid);
-	pci_set_power_state(pcid, pci_choose_state(pcid, state));
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
+	pci_set_power_state(pcid, pci_choose_state(pcid, state));
+
 	return 0;
 }
 
-- 
1.7.9.5
