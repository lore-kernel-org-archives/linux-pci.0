Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63173 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2KMASC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 19:18:02 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so4550632wgb.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2012 16:18:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1352711830-9772-1-git-send-email-wangyijing@huawei.com>
References: <1352711830-9772-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 12 Nov 2012 17:17:39 -0700
Message-ID: <CAErSpo6KSkR+Rg1G4Tte99VpOM-tZxjCfPJzCuT5-iKMN4m=4w@mail.gmail.com>
Subject: Re: [PATCH -v3] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
To: Yijing Wang <wangyijing@huawei.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	Oliver Neukum <oneukum@suse.de>, jiang.liu@huawei.com,
	linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 12, 2012 at 2:17 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> Currently, pciehp use global pciehp_wq to handle hotplug event from hardware.
> Hot remove path will be blocked if a hotplug slot connected a IO-BOX(composed of PCIe
> Switch and some slots which support hotplug). The hot removed work was queued into
> pciehp_wq. But in the hot-remove path, pciehp driver would flush pciehp_wq when
> the pcie port(support pciehp) was removed. In this case the hot-remove path blocked.
> This patch remove the global pciehp_wq and create a new workqueue for every slot to
> avoid above problem.

Can you include the actual call path that leads to the deadlock?  I
assume it's related to a PCIe device removal that happens at about the
same time as the pcie_port_service_unregister(&hpdriver_portdrv)?

I just want to make sure that the new per-slot workqueue arrangement
doesn't lead to any case where the slot workqueue item depends on
something removed by the pcied_cleanup() as the module exits.

> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -773,23 +773,32 @@ static void pcie_shutdown_notification(struct controller *ctrl)
>  static int pcie_init_slot(struct controller *ctrl)
>  {
>         struct slot *slot;
> +       char name[32];
>
>         slot = kzalloc(sizeof(*slot), GFP_KERNEL);
>         if (!slot)
>                 return -ENOMEM;
> +
> +       snprintf(name, sizeof(name), "pciehp-%u", PSN(ctrl));
> +       slot->wq = create_singlethread_workqueue(name);

You're using create_singlethread_workqueue() instead of the previous
alloc_workqueue().  This is a slight change in semantics since we
previously called "alloc_workqueue(name, 0, 0)" and
create_singlethread_workqueue() calls "alloc_workqueue(name,
WQ_UNBOUND | WQ_MEM_RECLAIM, 1)."

I don't know whether this is necessary in order to have per-slot
workqueues or not.  If not, please split it into a separate patch to
make it more visible.

Bjorn
