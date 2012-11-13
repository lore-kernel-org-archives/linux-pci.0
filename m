Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35466 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab2KMCf2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2012 21:35:28 -0500
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 179343EE0BC
	for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 11:35:27 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F3DAC45DE55
	for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 11:35:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id D503E45DE54
	for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 11:35:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id C78A41DB8046
	for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 11:35:26 +0900 (JST)
Received: from g01jpexchyt12.g01.fujitsu.local (g01jpexchyt12.g01.fujitsu.local [10.128.194.51])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 76EC51DB804C
	for <linux-pci@vger.kernel.org>; Tue, 13 Nov 2012 11:35:26 +0900 (JST)
From: "Kaneshige, Kenji" <kaneshige.kenji@jp.fujitsu.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yijing Wang <wangyijing@huawei.com>
CC: Yinghai Lu <yinghai@kernel.org>, Rafael <rjw@sisk.pl>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Mauro Carvalho Chehab <mchehab@redhat.com>,
	"Oliver Neukum" <oneukum@suse.de>,
	"jiang.liu@huawei.com" <jiang.liu@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: RE: [PATCH -v3] PCI, pciehp: make every slot have its own workqueue
 to avoid deadlock
Date: Tue, 13 Nov 2012 02:35:24 +0000
Message-ID: <4A338DB2991D2A44B9A44B8718AECF650A52062A@G01JPEXMBYT03>
References: <1352711830-9772-1-git-send-email-wangyijing@huawei.com>
 <CAErSpo6KSkR+Rg1G4Tte99VpOM-tZxjCfPJzCuT5-iKMN4m=4w@mail.gmail.com>
In-Reply-To: <CAErSpo6KSkR+Rg1G4Tte99VpOM-tZxjCfPJzCuT5-iKMN4m=4w@mail.gmail.com>
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Tuesday, November 13, 2012 9:18 AM
> To: Yijing Wang
> Cc: Kaneshige, Kenji/金重 憲治; Yinghai Lu; Rafael; Rusty Russell; Mauro Carvalho Chehab; Oliver Neukum;
> jiang.liu@huawei.com; linux-pci@vger.kernel.org; Hanjun Guo
> Subject: Re: [PATCH -v3] PCI, pciehp: make every slot have its own workqueue to avoid deadlock
> 
> On Mon, Nov 12, 2012 at 2:17 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> > Currently, pciehp use global pciehp_wq to handle hotplug event from hardware.
> > Hot remove path will be blocked if a hotplug slot connected a IO-BOX(composed of PCIe
> > Switch and some slots which support hotplug). The hot removed work was queued into
> > pciehp_wq. But in the hot-remove path, pciehp driver would flush pciehp_wq when
> > the pcie port(support pciehp) was removed. In this case the hot-remove path blocked.
> > This patch remove the global pciehp_wq and create a new workqueue for every slot to
> > avoid above problem.
> 
> Can you include the actual call path that leads to the deadlock?  I
> assume it's related to a PCIe device removal that happens at about the
> same time as the pcie_port_service_unregister(&hpdriver_portdrv)?
> 
> I just want to make sure that the new per-slot workqueue arrangement
> doesn't lead to any case where the slot workqueue item depends on
> something removed by the pcied_cleanup() as the module exits.

Just for your information, here is my understanding of the problem.

====
- Your hardware has nested PCIe hotplug slots like below.

    --<slot A>--<Slot B>

- Hot-removal request (attention button event) comes to <slot A>
- Pciehp driver queue the hot-removal work
- This hot-removal work try to remove <slot B>
- To remove <slot B>, pciehp flush the pciehp_wq, but it never finishes
  because hot-removal work is in progress. ===> deadlock
====

> 
> > --- a/drivers/pci/hotplug/pciehp_hpc.c
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -773,23 +773,32 @@ static void pcie_shutdown_notification(struct controller *ctrl)
> >  static int pcie_init_slot(struct controller *ctrl)
> >  {
> >         struct slot *slot;
> > +       char name[32];
> >
> >         slot = kzalloc(sizeof(*slot), GFP_KERNEL);
> >         if (!slot)
> >                 return -ENOMEM;
> > +
> > +       snprintf(name, sizeof(name), "pciehp-%u", PSN(ctrl));
> > +       slot->wq = create_singlethread_workqueue(name);
> 
> You're using create_singlethread_workqueue() instead of the previous
> alloc_workqueue().  This is a slight change in semantics since we
> previously called "alloc_workqueue(name, 0, 0)" and
> create_singlethread_workqueue() calls "alloc_workqueue(name,
> WQ_UNBOUND | WQ_MEM_RECLAIM, 1)."
> 
> I don't know whether this is necessary in order to have per-slot
> workqueues or not.  If not, please split it into a separate patch to
> make it more visible.

Good catch.
I think we should use 0 for max_active.
Hot-add/remove operation take a long time. So if we use 1 for max_active,
we cannot handle events during hot-add/remove operation. As a result, for
example, push button event and cancel event that are issued during
hot-add/remove operation might not be handled properly, I think.

Any comments, Yijing?

Regards,
Kenji Kaneshige

