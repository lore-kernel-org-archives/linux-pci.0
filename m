Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Fri, 10 Jun 2016 16:49:08 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jcm@redhat.com, andrea.gallo@linaro.org, dhdang@apm.com,
	jeremy.linton@arm.com, liudongdong3@huawei.com, cov@codeaurora.org
Subject: Re: [PATCH V8 5/9] pci, acpi: add acpi hook to assign domain number.
Message-ID: <20160610154908.GB23638@red-moon>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
 <1464621262-26770-6-git-send-email-tn@semihalf.com>
 <20160608001559.GD4759@localhost>
 <20160610151458.GA23638@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160610151458.GA23638@red-moon>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 10, 2016 at 04:14:58PM +0100, Lorenzo Pieralisi wrote:
> Hi Bjorn, Tomasz,
> 
> On Tue, Jun 07, 2016 at 07:15:59PM -0500, Bjorn Helgaas wrote:
> 
> [...]
> 
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index eb431b5..2b52178 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -7,6 +7,7 @@
> > >   *	Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/init.h>
> > > @@ -4941,7 +4942,7 @@ int pci_get_new_domain_nr(void)
> > >  }
> > >  
> > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > -void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > > +static int of_pci_bus_domain_nr(struct device *parent)
> > 
> > Can we do a little cleanup before this patch?  
> > 
> >   - pci_bus_assign_domain_nr() is only used inside drivers/pci, so
> >     maybe we move the prototype to drivers/pci/pci.h?
> > 
> >   - I don't really like the style of calling a function that
> >     internally assigns bus->domain_nr.  Could we do something like
> >     this instead?
> > 
> >     int pci_bus_domain_nr(...)
> >     {
> >       ...
> >       return domain;
> >     }
> > 
> >     ... pci_create_root_bus(...)
> >     {
> >       ...
> >       b->domain_nr = pci_bus_domain_nr(...);
> 
> We noticed while preparing v9, that this would force us to
> write an empty pci_bus_domain_nr() prototype for
> !PCI_DOMAINS_GENERIC (ie every arch but ARM/ARM64) that should
> return 0 to keep current behaviour unchanged.
> 
> That's why pci_bus_assign_domain_nr() was there, so that it
> was compiled out on !PCI_DOMAINS_GENERIC.
> 
> I really would like v9 to be final so let's fix it before posting it
> shortly please.
> 
> For the above we have three options:
> 
> 1) Leave code as-is in v8
> 
> 2) in pci_create_root_bus():
> #ifdef CONFIG_PCI_DOMAINS_GENERIC
>        b->domain_nr = pci_bus_domain_nr(...);
> #endif
> 
> + other changes requested above
> 
> 3) in pci_create_root_bus()
> 
> b->domain_nr = pci_bus_domain_nr(...);
> 
> unguarded and a stub:
> 
> #ifndef CONFIG_PCI_DOMAINS_GENERIC
> static inline int pci_bus_domain_nr() { return 0; }
> #endif
> 
> + other changes requested above

Actually, Tomasz made me notice that pci_bus.domain_nr is
only declared for CONFIG_PCI_DOMAINS_GENERIC so (3) is not
even an option and IMO (2) is not much nicer than code in
v8 as-is with an ifdef in the middle of pci_create_root_bus().

Thanks,
Lorenzo
