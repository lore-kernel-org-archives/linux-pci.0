Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:47792
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964967AbcBCScW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2016 13:32:22 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	KY Srinivasan <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
Date: Wed, 3 Feb 2016 18:32:20 +0000
Message-ID: <DM2PR0301MB12328FC565D58EB8F995DECFABD00@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1454434903-1680-1-git-send-email-jakeo@microsoft.com>
 <1454434903-1680-2-git-send-email-jakeo@microsoft.com>
 <20160203182528.GB10879@localhost>
In-Reply-To: <20160203182528.GB10879@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Wednesday, February 3, 2016 10:25 AM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; Haiyang Zhang
> <haiyangz@microsoft.com>; marc.zyngier@arm.com;
> bhelgaas@google.com; linux-pci@vger.kernel.org
> Subject: Re: [PATCH RESEND 1/3] PCI: Add fwnode_handle to pci_sysdata
> 
> Hi Jake,
> 
> On Tue, Feb 02, 2016 at 05:41:41PM +0000, jakeo@microsoft.com wrote:
> > From: Jake Oshins <jakeo@microsoft.com>
> >
> > This patch adds an fwnode_handle to struct pci_sysdata, which is used
> > by the next patch in the series when trying to locate an IRQ domain
> > associated with a root PCI bus.
> >
> > Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> > ---
> >  arch/x86/include/asm/pci.h | 15 +++++++++++++++
> >  drivers/pci/probe.c        |  1 +
> >  include/linux/pci.h        |  4 ++++
> >  3 files changed, 20 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> > index 4625943..6fc3c7c 100644
> > --- a/arch/x86/include/asm/pci.h
> > +++ b/arch/x86/include/asm/pci.h
> > @@ -20,6 +20,9 @@ struct pci_sysdata {  #ifdef CONFIG_X86_64
> >  	void		*iommu;		/* IOMMU private data */
> >  #endif
> > +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> > +	void		*fwnode;	/* IRQ domain for MSI assignment */
> > +#endif
> >  };
> >
> >  extern int pci_routeirq;
> > @@ -32,6 +35,7 @@ extern int noioapicreroute;  static inline int
> > pci_domain_nr(struct pci_bus *bus)  {
> >  	struct pci_sysdata *sd = bus->sysdata;
> > +
> >  	return sd->domain;
> >  }
> >
> > @@ -41,6 +45,17 @@ static inline int pci_proc_domain(struct pci_bus
> > *bus)  }  #endif
> >
> > +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> > +static inline void *_pci_root_bus_fwnode(struct pci_bus *bus) {
> > +	struct pci_sysdata *sd = bus->sysdata;
> > +
> > +	return sd->fwnode;
> > +}
> > +
> > +#define pci_root_bus_fwnode	_pci_root_bus_fwnode
> > +#endif
> > +
> >  /* Can be used to override the logic in pci_scan_bus for skipping
> >     already-configured bus numbers - to be used for buggy BIOSes
> >     or architectures with incomplete PCI setup by the loader */ diff
> > --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > 6d7ab9b..b207e74 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/pci-aspm.h>
> >  #include <linux/aer.h>
> >  #include <linux/acpi.h>
> > +#include <linux/irqdomain.h>
> 
> You're not adding a use of anything in irqdomain.h.  It looks like this hunk
> should be moved to the second patch.

Wil do.

> 
> >  #include <asm-generic/pci-bridge.h>
> >  #include "pci.h"
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > 27df4a6..cd05a8e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1515,6 +1515,10 @@ static inline int pci_get_new_domain_nr(void) {
> > return -ENOSYS; }
> >
> >  #include <asm/pci.h>
> >
> > +#ifndef pci_root_bus_fwnode
> > +#define pci_root_bus_fwnode(bus)	((void)(bus), NULL)
> 
> Huh, interesting.  This is new for me; I guess the idea is that we at least
> evaluate "bus" even when pci_root_bus_fwnode isn't defined, so the
> compiler can catch egregious errors?
> 

This was a suggestion by Mark Zyngier.  It made the non-x86 architectures build benignly.  If you'd like it done differently, I'm open to suggestion.

Thanks,
Jake Oshins

