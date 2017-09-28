Return-Path: <SRS0=yaEI=A5=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=yaEI=A5=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 28 Sep 2017 11:09:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>,
	Dan J Williams <dan.j.williams@intel.com>
Subject: Re: [RFC 1/3] PCI: pci-driver: Introduce pci device delete list
Message-ID: <20170928090901.GC12599@kroah.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506544822-2632-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 04:40:20PM -0400, Jon Derrick wrote:
> This patch introduces a new kernel command line parameter to mask pci
> device ids from pci driver id tables. This prevents masked devices from
> automatically binding to both built-in and module drivers.
> 
> Devices can be later attached through the driver's sysfs new_id
> inteface.
> 
> The use cases for this are primarily for debugging, eg, being able to
> prevent attachment before probes are set up. It can also be used to mask
> off faulty built-in hardware or faulty simulated hardware.
> 
> Another use case is to prevent attachment of devices which will be
> passed to VMs, shortcutting the detachment effort.

Is the "shortcut" really that big of a deal?  unbind actually causes
problems?  Is this an attempt to deal with devices being handled by more
than one driver and then you want to manually bind it later on?

> The format is similar to the sysfs new_id format. Device ids are
> specified with:
> 
> VVVV:DDDD[:SVVV:SDDD][:CCCC][:MMMM]
> 
> Where:
> VVVV = Vendor ID
> DDDD = Device ID
> SVVV = Subvendor ID
> SDDD = Subdevice ID
> CCCC = Class
> MMMM = Class Mask
> 
> IDs can be chained with commas.
> 
> Examples:
> 	<driver>.delete_id=1234:5678
> 	<driver>.delete_id=ffffffff:ffffffff
> 	<driver>.delete_id=ffffffff:ffffffff:ffffffff:ffffffff:010802
> 	<driver>.delete_id=1234:5678,abcd:ef01,2345:ffffffff

What about drivers that handle more than one bus type (i.e. USB and
PCI?)  This format is specific to PCI, yet you are defining it as a
"global" for all drivers :(

This feels hacky, what is the real reason for this?  It feels like we
have so many different ways to blacklist and unbind and bind devices to
drivers already, why add yet-another way?

thanks,

greg k-h
