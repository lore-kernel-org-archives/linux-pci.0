Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:30395 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbdI3FuP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Sep 2017 01:50:15 -0400
From: Govindarajulu Varadarajan <gvaradar@cisco.com>
To: benve@cisco.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlbec@evilplan.org, hch@lst.de,
        mingo@redhat.com, peterz@infradead.org, okaya@codeaurora.org
Cc: Govindarajulu Varadarajan <gvaradar@cisco.com>
Subject: [PATCH V2] PCI: AER: fix deadlock in do_recovery
Date: Fri, 29 Sep 2017 22:49:38 -0700
Message-Id: <20170930054938.43271-1-gvaradar@cisco.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

CPU0					CPU1
---------------------------------------------------------------------
__driver_attach()
device_lock(&dev->mutex) <--- device mutex lock here
driver_probe_device()
pci_enable_sriov()
pci_iov_add_virtfn()
pci_device_add()
					aer_isr()		<--- pci aer error
					do_recovery()
					broadcast_error_message()
					pci_walk_bus()
					down_read(&pci_bus_sem) <--- rd sem
down_write(&pci_bus_sem) <-- stuck on wr sem
					report_error_detected()
					device_lock(&dev->mutex)<--- DEAD LOCK

This can also happen when aer error occurs while pci_dev->sriov_config() is
called.

This patch does a pci_bus_walk and adds all the devices to a list. After
unlocking (up_read) &pci_bus_sem, we go through the list and call
err_handler of the devices with devic_lock() held. This way, we dont try
to hold both locks at same time.

v2:
* Drop patch 1, 2 & 4.
* Instead of locking 50+ devices, do get_device() and add them to a list.
  After unlocking &pci_bus_sem, go through the list call err_handler.

v1:
* Previous discussion here: https://lkml.org/lkml/2017/9/27/720

