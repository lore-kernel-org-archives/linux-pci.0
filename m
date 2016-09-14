Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Wed, 14 Sep 2016 10:45:24 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Aaron Durbin <adurbin@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Add pci_find_resource()
Message-ID: <20160914074524.GT1811@lahna.fi.intel.com>
References: <CAJZ5v0gRm++9zcAtXc1jYKsrg=tw2K3Wd=kQRS=RbRxXRDj8yA@mail.gmail.com>
 <20160913121942.80356-1-mika.westerberg@linux.intel.com>
 <1473775909.11323.274.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1473775909.11323.274.camel@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 05:11:49PM +0300, Andy Shevchenko wrote:
> On Tue, 2016-09-13 at 15:19 +0300, Mika Westerberg wrote:
> > Add a new helper function pci_find_resource() that can be used to find
> > out
> > whether a given resource (for example from a child device) is
> > contained
> > within given PCI device's standard resources.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci.c   | 27 +++++++++++++++++++++++++++
> >  include/linux/pci.h |  4 ++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index aab9d5115a5f..491f879f34cb 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -480,6 +480,33 @@ struct resource *pci_find_parent_resource(const
> > struct pci_dev *dev,
> >  EXPORT_SYMBOL(pci_find_parent_resource);
> >  
> >  /**
> > + * pci_find_resource - Return matching PCI device resource
> > + * @dev: PCI device to query
> > + * @res: Resource to look for
> > + *
> > + * Goes over standard PCI resources (BARs) and checks if the given
> > resource
> > + * is partially or fully contained in any of them. In that case the
> > + * matching resource is returned, %NULL otherwise.
> > + */
> > +struct resource *pci_find_resource(struct pci_dev *dev, struct
> > resource *res)
> > +{
> > +	int i;
> > +
> 
> > +	if (!res)
> > +		return NULL;
> 
> Shouldn't it be a problem of caller to supply valid pointer?
> Seems other function(s) has(ve) this assumption.

No, I can drop the check.

> > +
> > +	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> > +		struct resource *r = &dev->resource[i];
> > +
> > +		if (r->start && resource_contains(r, res))
> > +			return r;
> 
> I'm not sure what we have to return in case of
> 1) r->start == 0, r->end > 0
> 2) r->start > 0, r->end == 0
> 
> assuming that all previous checks are positive.

These are PCI BARs so if they are not populated (r->start == 0) we skip
them. PCI core should have filled those already with correct values (and
resource_contains() should deal with everything that does not match
anyway).
