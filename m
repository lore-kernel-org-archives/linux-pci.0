Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33251 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbeDJNER (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 09:04:17 -0400
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kishon@ti.com, bhelgaas@google.com, nsekhar@ti.com,
        john@metanate.com, shawn.lin@rock-chips.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] pci: endpoint: Replace mdelay with usleep_range in pci_epf_test_write
Date: Tue, 10 Apr 2018 21:04:06 +0800
Message-Id: <1523365446-31563-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_epf_test_write() is never called in atomic context.

The call chain ending up at pci_epf_test_write() is:
[1] pci_epf_test_write() <- pci_epf_test_cmd_handler()

pci_epf_test_cmd_handler() is set as a parameter of INIT_DELAYED_WORK() 
in pci_epf_test_probe().
This function is not called in atomic context.

Despite never getting called from atomic context, pci_epf_test_write()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index f9308c2..2f0642e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -237,7 +237,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	 * wait 1ms inorder for the write to complete. Without this delay L3
 	 * error in observed in the host system.
 	 */
-	mdelay(1);
+	usleep_range(1000, 2000);
 
 	kfree(buf);
 
-- 
1.9.1
