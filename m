Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46711 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497Ab2HURqp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 21 Aug 2012 13:46:45 -0400
Received: by lagy9 with SMTP id y9so46529lag.19
        for <linux-pci@vger.kernel.org>; Tue, 21 Aug 2012 10:46:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50332c92.e8b8320a.348c.782bSMTPIN_ADDED@mx.google.com>
References: <1345470395-17295-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1345470395-17295-6-git-send-email-shangw@linux.vnet.ibm.com> <50332c92.e8b8320a.348c.782bSMTPIN_ADDED@mx.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 21 Aug 2012 11:46:23 -0600
Message-ID: <CAErSpo52A78NbvtJxW8oYJ3LKXc4NQe4CrLs-V2kNUaU=LzmdQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] pci: resource assignment based on p2p alignment
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	weiyang@linux.vnet.ibm.com, linuxram@us.ibm.com, yinghai@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 21, 2012 at 12:36 AM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
>
> Last night, I talked to Bjorn through IRC. It seems that Bjorn still have
> concerns on what we're doing in function pcibios_window_alignment() and
> pcibios_align_resource(). Another question that Bjorn has is that's possible
> to put the PPC alignment (alignment on p2p memory windows) to pcibios_align_resource().
> Actually, I've replied to that before and it seems the reply was lost again.

It's not that I missed the previous discussion, it's just that I
didn't think we had come up with a clear explanation for why we needed
two kinds of alignment hooks and a way to decide when to use one vs.
the other.  It might be clear in *your* head, but it's not clear to me
yet :)

> Anyway, here's the full message about the discussion.
>
> https://patchwork.kernel.org/patch/1203171/
>
>>> Hmm..'struct resource *window' may not yet know which aperature it is
>>> allocated from. Will it? We are still in the sizing process, the allocation will
>>> be done much later.
>>
>> Of course, you're absolutely right; I had this backwards.  In
>> pbus_size_io/mem(), we do "b_res = find_free_bus_resource()", so b_res
>> is a bus resource that matches the desired type (IO/MEM).  This
>> resource represents an aperture of the upstream bridge leading to the
>> bus.  I was thinking that b_res->start would contain address
>> information that the arch could use to decide alignment.
>>
>> But at this point, in pbus_size_io/mem(), we set "b_res->start =
>> min_align", so obviously b_res contains no information about the
>> window base that will eventually be assigned.  I think b_res is
>> basically the *container* into which we'll eventually put the P2P
>> aperture start/end, but here, we're using that container to hold the
>> information about the size and alignment we need for that aperture.
>>
>> The fact that we deal with alignment in pbus_size_mem() and again in
>> __pci_assign_resource() (via pcibios_align_resource) is confusing to
>> me -- I don't have a clear idea of what sorts of alignment are done in
>> each place.  Could this powerpc alignment be done in
>> pcibios_align_resource()?  We do have the actual proposed address
>> there, as well as the pci_dev.
>
> Currently, we have 2 phases for resourece reallocation. During the first
> phase that is being covered by function pbus_size_io() and pbus_size_mem(),
> the PCI hierarchy tree is scanned from bottom to top so that we can reserve
> enough resources in p2p I/O or memory windows for its child devices (including
> child p2p bridge possiblly). During the time, pcibios_window_alignment() will
> be called to determine the minimal alignment of the p2p windows (I/O or memory)
> so that the p2p windows could be aligned to what the specific platform requires.
>
> In the 2nd phase, the resources of p2p windows as well as PCI devices will
> be allocated. That will be done according to the PCI hierarchy tree from top
> to bottom. During the period, function pcibios_align_resource() will be called
> to do _little_ adjustment on those resources that have special requirments. If
> I understood correctly, it's unsafe to change the resource size (or start address)
> greatly.
>
> Lets have one example here for more explanation on why it's unsafe to change
> the resource size (or start address) greatly by pcibios_align_resource(). As
> the following figure shows, we have 2 p2p bridges (A, B) and another one PCI
> device (C). The memory resources they're owning are shown below them after the
> phase one. Now, we're running in phase 2 (resource allocation) for (B) when the
> allocation on resources of (A) should have done because phase 2 is expected to
> be done from top to bottom of the PCI tree. It is impossible to extend the resource
> of (B) for another one 1MB to [0x100000, 0x2fffff] through pcibios_align_resource()
> since (C) needs some resources as well. The cause is that we never did enough resource
> reservation for (A) during phase 1. So pcibios_align_resource() isn't safe enough to
> cover the PowerPC alignment we requires, but pcibios_window_alignment() can accomodate
> that very well :-)
>
>                 [ p2p bridge A ]
>                 [0x100000, 0x2fffff]
>                       |
>         ---------------------------------
>         |                               |
>       [ p2p bridge B ]              [ PCI dev C]
>       [0x100000, 0x1fffff]
>
> In summary, pcibios_window_alignment() takes affect in phase 1 (resource reservation),
> but pcibios_align_resource() will function in phase 2 (resource allocation). They're
> different.

This is a good start.  You're saying that "large" alignments must be
done in phase 1 with pcibios_window_alignment() and
pcibios_align_resource() can do "small" adjustments in phase 2.  How
do we quantify that?  *Can* it be quantified?

I think pcibios_align_resource() is primarily used to deal with
devices that only do partial decoding, e.g., ISA 10-bit I/O port
resources.  By the time we call it, I think the upstream aperture has
already been determined, so the allocation may fail completely.

It seems like we can't accurately do even the resource reservation
part without knowing what pcibios_align_resource() is going to do.

Bjorn
