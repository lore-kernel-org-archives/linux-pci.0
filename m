Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9622 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308Ab3GSXWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Jul 2013 19:22:40 -0400
Message-ID: <51E9CA2F.5050307@intel.com>
Date: Fri, 19 Jul 2013 16:22:23 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Donald Dutile <ddutile@redhat.com>,
	Greg Rose <gregory.v.rose@intel.com>
Subject: Re: [PATCH] PCI: Stop sriov before remove PF
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org> <1374261258-23036-3-git-send-email-yinghai@kernel.org> <51E9B3C7.1010409@intel.com> <CAE9FiQXUgSVO8h=+JTY-giQ_jz9DryOXDsFJJeMT-y1J9Sv+fA@mail.gmail.com>
In-Reply-To: <CAE9FiQXUgSVO8h=+JTY-giQ_jz9DryOXDsFJJeMT-y1J9Sv+fA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/19/2013 03:44 PM, Yinghai Lu wrote:
> On Fri, Jul 19, 2013 at 2:46 PM, Alexander Duyck
> <alexander.h.duyck@intel.com> wrote:
>> On 07/19/2013 12:14 PM, Yinghai Lu wrote:
>>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>>> (PCI: Simplify IOV implementation and fix reference count races)
>>> VF need to be removed via virtfn_remove to make sure ref to PF
>>> is put back.
>>>
>>> Some driver (like ixgbe) does not call pci_disable_sriov() if
>>> sriov is enabled via /sys/.../sriov_numvfs setting.
>>> ixgbe does allow driver for PF get detached, but still have VFs
>>> around.
>>>
>>> But how about PF get removed via /sys or pciehp?
>>>
>>> During hot-remove, VF will still hold one ref to PF and it
>>> prevent PF to be removed.
>>> That make the next hot-add fails, as old PF dev struct is still around.
>>>
>>> We need to add pci_disable_sriov() calling during pci dev removing.
>>>
>>> Need this one for v3.11
>>>
>>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>> Cc: Jiang Liu <liuj97@gmail.com>
>>> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
>>> Cc: Donald Dutile <ddutile@redhat.com>
>>> Cc: Greg Rose <gregory.v.rose@intel.com>
>>>
>>> ---
>>>  drivers/pci/remove.c |    3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> Index: linux-2.6/drivers/pci/remove.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/pci/remove.c
>>> +++ linux-2.6/drivers/pci/remove.c
>>> @@ -34,6 +34,9 @@ static void pci_stop_dev(struct pci_dev
>>>
>>>  static void pci_destroy_dev(struct pci_dev *dev)
>>>  {
>>> +     /* remove VF, if PF driver skip that */
>>> +     pci_disable_sriov(dev);
>>> +
>>>       down_write(&pci_bus_sem);
>>>       list_del(&dev->bus_list);
>>>       up_write(&pci_bus_sem);
>>>
>> How are you able to hot-remove the PF if the VFs are still holding
>> references to it?
> usually pci_stop_and_remove_bus_device always successfully, and
> power get turned off for that card.

I'm not an expert in this area, but that doesn't seem right.  How is it
you can remove a device if there are still outstanding references to
it?  Is this one of those cases where we have to succeed because the
system is removing the device and there is nothing we can do to stop it?

>> The issue I see with this patch is that if the PF has any VFs direct
>> assigned, hot plug removing the PF will cause the guests containing
>> those VFs to panic.
> Then you should make guest support hotplug or suprise removal.
>
> If the guest does panic because it does support hotplug, that is right behavior.
>
> Just like in bare metal machine, if it does not support hotplug, and user would
> know what is going to happen if he remove one pcie card.
>
> Thanks
>
> Yinghai

I suspect that is much easier said than done.  We probably need somebody
familiar with the KVM side of things to address the feasibility of
something like that.  I believe it was Greg and Don that worked on the
original patches that made it so that we could leave the VFs in place on
driver removal.  They would likely have a better answer as to why it is
preferable to leave the VFs in place than panic a non-compliant guest.

Thanks,

Alex
