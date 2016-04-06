Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sysgo.com ([176.9.12.79]:51688 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbcDFOBu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Apr 2016 10:01:50 -0400
Subject: Re: Exception due to PCI: Use pci_is_root_bus() to check for root bus
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5704F85B.4080501@sysgo.com> <20160406133502.GB4976@localhost>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <570516CB.7080406@sysgo.com>
Date: Wed, 6 Apr 2016 16:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160406133502.GB4976@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Am 06.04.2016 um 15:35 schrieb Bjorn Helgaas:
> Hi David,
>
> On Wed, Apr 06, 2016 at 01:51:55PM +0200, David Engraf wrote:
>> Hi,
>>
>> I have an exception in __pci_bus_size_bridges() when pci_is_root_bus
>> returns false but bus->self == NULL. My driver registers a virtual
>> bus, like virtfn_add_bus(). pci_add_new_bus() is called with a
>> parent but without a pci_dev. Thus bus->parent is set but bus->self
>> is NULL. When __pci_bus_size_bridges() is called I get an exception
>> at:
>>
>> switch (bus->self->class >> 8)
>>
>> The previous version of the code, checking for bus->self != NULL
>> worked for me. I think an additional check is required to make sure
>> we're not accessing a NULL pointer.
>
> When you say "previous version of the code," do you mean a previous
> version of Linux worked correctly but a newer version does not?  What
> versions are they?  Did you identify a commit that changed the
> behavior?  I assume you're talking about an out-of-tree driver that
> registers a virtual bus?  Can you point us to the code?  Can you share
> the dmesg log, including the backtrace?

With previous version, I mean reverting commit 
2ba29e270e977b213a7d58ae1152c23a1c3074a3. This will check for bus->self 
instead of using pci_is_root_bus().
I'm working on a driver which is basically based on drivers/pci/iov.c.

The code looks like this:

child = pci_add_new_bus(parent, NULL, busnr);

This will create child with child->parent = parent and child->self = 
NULL. When the kernel calls __pci_bus_size_bridges(), accessing 
bus->self->class crashes:

/* The root bus? */
if (pci_is_root_bus(bus))
	return;

switch (bus->self->class >> 8) { <- crash here because of bus->self == NULL

Best regards
David