[   70.984091] pcieport 0000:00:02.0: AER: Uncorrected (Non-Fatal) error received: id=0010
[   70.984112] pcieport 0000:00:02.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, id=0010(Requester ID)
[   70.984116] pcieport 0000:00:02.0:   device [8086:3c04] error status/mask=00004000/00100000
[   70.984120] pcieport 0000:00:02.0:    [14] Completion Timeout     (First)
...
[  107.484190] INFO: task kworker/0:1:76 blocked for more than 30 seconds.
[  107.563619]       Not tainted 4.13.0+ #28
[  107.611618] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  107.705368] kworker/0:1     D    0    76      2 0x80000000
[  107.771050] Workqueue: events aer_isr
[  107.814895] Call Trace:
[  107.844181]  __schedule+0x312/0xa40
[  107.885928]  schedule+0x3d/0x90
[  107.923506]  schedule_preempt_disabled+0x15/0x20
[  107.978773]  __mutex_lock+0x304/0xa30
[  108.022594]  ? dev_printk_emit+0x3b/0x50
[  108.069534]  ? report_error_detected+0xa6/0x210
[  108.123770]  mutex_lock_nested+0x1b/0x20
[  108.170713]  ? mutex_lock_nested+0x1b/0x20
[  108.219730]  report_error_detected+0xa6/0x210
[  108.271881]  ? aer_recover_queue+0xe0/0xe0
[  108.320904]  pci_walk_bus+0x46/0x90
[  108.362645]  ? aer_recover_queue+0xe0/0xe0
[  108.411658]  broadcast_error_message+0xc3/0xf0
[  108.464835]  do_recovery+0x34/0x220
[  108.506569]  ? get_device_error_info+0x92/0x130
[  108.560785]  aer_isr+0x28f/0x3b0
[  108.599410]  process_one_work+0x277/0x6c0
[  108.647399]  worker_thread+0x4d/0x3b0
[  108.691218]  kthread+0x171/0x190
[  108.729830]  ? process_one_work+0x6c0/0x6c0
[  108.779888]  ? kthread_create_on_node+0x40/0x40
[  108.834110]  ret_from_fork+0x2a/0x40
[  108.876916] INFO: task kworker/0:2:205 blocked for more than 30 seconds.
[  108.957129]       Not tainted 4.13.0+ #28
[  109.005114] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  109.098873] kworker/0:2     D    0   205      2 0x80000000
[  109.164544] Workqueue: events work_for_cpu_fn
[  109.216681] Call Trace:
[  109.245943]  __schedule+0x312/0xa40
[  109.287687]  ? rwsem_down_write_failed+0x308/0x4f0
[  109.345021]  schedule+0x3d/0x90
[  109.382603]  rwsem_down_write_failed+0x30d/0x4f0
[  109.437869]  ? __lock_acquire+0x75c/0x1410
[  109.486910]  call_rwsem_down_write_failed+0x17/0x30
[  109.545287]  ? call_rwsem_down_write_failed+0x17/0x30
[  109.605752]  down_write+0x88/0xb0
[  109.645410]  pci_device_add+0x158/0x240
[  109.691313]  pci_iov_add_virtfn+0x24f/0x340
[  109.741375]  pci_enable_sriov+0x32b/0x420
[  109.789466]  ? pci_read+0x2c/0x30
[  109.829142]  enic_probe+0x5d4/0xff0 [enic]
[  109.878184]  ? trace_hardirqs_on+0xd/0x10
[  109.926180]  local_pci_probe+0x42/0xa0
[  109.971037]  work_for_cpu_fn+0x14/0x20
[  110.015898]  process_one_work+0x277/0x6c0
[  110.063884]  worker_thread+0x1d6/0x3b0
[  110.108750]  kthread+0x171/0x190
[  110.147363]  ? process_one_work+0x6c0/0x6c0
[  110.197426]  ? kthread_create_on_node+0x40/0x40
[  110.251642]  ret_from_fork+0x2a/0x40
[  110.294448] INFO: task systemd-udevd:492 blocked for more than 30 seconds.
[  110.376742]       Not tainted 4.13.0+ #28
[  110.424715] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  110.518457] systemd-udevd   D    0   492    444 0x80000180
[  110.584116] Call Trace:
[  110.613382]  __schedule+0x312/0xa40
[  110.655127]  ? wait_for_completion+0x14a/0x1d0
[  110.708302]  schedule+0x3d/0x90
[  110.745875]  schedule_timeout+0x26e/0x5b0
[  110.793887]  ? wait_for_completion+0x14a/0x1d0
[  110.847068]  wait_for_completion+0x169/0x1d0
[  110.898165]  ? wait_for_completion+0x169/0x1d0
[  110.951354]  ? wake_up_q+0x80/0x80
[  110.992060]  flush_work+0x237/0x300
[  111.033795]  ? flush_workqueue_prep_pwqs+0x1b0/0x1b0
[  111.093224]  ? wait_for_completion+0x5a/0x1d0
[  111.145363]  ? flush_work+0x237/0x300
[  111.189189]  work_on_cpu+0x94/0xb0
[  111.229894]  ? work_is_static_object+0x20/0x20
[  111.283070]  ? pci_device_shutdown+0x60/0x60
[  111.334173]  pci_device_probe+0x17a/0x190
[  111.382163]  driver_probe_device+0x2ff/0x450
[  111.433260]  __driver_attach+0x103/0x140
[  111.480195]  ? driver_probe_device+0x450/0x450
[  111.533381]  bus_for_each_dev+0x74/0xb0
[  111.579276]  driver_attach+0x1e/0x20
[  111.622056]  bus_add_driver+0x1ca/0x270
[  111.667955]  ? 0xffffffffc039c000
[  111.707616]  driver_register+0x60/0xe0
[  111.752472]  ? 0xffffffffc039c000
[  111.792126]  __pci_register_driver+0x6b/0x70
[  111.843275]  enic_init_module+0x38/0x1000 [enic]
[  111.898533]  do_one_initcall+0x50/0x192
[  111.944428]  ? trace_hardirqs_on+0xd/0x10
[  111.992408]  do_init_module+0x5f/0x1f2
[  112.037274]  load_module+0x1740/0x1f70
[  112.082148]  SYSC_finit_module+0xd7/0xf0
[  112.129083]  ? SYSC_finit_module+0xd7/0xf0
[  112.178106]  SyS_finit_module+0xe/0x10
[  112.222972]  do_syscall_64+0x69/0x180
[  112.266793]  entry_SYSCALL64_slow_path+0x25/0x25
[  112.322047] RIP: 0033:0x7f3da098b559
[  112.364826] RSP: 002b:00007ffeb3306a38 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  112.455447] RAX: ffffffffffffffda RBX: 0000557fe41ed3d0 RCX: 00007f3da098b559
[  112.540860] RDX: 0000000000000000 RSI: 00007f3da14c79c5 RDI: 0000000000000006
[  112.626281] RBP: 00007f3da14c79c5 R08: 0000000000000000 R09: 00007ffeb3306b50
[  112.711698] R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000000
[  112.797114] R13: 0000557fe420e210 R14: 0000000000020000 R15: 0000557fe2c1ef4a
[  112.882568]
               Showing all locks held in the system:
