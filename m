Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:51533 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdLLPBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Dec 2017 10:01:16 -0500
Subject: Re: [PATCH V3 2/2] Xen/PCIback: Implement PCI flr/slot/bus reset with
 'reset' SysFS attribute
To: Jan Beulich <JBeulich@suse.com>
Cc: roger.pau@citrix.com, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        konrad.wilk@Oracle.COM, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Message-ID: <e217cc6c-4aa4-40e0-cedb-b0cfd084b092@Oracle.COM>
Date: Tue, 12 Dec 2017 09:01:03 -0600
MIME-Version: 1.0
In-Reply-To: <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks Jan for your review comments. Please see below for my comments.

On 12/8/2017 3:34 AM, Jan Beulich wrote:
>>>> On 07.12.17 at 23:21,<Govinda.Tatti@Oracle.COM>  wrote:
>> Due to the complexity with the PCI lock we cannot do the reset when a
>> device is bound ('echo $BDF > bind') or when unbound ('echo $BDF > unbind')
>> as the pci_[slot|bus]_reset also takes the same lock resulting in a
>> dead-lock.
> It took me a moment to figure that here you're referring to the
> process of (un)binding, not the state. To avoid that ambiguity in
> wording, how about "... we cannot do the reset while a device is
> being bound (...) or while it is being unbound ..."?
Sure, I will fix it.
>> --- a/Documentation/ABI/testing/sysfs-driver-pciback
>> +++ b/Documentation/ABI/testing/sysfs-driver-pciback
>> @@ -11,3 +11,18 @@ Description:
>>                   #echo 00:19.0-E0:2:FF > /sys/bus/pci/drivers/pciback/quirks
>>                   will allow the guest to read and write to the configuration
>>                   register 0x0E.
>> +
>> +What:           /sys/bus/pci/drivers/pciback/reset
>> +Date:           Dec 2017
>> +KernelVersion:  4.15
>> +Contact:xen-devel@lists.xenproject.org  
>> +Description:
>> +                An option to perform a flr/slot/bus reset when a PCI device
>> +		is owned by Xen PCI backend. Writing a string of DDDD:BB:DD.F
> SSSS:BB:DD.F (or else the D-s are ambiguous, the more that "domain"
> in Xen code is ambiguous anyway - I continue to be mislead by struct
> pcistub_device_id's domain field)
Thanks for catching this issue. I will fix it.
> Also I assume the SSSS part is optional (default zero), which
> probably can and should be expressed in some way.
SSSS can be 0 or non-zero, subject to system configuration.
>> --- a/drivers/xen/xen-pciback/pci_stub.c
>> +++ b/drivers/xen/xen-pciback/pci_stub.c
>> @@ -313,6 +313,102 @@ void pcistub_put_pci_dev(struct pci_dev *dev)
>>   	up_write(&pcistub_sem);
>>   }
>>   
>> +struct pcistub_args {
>> +	const struct pci_dev *dev;
>> +	unsigned int dcount;
> The sole use of this field is for a debug message. Why not drop it
> and make "dev" the "data" argument without further indirection?
I prefer to keep this data structure since it will be helpful to debug 
any issues
orfor future enhancements.
>> +static int pcistub_device_search(struct pci_dev *dev, void *data)
>> +{
>> +	struct pcistub_device *psdev;
>> +	struct pcistub_args *arg = data;
>> +	bool found = false;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&pcistub_devices_lock, flags);
>> +
>> +	list_for_each_entry(psdev, &pcistub_devices, dev_list) {
>> +		if (psdev->dev == dev) {
>> +			found = true;
>> +			arg->dcount++;
>> +			break;
> Neither here nor in the caller I can see a check whether the device
> is currently assigned to a guest. Ownership by pciback alone imo is
> not sufficient to allow a reset to be performed.
I can add the following check

if ((psdev->dev == dev) && (pci_is_dev_assigned(dev)))
>> +static int pcistub_device_reset(struct pci_dev *dev)
>> +{
>> +	struct xen_pcibk_dev_data *dev_data;
>> +	bool slot = false, bus = false;
>> +	struct pcistub_args arg = {};
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
>> +
>> +	/* First check and try FLR */
>> +	if (pcie_has_flr(dev)) {
>> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
>> +			pci_name(dev));
>> +		pcie_flr(dev);
> The lack of error check here puzzled me, but I see the function
> indeed returns void right now. I think the prereq patch should
> change this along with exporting the function - you really don't
> want the device to be handed to a guest when the FLR timed
> out.
We will change pcie_flr() to return error code. I will make this change
in the next version of this patch.
>> +		return 0;
>> +	}
>> +
>> +	if (!pci_probe_reset_slot(dev->slot))
>> +		slot = true;
>> +	else if ((!pci_probe_reset_bus(dev->bus)) &&
>> +		 (!pci_is_root_bus(dev->bus)))
> Too many parentheses for my taste.
I will fix it.
>> +static ssize_t reset_store(struct device_driver *drv, const char *buf,
>> +			   size_t count)
>> +{
>> +	struct pcistub_device *psdev;
>> +	int domain, bus, slot, func;
>> +	int err;
>> +
>> +	err = str_to_slot(buf, &domain, &bus, &slot, &func);
>> +	if (err)
>> +		return err;
>> +
>> +	psdev = pcistub_device_find(domain, bus, slot, func);
>> +	if (psdev) {
>> +		err = pcistub_device_reset(psdev->dev);
>> +		pcistub_device_put(psdev);
>> +	} else {
>> +		err = -ENODEV;
>> +	}
>> +
>> +	if (!err)
>> +		err = count;
>> +
>> +	return err;
>> +}
>> +static DRIVER_ATTR_WO(reset);
> Would it be worth for reads of the file to return whether the device
> can be reset this way (i.e. the result of the checks you do before
> actually doing the reset)?
I don't think so. Plus, it makes this interface and its usage more 
complicated.

Cheers
GOVINDA
