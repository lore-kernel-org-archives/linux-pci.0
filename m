Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, catalin.marinas@arm.com, linux-pci@vger.kernel.org, will.deacon@arm.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ddaney@caviumnetworks.com, robert.richter@caviumnetworks.com, msalter@redhat.com, Liviu.Dudau@arm.com, jchandra@broadcom.com, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] [RFC] pci: add new method for register PCI hosts
Date: Mon, 02 May 2016 10:04:56 +0200
Message-ID: <8510060.F9ia068vGL@wuerfel>
In-Reply-To: <5727034D.4000204@semihalf.com>
References: <1461970899-4150603-1-git-send-email-arnd@arndb.de> <1461970899-4150603-2-git-send-email-arnd@arndb.de> <5727034D.4000204@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Monday 02 May 2016 09:35:41 Tomasz Nowicki wrote:
> > +int pci_register_host(struct pci_host_bridge *bridge)
> >   {
> >       int error;
> > -     struct pci_host_bridge *bridge;
> >       struct pci_bus *b, *b2;
> >       struct resource_entry *window, *n;
> > +     LIST_HEAD(resources);
> >       struct resource *res;
> >       resource_size_t offset;
> >       char bus_addr[64];
> >       char *fmt;
> > +     struct device *parent = bridge->dev.parent;
> >   
> >       b = pci_alloc_bus(NULL);
> >       if (!b)
> > -             return NULL;
> > +             return -ENOMEM;
> > +     bridge->bus = b;
> >   
> > -     b->sysdata = sysdata;
> > -     b->ops = ops;
> > -     b->number = b->busn_res.start = bus;
> > +     /* temporarily move resources off the list */
> > +     list_splice_init(&bridge->windows, &resources);
> > +     b->sysdata = bridge->sysdata;
> > +     b->msi = bridge->msi;
> > +     b->ops = bridge->ops;
> > +     b->number = b->busn_res.start = bridge->busnr;
> >       pci_bus_assign_domain_nr(b, parent);
> 
> Have you considered to move domain assigning out of here? Domain is 
> common for every bus under host bridge, hence it could go into the 
> pci_host_bridge structure. Then I would vote for extra host bridge 
> allocation call which would assign standard things like this.
> 

I had not thought of it, but it sounds like a good idea, thanks!

The other members of struct bus that we assign here (sysdata,
msi, and ops) are probably also constant for the bridge (need
to verify this), so ideally we'd move all four out of the
bus and replace them with a pointer to the pci_host_bridge
to avoid walking up the bus hierarchy every time we want to
access them.

	Arnd
