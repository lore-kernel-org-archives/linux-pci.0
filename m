Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
Return-Path: <SRS0=sw7U=A5=intel.com=jonathan.derrick@kernel.org>
Subject: Re: [RFC 1/3] PCI: pci-driver: Introduce pci device delete list
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Dan J Williams <dan.j.williams@intel.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-2-git-send-email-jonathan.derrick@intel.com>
 <20170928090901.GC12599@kroah.com>
From: Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <c7f0a859-302d-05a1-d24f-d5a6057420fa@intel.com>
Date: Thu, 28 Sep 2017 09:53:18 -0600
MIME-Version: 1.0
In-Reply-To: <20170928090901.GC12599@kroah.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

On 09/28/2017 03:09 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 27, 2017 at 04:40:20PM -0400, Jon Derrick wrote:
>> This patch introduces a new kernel command line parameter to mask pci
>> device ids from pci driver id tables. This prevents masked devices from
>> automatically binding to both built-in and module drivers.
>>
>> Devices can be later attached through the driver's sysfs new_id
>> inteface.
>>
>> The use cases for this are primarily for debugging, eg, being able to
>> prevent attachment before probes are set up. It can also be used to mask
>> off faulty built-in hardware or faulty simulated hardware.
>>
>> Another use case is to prevent attachment of devices which will be
>> passed to VMs, shortcutting the detachment effort.
> 
> Is the "shortcut" really that big of a deal?  unbind actually causes
> problems?  Is this an attempt to deal with devices being handled by more
> than one driver and then you want to manually bind it later on?
> 
>> The format is similar to the sysfs new_id format. Device ids are
>> specified with:
>>
>> VVVV:DDDD[:SVVV:SDDD][:CCCC][:MMMM]
>>
>> Where:
>> VVVV = Vendor ID
>> DDDD = Device ID
>> SVVV = Subvendor ID
>> SDDD = Subdevice ID
>> CCCC = Class
>> MMMM = Class Mask
>>
>> IDs can be chained with commas.
>>
>> Examples:
>> 	<driver>.delete_id=1234:5678
>> 	<driver>.delete_id=ffffffff:ffffffff
>> 	<driver>.delete_id=ffffffff:ffffffff:ffffffff:ffffffff:010802
>> 	<driver>.delete_id=1234:5678,abcd:ef01,2345:ffffffff
> 
> What about drivers that handle more than one bus type (i.e. USB and
> PCI?)  This format is specific to PCI, yet you are defining it as a
> "global" for all drivers :(
> 
I was hoping to extend it to other bus types as well, but just wanted
some early feedback on the idea. Pci was the easier implementation for
me. Could prepending pci:, usb:, etc on the format be an option?

> This feels hacky, what is the real reason for this?  It feels like we
> have so many different ways to blacklist and unbind and bind devices to
> drivers already, why add yet-another way?
> 
I ran into an issue a while back where I needed to disable a device from
a built-in driver to perform a regression test. I worked around that
issue by doing an initcall_blacklist on the pci-driver declaration, but
that also preventing later binding because the driver was never registered.

I've also had issues with remote systems where pluggable devices were
broken or otherwise non-responsive, and it would have been nice to have
been able to keep them from binding on module loading as a temporary
workaround until someone could have removed those devices (though
impossible on built-in hardware).

I'm not sure about hacky; I think the implementation in this patch (1/3)
is pretty clean :). I'm not familiar with all the different ways of
blacklisting. Is there another way to work around the issues I listed above?

I understand the concern about having it exist in the format <driver>.
and only supporting one or a few bus types. I have another set that
extends the pci= parameter instead.

> thanks,
> 
> greg k-h
> 

Best,
Jon
