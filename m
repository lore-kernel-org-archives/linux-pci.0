Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0067.outbound.protection.outlook.com ([65.55.169.67]:11712
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750879AbbJEQtw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 12:49:52 -0400
Message-ID: <5612AA26.90607@caviumnetworks.com>
Date: Mon, 5 Oct 2015 09:49:42 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"Sean O. Stalley" <sean.stalley@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	<linux-api@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/5] PCI: Add support for PCI Enhanced Allocation "BARs"
References: <1443825476-26880-1-git-send-email-ddaney.cavm@gmail.com> <CAE9FiQXT0ux42gQ+DhpVv2K=BR4jC++LmNdCSLiK4Wy0BhL=HQ@mail.gmail.com>
In-Reply-To: <CAE9FiQXT0ux42gQ+DhpVv2K=BR4jC++LmNdCSLiK4Wy0BhL=HQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/02/2015 08:16 PM, Yinghai Lu wrote:
> On Fri, Oct 2, 2015 at 3:37 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> PCI Enhanced Allocation is a new method of allocating MMIO & IO
>> resources for PCI devices & bridges. It can be used instead
>> of the traditional PCI method of using BARs.
>>
>> EA entries are hardware-initialized to a fixed address.
>> Unlike BARs, regions described by EA are cannot be moved.
>> Because of this, only devices which are permanently connected to
>> the PCI bus can use EA. A removable PCI card must not use EA.
>>
>> The Enhanced Allocation ECN is publicly available here:
>> https://www.pcisig.com/specifications/conventional/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf
>
> Looks like the EA will support more than just fixed address later.
>
> "Enhanced Allocation is an optional Conventional PCI Capability that
> may be implemented by
> Functions to indicate fixed (non reprogrammable) I/O and memory ranges
> assigned to the
> Function, as well as supporting new resource “type” definitions and
> future extensibility to also
> support reprogrammable allocations."
>
> so I would prefer to think more to make frame configurable to leave
> space for that.

I disagree.  Currently we know of no use case other than devices with 
fixed address BARs and bridges to buses containing such devices.

Since we have no idea what these future types of EA entries might look 
like, it is impossible to design a framework to handle them.  Since we 
cannot design the framework, it seems like insisting on the creation of 
a framework is the equivalent of refusing to handle EA.

We have today, actual hardware with configuration space that contains 
the EA entries defined by the specification.  We know how to handle 
these, it can be done with this patch set.

I have no objection to changing the patches so that they fit better with 
the core PCI code.  In fact, I fully expect to do so based on feedback I 
receive.

For the record the general idea is this:  IORESOURCE_PCI_FIXED already 
does almost exactly what we need for EA, there are only a couple of 
places where we need to fix things for it to work well with the 
pci-host-generic driver.  If we fix these few issues with 
IORESOURCE_PCI_FIXED, then EA is supported.  It also makes doing similar 
things by setting the IORESOURCE_PCI_FIXED in a "header" fixup.  I don't 
think it make sense to invent an additional flag for fixed EA resources, 
as it would just be a duplicate of IORESOURCE_PCI_FIXED.

David Daney

>
> Bjorn,
>
> I wonder if we need to revive the add-on resource support patchset
> that i suggested couple years ago,
> so we can extend it to support EA features.
>
> URL: https://lkml.org/lkml/2012/3/19/86
>
> Thanks
>
> Yinghai
>

