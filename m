Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54874 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865AbaJVMcB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Oct 2014 08:32:01 -0400
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH] PCI / PM: handle failure to enable wakeup on PCIe PME
Date: Wed, 22 Oct 2014 14:31:55 +0200
Message-Id: <1413981115-22045-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the irqchip handling the PCIe PME interrupt is not able
to enable interrupt wakeup we should properly reflect this
in the PME suspend status.

This fixes a kernel warning on resume, where it would try
to disable the irq wakeup that failed to be activated while
suspending. The issue was introduced with 76cde7e49590
(PCI / PM: Make PCIe PME interrupts wake up from suspend-to-idle).

Reported-by: Richard Zhu <richard.zhu@freescale.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Richard Zhu <richard.zhu@freescale.com>
---
Trimmed warning on resume looks like this:
[  109.292736] WARNING: CPU: 0 PID: 609 at kernel/irq/manage.c:536 irq_set_irq_wake+0xc0/0xf8()
[  109.301193] Unbalanced IRQ 384 wake disable
[  109.305392] Modules linked in:
[  109.308502] CPU: 0 PID: 609 Comm: kworker/u2:9 Tainted: G        W      3.18.0-rc1-00009-g820df3d-dirty #268
[  109.318368] Workqueue: events_unbound async_run_entry_fn
[  109.323718] Backtrace:
[  109.326233] [<80012460>] (dump_backtrace) from [<80012744>] (show_stack+0x18/0x1c)
[  109.339616] [<8001272c>] (show_stack) from [<806d8dc8>] (dump_stack+0x8c/0xa4)
[  109.346885] [<806d8d3c>] (dump_stack) from [<8002a88c>] (warn_slowpath_common+0x70/0x94)
[  109.360773] [<8002a81c>] (warn_slowpath_common) from [<8002a8e8>] (warn_slowpath_fmt+0x38/0x40)
[  109.376334] [<8002a8b4>] (warn_slowpath_fmt) from [<8006c2a8>] (irq_set_irq_wake+0xc0/0xf8)
[  109.388351] [<8006c1e8>] (irq_set_irq_wake) from [<802f22cc>] (pcie_pme_resume+0x34/0x64)
[  109.402328] [<802f2298>] (pcie_pme_resume) from [<802f1590>] (resume_iter+0x44/0x50)
[  109.413742] [<802f154c>] (resume_iter) from [<803784d4>] (device_for_each_child+0x4c/0x78)
[  109.422039] [<80378488>] (device_for_each_child) from [<802f196c>] (pcie_port_device_resume+0x18/0x20)
[  109.436085] [<802f1954>] (pcie_port_device_resume) from [<802e6f40>] (pci_pm_resume+0x7c/0x10c)
[  109.444829] [<802e6ec4>] (pci_pm_resume) from [<8038502c>] (dpm_run_callback.isra.12+0x34/0x7c)
[  109.459323] [<80384ff8>] (dpm_run_callback.isra.12) from [<8038543c>] (device_resume+0xb8/0x194)
[  109.474961] [<80385384>] (device_resume) from [<80385538>] (async_resume+0x20/0x4c)
[  109.490523] [<80385518>] (async_resume) from [<800471a0>] (async_run_entry_fn+0x48/0x11c)
[  109.502371] [<80047158>] (async_run_entry_fn) from [<8003f46c>] (process_one_work+0x1ac/0x414)
[  109.515711] [<8003f2c0>] (process_one_work) from [<8003ff50>] (worker_thread+0x148/0x4e0)
[  109.534446] [<8003fe08>] (worker_thread) from [<80044704>] (kthread+0xdc/0xf8)
[  109.552225] [<80044628>] (kthread) from [<8000ec08>] (ret_from_fork+0x14/0x2c)
---
 drivers/pci/pcie/pme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index a9f9c46e5022..63fc63911295 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -397,6 +397,7 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 	struct pcie_pme_service_data *data = get_service_data(srv);
 	struct pci_dev *port = srv->port;
 	bool wakeup;
+	int ret;
 
 	if (device_may_wakeup(&port->dev)) {
 		wakeup = true;
@@ -407,9 +408,10 @@ static int pcie_pme_suspend(struct pcie_device *srv)
 	}
 	spin_lock_irq(&data->lock);
 	if (wakeup) {
-		enable_irq_wake(srv->irq);
+		ret = enable_irq_wake(srv->irq);
 		data->suspend_level = PME_SUSPEND_WAKEUP;
-	} else {
+	}
+	if (!wakeup || ret) {
 		struct pci_dev *port = srv->port;
 
 		pcie_pme_interrupt_enable(port, false);
-- 
2.1.1