[  112.956545] 5 locks held by kworker/0:1/76:
[  113.006616]  #0:  ("events"){+.+.}, at: [<ffffffffb00b10ed>] process_one_work+0x1ed/0x6c0
[  113.104535]  #1:  ((&rpc->dpc_handler)){+.+.}, at: [<ffffffffb00b10ed>] process_one_work+0x1ed/0x6c0
[  113.213894]  #2:  (&rpc->rpc_mutex){+.+.}, at: [<ffffffffb0505ca2>] aer_isr+0x32/0x3b0
[  113.308711]  #3:  (pci_bus_sem){++++}, at: [<ffffffffb04ea18a>] pci_walk_bus+0x2a/0x90
[  113.403501]  #4:  (&dev->mutex){....}, at: [<ffffffffb0505706>] report_error_detected+0xa6/0x210
[  113.508715] 3 locks held by kworker/0:2/205:
[  113.559808]  #0:  ("events"){+.+.}, at: [<ffffffffb00b10ed>] process_one_work+0x1ed/0x6c0
[  113.657718]  #1:  ((&wfc.work)){+.+.}, at: [<ffffffffb00b10ed>] process_one_work+0x1ed/0x6c0
[  113.758745]  #2:  (pci_bus_sem){++++}, at: [<ffffffffb04ec978>] pci_device_add+0x158/0x240
[  113.857710] 1 lock held by khungtaskd/239:
[  113.906729]  #0:  (tasklist_lock){.+.+}, at: [<ffffffffb00f07dd>] debug_show_all_locks+0x3d/0x1a0
[  114.012972] 2 locks held by systemd-udevd/492:
[  114.066148]  #0:  (&dev->mutex){....}, at: [<ffffffffb06254d5>] __driver_attach+0x55/0x140
[  114.165107]  #1:  (&dev->mutex){....}, at: [<ffffffffb06254f2>] __driver_attach+0x72/0x140

[  114.281879] =============================================

Signed-off-by: Govindarajulu Varadarajan <gvaradar@cisco.com>
---
 drivers/pci/pcie/aer/aerdrv.h      |  5 +++++
 drivers/pci/pcie/aer/aerdrv_core.c | 45 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index d51e4a57b190..f6d8761dc656 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -105,6 +105,11 @@ static inline pci_ers_result_t merge_result(enum pci_ers_result orig,
 	return orig;
 }
 
+struct aer_device_list {
+	struct device *dev;
+	struct hlist_node node;
+};
+
 extern struct bus_type pcie_port_bus_type;
 void aer_isr(struct work_struct *work);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 890efcc574cb..d524f2c2c288 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -346,6 +346,47 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+int aer_get_pci_dev(struct pci_dev *pdev, void *data)
+{
+	struct hlist_head *hhead = (struct hlist_head *)data;
+	struct device *dev = &pdev->dev;
+	struct aer_device_list *entry;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		/* continue with other devices, lets not return error */
+		return 0;
+
+	entry->dev = get_device(dev);
+	hlist_add_head(&entry->node, hhead);
+
+	return 0;
+}
+
+static void aer_pci_walk_bus(struct pci_bus *top,
+			     int (*cb)(struct pci_dev *, void *),
+			     struct aer_broadcast_data *result)
+{
+	HLIST_HEAD(dev_hlist);
+	struct hlist_node *tmp;
+	struct aer_device_list *entry;
+
+	pci_walk_bus(top, aer_get_pci_dev, &dev_hlist);
+	hlist_for_each_entry_safe(entry, tmp, &dev_hlist, node) {
+		struct pci_dev *pdev = container_of(entry->dev, struct pci_dev,
+						    dev);
+		int err;
+
+		err = cb(pdev, result);
+		if (err)
+			dev_err(entry->dev, "AER: recovery handler failed: %d",
+				err);
+		put_device(entry->dev);
+		hlist_del(&entry->node);
+		kfree(entry);
+	}
+}
+
 /**
  * broadcast_error_message - handle message broadcast to downstream drivers
  * @dev: pointer to from where in a hierarchy message is broadcasted down
@@ -380,7 +421,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		 */
 		if (cb == report_error_detected)
 			dev->error_state = state;
-		pci_walk_bus(dev->subordinate, cb, &result_data);
+		aer_pci_walk_bus(dev->subordinate, cb, &result_data);
 		if (cb == report_resume) {
 			pci_cleanup_aer_uncorrect_error_status(dev);
 			dev->error_state = pci_channel_io_normal;
@@ -390,7 +431,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
 		 */
-		pci_walk_bus(dev->bus, cb, &result_data);
+		aer_pci_walk_bus(dev->bus, cb, &result_data);
 	}
 
 	return result_data.result;
-- 
2.14.1
