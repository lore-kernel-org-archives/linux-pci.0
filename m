Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43736 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbcAUPWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Jan 2016 10:22:40 -0500
Date: Thu, 21 Jan 2016 09:22:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH] pci: Add support for multiple DMA aliases
Message-ID: <20160121152236.GA6629@localhost>
References: <1453118346-76897-1-git-send-email-jacek.lawrynowicz@intel.com>
 <1453133267-79756-1-git-send-email-jacek.lawrynowicz@intel.com>
 <20160119033315.GA6510@localhost>
 <20160119201254.GB6510@localhost>
 <1453237471.32741.267.camel@redhat.com>
 <20160119213901.GG14080@localhost>
 <36D38C1F74839847A52A484C31F3E51A62131B9D@irsmsx105.ger.corp.intel.com>
 <20160120174622.GC7973@localhost>
 <1453369141.4639.73.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453369141.4639.73.camel@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 21, 2016 at 09:39:01AM +0000, David Woodhouse wrote:
> On Wed, 2016-01-20 at 11:46 -0600, Bjorn Helgaas wrote:
> > 
> > I don't really want to merge things that only exist to enable
> > out-of-tree development, because (1) they're an extra maintenance
> > burden for which we get risk without benefit, and (2) we can't see
> > the out-of-tree code, so it's easy for people to make changes that
> > accidentally break that code.
> > 
> > Looking at the patch again, I see that even without the export,
> > there's no current benefit,
> 
> This is just a PCI quirk; I'm not sure it should be considered part of
> the driver code at all. With this patch, even without a Linux driver,
> we could correctly handle assignment to VM guests (which *might* have a
> driver), and also theoretically we should be able to handle fault
> storms and shoot the right device in the head if it was left in an odd
> state and misbehaves (not that I've hooked that up yet).
> 
> So I'm not sure it makes sense to tie this patch to the existence of a
> driver.

This definitely isn't part of the driver code; I didn't mean to
suggest that.  I'd like to see this as a separate patch, but as part
of a series that adds a user of the multiple-alias functionality.

All I'm saying is that as-is, this patch makes the quirks easier to
read but doesn't actually change any behavior: we set up at most one
alias, and we do it as a header quirk at enumeration-time, so there
are no new lifetime issues.  Normally we merge things when they're
needed, and multiple alias support is a bit of infrastructure that
isn't used yet.

I already said I'm not rejecting the patch.  Alex and I raised a few
questions.  Usually that leads to a little discussion and possibly a
v2 of the patch, but so far, I haven't seen any answers.

Here are a couple more questions/concerns:

  - If we export an "add" function, do we need a corresponding
    "remove"?  This depends on how the alias lifetimes are managed,
    and I haven't seen that yet.

  - Changing pci_dev_flags and struct pci_dev changes the ABI and makes
    work for distros, with no current benefit.

I'm not sure why we're even having this discussion.  The merge window
opened Jan 10, and IIRC, I first saw the patch Jan 11 and it first
appeared on linux-pci Jan 13, so this is just late for v4.5 to begin
with.  

Bjorn
