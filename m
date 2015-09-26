Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44843 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbIZRHY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 26 Sep 2015 13:07:24 -0400
Date: Sat, 26 Sep 2015 13:07:21 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: create builtin_pci_driver to avoid registration
 boilerplate
Message-ID: <20150926170720.GA1279@windriver.com>
References: <1440548737-7465-1-git-send-email-paul.gortmaker@windriver.com>
 <20150915164642.GC25767@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150915164642.GC25767@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Re: [PATCH] PCI: create builtin_pci_driver to avoid registration boilerplate] On 15/09/2015 (Tue 11:46) Bjorn Helgaas wrote:

> Hi Paul,
> 
> On Tue, Aug 25, 2015 at 08:25:37PM -0400, Paul Gortmaker wrote:
> > In commit f309d4443130bf814e991f836e919dca22df37ae ("platform_device:
> > better support builtin boilerplate avoidance") we introduced the
> > builtin_driver macro.
> > 
> > Here we use that support and extend it to PCI driver registration,
> > so where a driver is clearly non-modular and builtin-only, we can
> > register it in a similar fashion.  And existing code that is clearly
> > non-modular can be updated with the simple mapping of
> > 
> >      module_pci_driver(...)  ---> builtin_pci_driver(...)
> > 
> > We've essentially cloned the former to make the latter, and taken
> > out the remove/module_exit parts since those never get used in a
> > non-modular build of the code.
> 
> Do you have any estimate of how many potential users of this there
> are?  I took a quick look at users of module_pci_driver() (I see
> almost 300 of them in v4.3-rc1), and most of them look like legitimate
> modules.  But the comment mentions replacing device_initcall() as
> well, so maybe there are more there?

It doesn't appear to be a lot; maybe a couple.  When I sent this, I had
not completed much of the treewide audit, nor strayed outside of x86,
but I sent it ahead of time since I was hoping to stage any
infrastructure patches like this ahead of conversions to avoid cross
subsystem dependencies.

> 
> If only a couple would be converted to builtin_pci_driver(), I'm not
> sure it's worth it, because it does add more things to look at
> (builtin_pci_driver() in addition to module_pci_driver()).

So the real goal I am after here, which may not have been clear from
this one stand-alone patch, is to ensure people have what they need to
make non-modular drivers clearly non-modular.  Currently we have about
300+ drivers/files including module.h and using modular registration
functions when they can only be built in.  And along with that is about
5k worth of dead code in exit / unregistration functions that never has
been used.

In which case, the numbers maybe don't matter.  If we have a specific
modular registration function for subsystem X, then we probably should
also have a non-modular/builtin parallel of the same thing.

However, since there are so few in PCI, I guess we could replace
non-modular users with it open coded, if you don't want to add the new
alias/macro, i.e.:

module_pci_driver(xyz) --> builtin_driver(xyz, pci_register_driver)


[...]

> > + * builtin_pci_driver() - Helper macro for registering a PCI driver
> > + * @__pci_driver: pci_driver struct
> > + *
> > + * Helper macro for PCI drivers which do not do anything special in their
> > + * init code. This eliminates a lot of boilerplate. Each driver may only
> > + * use this macro once, and calling it replaces device_initcall(...)
> 
> The builtin_platform_driver() patches I see are single-line patches,
> so they don't look like they remove a *lot* of boilerplate.

The comment applies here as much as it does to the same comment for the
module_pci_driver macro ; I'm assuming it was in reference to what it
would look like if none of the platform driver helper macros were used
and the whole thing was open coded.

Anyway, I'm open to suggestions here, now that you know the whole story.

Paul.
--

> 
> Bjorn
> 
> > + */
> > +#define builtin_pci_driver(__pci_driver) \
> > +	builtin_driver(__pci_driver, pci_register_driver)
> > +
> >  struct pci_driver *pci_dev_driver(const struct pci_dev *dev);
> >  int pci_add_dynid(struct pci_driver *drv,
> >  		  unsigned int vendor, unsigned int device,
> > -- 
> > 2.5.0
> > 
