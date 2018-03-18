Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL in hv_pci_onchannelcallback
Date: Sun, 18 Mar 2018 22:53:02 +0800
Message-Id: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hv_pci_onchannelcallback() is not called in atomic context.

The call chain ending up at hv_pci_onchannelcallback() is:
[1] hv_pci_onchannelcallback() <- hv_pci_probe()
hv_pci_probe() is only set as ".probe" in hv_driver 
structure "hv_pci_drv".

Despite never getting called from atomic context, 
hv_pci_onchannelcallback() calls kmalloc with GFP_ATOMIC, 
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL 
to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/host/pci-hyperv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0fe3ea1..c5c8a99 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void *context)
 	struct pci_dev_incoming *dev_message;
 	struct hv_pci_dev *hpdev;
 
-	buffer = kmalloc(bufferlen, GFP_ATOMIC);
+	buffer = kmalloc(bufferlen, GFP_KERNEL);
 	if (!buffer)
 		return;
 
@@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void *context)
 			kfree(buffer);
 			/* Handle large packet */
 			bufferlen = bytes_recvd;
-			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
+			buffer = kmalloc(bytes_recvd, GFP_KERNEL);
 			if (!buffer)
 				return;
 			continue;
-- 
1.9.1
