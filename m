Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH][resend] pciehp: fix a race between pciehp and
 removing operations by sysfs
To: <bhelgaas@google.com>
References: <1513067384-10914-1-git-send-email-wangxiongfeng2@huawei.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <55cc79f2-cece-c84b-5c95-050a954d3669@huawei.com>
Date: Tue, 12 Dec 2017 19:30:31 +0800
MIME-Version: 1.0
In-Reply-To: <1513067384-10914-1-git-send-email-wangxiongfeng2@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, liudongdong3@huawei.com,
 linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch seems to introduce another issue. pciehp_power_thread() use
'container_of' to get the 'slot' according to 'work_struct'.
If the 'slot' has been freed before that, there will be an issue.

On 2017/12/12 16:29, Xiongfeng Wang wrote:
> When the Attention button on a PCIE slot is pressed, 5 seconds later,
> pciehp_power_thread() will be scheduled on slot->wq. This function will
> get a global mutex lock 'pci_rescan_remove_lock' in
> pciehp_unconfigure_device().
> 
> At the same time, we remove the pcie port by sysfs, which results in
> pci_stop_and_remove_bus_device_locked() called. This function will get
> the global mutex lock 'pci_rescan_remove_lock', and then release the
> struct 'ctrl', which will wait until the work_struct on slot->wq is
> finished.
> 
> If pci_stop_and_remove_bus_device_locked() got the mutex lock, and
> before it drains workqueue slot->wq, pciehp_power_thread() is scheduled
> on slot->wq and tries to get the mutex lock. Then
> pci_stop_and_remove_bus_device_locked() tries to drain workqueue
> slot->wq and wait until work struct 'pciehp_power_thread()' is finished.
> Then a hung_task happens.
> 
> This patch solve this problem by schedule 'pciehp_power_thread()' on a
> system workqueue instead of slot->wq.
> 
> The Call Trace we got is as following.
> 
>  INFO: task kworker/0:2:4413 blocked for more than 120 seconds.
>        Tainted: P        W  O    4.12.0-rc1 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  kworker/0:2     D    0  4413      2 0x00000000
>  Workqueue: pciehp-0 pciehp_power_thread
>  Call trace:
>  [<ffff0000080861d4>] __switch_to+0x94/0xa8
>  [<ffff000008bea9c0>] __schedule+0x1b0/0x708
>  [<ffff000008beaf58>] schedule+0x40/0xa4
>  [<ffff000008beb33c>] schedule_preempt_disabled+0x28/0x40
>  [<ffff000008bec1dc>] __mutex_lock.isra.8+0x148/0x50c
>  [<ffff000008bec5c4>] __mutex_lock_slowpath+0x24/0x30
>  [<ffff000008bec618>] mutex_lock+0x48/0x54
>  [<ffff0000084d8188>] pci_lock_rescan_remove+0x20/0x28
>  [<ffff0000084f87c0>] pciehp_unconfigure_device+0x54/0x1cc
>  [<ffff0000084f8260>] pciehp_disable_slot+0x4c/0xbc
>  [<ffff0000084f8370>] pciehp_power_thread+0xa0/0xb8
>  [<ffff0000080e9ce8>] process_one_work+0x13c/0x3f8
>  [<ffff0000080ea004>] worker_thread+0x60/0x3e4
>  [<ffff0000080f0814>] kthread+0x10c/0x138
>  [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>  INFO: task bash:31732 blocked for more than 120 seconds.
>        Tainted: P        W  O    4.12.0-rc1 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  bash            D    0 31732      1 0x00000009
>  Call trace:
>  [<ffff0000080861d4>] __switch_to+0x94/0xa8
>  [<ffff000008bea9c0>] __schedule+0x1b0/0x708
>  [<ffff000008beaf58>] schedule+0x40/0xa4
>  [<ffff000008bee7b4>] schedule_timeout+0x1a0/0x340
>  [<ffff000008bebb88>] wait_for_common+0x108/0x1bc
>  [<ffff000008bebc64>] wait_for_completion+0x28/0x34
>  [<ffff0000080e7594>] flush_workqueue+0x130/0x488
>  [<ffff0000080e79b0>] drain_workqueue+0xc4/0x164
>  [<ffff0000080ec3cc>] destroy_workqueue+0x28/0x1f4
>  [<ffff0000084fa094>] pciehp_release_ctrl+0x34/0xe0
>  [<ffff0000084f75b0>] pciehp_remove+0x30/0x3c
>  [<ffff0000084f24d8>] pcie_port_remove_service+0x3c/0x54
>  [<ffff00000876b1e4>] device_release_driver_internal+0x150/0x1d0
>  [<ffff00000876b28c>] device_release_driver+0x28/0x34
>  [<ffff00000876a018>] bus_remove_device+0xe0/0x11c
>  [<ffff000008766348>] device_del+0x200/0x304
>  [<ffff00000876646c>] device_unregister+0x20/0x38
>  [<ffff0000084f2560>] remove_iter+0x44/0x54
>  [<ffff000008765230>] device_for_each_child+0x4c/0x90
>  [<ffff0000084f2c98>] pcie_port_device_remove+0x2c/0x48
>  [<ffff0000084f2f48>] pcie_portdrv_remove+0x60/0x6c
>  [<ffff0000084e3de4>] pci_device_remove+0x48/0x110
>  [<ffff00000876b1e4>] device_release_driver_internal+0x150/0x1d0
>  [<ffff00000876b28c>] device_release_driver+0x28/0x34
>  [<ffff0000084db028>] pci_stop_bus_device+0x9c/0xac
>  [<ffff0000084db190>] pci_stop_and_remove_bus_device_locked+0x24/0x3c
>  [<ffff0000084e5eb0>] remove_store+0x74/0x80
>  [<ffff000008764680>] dev_attr_store+0x44/0x5c
>  [<ffff0000082e7e1c>] sysfs_kf_write+0x5c/0x74
>  [<ffff0000082e7014>] kernfs_fop_write+0xcc/0x1dc
>  [<ffff0000082602e0>] __vfs_write+0x48/0x13c
>  [<ffff00000826174c>] vfs_write+0xa8/0x198
>  [<ffff000008262ce8>] SyS_write+0x54/0xb0
>  [<ffff000008083730>] el0_svc_naked+0x24/0x28
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>  drivers/pci/hotplug/pciehp_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 83f3d4a..9d39d85 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -221,7 +221,7 @@ static void pciehp_queue_power_work(struct slot *p_slot, int req)
>  	info->p_slot = p_slot;
>  	INIT_WORK(&info->work, pciehp_power_thread);
>  	info->req = req;
> -	queue_work(p_slot->wq, &info->work);
> +	schedule_work(&info->work);
>  }
>  
>  void pciehp_queue_pushbutton_work(struct work_struct *work)
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
