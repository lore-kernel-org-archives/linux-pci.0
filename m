Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:56786 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaBSA2S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Feb 2014 19:28:18 -0500
Received: by mail-ob0-f180.google.com with SMTP id wp4so19505618obc.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2014 16:28:18 -0800 (PST)
Date: Tue, 18 Feb 2014 17:28:14 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Liviu Dudau <liviu@dudau.co.uk>,
	linux-arm-kernel@lists.infradead.org,
	Will Deacon <will.deacon@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
Message-ID: <20140219002814.GD8786@google.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <5805232.JrD2FybBlg@wuerfel>
 <20140214220047.GA5394@bart.dudau.co.uk>
 <2312919.pM61KLBcYY@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2312919.pM61KLBcYY@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 15, 2014 at 02:03:26PM +0100, Arnd Bergmann wrote:
> On Friday 14 February 2014 22:00:47 Liviu Dudau wrote:
> > 
> > What I'm going to suggest in my v2 patch (hope to send it before Monday)
> > is a new API in the generic PCI code that will allow you to create a
> > host bridge in a new domain or in the existing domain, with the management
> > of the domain number being done in the generic code.
> > 
> > Something like:
> > 
> >   int create_hostbridge_in_new_domain(....);
> >   int create_hostbridge(....);
> > 
> > with the functions being wrappers around the pci_hostbridge_of_init function
> > that I'm introducing.
> > 
> > What do you think?
> 
> Not sure. It would still keep the decision about whether to use a
> new domain or not in the host bridge driver, but that doesn't seem
> like the right place. The same driver might be used in different
> ways based on what is around it.
> 
> I've also had a look at the MIPS implementation now, which has its
> own way of dealing with this, see arch/mips/pci/pci.c.
> 
> There was also an interesting comment in the MIPS header file:
> 
>         /* For compatibility with current (as of July 2003) pciutils
>            and XFree86. Eventually will be removed. */
>         unsigned int need_domain_info;
> 
> This is over ten years old, so I wonder if we can start assuming that
> domains work out of the box now. All references to problems from 
> PCI domains are about old code (ca. pre-2007) that doesn't understand
> nonzero domains and that has since been fixed. I am pretty sure we
> don't need to ever worry about stuffing multiple host bridges into
> a domain other than the first one, and I also doubt we have to worry
> about the problem at all on arm64 as we won't run old binaries on it
> (or arm32 compat mode binaries that need to manage PCI devices).
> 
> Can anyone with more experience on the subject than me (Bjorn,
> Russell, Jason, ...) think of a reason why we would not want to
> just use a new domain for every host bridge we find?

With ACPI on x86 and ia64, we currently use _SEG directly as the Linux
PCI domain.  Are you proposing that we make the Linux PCI domain
independent of _SEG?

It will look sort of funny to have things like this:

  ACPI: PCI Root Bridge [L000] (_SEG 0 domain 0000 [bus 00-1b])
  ACPI: PCI Root Bridge [L001] (_SEG 0 domain 0001 [bus 1c-37])
  ACPI: PCI Root Bridge [L002] (_SEG 0 domain 0002 [bus 38-53])

where the firmware had _SEG==0 for all the bridges and assigned
non-overlapping bus number ranges, but since nothing in PCI really
depends on the domain, I guess it should work.

Bjorn
