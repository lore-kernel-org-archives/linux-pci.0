Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50611 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbcEWPHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 May 2016 11:07:16 -0400
Date: Mon, 23 May 2016 09:07:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
Message-ID: <20160523090711.12fa34f9@ul30vt.home>
In-Reply-To: <20160523105532.GB26331@infradead.org>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
	<20160517160832.51fc0304@t450s.home>
	<20160523105532.GB26331@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 23 May 2016 03:55:32 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, May 17, 2016 at 04:08:32PM -0600, Alex Williamson wrote:
> > On Tue, 17 May 2016 15:39:58 -0600
> > Keith Busch <keith.busch@intel.com> wrote:
> >   
> > > Every sriov capable driver has to check if any guest is using a virtual
> > > function prior to disabling, so let's make it common code.  
> > 
> > This is not true, the PCI_DEV_FLAGS_ASSIGNED flag is inherently racy,
> > so checking it is really only a courtesy for broken drivers that
> > still make use of it.  I don't object to adding it here, though I
> > wish the entire interface was deprecated, but it's only a minimal amount
> > of insurance as a VF might get assigned immediately following your added
> > test or might not participate in the assigned device flagging at all.  
> 
> Si should we just kill it? As far as I can tell it's only used in these
> kinds of boilerplate checks.

Long term, yes, but perhaps KVM legacy PCI device assignment needs to
be not only deprecated, but removed first.

> > I
> > believe the better way to handle this is with proper host drivers for
> > assigned devices that manage the driver .remove callback properly while
> > devices are in use.  The only reason to handle assigned devices
> > specially in this case is when they don't have proper host drivers
> > managing them, which is a problem that we've fixed.  Thanks,  
> 
> We always use pci-stub now, don't we?

pci-stub's only purpose is to prevent other drivers from binding to a
device, such as while it's in used by legacy KVM device assignment.
pci-stub has no visibility whether a device is in use or not, and will
happily unbind the device at any point in time.  Thus legacy KVM device
assignment with pci-stub makes use of this horrible flag in a vain
attempt to prevent devices from disappearing, littering every possible
remove path with these sorts of checks when really the driver holding
the assigned device should block or maybe allow an error return from
the .remove callback.  Xen pci-back also sets this flag, but I would
hope there's a sensible solution available there and they just adopted
use of this flag without really questioning that it works or makes
sense. Thanks,

Alex
