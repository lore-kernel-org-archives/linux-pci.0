Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:51274 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab3FNXyJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2013 19:54:09 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so1266373obc.24
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2013 16:54:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUCR0cSH1u59qyZo8KM9J6P0+AG79vodGYPDVohg6UOfQ@mail.gmail.com>
References: <CAErSpo4AFxSqUfxbw60B8XVk3XxtYfRcLyWDy=yPb0fURV=BQg@mail.gmail.com>
 <1370538609-28903-1-git-send-email-jiang.liu@huawei.com> <1370538609-28903-2-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQUDnU_DaXDKKnRh=VYQ6Y+FeWHsKB7rnN2Gn3d0EoGLPg@mail.gmail.com>
 <20130608015133.GB5874@google.com> <CAE9FiQUCR0cSH1u59qyZo8KM9J6P0+AG79vodGYPDVohg6UOfQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 14 Jun 2013 17:53:48 -0600
Message-ID: <CAErSpo6X0cpHjkvX0ZXPeGXMFmRjpeYqiBtyH9eQBwgUPxiRTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: make PCI host bridge/bus creating and destroying
 logic symmetric
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>, Jiang Liu <jiang.liu@huawei.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 8, 2013 at 1:01 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jun 7, 2013 at 6:51 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>>
>>> should split pci_release_host_bridge_dev renaming and moving to another patch.
>>
>> I split the rename/move to another patch and added both to my
>> pci/jiang-bus-lock-v3 branch.
>
> good.
>
>>
>>> > @@ -1726,30 +1722,21 @@ struct pci_bus *pci_create_root_bus(struct ..
> ...
>>
>> I think this function would be better if we created the host bridge
>> first, then the bus.  But your patch is an improvement, so we can look
>> at doing that later.
>
> Yes, that will more straightforward, create hostbidge before root bus,
> like we have pci bridge before subordinate bus under it.
>
> current logic is
>
>         b = pci_alloc_bus();
>         if (!b)
>                 return NULL;
>
>         b->sysdata = sysdata;
>         b->ops = ops;
>         b->number = b->busn_res.start = bus;
>         b2 = pci_find_bus(pci_domain_nr(b), bus);
>         if (b2) {
>                 /* If we already got to this bus through a different
> bridge, ignore it */
>                 dev_dbg(&b2->dev, "bus already known\n");
>                 goto err_out;
>         }
>
>         bridge = pci_alloc_host_bridge(b);
>
> We need to find the duplicated hostbridge or racing.
>
> If we need call pci_alloc_host_bridge at first, we will need my
> for_each_host_bridge patchset, and use it to check if there is
> existing hostbridge.
>
>>
>>> looks like we don't need to split device_register to device_del and put_device.
>>>
>>> we can make root bus removal to use device_unregister too, in the patches,
>>
>> If we can use device_register()/device_unregister() directly instead of
>> splitting them into initialize/add/del/put, that would be awesome.
>>
>> Anyway, http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/jiang-bus-lock-v3
>> is the current state of what I've got.  If you want to iterate on this some
>> more and improve things, that's great.  But please start with what's on my
>> branch and post your updates as a complete v4 because I did tweak some
>> changelogs and code formatting, and I don't want to lose that work.
>
> ok, please consider drop
> commit d751727a1792262cb464d8d9608500facb763301
>     PCI: Make host bridge/bus creating and destroying logic symmetric
> from pci/jiang-bus-lock-v3, and apply my three patches at
>
>   https://patchwork.kernel.org/patch/2562431/
>     [1/7] PCI: move back pci_proc_attach_devices calling
>   https://patchwork.kernel.org/patch/2562461/
>     [2/7] PCI: move resources and bus_list releasing to pci_release_dev
>   https://patchwork.kernel.org/patch/2562451/
>     [3/7] PCI: Detach driver in pci_stop_device

I dropped the "Make host bridge/bus creating and destroying logic
symmetric" patch for now.  I don't think the subsequent patches depend
on that one, so I merged the rest to my -next branch for v3.11, so we
can make at least a tiny bit of progress in this cycle.

Bjorn
