Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiang Liu <liuj97@gmail.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <efault@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vinod Koul <vinod.koul@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Ingo Molnar <mingo@elte.hu>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v1 2/3] DCA, x86: restart DCA operations in unregister_dca_provider()
Date: Mon, 23 Apr 2012 22:34:01 +0800
Message-Id: <1335191642-6869-3-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1335191642-6869-1-git-send-email-jiang.liu@huawei.com>
References: <1335191642-6869-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When deregistering a DCA device, function unregister_dca_provider() will
notify clients by DCA_PROVIDER_REMOVE to stop DCA operations at beginning.
Currently DCA operations won't be restarted by unregister_dca_provider()
even if there are still DCA devices left. This may cause trouble to systems
with multiple DCA devices/IOHs. So restart DCA operations if there are
still DCA devices left after removing a DCA device.

Signed-off-by: Jiang Liu <liuj97@gmail.com>
---
 drivers/dca/dca-core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/dca/dca-core.c b/drivers/dca/dca-core.c
index 075c4bd..f8cfa58 100644
--- a/drivers/dca/dca-core.c
+++ b/drivers/dca/dca-core.c
@@ -414,6 +414,7 @@ void unregister_dca_provider(struct dca_provider *dca, struct device *dev)
 	unsigned long flags;
 	struct pci_bus *pci_rc;
 	struct dca_domain *domain;
+	bool restart = false;
 
 	blocking_notifier_call_chain(&dca_provider_chain,
 				     DCA_PROVIDER_REMOVE, NULL);
@@ -427,9 +428,20 @@ void unregister_dca_provider(struct dca_provider *dca, struct device *dev)
 	if (list_empty(&domain->dca_providers))
 		dca_free_domain(domain);
 
+	if (!list_empty(&dca_domains))
+		restart = true;
+
 	raw_spin_unlock_irqrestore(&dca_lock, flags);
 
 	dca_sysfs_remove_provider(dca);
+
+	/*
+	 * Notify DCA clients to restart DCA operations if there are still
+	 * DCA devices left.
+	 */
+	if (restart)
+		blocking_notifier_call_chain(&dca_provider_chain,
+					     DCA_PROVIDER_ADD, NULL);
 }
 EXPORT_SYMBOL_GPL(unregister_dca_provider);
 
-- 
1.7.5.4

