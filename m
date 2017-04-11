Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v2
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
 <20170324213445.GF25380@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <70ea3ef3-10a6-01f1-125c-dbf89e87b1d0@vodafone.de>
Date: Tue, 11 Apr 2017 17:37:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170324213445.GF25380@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

first of all sorry for the delay, had been busy with other stuff in the 
last few weeks.

Am 24.03.2017 um 22:34 schrieb Bjorn Helgaas:
>> +			release_child_resources(res);
> Doesn't this recursively release *all* child resources?  There could
> be BARs from several devices, or even windows of downstream bridges,
> inside this window.  The drivers of those other devices aren't
> expecting things to change here.

Yes, the original idea was that the driver calling this knows that the 
BARs will be changed for the bridge it belongs to.

But you're right. I've changed it in the way that our device driver will 
release all resource first and then call the function to resize its BAR.

The function will return an error in the next version of the patch if 
the bridge BAR which needs to be moved for this is still used by child 
resources.

>> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>> +{
>> +	struct resource *res = dev->resource + resno;
>> +	u32 sizes = pci_rbar_get_possible_sizes(dev, resno);
>> +	int old = pci_rbar_get_current_size(dev, resno);
>> +	u64 bytes = 1ULL << (size + 20);
>> +	int ret = 0;
> I think we should fail the request if the device is enabled, i.e., if
> the PCI_COMMAND_MEMORY bit is set.  We can't safely change the BAR
> while memory decoding is enabled.
>
> I know there's code in pci_std_update_resource() that turns off
> PCI_COMMAND_MEMORY, but I think that's a mistake: I think it should
> fail when asked to update an enabled BAR the same way
> pci_iov_update_resource() does.
>
> I'm not sure why you call pci_reenable_device() below, but I think I
> would rather have the driver do something like this:
>
>    pci_disable_device(dev);
>    pci_resize_resource(dev, 0, size);
>    pci_enable_device(dev);
>
> That way it's very clear to the driver that it must re-read all BARs
> after resizing this one.

I've tried it, but this actually doesn't seem to work.

At least on the board I've tried pci_disable_device() doesn't clear the 
PCI_COMMAND_MEMORY bit, it just clears the master bit.

Additional to that the power management reference counting 
pci_disable_device() and pci_enable_device() doesn't look like what I 
want for this functionality.

How about the driver needs to disabled memory decoding itself before 
trying to resize anything?

>> +	if (!sizes)
>> +		return -ENOTSUPP;
>> +
>> +	if (!(sizes & (1 << size)))
>> +		return -EINVAL;
>> +
>> +	if (old < 0)
>> +		return old;
>> +
>> +	/* Make sure the resource isn't assigned before making it larger. */
>> +	if (resource_size(res) < bytes && res->parent) {
>> +		release_resource(res);
>> +		res->end = resource_size(res) - 1;
>> +		res->start = 0;
>> +		if (resno < PCI_BRIDGE_RESOURCES)
>> +			pci_update_resource(dev, resno);
> Why do we need to write this zero to the BAR?  If PCI_COMMAND_MEMORY
> is set, I think this is dangerous, and if it's not set, I think it's
> unnecessary.
>
> I think we should set the IORESOURCE_UNSET bit to indicate that the
> resource does not have an address assigned to it.  It should get
> cleared later anyway, but having IORESOURCE_UNSET will make any debug
> messages emitted while reassigning resources make more sense.

Makes sense, changed.

>> +	return 0;
>> +
>> +error_resize:
>> +	pci_rbar_set_size(dev, resno, old);
>> +	res->end = res->start + (1ULL << (old + 20)) - 1;
>> +
>> +error_reassign:
>> +	pci_assign_unassigned_bus_resources(dev->bus);
>> +	pci_setup_bridge(dev->bus);
> Could this bridge-related recovery code go inside
> pci_reassign_bridge_resources()?

No, we need to restore the original size of the resource before trying 
the recovery code when something goes wrong.

I will address all other comments in the next version of the patch as well.

Regards,
Christian.
