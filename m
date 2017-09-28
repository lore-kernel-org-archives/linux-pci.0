Return-Path: <SRS0=AvtO=A5=intel.com=dan.j.williams@kernel.org>
Return-Path: <SRS0=AvtO=A5=intel.com=dan.j.williams@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170928090901.GC12599@kroah.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-2-git-send-email-jonathan.derrick@intel.com> <20170928090901.GC12599@kroah.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 28 Sep 2017 08:58:29 -0700
Message-ID: <CAPcyv4iWTFCte_KTe8N6w5yQ6MuwFqBnitquJ8sVTmvhrF-MKQ@mail.gmail.com>
Subject: Re: [RFC 1/3] PCI: pci-driver: Introduce pci device delete list
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Derrick <jonathan.derrick@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 28, 2017 at 2:09 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
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
>>       <driver>.delete_id=1234:5678
>>       <driver>.delete_id=ffffffff:ffffffff
>>       <driver>.delete_id=ffffffff:ffffffff:ffffffff:ffffffff:010802
>>       <driver>.delete_id=1234:5678,abcd:ef01,2345:ffffffff
>
> What about drivers that handle more than one bus type (i.e. USB and
> PCI?)  This format is specific to PCI, yet you are defining it as a
> "global" for all drivers :(

I assume other buses could define their own "delete_id" format and
it's up to those bus_type implementations to check for "delete_id"
statements for the drivers attached to it. Somewhat similar to what we
have for "new_id" where it appears to be global sysfs attribute, but
implemented per-bus.

> This feels hacky, what is the real reason for this?  It feels like we
> have so many different ways to blacklist and unbind and bind devices to
> drivers already, why add yet-another way?

Unbind after the fact may be too late, and builtin-drivers eliminate
modprobe blacklisting. I've missed having this functionality in the
past for platform bring up.
