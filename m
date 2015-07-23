Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Spencer Baugh <sbaugh@catern.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Joern Engel <joern@logfs.org>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Joern Engel <joern@purestorage.com>,
	Spencer Baugh <Spencer.baugh@purestorage.com>,
	Spencer Baugh <sbaugh@catern.com>
Subject: [PATCH] aer: add cond_resched to aer_isr
Date: Thu, 23 Jul 2015 14:54:32 -0700
Message-Id: <1437688476-3399-2-git-send-email-sbaugh@catern.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Joern Engel <joern@logfs.org>

Multiple nested loops.  I have observed 590ms scheduler latency caused
by this loop and interrupts.  Interrupts were responsible for 190ms, the
rest could have been avoided with a cond_resched.

Signed-off-by: Joern Engel <joern@logfs.org>
Signed-off-by: Spencer Baugh <sbaugh@catern.com>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 9803e3d..32b1b5c 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -780,8 +780,10 @@ void aer_isr(struct work_struct *work)
 	struct aer_err_source uninitialized_var(e_src);
 
 	mutex_lock(&rpc->rpc_mutex);
-	while (get_e_source(rpc, &e_src))
+	while (get_e_source(rpc, &e_src)) {
 		aer_isr_one_error(p_device, &e_src);
+		cond_resched();
+	}
 	mutex_unlock(&rpc->rpc_mutex);
 
 	wake_up(&rpc->wait_release);
-- 
2.5.0.rc3

