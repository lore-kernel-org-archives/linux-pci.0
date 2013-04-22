Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52072 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752630Ab3DVVue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Apr 2013 17:50:34 -0400
Message-ID: <5175B0A9.7070100@intel.com>
Date: Mon, 22 Apr 2013 14:50:33 -0700
From: Alexander Duyck <alexander.h.duyck@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
	David Miller <davem@davemloft.net>,
	netdev <netdev@vger.kernel.org>, gospo@redhat.com,
	sassmann@redhat.com,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [net-next 08/14] pci: Add SRIOV helper function to determine
 if VFs are assigned to guest
References: <1366451353-24714-1-git-send-email-jeffrey.t.kirsher@intel.com> <1366451353-24714-9-git-send-email-jeffrey.t.kirsher@intel.com> <1366515088.2209.15.camel@jtkirshe-mobl> <CAErSpo4D4rn4G56+YT4Ja-S4cjnJ6svBaH3v+_n=cmS5CooC+g@mail.gmail.com>
In-Reply-To: <CAErSpo4D4rn4G56+YT4Ja-S4cjnJ6svBaH3v+_n=cmS5CooC+g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/22/2013 01:09 PM, Bjorn Helgaas wrote:
> On Sat, Apr 20, 2013 at 9:31 PM, Jeff Kirsher
> <jeffrey.t.kirsher@intel.com> wrote:
>> On Sat, 2013-04-20 at 02:49 -0700, Jeff Kirsher wrote:
>>> From: Alexander Duyck <alexander.h.duyck@intel.com>
>>>
>>> This function is meant to add a helper function that will determine if a PF
>>> has any VFs that are currently assigned to a guest.  We currently have been
>>> implementing this function per driver, and going forward I would like to avoid
>>> that by making this function generic and using this helper.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>>> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> Adding linux-pci mailing list and Bjorn to the CC.
>>
>> Bjorn- David Miller needs a signoff by PCI maintainer.
>>
>>> ---
>>>  drivers/pci/iov.c   | 41 +++++++++++++++++++++++++++++++++++++++++
>>>  include/linux/pci.h |  5 +++++
>>>  2 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>> index ee599f2..fd99720 100644
>>> --- a/drivers/pci/iov.c
>>> +++ b/drivers/pci/iov.c
>>> @@ -729,6 +729,47 @@ int pci_num_vf(struct pci_dev *dev)
>>>  EXPORT_SYMBOL_GPL(pci_num_vf);
>>>
>>>  /**
>>> + * pci_vfs_assigned - returns number of VFs are assigned to a guest
>>> + * @dev: the PCI device
>>> + *
>>> + * Returns number of VFs belonging to this device that are assigned to a guest.
>>> + * If device is not a physical function returns -ENODEV.
>>> + */
>>> +int pci_vfs_assigned(struct pci_dev *dev)
> I guess the idea here is to replace be_find_vfs(),
> igb_vfs_are_assigned(), ixgbe_vfs_are_assigned(), etc.  It does seem
> good to reduce duplicated code.

The general idea was just to remove duplicate code.  As is we have a
couple more drivers on the way that would end up needing a similar function.

> I'm trying to figure out why this is safe -- there's no explicit
> synchronization between the iteration through PCI devices looking for
> matching VFs and the device assignment/deassignment paths that set or
> clear PCI_DEV_FLAGS_ASSIGNED, so on the face of it, it looks like
> things could change between calling pci_vfs_assigned() and using the
> result to make a decision.
>
> Most of the calls would be in .remove() functions, so maybe there's
> some sort of synchronization in that path that  makes this safe.
>
> Bjorn

I'm assuming this will be used in regions that are somehow protected
since the main spots where this might be called would be probe, remove,
or when updating the number of VFs.  From what I can tell in the Xen
case there is a driver stub that is loaded that sets the flag so that is
covered by probe/remove.  I don't know about the KVM case.

Thanks,

Alex

