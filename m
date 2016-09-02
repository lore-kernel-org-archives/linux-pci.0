Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Fri, 2 Sep 2016 16:38:45 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rafael@kernel.org, hanjun.guo@linaro.org,
	okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
	dhdang@apm.com, ard.biesheuvel@linaro.org,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com,
	andrea.gallo@linaro.org, jeremy.linton@arm.com,
	liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
	jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V5 1/5] PCI: Embed pci_ecam_ops in pci_config_window
 structure
Message-ID: <20160902153845.GA11234@red-moon>
References: <1470661541-26270-1-git-send-email-tn@semihalf.com>
 <1470661541-26270-2-git-send-email-tn@semihalf.com>
 <20160901182345.GA18461@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160901182345.GA18461@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 01:23:45PM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 08, 2016 at 03:05:37PM +0200, Tomasz Nowicki wrote:
> > pci_config_window keeps pointer to pci_ecam_ops and every time
> > we want to deallocate pci_config_window (pci_ecam_free()) we need to make
> > sure to free pci_ecam_ops in case it was dynamically allocated prior to
> > pci_ecam_create() call.
> 
> I think this is a theoretical problem, right?  All the current callers
> pass a pointer to a static pci_ecam_ops struct that does not need to
> be deallocated.
> 
> I see that the next patch uses a pci_ecam_ops struct on the stack,

I asked Tomasz why we need to have pci_ecam_ops on the stack in the
first place since I do not think it is needed, or nicer (actually I
think it is not nice at all, what's the problem in making it static ?).

Anyway, that's part of this thread but I think Tomasz was looking
more for feedback/agreement on the whole quirks mechanism to check
if it is fine, more below.

> which would definitely cause issues without this patch, so I agree we
> need something like this; I'm just trying to make the changelog make
> more sense.
> 
> > To avoid that extra effort, embed pci_ecam_ops in pci_config_window,
> > instead of just a pointer.
> > 
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > To: Jayachandran C <jchandra@broadcom.com>
> 
> This looks like an editing mistake?

Yes it is.

I think the most important bit about this series is to agree on
whether it is ok to keep quirks in drivers/pci/host/mcfg-quirks.c
or we need to find a different dir for it, and of course to make
sure the quirks mechanism is fine with everyone.

Thanks !
Lorenzo

> >  arch/arm64/kernel/pci.c  | 2 +-
> >  drivers/pci/ecam.c       | 6 +++---
> >  include/linux/pci-ecam.h | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> > index acf3872..981e828 100644
> > --- a/arch/arm64/kernel/pci.c
> > +++ b/arch/arm64/kernel/pci.c
> > @@ -183,7 +183,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >  		return NULL;
> >  	}
> >  
> > -	acpi_pci_root_ops.pci_ops = &ri->cfg->ops->pci_ops;
> > +	acpi_pci_root_ops.pci_ops = &ri->cfg->ops.pci_ops;
> >  	bus = acpi_pci_root_create(root, &acpi_pci_root_ops, &ri->common,
> >  				   ri->cfg);
> >  	if (!bus)
> > diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> > index 43ed08d..24242f0 100644
> > --- a/drivers/pci/ecam.c
> > +++ b/drivers/pci/ecam.c
> > @@ -52,7 +52,7 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	cfg->parent = dev;
> > -	cfg->ops = ops;
> > +	cfg->ops = *ops;
> >  	cfg->busr.start = busr->start;
> >  	cfg->busr.end = busr->end;
> >  	cfg->busr.flags = IORESOURCE_BUS;
> > @@ -138,7 +138,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  			       int where)
> >  {
> >  	struct pci_config_window *cfg = bus->sysdata;
> > -	unsigned int devfn_shift = cfg->ops->bus_shift - 8;
> > +	unsigned int devfn_shift = cfg->ops.bus_shift - 8;
> >  	unsigned int busn = bus->number;
> >  	void __iomem *base;
> >  
> > @@ -149,7 +149,7 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
> >  	if (per_bus_mapping)
> >  		base = cfg->winp[busn];
> >  	else
> > -		base = cfg->win + (busn << cfg->ops->bus_shift);
> > +		base = cfg->win + (busn << cfg->ops.bus_shift);
> >  	return base + (devfn << devfn_shift) + where;
> >  }
> >  
> > diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
> > index 7adad20..0ce2920 100644
> > --- a/include/linux/pci-ecam.h
> > +++ b/include/linux/pci-ecam.h
> > @@ -39,7 +39,7 @@ struct pci_config_window {
> >  	struct resource			res;
> >  	struct resource			busr;
> >  	void				*priv;
> > -	struct pci_ecam_ops		*ops;
> > +	struct pci_ecam_ops		ops;
> >  	union {
> >  		void __iomem		*win;	/* 64-bit single mapping */
> >  		void __iomem		**winp; /* 32-bit per-bus mapping */
> > -- 
> > 1.9.1
> > 
> 
