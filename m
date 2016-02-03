Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 3 Feb 2016 12:51:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jake Oshins <jakeo@microsoft.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
Message-ID: <20160203185127.GE10879@localhost>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
 <1454434903-1680-2-git-send-email-jakeo@microsoft.com>
 <20160203182528.GB10879@localhost>
 <DM2PR0301MB12328FC565D58EB8F995DECFABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM2PR0301MB12328FC565D58EB8F995DECFABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 03, 2016 at 06:32:20PM +0000, Jake Oshins wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Wednesday, February 3, 2016 10:25 AM
> > To: Jake Oshins <jakeo@microsoft.com>
> > Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> > kernel@vger.kernel.org; devel@linuxdriverproject.org; Haiyang Zhang
> > <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> > bhelgaas@google.com; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
> > 
> > Hi Jake,
> > 
> > On Tue, Feb 02, 2016 at 05:41:41PM +0000, jakeo@microsoft.com wrote:

> > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > 27df4a6..cd05a8e 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -1515,6 +1515,10 @@ static inline int pci_get_new_domain_nr(void) {
> > > return -ENOSYS; }
> > >
> > >  #include <asm/pci.h>
> > >
> > > +#ifndef pci_root_bus_fwnode
> > > +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
> > 
> > Huh, interesting.  This is new for me; I guess the idea is that we at least
> > evaluate "bus" even when pci_root_bus_fwnode isn't defined, so the
> > compiler can catch egregious errors?
> > 
> 
> This was a suggestion by Mark Zyngier.  It made the non-x86 architectures build benignly.  If you'd like it done differently, I'm open to suggestion.

Something like "#define pci_root_bus_fwnode(bus) NULL" would be
typical.  What I'm curious about is the use of the comma operator.
I'm not opposed to it; I'm just trying to understand why it makes a
difference.
