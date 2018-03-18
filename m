Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        bhelgaas@google.com
Cc: devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_KERNEL in new_pcichild_device
Date: Sun, 18 Mar 2018 22:53:28 +0800
Message-Id: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

new_pcichild_device() is not called in atomic context.

The call chain ending up at new_pcichild_device() is:
[1] new_pcichild_device() <- pci_devices_present_work()
pci_devices_present_work() is only set in INIT_WORK().

Despite never getting called from atomic context,
new_pcichild_device() calls kzalloc with GFP_ATOMIC,
which waits busily for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
to avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pci/host/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
index 0fe3ea1..289e31d 100644
--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1500,7 +1500,7 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
 	unsigned long flags;
 	int ret;
 
-	hpdev = kzalloc(sizeof(*hpdev), GFP_ATOMIC);
+	hpdev = kzalloc(sizeof(*hpdev), GFP_KERNEL);
 	if (!hpdev)
 		return NULL;
 
-- 
1.9.1
