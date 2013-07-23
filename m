Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46239 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3GWB7w (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 21:59:52 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so17509394iej.29
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2013 18:59:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7t4wzLCG6PFzP3NqnA5mwnK5nisaPadK4=74AxGT7p_g@mail.gmail.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-3-git-send-email-yinghai@kernel.org>
	<CAErSpo7t4wzLCG6PFzP3NqnA5mwnK5nisaPadK4=74AxGT7p_g@mail.gmail.com>
Date: Mon, 22 Jul 2013 18:59:51 -0700
Message-ID: <CAE9FiQXLSt6j9fR5_i+DWB570KS5ZGMXgPUoKHxQZYYvXoGjBQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Stop sriov before remove PF
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 22, 2013 at 4:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>> (PCI: Simplify IOV implementation and fix reference count races)
>> VF need to be removed via virtfn_remove to make sure ref to PF
>> is put back.
>>
>> Some driver (like ixgbe) does not call pci_disable_sriov() if
>> sriov is enabled via /sys/.../sriov_numvfs setting.
>> ixgbe does allow driver for PF get detached, but still have VFs
>> around.
>>
>> But how about PF get removed via /sys or pciehp?
>>
>> During hot-remove, VF will still hold one ref to PF and it
>> prevent PF to be removed.
>> That make the next hot-add fails, as old PF dev struct is still around.
>>
>> We need to add pci_disable_sriov() calling during pci dev removing.
>>
>> Need this one for v3.11
>
> Needs explanation.  Pretend Linus is asking why we should put this in
> after the merge window :)
>
> I think the answer is that dc087f2f introduced a regression in certain
> hot-remove/hot-add scenarios, but an example transcript showing the
> issue would help a lot.

for intel 10GB ethernet, user could use /sys/../num_vfs to enable SRIOV
after PF driver is loaded.

If the cards in slots for pciehp, when user press button or use
/sys/bus/pci/slots/../power to turn off the power.

The PF driver will be stopped (but it does not call pci_disable_sriov),
and try to remove the PF, then turn off the power.
Actually the PF's pci_dev struct is not freed, because VFs still hold
some reference to it.

That is not fun, hotadd will not work, as old pci_dev struct is still there.
those VF struct still have old ref to it.

>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Jiang Liu <liuj97@gmail.com>
>> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
>> Cc: Donald Dutile <ddutile@redhat.com>
>> Cc: Greg Rose <gregory.v.rose@intel.com>
>>
>> ---
>>  drivers/pci/remove.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> Index: linux-2.6/drivers/pci/remove.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/remove.c
>> +++ linux-2.6/drivers/pci/remove.c
>> @@ -34,6 +34,9 @@ static void pci_stop_dev(struct pci_dev
>>
>>  static void pci_destroy_dev(struct pci_dev *dev)
>>  {
>> +       /* remove VF, if PF driver skip that */
>> +       pci_disable_sriov(dev);
>
> How did you decide to call pci_disable_sriov() here rather than, for
> example, in pci_stop_dev()?  We already have some PME and ASPM cleanup
> in pci_stop_dev(), and this seems sort of similar to those.

yes, pci_stop_dev is better.

I was thinking that pci_stop_dev could be used when PF's driver is
unloaded or detached.

Yinghai
