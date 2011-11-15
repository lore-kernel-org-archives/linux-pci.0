Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65021 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755059Ab1KOCaI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Nov 2011 21:30:08 -0500
Message-ID: <1321324188.17169.129.camel@bling.home>
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: Scott Wood <scottwood@freescale.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	benve@cisco.com, aafabbri@cisco.com, B08248@freescale.com,
	B07421@freescale.com, avi@redhat.com, konrad.wilk@oracle.com,
	kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Mon, 14 Nov 2011 19:29:48 -0700
In-Reply-To: <1321304079.17169.74.camel@bling.home>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <4EBDBA50.3070801@freescale.com> <1321304079.17169.74.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2011-11-14 at 13:54 -0700, Alex Williamson wrote:
> On Fri, 2011-11-11 at 18:14 -0600, Scott Wood wrote:
> > On 11/03/2011 03:12 PM, Alex Williamson wrote:
> > > +	int			(*get)(void *);
> > > +	void			(*put)(void *);
> > > +	ssize_t			(*read)(void *, char __user *,
> > > +					size_t, loff_t *);
> > > +	ssize_t			(*write)(void *, const char __user *,
> > > +					 size_t, loff_t *);
> > > +	long			(*ioctl)(void *, unsigned int, unsigned long);
> > > +	int			(*mmap)(void *, struct vm_area_struct *);
> > > +};
> > 
> > When defining an API, please do not omit parameter names.
> 
> ok
> 
> > Should specify what the driver is supposed to do with get/put -- I guess
> > not try to unbind when the count is nonzero?  Races could still lead the
> > unbinder to be blocked, but I guess it lets the driver know when it's
> > likely to succeed.
> 
> Right, for the pci bus driver, it's mainly for reference counting,
> including the module_get to prevent vfio-pci from being unloaded.  On
> the first get for a device, we also do a pci_enable() and pci_disable()
> on last put.  I'll try to clarify in the docs.

Looking at these again, I should just rename them to open/release.  That
matches the points when they're called.  I suspect I started with just
reference counting and it grew to more of a full blown open/release.
Thanks,

Alex

