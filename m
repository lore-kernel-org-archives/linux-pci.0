Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:59191 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890Ab3GWCcH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jul 2013 22:32:07 -0400
Received: by mail-ie0-f177.google.com with SMTP id w15so8747469iea.22
        for <linux-pci@vger.kernel.org>; Mon, 22 Jul 2013 19:32:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-2-git-send-email-yinghai@kernel.org>
	<CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
Date: Mon, 22 Jul 2013 19:32:06 -0700
Message-ID: <CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 22, 2013 at 2:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Evidently this is really part of a series, but you didn't label it
> that way.  It looks like this applies on top of your "PCI: Fix hotplug
> remove with sriov again" patch?

Yes.

that one need be back ported to 3.9 and later.

this one need to be for 3.11 final, as Jiang's patch is in 3.11-rc0.

>
> On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>> (PCI: Simplify IOV implementation and fix reference count races)
>> VF need to be removed via virtfn_remove to make sure ref to PF
>> is put back.
>
> I'm sure this makes sense, but it needs background.  I haven't figured
> out exactly what the problem is.  You're describing the lowest-level
> details, but not the overall picture that would make it understandable
> to the rest of us.

Overall, after we reversely loop the bus_devices, VF get stop and removed,
but fail to release ref to PF, and prevent PF to be removed and freed.

>
>> So we can not call stop_and_remove for VF before PF, that will
>> make VF get removed directly before PF's driver try to use
>> virtfn_remove to do it.
>>
>> Solution is separating stop and remove in two iterations.
>>
>> In first iteration, we stop VF driver at first with iterating devices
>> reversely, and later during stop PF driver, disable_sriov will use
>> virtfn_remove to remove VFs.
>>
>> Also some driver (like mlx4_core) need VF's driver get stopped before PF.
>
> If this is relevant, please give a pointer to the mlx4_core code that
> requires VFs to be stopped before the PF.

that is add-on benefits.

drivers/net/ethernet/mellanox/mlx4/main.c::
static void mlx4_remove_one(struct pci_dev *pdev)
{
        struct mlx4_dev  *dev  = pci_get_drvdata(pdev);
        struct mlx4_priv *priv = mlx4_priv(dev);
        int p;

        if (dev) {
                /* in SRIOV it is not allowed to unload the pf's
                 * driver while there are alive vf's */
                if (mlx4_is_master(dev)) {
                        if (mlx4_how_many_lives_vf(dev))
                                printk(KERN_ERR "Removing PF when
there are assigned VF's !!!\n");
                }

mlx4_how_many_lives_vf() is checking how VFs have driver loaded.

>
>> To make it simple, separate VGA checking out and do that at first,
>> if there is VGA in the chain, do even try to stop or remove any device
>> under that bus.
>
> This part seems like it could be a separate patch.

ok, will separate it out in next rev.

>
>> Need this one for v3.11.
>
> OK, but why?  We need a better explanation of what problem this fixes.
>  It sounds like it fixes a reference counting problem in v3.11-rc1,
> but I don't know what the effect of that problem is.  Maybe it means a
> device isn't freed when it should be?  Maybe it means we can't add a
> new device after hot-removing an SR-IOV device?

Yes.

>
...
>> Index: linux-2.6/drivers/pci/remove.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/remove.c
>> +++ linux-2.6/drivers/pci/remove.c
>> @@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
>>  }
>>  EXPORT_SYMBOL(pci_remove_bus);
>>
>> -static void pci_stop_bus_device(struct pci_dev *dev)
>> +void pci_stop_bus_device(struct pci_dev *dev)
>>  {
>>         struct pci_bus *bus = dev->subordinate;
>>         struct pci_dev *child, *tmp;
>> @@ -75,8 +75,9 @@ static void pci_stop_bus_device(struct p
>>
>>         pci_stop_dev(dev);
>>  }
>> +EXPORT_SYMBOL(pci_stop_bus_device);
>>
>> -static void pci_remove_bus_device(struct pci_dev *dev)
>> +void pci_remove_bus_device(struct pci_dev *dev)
>>  {
>>         struct pci_bus *bus = dev->subordinate;
>>         struct pci_dev *child, *tmp;
>> @@ -92,6 +93,7 @@ static void pci_remove_bus_device(struct
>>
>>         pci_destroy_dev(dev);
>>  }
>> +EXPORT_SYMBOL(pci_remove_bus_device);
>
> I really don't want to export these two symbols unless we have to.
> Obviously this is the heart of your patch, so we probably *will* have
> to.

Agree.

>
> But maybe they can at least be confined to drivers/pci code, and not
> exported to modules?  I don't think there's any reason pciehp needs to
> be a module.  I was planning to merge a patch restricting it to be
> built-in this cycle anyway.

sure, you can apply that patch (make pciehp to be built-in) at first.

Thanks

Yinghai
