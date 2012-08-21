Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63002 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab2HUFje (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2012 01:39:34 -0400
Received: by vbbff1 with SMTP id ff1so6147215vbb.19
        for <linux-pci@vger.kernel.org>; Mon, 20 Aug 2012 22:39:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7-QhB742WebOb2x9LsagraXMdW2kUt-phj87KXWeF3fQ@mail.gmail.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
	<20120817233626.10973.57304.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQX+OCFeDFfpoMNRR+QS9=hNoMS94WJ0+s4dTv6E70WRAw@mail.gmail.com>
	<CAErSpo7-QhB742WebOb2x9LsagraXMdW2kUt-phj87KXWeF3fQ@mail.gmail.com>
Date: Mon, 20 Aug 2012 22:39:33 -0700
Message-ID: <CAE9FiQXGLovJGOjDraAssU_82yt8MMZeTW2UBNWhrzPsDkguVA@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] PCI: Stop and remove devices in one pass
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-pcmcia@lists.infradead.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2012 at 8:27 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Aug 17, 2012 at 7:21 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On Fri, Aug 17, 2012 at 4:36 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> Previously, when we removed a PCI device, we made two passes over the
>>> hierarchy rooted at the device.  In the first pass, we stopped all
>>> the devices, and in the second, we removed them.
>>>
>>> This patch combines the two passes into one so that we remove a device as
>>> soon as it and all its children have been stopped.
>>>
>>> Note that we previously stopped devices in reverse order and removed them
>>> in forward order.  Now we stop and remove them in reverse order.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> ---
>>>  drivers/pci/remove.c |   42 +++++++-----------------------------------
>>>  1 files changed, 7 insertions(+), 35 deletions(-)
>>
>> looks like your cleanup will have some conflict with my pci root bus
>> hot plug branch.
>
> Yes, indeed, they have serious conflicts.
>
>> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=blob;f=drivers/pci/remove.c;h=f672731922f8db619fb36db05dbd9c27f3253c19;hb=refs/heads/for-pci-root-bus-hotplug
>>
>> it add pci_stop_and_remove_bus and it depends on some functions that
>> you kill in this patch set.
>
> Do you have any suggestions on how to proceed?  In my opinion,
> remove.c is a bit of a rat's nest right now.  It took me quite a long
> time to sort out what's going on, but when you finally get down to the
> bottom, it's actually very simple.  So I'd really like to clean it up
> and expose that simple structure before we throw more stuff into it.
>
> After my cleanup, pci_stop_and_remove_bus_device() and
> pci_remove_bus() are the only exported interfaces left.  How hard
> would it be to implement host bridge remove on top of that?
>
> I think it's OK (and even preferable) if the host bridge-related code
> can be segregated by itself rather than being sprinkled around through
> lots of PCI code.  So maybe the pci_is_root_bus()  and
> pci_stop_host_bridge() stuff below could be in some sort of host
> bridge interface that just calls the code in remove.c.

Yes, your change is quite clean.
Please go ahead to push your changes for 3.7 and my Acked-by.

I would try to rebase pci-root-bus hot plug branch according to the
output of discussion of pci mini-summit.

Thanks

Yinghai
