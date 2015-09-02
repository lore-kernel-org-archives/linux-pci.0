Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35689 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070AbbIBVWF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Sep 2015 17:22:05 -0400
Received: by ioiz6 with SMTP id z6so36005763ioi.2
        for <linux-pci@vger.kernel.org>; Wed, 02 Sep 2015 14:22:04 -0700 (PDT)
Date: Wed, 2 Sep 2015 16:21:59 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add support for Enhanced Allocation devices
Message-ID: <20150902212159.GC829@google.com>
References: <1440089947-2839-1-git-send-email-sean.stalley@intel.com>
 <1440089947-2839-3-git-send-email-sean.stalley@intel.com>
 <CAE9FiQUQacSJXPqv9GQJ4AF0TN7uxcBiAYHVbHwvFhEfWgWKHg@mail.gmail.com>
 <20150902174612.GA2700@sean.stalley.intel.com>
 <CAErSpo4qZ9AXskyo86gXG1cb3AqCn-HB05nj7qT9wovZdLt2Tg@mail.gmail.com>
 <20150902200127.GA3347@sean.stalley.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150902200127.GA3347@sean.stalley.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 02, 2015 at 01:01:27PM -0700, Sean O. Stalley wrote:
> On Wed, Sep 02, 2015 at 02:25:50PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 2, 2015 at 12:46 PM, Sean O. Stalley <sean.stalley@intel.com> wrote:
> > 
> > > Would it be better to modify pci_claim_resource() to support EA instead of adding pci_ea_claim_resource()?
> > > That way, EA entries would be claimed at the same time as traditional BARs.
> > 
> > Yes, I think so.
> 
> Ok, I'll make it work this way in the next patchset.
> 
> > Why wouldn't pci_claim_resource() work as-is for EA?  I see that
> > pci_ea_get_parent_resource() defaults to iomem_resource or
> > ioport_resource if we don't find a parent, but I don't understand why
> > that's necessary.
> 
> EA resources may (or may not) be in the parent's range[1].
> If the parent doesn't describe this range, we want to default to the top-level resource.
> Other than that case, I think pci_claim_resource would work as-is.
> 
> -Sean
> 
> [1] From the EA ECN:
> For a bridge function that is permitted to implement EA based on the rules above, it is
> permitted, but not required, for the bridge function to use EA mechanisms to indicate
> resource ranges that are located behind the bridge Function (see Section 6.9.1.2).

[BTW, in EA ECN 23_Oct_2014_Final, this text is in sec 6.9, not 6.9.1.2]

I agree that it implies EA resources need not be in the parent's *EA*
range.  But I would read it as saying "a bridge can use either the
usual window registers or EA to indicate resources forwarded
downstream."

What happens in the following case?

  00:00.0: PCI bridge to [bus 01]
  00:00.0:   bridge window [mem 0x80000000-0x8fffffff]
  01:00.0: EA 0: [mem 0x90000000-0x9000ffff]

The 00:00.0 bridge knows nothing about EA.  The 01:00.0 EA device has
a fixed region at 0x90000000.  The ECN says:

  System firmware/software must comprehend that such bridge functions
  [those that are permitted to implement EA] are not required to
  indicate inclusively all resources behind the bridge, and as a
  result system firmware/software must make a complete search of all
  functions behind the bridge to comprehend the resources used by
  those functions.

A bridge was never required to indicate, e.g., via its window
registers, anything about the resources behind it.  Software always
had to search behind the bridge and look at all the downstream BARs.
What's new here is that software now has to look for downstream EA
entries in addition to BARs, and the EA entries are at fixed
addresses.

My question is what the implication is for address routing performed
by the bridge.  The EA ECN doesn't mention any changes there, so I
assume it is software's responsibility to reprogram the 00:00.0 mem
window so it includes [mem 0x90000000-0x9000ffff].

If software does have to reprogram that window, the normal
pci_claim_resource() should work.  If it doesn't have to reprogram the
window, and there's some magical way for 01:00.0 to work even though
we don't route address space to it, I suspect we'll need significantly
more changes than just pci_ea_claim_resource(), because then 00:00.0
is really not a PCI bridge any more.

Bjorn
