Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932426AbcKGRpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Nov 2016 12:45:51 -0500
Subject: Re: [PATCH] PCI: pci-stub: accept exceptions to the ID- and
 class-based matching
To: Alex Williamson <alex.williamson@redhat.com>
References: <20161025182419.22910-1-lersek@redhat.com>
 <20161025124218.2696e55a@t450s.home>
 <fdce64d5-1610-5d68-81c2-58ed61c398f4@redhat.com>
 <20161107094926.139566c1@t450s.home>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Grigore <andrei.grg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jayme Howard <g.prime@gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <95384aa8-5c43-5bed-6b60-45ef21f28a4f@redhat.com>
Date: Mon, 7 Nov 2016 18:45:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161107094926.139566c1@t450s.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/07/16 17:49, Alex Williamson wrote:
> On Tue, 25 Oct 2016 21:24:25 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 10/25/16 20:42, Alex Williamson wrote:
>>> On Tue, 25 Oct 2016 20:24:19 +0200
>>> Laszlo Ersek <lersek@redhat.com> wrote:
>>>   
>>>> Some systems have multiple instances of the exact same kind of PCI device
>>>> installed. When VFIO users intend to assign these devices to VMs, they
>>>> occasionally don't want to assign all of them; they'd keep a few for
>>>> host-side use. The current ID- and class-based matching in pci-stub
>>>> doesn't accommodate this use case, so users are left with either
>>>> rc.local-style host boot scripts, or QEMU wrapper scripts (which are
>>>> inferior to a pure libvirt environment).
>>>>
>>>> Introduce the "except" module parameter for pci-stub. In addition to
>>>> "ids", users can specify a list of Domain:Bus:Device.Function tuples. The
>>>> tuples are parsed and saved before pci_add_dynid() is called. The pci-stub
>>>> probe function will fail for the listed devices, for the initial and all
>>>> later (explicit) binding attempts.
>>>>
>>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>>> Cc: Andrei Grigore <andrei.grg@gmail.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> Cc: Jayme Howard <g.prime@gmail.com>
>>>> Reported-by: Andrei Grigore <andrei.grg@gmail.com>
>>>> Ref: https://www.redhat.com/archives/vfio-users/2016-October/msg00121.html
>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>> ---
>>>>  drivers/pci/pci-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 63 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
>>>> index 886fb3570278..120c29609c44 100644
>>>> --- a/drivers/pci/pci-stub.c
>>>> +++ b/drivers/pci/pci-stub.c
>>>> @@ -26,8 +26,44 @@ MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the stub driver, format is "
>>>>  		 "\"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\""
>>>>  		 " and multiple comma separated entries can be specified");
>>>>  
>>>> +#define MAX_EXCEPT 16
>>>> +
>>>> +static unsigned num_except;
>>>> +static struct except {
>>>> +	u16 domain;
>>>> +	u16 devid;
>>>> +} except[MAX_EXCEPT];
>>>> +
>>>> +/*
>>>> + * Accommodate substrings like "0000:00:1c.4," MAX_EXCEPT times, with the comma
>>>> + * replaced with '\0' in the last instance
>>>> + */
>>>> +static char except_str[13 * MAX_EXCEPT] __initdata;
>>>> +
>>>> +module_param_string(except, except_str, sizeof except_str, 0);
>>>> +MODULE_PARM_DESC(except, "Comma-separated list of PCI addresses to except "
>>>> +		 "from the ID- and class-based binding. The address format is "
>>>> +		 "Domain:Bus:Device.Function (all components are required and "
>>>> +		 "written in hex), for example, 0000:00:1c.4. At most "
>>>> +		 __stringify(MAX_EXCEPT) " exceptions are supported.");  
>>>
>>> So a user needs to specify both a set of set of vendor:device ids AND an
>>> exception list?  Wouldn't it be easier to make a list of _included_
>>> devices by address, w/o needing an ids= list?  
>>
>> First, I didn't want to drop the ids=... parameter for compatibility
>> reasons.
>>
>> Second (because I realize you're likely not suggesting to *drop* "ids",
>> just to provide a positive-sense replacement for it), I have no idea how
>> to influence the PCI subsystem like this. As far as I know (which is
>> very little, admittedly), the only way to get the PCI subsystem to call
>> back into a specific driver probe function is to provide
>> device/vendor/subsystem IDs, and class patterns, with that device driver.
>>
>> If I don't provide those IDs (either statically or dynamically), then
>> the driver will bind nothing, because the core won't invoke the probe
>> function for any device.
>>
>> If I provided a match-all pattern (not sure how), then the core would
>> call the probe function for all devices. While that might help move the
>> actual positive filtering into the stub probe function (i.e., without
>> the "ids" parameter), I don't think it would be appreciated.
> 
> This is why we have a driver_override available for devices, it
> supersedes the PCI ID match table.  I'd rather see work towards making
> a commandline interface to driver_override, which potentially benefits
> drivers beyond pci-stub, beyond PCI actually (in fact, we can pretty
> much eliminate pci-stub altogether simply by specifying a dummy
> driver_override that doesn't match any drivers, ex. "NONE").
> Regardless of an exception list being the easiest, or understood way to
> currently code pci-stub to get what you want, I still consider an
> id+exception list to be convoluted. Thanks,

driver_override sounds superior, indeed. I didn't know about it, I've
now read up on it in "ABI/testing/sysfs-bus-pci".

Unfortunately, I don't think I can personally tackle the kernel cmdline
enablement of driver_override.

Feel free to drop this patch (and thanks for the information).

Laszlo

>>> FWIW, I think the reason
>>> this hasn't been done to date is that PCI bus addresses (except for
>>> root bus devices) are not stable.  Depending on the system, the address
>>> of a given device may change, not only based on the slot where the
>>> device is installed, but whether other devices in other slots are
>>> populated.  
>>
>> I agree.
>>
>> However, while the addresses are not stable in the face of hardware
>> changes, I think the addresses don't change haphazardly (that is,
>> without hardware changes).
>>
>> So, if you plug in another card, your current pci-stub.except=...
>> parameter might become invalid; but that's not very different from the
>> case when you plug in the second instance of a preexistent card right
>> now -- then the pci-stub.ids=... filter won't match uniquely anymore,
>> and assignment vs. host-side use might not work as intented.
>>
>>> This is why when ACPI needs to describe a PCI device (such
>>> as in the DMAR tables), it does so via paths.  We don't know the bus
>>> number that will be assigned to a device, but we do know
>>> deterministically how to traverse to it, for instance root bus -> root
>>> dev.fn -> intermediate dev.fn -> target dev.fn.  Thanks,  
>>
>> Yes, UEFI device paths follow this model as well. In UEFI, device paths
>> (which cover a lot more than PCI) are very clearly separated from
>> domain/bus/device/function quadruplets.
>>
>> Are there utilities in the kernel for parsing a textual device path into
>> a binary representation, and then locating the PCI device with the
>> binary devpath? (This is doable in UEFI.)
>>
>> ... Anyhow, when I started working on this patch, the first thing I
>> searched for was existing practice. There is "prior art" for specifying
>> PCI BDFs on the kernel command line; please see the following commits:
>>
>> ea9e9d802902 Specify PCI based UART for earlyprintk
>> c43088e3b8ca Documentation/kernel-parameters: add missing pciserial to
>>              the earlyprintk
>>
>> Thanks
>> Laszlo
>>
>>>   
>>>> +
>>>> +static inline bool exception_matches(const struct except *ex,
>>>> +				     const struct pci_dev *dev)
>>>> +{
>>>> +	return ex->domain == pci_domain_nr(dev->bus) &&
>>>> +	       ex->devid == PCI_DEVID(dev->bus->number, dev->devfn);
>>>> +}
>>>> +
>>>>  static int pci_stub_probe(struct pci_dev *dev, const struct pci_device_id *id)
>>>>  {
>>>> +	unsigned i;
>>>> +
>>>> +	for (i = 0; i < num_except; i++)
>>>> +		if (exception_matches(&except[i], dev)) {
>>>> +			dev_info(&dev->dev, "skipped by stub\n");
>>>> +			return -EPERM;
>>>> +		}
>>>> +
>>>>  	dev_info(&dev->dev, "claimed by stub\n");
>>>>  	return 0;
>>>>  }
>>>> @@ -47,6 +83,33 @@ static int __init pci_stub_init(void)
>>>>  	if (rc)
>>>>  		return rc;
>>>>  
>>>> +	/* parse exceptions */
>>>> +	p = except_str;
>>>> +	while ((id = strsep(&p, ","))) {
>>>> +		int fields;
>>>> +		unsigned domain, bus, dev, fn;
>>>> +
>>>> +		if (*id == '\0')
>>>> +			continue;
>>>> +
>>>> +		fields = sscanf(id, "%x:%x:%x.%x", &domain, &bus, &dev, &fn);
>>>> +		if (fields != 4 || domain > 0xffff || bus > 0xff ||
>>>> +		    dev > 0x1f || fn > 0x7) {
>>>> +			printk(KERN_WARNING
>>>> +			       "pci-stub: invalid exception \"%s\"\n", id);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		if (num_except < MAX_EXCEPT) {
>>>> +			struct except *ex = &except[num_except++];
>>>> +
>>>> +			ex->domain = domain;
>>>> +			ex->devid = PCI_DEVID(bus, PCI_DEVFN(dev, fn));
>>>> +		} else
>>>> +			printk(KERN_WARNING
>>>> +			       "pci-stub: no room for exception \"%s\"\n", id);
>>>> +	}
>>>> +
>>>>  	/* no ids passed actually */
>>>>  	if (ids[0] == '\0')
>>>>  		return 0;  
>>>   
>>
> 

