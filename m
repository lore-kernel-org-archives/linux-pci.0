Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45676 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633Ab3G2Vbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 29 Jul 2013 17:31:38 -0400
Message-ID: <51F6DF35.40909@redhat.com>
Date: Mon, 29 Jul 2013 17:31:33 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Alexander Duyck <alexander.h.duyck@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <liuj97@gmail.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	"Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH v2 3/3] PCI: Stop sriov after stop PF if PF's driver skip
 that
References: <1374937868-24437-1-git-send-email-yinghai@kernel.org> <1374937868-24437-2-git-send-email-yinghai@kernel.org> <CAErSpo7xk-NGp+4ZFo-jnVnQSEomY=7=CXDSbZPzrhdjZ4zVSA@mail.gmail.com> <51F6D161.1040106@redhat.com> <51F6D9A2.8020403@intel.com>
In-Reply-To: <51F6D9A2.8020403@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/29/2013 05:07 PM, Alexander Duyck wrote:
> On 07/29/2013 01:32 PM, Don Dutile wrote:
>> On 07/29/2013 03:58 PM, Bjorn Helgaas wrote:
>>> On Sat, Jul 27, 2013 at 9:11 AM, Yinghai Lu<yinghai@kernel.org>   wrote:
>>>> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>>>> (PCI: Simplify IOV implementation and fix reference count races)
>>>> VF need to be removed via virtfn_remove to make sure ref to PF
>>>> is put back.
>>>>
>>>> Some driver (like ixgbe) does not call pci_disable_sriov() if
>>>> sriov is enabled via /sys/.../sriov_numvfs setting.
>>>> ixgbe does allow driver for PF get detached, but still have VFs
>>>> around.
>>>
>>> Is this something ixgbe should be doing differently?
>>>
>>> I'm not 100% sold on the idea of the VFs staying active after the
>>> driver releases the PF.  It seems asymmetric because I think the
>>> driver has to claim the PF to *enable* the VFs, but we don't disable
>>> them when releasing the PF.
>>>
>>> What's the use case for detaching the PF driver while the VFs are
>>> active?
>>>
>> VF's assigned to (KVM) guest (via device-assignment).
>> Virtually, it's as if the enet cable is unplugged to the VF in the
>> guest --
>> the device is still there (the PF wasn't unplugged, just the driver
>> de-configured).
>>
>> Pre-sysfs-based configuration, the std way to configure the VFs into
>> a system was to unload the PF driver, and reload it with a vf-enabling
>> parameter
>> (like max_vfs=<n>  in the case of ixgbe, igb).
>> Now, if someone unloaded the PF driver in the host, the unplanned removal
>> of the PF enabled the VF to crash the host (maybe AlexD can provide the
>> details how that occurred).
>> So, the solution was to 'pause' the VF operation and let packets drop
>> in the guest, and re-enable the VF operation if the PF driver was
>> re-configured.
>>
>> So, as I stated in previous postings, this patch is acceptable if
>> it doesn't cause a guest crash when a VF is assigned to a KVM guest.
>> If you tested this case, then please state as such in the posting.
>> If not, then can AlexD test this case ?
>>
>> - Don
>
> I actually haven't done much with direct assignment to guests.  I
> believe it was Greg who did that work to fix this issue.
>
> I'm adding Jeff Kirsher to the CC.  Perhaps he can pull this patch into
> a copy of the net tree and submit it to our validation team for testing
> to see if they end up being able to reproduce the kernel panic issue
> that was originally addressed by allowing the VFs to be persistent.
>
I'd appreciate hearing Jeff's test results....

> Thanks,
>
> Alex
>
>>>> But how about PF get removed via /sys or pciehp finally?
>>>>
>>>> During hot-remove, VF will still hold one ref to PF and it
>>>> prevent PF to be removed.
>>>> That make the next hot-add fails, as old PF dev struct is still around.
>>>>
>>>> We need to add pci_disable_sriov() calling during stop PF .
>>>>
>>>> Need this one for v3.11
>>>
>>> Don had a concern that there might be a regression here ... I'm a bit
>>> confused on the details, but you guys need to come to agreement that
>>> this doesn't make things worse.
>>>
>>>> Signed-off-by: Yinghai Lu<yinghai@kernel.org>
>>>> Cc: Jiang Liu<liuj97@gmail.com>
>>>> Cc: Alexander Duyck<alexander.h.duyck@intel.com>
>>>> Cc: Donald Dutile<ddutile@redhat.com>
>>>> Cc: Greg Rose<gregory.v.rose@intel.com>
>>>>
>>>> ---
>>>>    drivers/pci/remove.c |    2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> Index: linux-2.6/drivers/pci/remove.c
>>>> ===================================================================
>>>> --- linux-2.6.orig/drivers/pci/remove.c
>>>> +++ linux-2.6/drivers/pci/remove.c
>>>> @@ -25,6 +25,8 @@ static void pci_stop_dev(struct pci_dev
>>>>                   pci_proc_detach_device(dev);
>>>>                   pci_remove_sysfs_dev_files(dev);
>>>>                   device_del(&dev->dev);
>>>> +               /* remove VF, if PF driver skip that */
>>>> +               pci_disable_sriov(dev);
>>>>                   dev->is_added = 0;
>>>>           }
>>>>
>>
>

