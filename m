Return-Path: <ddutile@redhat.com>
Return-Path: <ddutile@redhat.com>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20161102223552.14776-1-jthumshirn@suse.de>
 <20161102223552.14776-2-jthumshirn@suse.de>
 <20161109171140.GK14322@bhelgaas-glaptop.roam.corp.google.com>
 <20161114115604.gzxjstjj7vb4ytno@linux-x5ow.site>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
        Hannes Reinecke <hare@suse.de>
From: Don Dutile <ddutile@redhat.com>
Message-ID: <5829E373.1070901@redhat.com>
Date: Mon, 14 Nov 2016 11:16:51 -0500
MIME-Version: 1.0
In-Reply-To: <20161114115604.gzxjstjj7vb4ytno@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 11/14/2016 06:56 AM, Johannes Thumshirn wrote:
> On Wed, Nov 09, 2016 at 11:11:40AM -0600, Bjorn Helgaas wrote:
>> Hi Johannes,
>>
>> On Wed, Nov 02, 2016 at 04:35:52PM -0600, Johannes Thumshirn wrote:
>>> The Read Completion Boundary (RCB) bit must only be set on a device or
>>> endpoint if it is set on the root complex.
>>>
>>> Certain BIOSes erroneously set the RCB Bit in their ACPI _HPX Tables
>>> even if it is not set on the root port. This is a violation to the PCIe
>>> Specification and is known to bring some Mellanox Connect-X 3 HCAs into
>>> a state where they can't map their firmware and go into error recovery.
>>>
>>> BIOS Information
>>> 	Vendor: IBM
>>> 	Version: -[A8E120CUS-1.30]-
>>> 	Release Date: 08/22/2016
>>
>> This seems like a pretty serious problem (sounds like maybe the HCA is
>> completely useless?)
>
> Correct.
>
>>
>> Can you point us at a bugzilla or other problem report?  It's nice to
>> have details of what this looks like to a user, so people who trip
>> over this problem have a little more chance of finding the solution.
>
> As we already said, our bugzilla entry for this is not accessible from the
> outside, but I know Red Hat does have a bugzilla entry for the same issue as
> well. Maybe this is reachable from the outside (adding Don for this, as I know
> he has worked on this problem as well).
>
RHEL bz's are not accessible from the outside.
I suggest capturing the content of the RH bz issue and creating a k.o. bz
with the information.

>>
>> 7a1562d4f2d0 ("PCI: Apply _HPX Link Control settings to all devices
>> with a link") appeared in v3.18, so it's probably not a *new* problem,
>> so my guess is that this is v4.10 material.
>
> Yes 4.10 sounds good to me. I personally think, this problem hasn't
> materialized yet, as this is the kind of hardware you run on a rather /stable/
> kernel either you built on your own or get from an enterprise distribution and
> until recently these kernels haven't been updated to something newer than
> 3.18.
>
> Thanks,
> 	Johannes
>
