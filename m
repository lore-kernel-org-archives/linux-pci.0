Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2039 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbbJEXHm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 5 Oct 2015 19:07:42 -0400
Date: Mon, 5 Oct 2015 16:05:05 -0700
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Daney <ddaney.cavm@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-api@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v4 0/5] PCI: Add support for PCI Enhanced Allocation
 "BARs"
Message-ID: <20151005230505.GD4821@sean.stalley.intel.com>
References: <1443825476-26880-1-git-send-email-ddaney.cavm@gmail.com>
 <CAE9FiQXT0ux42gQ+DhpVv2K=BR4jC++LmNdCSLiK4Wy0BhL=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAE9FiQXT0ux42gQ+DhpVv2K=BR4jC++LmNdCSLiK4Wy0BhL=HQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 02, 2015 at 08:16:48PM -0700, Yinghai Lu wrote:
> On Fri, Oct 2, 2015 at 3:37 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> > From: David Daney <david.daney@cavium.com>
> >
> > PCI Enhanced Allocation is a new method of allocating MMIO & IO
> > resources for PCI devices & bridges. It can be used instead
> > of the traditional PCI method of using BARs.
> >
> > EA entries are hardware-initialized to a fixed address.
> > Unlike BARs, regions described by EA are cannot be moved.
> > Because of this, only devices which are permanently connected to
> > the PCI bus can use EA. A removable PCI card must not use EA.
> >
> > The Enhanced Allocation ECN is publicly available here:
> > https://www.pcisig.com/specifications/conventional/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf
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

This might be useful for fixed resources as well.

For some BEI values, EA allows for an arbitrary number of EA entries.
For PF & VF resource ranges, it allows 2 ranges.
(one below the 4GB boundry, and one above).
I don't think the current pci_dev struct can handle that many resources.

-Sean
