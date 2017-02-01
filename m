Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751686AbdBAQFF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Feb 2017 11:05:05 -0500
Date: Wed, 1 Feb 2017 10:04:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Austin.Bolen@dell.com
Cc: keith.busch@intel.com, gregkh@linuxfoundation.org, lukas@wunner.de,
        linux-pci@vger.kernel.org, bhelgaas@google.com, wzhang@fb.com
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20170201160459.GB15793@bhelgaas-glaptop.roam.corp.google.com>
References: <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
 <20161213231840.GD12113@localhost.localdomain>
 <B58D82457FDA0744A320A2FC5AC253B93D82F37D@fmsmsx104.amr.corp.intel.com>
 <20170120213550.GA16618@localhost.localdomain>
 <20170121073140.GA26396@wunner.de>
 <20170121084243.GA24706@kroah.com>
 <20170123160452.GA10771@localhost.localdomain>
 <35db59dfeccf4c83b5cb0eb3a1cf00b1@AUSX13MPC131.AMER.DELL.COM>
 <20170125211718.GA18383@bhelgaas-glaptop.roam.corp.google.com>
 <1335cad92c6f4d258d5ca6738d585ccc@AUSX13MPC131.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335cad92c6f4d258d5ca6738d585ccc@AUSX13MPC131.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Responding inline, per linux mailing list convention]

Hi Austin,

On Thu, Jan 26, 2017 at 01:12:40AM +0000, Austin.Bolen@dell.com wrote:
> I know of two ways that are being discussed on how to handle this in
> a generic way that don't require a priori knowledge of what the
> register value should be.  Both have tradeoffs.  It may be that
> neither are acceptable from OS standpoint or both are. I'm
> interested in your perspective and if neither are acceptable, then
> it will be great to get your thoughts on if there is anything that
> could be added to the PCIe Base Spec to provide the OS with an
> acceptable way to handle these types of errors.
> 
> 1. Check Vendor ID Register If 1's are returned on a config read
> then read the Vendor ID.  If the Vendor ID also returns 1's (which
> it will if the device is removed) then we know with certainty it is
> an error.  On removal events, we see this check working in practice.
> 
> How the check above can fail:  It is possible (though we've not been
> able to replicate this failure IRL) that a device could be removed
> causing all 1's to be returned for the data and by the time the
> error checking code in the config read API reads the Vendor ID, a
> new device has been inserted and Vendor ID returns a valid value
> (the config read API would need to be really slow or get suspended
> or otherwise stalled for a large amount of time). An operating
> system could probably add some sort of co-ordination between this
> error checking code in the config space API and the operating
> system's PCIe hot-plug driver (perhaps using dev->is_removed or the
> like as the proxy) to cover this corner case and make this
> bullet-proof but I'm not sure if it's necessary.
> 
> This mechanism would work for PCI and PCIe.

I like this idea, and if we do go down the route of trying to reliably
return PCIBIOS_DEVICE_NOT_FOUND, I think we'd have to do something
like this at least for conventional PCI.  I don't think it would help
much to make a mechanism where drivers would have to check for errors
differently for PCI vs. PCIe devices.

I do wonder about the MacOS guidance Lukas pointed out [1].  It sounds
like MacOS drivers are expected to handle 0xFFFFFFFF data values, both
from config reads and MMIO config reads.

Does that mean MacOS considered and rejected this idea (reading Vendor
ID to check for device removal) for some reason?  Or maybe MacOS
config accessors don't return success/failure indication?  Or maybe
MMIO accesses can't return success/failure and they wanted the same
failure model for both MMIO and config space?

I think there's some value in having similar driver expectations for
MacOS and Linux, to make it easier for developers who work on both
OSes.

[1] https://developer.apple.com/library/content/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html

> OSes could choose to not handle this in the core config space APIs
> and require all software entities that may access a device's config
> space (PCI bus driver/device driver/systems management
> software/diagnostic utilities/etc.) to perform this check (what we
> do today).
> 
> 2. Use the Root Port Programmed IO (RP PIO) mechanism The PCIe Spec
> architected way is to use RP PIO extensions which were added in the
> PCIe 3.1 specification (see section 6.2.10.3 and 7.31) as part of
> the Enhanced Downstream Port Containment ECN.  This ECN added status
> bits in root ports for the various errors (Unsupported Request,
> Completer Abort, Completion Timeout) that could occur due to a
> failed non-posted request (Configuration Space access, MMIO access,
> IO access), TLP Header Logs to determine the which device is
> associated with the failure, and a synchronous exception mechanism
> to notify the operating system.  This mechanism was intended to
> solve all corner cases for these types of failures.
> 
> This feature won't be available in products for some time and is
> optional so all root ports may not implement it.
> 
> This feature is PCIe only so won't work for PCI.  Is this a
> deal-breaker?

The config accessors (pci_read_config_word(), etc.) currently work for
PCI and PCIe devices, and the caller doesn't have to know the
difference.  I want to preserve that, so I don't want to add
PCIe-specific accessors.  But it's conceivable that the accessors
could internally do something different for PCI vs. PCIe.

We currently serialize all config accesses system-wide, which I think
is unnecessarily strict for ECAM, so I would like to relax it.  It
sounds like this mechanism might require serialization at least at the
Root Port level to do this synchronously.  

> Unlike option 1, this mechanism most likely cannot be used by anyone
> but the OS so this work cannot be pushed to the caller.  There would
> be no way to co-ordinate ownership of the RP PIO registers amongst
> the many software entities that may access a device's config space
> (PCI bus driver/device driver/systems management software/diagnostic
> utilities/etc.)

