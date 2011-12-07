Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41970 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757933Ab1LGTL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2011 14:11:59 -0500
MIME-Version: 1.0
In-Reply-To: <20111207163842.GC29680@amd.com>
References: <CALRxmdDS4qas9fyHXeDVw2e_yMCTqzMi6VXUF-q+eYwgMwg7tw@mail.gmail.com>
	<20111207163842.GC29680@amd.com>
Date: Wed, 7 Dec 2011 13:11:58 -0600
Message-ID: <CALRxmdDgfzZOPCnJeN2vOTkvpqFbyPEeCF4bbq5QW2iCoVKgCw@mail.gmail.com>
Subject: Re: vfio / iommu domain attributes
From: Stuart Yoder <b08248@gmail.com>
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>, aafabbri@cisco.com,
	kvm@vger.kernel.org, pmac@au1.ibm.com, qemu-devel@nongnu.org,
	konrad.wilk@oracle.com, agraf@suse.de, dwg@au1.ibm.com,
	chrisw@sous-sol.org, B08248@freescale.com,
	iommu@lists.linux-foundation.org, avi@redhat.com,
	linux-pci@vger.kernel.org, B07421@freescale.com, benve@cisco.com,
	benh@kernel.crashing.org,
	David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 7, 2011 at 10:38 AM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> On Wed, Dec 07, 2011 at 09:54:39AM -0600, Stuart Yoder wrote:
>> Alex, Alexey I'm wondering if you've had any new thoughts on this over
>> the last week.
>>
>> For Freescale, our iommu domain attributes would look something like:
>>     -domain iova base address
>>     -domain iova window size
>
> I agree with that.
>
>>     -domain enable/disable
>>     -number of subwindows
>>     -operation mapping table index
>>     -stash destination CPU
>>     -stash target (cache– L1, L2, L3)
>
> Why does the user of the IOMMU-API need to have control over these
> things?

Our IOMMU complicates things in that it is used for more than just
memory protection
and address translation.  It has a concept of operation translation as well.
Some devices could do a 'write' transaction that when passing through the
iommu gets translated to a a 'write-with-stash'.   Stashed transactions
get pushed directly into some cache.

It's the entity creating and setting up the domain that will have the knowledge
of what cache is to be stashed to.    Right now software that uses stashing
is pinned to a CPU, but if in the future it's possible that we'll want to
work without pinning and may need to update stashing attributes on the
fly.

The overall iova window for the domain can be divided into a configurable
number of subwindows (a power of 2, up to 256), which means we can have
a contiguous iova region backed by up to 256 physically dis-contiguous
subwindows.    The creator of the iommu domain is in the best position
to know how many subwindows are needed (the fewer the better for
performance reasons).

So, in short, the above list of attributes are the attributes of our
iommu hardware
and  the knowlege of how they should be set is with the domain creator.

>> These are all things that need to be set by the creator of the domain.
>>
>> Since the domain attributes are going to be so different for each platform does
>> it make sense to define a new iommu_ops call back that just takes a void pointer
>> that can be implemented in a platform specific way?   For example:
>>
>>     struct iommu_ops {
>>         [cut]
>>         int (*domain_set_attrs)(struct iommu_domain *domain,
>>                               void *attrs);
>>         int (*domain_get_attrs)(struct iommu_domain *domain,
>>                               void *attrs);
>>     }
>
> A void pointer is certainly the worst choice for an interface. I think
> it is better to have at least a set of common attributes. Somthing like
> this:
>
> iommu_domain_set_attr(struct iommu_domain *domain, enum attr_type, void *data)
> iommu_domain_get_attr(struct iommu_domain *domain, enum attr_type, void *data)

That would be fine.

Stuart
