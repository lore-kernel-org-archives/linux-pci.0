Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.hostfission.com ([139.99.139.48]:33642 "EHLO
        mail1.hostfission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXW3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jan 2018 17:29:01 -0500
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] Restore PCI bridge configuration space on bridge reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 25 Jan 2018 09:28:59 +1100
From: geoff@hostfission.com
Cc: linux-pci@vger.kernel.org, suravee.suthikulpanit@amd.com,
        Gary R Hook <gary.hook@amd.com>
In-Reply-To: <20180124141051.733f7b28@w520.home>
References: <0986ad77b71f3b8e0a17f79e238d1ebc@hostfission.com>
 <20180124141051.733f7b28@w520.home>
Message-ID: <745998038463da91584ef51dfc8ffcac@hostfission.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-25 08:10, Alex Williamson wrote:
> On Wed, 24 Jan 2018 19:02:33 +1100
> geoff@hostfission.com wrote:
> 
>> According to PCI-to-PCI Bridge Architecture Specification 3.2.5.17
> 
> Correction, rev 1.2 section 3.2.5.18, in reference to the secondary bus
> reset bit in the bridge control register.
> 

Thanks, I will make this correction if the patch is deemed valid re 
below.
Please excuse any confusing terminology/wording, I am still coming to
terms with how PCI operates.

>> > The bridge’s secondary bus interface and any buffers between
>> > the two interfaces (primary and secondary) must be initialized
>> > back to their default state whenever this bit is set.
>> 
>> Failure to observe this causes inability to access devices on the
>> secondary bus
>> on the AMD Threadripper platform after device reset when the device is
>> being
>> used for PCI passthrough with KVM.
>> 
>> The following patch corrects this by saving the pci state and 
>> restoring
>> it after
>> the bus has been reset.
> 
> How do configuration registers on the primary bus interface fall into
> this requirement?  It's not very clear from the spec what these
> "buffers" are and the secondary interface has no configuration
> registers itself.  Figure 1-2 shows Transaction/Data Buffers which are
> clearly separate from the Primary Interface Configuration Registers.
> I'd tend to say this excerpt of the spec is describing a hardware
> requirement, not a software requirement.

These are not the configuration registers on the primary bus but on the
secondary bus, in the case of a TR system a "PCIe GPP Bridge" device is
created and the PCI device is placed under it. It is this bridge that
needs it's configuration space rewritten.

Unless I am mistaken, currently pci.c is inconsistent with secondary bus
resets as it is. In `pci_reset_bus` the bus configuration space is saved
via `pci_bus_save_and_disable`, the bus is reset, and then the 
configuration
is reloaded using `pci_bus_restore`.

`pci_try_reset_bus` is different again, in that it calls
`pci_reset_bridge_secondary_bus` also.

In short, it is already happening under certain circumstances, but 
because
on TR the CPU view of the PCI configuration space seems to be cached, it 
is
unable to determine the changes and thus a blind re-write is required.

> 
> I know that people have found that re-writing bridge registers on
> threadripper solves the reset problem, but this seems like a bit of a
> stretch to attribute it to this spec statement.  Maybe it can be
> handled via a quirk if AMD isn't planning to release firmware that
> resolves this issue?  AMD...  Thanks,
> 

I'd love to see this fixed in firmware/bios/microcode, etc... but as the
spec reads, it is unclear if this is a software or hardware requirement, 
IMO
it is a software requirement to reconfigure the configuration space of 
the
secondary bus, but my understanding of PCI at this time is quite new so 
I
am ready to accept a final decision by someone with more experience.