If we want a change in this area, I think we have to figure out what
the benefit would be.  The current situation is that drivers should
check for 0xffffffff data and treat that as an (unreliable) indication
that the device was removed.  We can't change all those drivers, so I
think we have to preserve this behavior.

We could also make the accessor return something like
PCIBIOS_DEVICE_NOT_FOUND (in addition to returning data of
0xffffffff), which might be a more reliable indication.

In that case, would we change the message to driver writers from
"treat 0xffffffff data as possible removal" to "treat
PCIBIOS_DEVICE_NOT_FOUND as removal indication"?

If PCIBIOS_DEVICE_NOT_FOUND were reliable, that would be an
improvement.  But maybe we could get most of that benefit by adding a
new "pci_device_removed(dev)" API that uses one of the mechanisms you
mention?  Then the guidance could be "if you read 0xffffffff, use
pci_device_removed() and act accordingly."  That's an incremental
change and makes it easier to maintain a driver that works across old
and new versions of Linux.

You mention other entities (systems management, utilities, etc.)
above.  I don't really know what the tradeoffs are there.  Obviously
they wouldn't use the Linux accessors directly, so the strategy there
might not have to be the same.  Maybe the wrappers they use could use
one of these mechanisms.

Bjorn

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org] 
> Sent: Wednesday, January 25, 2017 3:17 PM
> To: Bolen, Austin <Austin_Bolen@Dell.com>
> Cc: keith.busch@intel.com; gregkh@linuxfoundation.org; lukas@wunner.de; linux-pci@vger.kernel.org; bhelgaas@google.com; wzhang@fb.com
> Subject: Re: [PATCHv4 next 0/3] Limiting pci access
> 
> Hi Austin,
> 
> Thanks a lot for bringing some more PCIe spec expertise.  I wish we had more insight into what the spec authors were thinking because I'm sure we often miss the point and cause face-palms on the committee.
> 
> On Wed, Jan 25, 2017 at 12:44:34AM +0000, Austin.Bolen@dell.com wrote:
> > To add to what Keith sent, I wanted to throw in my 2 cents on this 
> > issue.  Full disclosure - I'm not a Linux developer and so my thoughts 
> > on this are more from the PCIe Base Specification point of view and 
> > specifically, hardening the spec to better support PCIe hot-plug for 
> > storage use cases (NVMe) and providing better guidance in the PCIe 
> > spec on how system software can interact with the PCIe subsystem to 
> > better determine/handle the sort of errors that arise in PCIe removal 
> > scenarios.
> > 
> > From Dell EMC side, we would definitely like to see the config read 
> > routines in all operating environments return an error status code any 
> > time data is synthesized by the root port - but especially for 
> > failures due to device removal.  Today, if bad data is synthesized by 
> > a root port due to a failed config read, the config read routines in 
> > various operating environments do not return an error.  We, and 
> > others, have found cases where the caller of these config routines 
> > will consume the bad data since the API did not return an error due to 
> > this type of failure.  Most folks have been patching up every caller 
> > to check if data is synthesized after every config read.
> 
> How exactly do the callers do this?  By checking for all ones data?  It's legal for a config register to contain all ones, of course, so checking for all ones by itself is not definitive.  A driver does have additional knowledge about what registers exist and what their legal contents are, but of course, the config accessor in the core does not.
> 
> > This is not very efficient as there are many entities that read config 
> > space (device driver, bus driver, systems management
> > software, diagnostic software, etc.).   This patch, or similar,
> > is very beneficial because it localizes the error checking for 
> > synthesized data to a single location in the core config read APIs 
> > rather than distributing this code to every caller.
> 
> This sounds like you mean checking for synthesized data in the PCI core.  How can we figure that out?  Is there something in the root port that can tell us the data was synthesized?
> 
> Is there a way to do this check for both conventional PCI and PCIe, since we use the same config accessors for PCI and PCIe?
> 
> We support many host bridges and most of the time (x86 platforms with ACPI) we have no bridge-specific support in Linux, so anything we do in the core would have to be pretty generic.  I'm sure this is all obvious, so I apologize for restating it.  I'm just not sure what the concrete details should look like.
> 
> > The callers benefit by only requiring a simple check of the return 
> > status code from the API (which many are already doing).
> 
> Very roughly, I'd guess about 10% of current Linux callers check the status code:
> 
>   $ git grep "pci_read_config" | wc -l
>   2922
>   $ git grep "pci_read_config" | egrep "if \(pci| = pci" | wc -l
>   219
> 
> But I certainly agree that the current API is hard for callers to deal with.
> 
> > Having the check for a removed device before reading config space will 
> > result in correctly returning an error for most failures of this 
> > nature.  There is a race condition even with this patch, however.  If 
> > the device is present when the check occurs, but is removed just after 
> > that and before the config read goes out, the config routine can still 
> > return bad data without an error status return code.  To eliminate 
> > this race condition where bad data is returned, I think that config 
> > read routines will need to have a check *after* reading the data in 
> > addition to the check *before* reading.  The check after reading would 
> > need to determine if the data was synthesized and return and error 
> > status if so.
> > 
> > I'm interested in hearing what others think on returning an error for 
> > this case in the core config read APIs or any alternative ways to more 
> > gracefully handle these types of errors.
> 
> > 
> > Thanks,
> > Austin
