Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:53274 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753596AbcITVZK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Sep 2016 17:25:10 -0400
Message-ID: <1474406676.2857.84.camel@kernel.crashing.org>
Subject: Re: [Discussion] PCI Resource Resizing & Assignment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, yinghai@kernel.org
Cc: bhelgaas@google.com, ruscur@russell.cc, linux-pci@vger.kernel.org
Date: Wed, 21 Sep 2016 07:24:36 +1000
In-Reply-To: <20160920023328.GA8527@gwshan>
References: <20160920023328.GA8527@gwshan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-09-20 at 12:33 +1000, Gavin Shan wrote:
> Hi Yinghai,
> 
> The purpose of this is going to have some discussion on current PCI resource
> resizing and assignment implementation, mainly related to __pci_bus_size_bridges()
> and pbus_size_mem().
> 
> In current implementation, all 64-bits and prefetchable BARs are going to be covered
> by 64-bits and prefetchable bridge windows, and all other types of BARs are covered
> by 32-bits bridge windows. It means 64-bits and non-prefetchable BARs are assigned
> from 32-bits bridge windows which is usually limited and 2GB on our PowerNV platform.

Just to clarify, Gavin means "all 64-bit prefetchable" BARs are
assigned to 64-bit prefetchable bridge windows while 64-bit non-
prefetchable BARs are stuck behind 32-bit bridge windows.

This isn't so much a limitation of the PowerNV platform but of the fact
that the bridges don't have 64-bit windows that aren't also
prefetchable.

However, PCIe allows to break this, as Gavin explains below:

> It seems the attribute ("prefetchable") plays important role in the design so that
> the final resource layout is compatible with: non-prefetchable BARs cannot be covered
> by prefetchable bridge windows.

That used to be true on PCI/PCI-X where bridges were allowed to
aggressively prefetch (or under some circumstances the PCI host bridge
itself).

>  It seems that's not true any more in PCI express domain,
> meaning non-prefetchable BARs can live under prefetchable bridge windows.

That is correct, at least as long as the host bridge allows it (it may
still have a window where it performs some kind of prefetching in which
case it musn't allow it, so whatever we do needs to be driven by some
kind of flag/attribute).

>  If so, I
> think the "prefetchable" attribute isn't important and shouldn't affect the implementation
> so much as we had. 

It is still important to the final device driver in that the
prefetchable attribute of the BAR itself does provide important
information about the kind of mapping that can be done for that BAR.
Some drivers might rely on this. For example, the userspace mappings
via sysfs on power will create a more relaxed mapping (without the
Guarded bit) if you mmap a BAR that has prefetchable set.

However we would like a way to make it irrelevant to the resource
allocation scheme as long as we are in PCIe-domain from the root. Of
course the minute we cross a bridge to another domain, the attribute
needs to become relevant again.

> PCI/PCIx domain still have the problem: non-prefetchable BARs cannot
> live behind a prefetchable bridge window. Apart from PCI/PCIx, we
> probably need enhance
> current implementation for PCIe domain: 64-bits BARs are covered by
> 64-bits bridge windows
> and 32-bits BARs are covered by 32-bits bridge windows, meaning the
> attribute "prefetchable"
> won't have effect during resizing/assignment in PCIe domain. We will
> benefit from the
> enhancement: (A) 64-bits non-prefetchable BARs will be covered by 64-
> bits prefetchable
> bridge windows instead of 32-bits bridge windows, avoid 32-bits
> resource to be exhausted
> quickly. (B) VFs whose BARs isn't 64-bits and prefetchable cannot be
> enabled on PowerNV
> > platform. It's not a issue with this enhancement.

Right, this is definitely a problem for us with SR-IOV.
> 
> The situation becomes complicated when we have combination of PCIe
> and PCI/PCIx domains.
> We still need follow the rule in this scenario: non-prefetchable BARs
> cannot be covered
> by prefetchable bridge windows. It might be more complicated with PCI
> hotplug is under
> consideration. However, the platform (e.g. PowerNV) could have clear
> idea if PCI/PCIx
> is going to be supported on particular PHB. I think the above
> enhancement can be applied
> if PCI/PCIx won't be supported on particular PHB.
> 
I don't think the combination is a problem. When assigning the
resources under a given bridge we know if that bridge is PCIe or not
and can decide what logic to apply to it at that point in the
hierarchy.

Since this only affect device BARs (as bridge windows can only be
either 32-bit or 64-bit prefetchable anyway), I believe the only issue is when assigning BARs at a given level, whether the bus they sit on is PCIe or PCI/PCI-X. The rest of hierarchy shouldn't matter.

Cheers,
Ben.

