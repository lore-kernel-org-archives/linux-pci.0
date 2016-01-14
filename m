Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:64601 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756237AbcANXFr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 18:05:47 -0500
Date: Thu, 14 Jan 2016 15:02:15 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	david.daney@cavium.com
Subject: Re: [RFC PATCH] pci: Identify Enhanced Allocation (EA) BAR
 Equivalent resources
Message-ID: <20160114230214.GA3700@sean.stalley.intel.com>
References: <20160114172645.23429.9938.stgit@gimli.home>
 <20160114183452.GA3075@sean.stalley.intel.com>
 <1452798962.14628.52.camel@redhat.com>
 <20160114202347.GB3381@sean.stalley.intel.com>
 <1452806092.14628.110.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1452806092.14628.110.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 14, 2016 at 02:14:52PM -0700, Alex Williamson wrote:
> On Thu, 2016-01-14 at 12:23 -0800, Sean O. Stalley wrote:
> > On Thu, Jan 14, 2016 at 12:16:02PM -0700, Alex Williamson wrote:
> > > On Thu, 2016-01-14 at 10:34 -0800, Sean O. Stalley wrote:
> > > > On Thu, Jan 14, 2016 at 10:26:56AM -0700, Alex Williamson wrote:
> > > > > We've done a pretty good job of abstracting EA from drivers, but
> > > > > there
> > > > > are some properties of BAR Equivalent resources that don't really
> > > > > jive
> > > > > with traditional PCI BARs.  In particular, natural alignment is
> > > > > only
> > > > > encouraged, not required.
> > > > > 
> > > > > Why does this matter?  There are drivers like vfio-pci that will
> > > > > happily gobble up the EA abstraction that's been implemented and
> > > > > expose a device using EA to userspace as if those resources are
> > > > > traditional BARs.  Pretty cool.  The vfio API is bus agnostic, so
> > > > > it
> > > > > doesn't care about alignment.  The problem comes with PCI config
> > > > > space
> > > > > emulation where we don't let userspace manipulate the BAR value,
> > > > > but
> > > > > we do emulate BAR sizing.  The abstraction kind of falls apart if
> > > > > userspace gets garbage when they try to size what appears to be a
> > > > > traditional BAR, but is actually a BAR equivalent.
> > > > > 
> > > > > We could simply round up the size in vfio to make it naturally
> > > > > aligned, but then we're imposing artificial sizes to the user and
> > > > > we
> > > > > have the discontinuity that BAR size emulation and vfio region size
> > > > > reporting don't agree on the size.  I think what we want to do is
> > > > > expose EA to the user, reporting traditional BARs with BEIs as
> > > > > zero-sized and providing additional regions for the user to access
> > > > > each EA region, whether it has a BEI or not.
> > > > > 
> > > > > To facilitate that, a flag indicating whether a PCI resource is a
> > > > > traditional BAR or BAR equivalent seems much nicer than attempting
> > > > > to size the BAR ourselves or deducing it through the EA capability.
> > > > 
> > > > If vfio does size the resource, EA entries that are aligned could
> > > > still be emulated as BARs, correct?
> > > > 
> > > > I would think that emulating a BAR would be preferred when possible,
> > > > for backwards-compatibility.
> > > 
> > > If a BEI is naturally aligned, I can't think of any problems with
> > > exposing it as a traditional BAR to userspace.  I agree that there may
> > > be some compatibility benefits there, so it may be useful to offer both
> > > options.  I don't think we can combine them though, it would violate
> > > the EA spec to expose the traditional BAR and and the matching BEI.
> > > We'd either need to hide the fake BAR or hide the EA entry defining
> > > that BEI.  A module option could define which is preferred or maybe an
> > > ioctl.
> > 
> > Would any functionality be lost if vfio:
> > 	- emulates BARs & hide EA entry when EA resources are aligned.
> > 	- exposes EA entries when the resources aren't aligned (no BAR emulation).
> > ?
> > 
> > I'm just wondering if giving userspace the option to pick is necessary,
> > or if there is a setting that is always ideal.
> 
> That certainly might be a good default and the only use case I can
> think where it wouldn't be ideal is if we want to expose EA to a VM for
> the purpose of doing EA testing and development in a guest.  A module
> option would make more sense than defining a user interface for that
> case though.

The testing I have done for EA has been in a VM.
I sent out some patches a while back for QEMU that allow the user to add an EA entry to the existing PCI models.

[https://lists.nongnu.org/archive/html/qemu-devel/2015-07/msg00348.html]

I don't know if they will be useful for what you are doing, but they were very useful to me when doing the initial EA development.

-Sean
