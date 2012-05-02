Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 May 2012 22:08:33 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Don Dutile <ddutile@redhat.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Keping Chen <chenkeping@huawei.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 05/19] PCI: correctly flush workqueue when destroy
 pcie hotplug controller
Message-ID: <20120502050833.GC23579@kroah.com>
References: <1335539820-11232-1-git-send-email-jiang.liu@huawei.com>
 <1335539820-11232-6-git-send-email-jiang.liu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335539820-11232-6-git-send-email-jiang.liu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 27, 2012 at 11:16:46PM +0800, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> When destroying a PCIe hotplug controller, all work items associated with
> that controller should be flushed.  Function pcie_cleanup_slot() calls
> cancel_delayed_work() and flush_workqueue() to achieve that.
> Function flush_workqueue() will flush all work items already submitted,
> but new work items submitted by those already submitted work items may
> still be in live state when returning from flush_workqueue().
> 
> For the extreme case, pciehp driver may expierence following calling path:
> 1) pcie_isr() -> pciehp_handle_xxx() -> queue_interrupt_event()->queue_work()
> 2) interrupt_event_handler() -> handle_button_press_event() ->
>    queue_delayed_work()
> 3) pciehp_queue_pushbutton_work() -> queue_work()
> 
> So enhance pcie_cleanup_slot() to correctly flush workqueue when destroying
> PCIe hotplug controller.
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index a960fae..98b775f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -889,8 +889,20 @@ static int pcie_init_slot(struct controller *ctrl)
>  static void pcie_cleanup_slot(struct controller *ctrl)
>  {
>  	struct slot *slot = ctrl->slot;
> -	cancel_delayed_work(&slot->work);
> +
> +	/*
> +	 * Following workqueue flushing logic is to deal with the special
> +	 * call path:
> +	 * 1) pcie_isr() -> pciehp_handle_xxx() ->
> +	 *    queue_interrupt_event(pciehp_wq_event)->queue_work(pciehp_wq)
> +	 * 2) interrupt_event_handler() -> handle_button_press_event() ->
> +	 *    queue_delayed_work(pciehp_wq)
> +	 * 3) pciehp_queue_pushbutton_work() -> queue_work(pciehp_wq)
> +	 */
>  	flush_workqueue(pciehp_wq);
> +	cancel_delayed_work_sync(&slot->work);
> +	flush_workqueue(pciehp_wq);

Why just flush it twice?  Why not three times?

Like the magic "sync && sync && sync" invocation long typed by
sysadmins.

This really does not feel right, sorry.

Odds are the whole workqueue path needs to be reworked here, right?

greg k-h
