Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 28 Apr 2016 09:13:50 +0100
From: Liviu.Dudau@arm.com
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, arnd@arndb.de,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	hanjun.guo@linaro.org, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, jchandra@broadcom.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	ddaney@caviumnetworks.com, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com
Subject: Re: [PATCH V6 02/13] pci, acpi: Provide generic way to assign bus
 domain number.
Message-ID: <20160428081349.GU28464@e106497-lin.cambridge.arm.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-3-git-send-email-tn@semihalf.com>
 <20160427022649.GD6789@localhost>
 <20160427111758.GA6234@red-moon>
 <20160427164453.GB17629@localhost>
 <20160427173118.GA26653@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160427173118.GA26653@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 27, 2016 at 06:31:29PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Apr 27, 2016 at 11:44:53AM -0500, Bjorn Helgaas wrote:
> > On Wed, Apr 27, 2016 at 12:17:58PM +0100, Lorenzo Pieralisi wrote:
> > > On Tue, Apr 26, 2016 at 09:26:49PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Apr 15, 2016 at 07:06:37PM +0200, Tomasz Nowicki wrote:
> > > > > As we now have valid PCI host bridge device reference we can
> > > > > introduce code that is going to find its bus domain number using
> > > > > ACPI _SEG method.
> > > > > 
> > > > > Note that _SEG method is optional, therefore _SEG absence means
> > > > > that all PCI buses belong to domain 0.
> > > > > 
> > > > > While at it, for the sake of code clarity we put ACPI and DT domain
> > > > > assign methods into the corresponding helpers.
> > > > > 
> > > > > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > > > > Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > > > Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> > > > > Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > > Tested-by: Duc Dang <dhdang@apm.com>
> > > > > Tested-by: Dongdong Liu <liudongdong3@huawei.com>
> > > > > Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > > > Tested-by: Sinan Kaya <okaya@codeaurora.org>
> > > > > ---
> > > > >  drivers/acpi/pci_root.c  | 18 ++++++++++++++++++
> > > > >  drivers/pci/pci.c        | 11 +++++++++--
> > > > >  include/linux/pci-acpi.h |  2 ++
> > > > >  3 files changed, 29 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > > > > index 4581e0e..d9a70c4 100644
> > > > > --- a/drivers/acpi/pci_root.c
> > > > > +++ b/drivers/acpi/pci_root.c
> > > > > @@ -419,6 +419,24 @@ out:
> > > > >  }
> > > > >  EXPORT_SYMBOL(acpi_pci_osc_control_set);
> > > > >  
> > > > > +int acpi_pci_bus_domain_nr(struct device *parent)
> > 
> > It looks like acpi_pci_bus_domain_nr() could be under #ifdef
> > CONFIG_PCI_DOMAINS_GENERIC, right?
> 
> Yes it should.
> 
> > > > > +{
> > > > > +	struct acpi_device *acpi_dev = to_acpi_device(parent);
> > > > > +	unsigned long long segment = 0;
> > > > > +	acpi_status status;
> > > > > +
> > > > > +	/*
> > > > > +	 * If _SEG method does not exist, following ACPI spec (6.5.6)
> > > > > +	 * all PCI buses belong to domain 0.
> > > > > +	 */
> > > > > +	status = acpi_evaluate_integer(acpi_dev->handle, METHOD_NAME__SEG, NULL,
> > > > > +				       &segment);
> > > > 
> > > > We already have code in acpi_pci_root_add() to evaluate _SEG.  We
> > > > don't want to evaluate it *twice*, do we?
> > > > 
> > > > I was sort of expecting that if you added it here, we'd remove the
> > > > existing call, but it looks like you're keeping both?
> > > 
> > > We can't remove the existing call, since it is used on X86 and IA64
> > > to store the segment number that, in the process, is used in their
> > > pci_domain_nr() arch specific callback to retrieve the domain nr.
> > > 
> > > On ARM64, that selects PCI_DOMAINS_GENERIC, we have to find a way
> > > to retrieve the domain number that is not arch dependent, since
> > > this is generic code, we can't rely on any bus->sysdata format (unless
> > > we do something like JC did below), therefore the only way is to call
> > > the _SEG method *again* here, which also forced Tomasz to go through
> > > the ACPI_COMPANION setting song and dance and pass the parent pointer
> > > to pci_create_root_bus() (see patch 1), which BTW is a source of
> > > trouble on its own as you noticed.
> > > 
> > > JC solved it differently, via sysdata and pseudo-generic code:
> > > 
> > > http://www.spinics.net/lists/arm-kernel/msg478167.html
> > 
> > The thing I don't like about this is the special case of checking
> > parent and parent->of_node to figure out whether we should use the
> > segment from ACPI and the fragility of depending on the fact that the
> > companion hasn't been set yet.
> > 
> > > http://www.spinics.net/lists/arm-kernel/msg478169.html
> > > 
> > > I like neither, we need the lesser of two evils though.
> > 
> > Today we call pci_bus_assign_domain_nr() from the PCI core (from
> > pci_create_root_bus()).  This is only implemented for
> > PCI_DOMAINS_GENERIC, but even so, it fiddles around to figure out
> > whether to get the domain from DT or to assign a new one.
> > 
> > That seems backwards to me.  The host bridge drivers already know
> > where the domain should come from (ACPI _SEG, DT, etc.) and in the
> > long term, I think they should be responsible for looking up or
> > assigning a domain number *before* they call pci_create_root_bus().
> 
> Yes, the question still is how pci_create_root_bus() can get that
> value (I am pretty certain this was heavily debated in the past, which
> does not mean we can't give it another try).

The main issue is that pci_create_root_bus() does a weird dance trying to
figure out if the root bus hasn't been already allocated. It allocates a
new bus, assigns a domain number and then it tries to find it in the list
of already allocated busses. Because pci_alloc_bus() does not pass any
additional information, pci_bus_assign_domain_nr() needs to try to guess
where the barely initialised bus should live and give you back a number.

Simplifying the creation of root busses to be the job of the host bridges
would greatly simplify the code as well.

Best regards,
Liviu

> 
> > > > > +	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
> > > > > +		dev_err(&acpi_dev->dev, "can't evaluate _SEG\n");
> > > > > +
> > > > > +	return segment;
> > > > > +}
> > > > > +
> > > > >  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
> > > > >  {
> > > > >  	u32 support, control, requested;
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 25e0327..1a74e87 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -19,6 +19,7 @@
> > > > >  #include <linux/spinlock.h>
> > > > >  #include <linux/string.h>
> > > > >  #include <linux/log2.h>
> > > > > +#include <linux/pci-acpi.h>
> > > > >  #include <linux/pci-aspm.h>
> > > > >  #include <linux/pm_wakeup.h>
> > > > >  #include <linux/interrupt.h>
> > > > > @@ -4779,7 +4780,7 @@ int pci_get_new_domain_nr(void)
> > > > >  }
> > > > >  
> > > > >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > > > > -void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > > > > +static int of_pci_bus_domain_nr(struct device *parent)
> > > > >  {
> > > > >  	static int use_dt_domains = -1;
> > > > >  	int domain = -1;
> > > > > @@ -4823,7 +4824,13 @@ void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > > > >  		domain = -1;
> > > > >  	}
> > > > >  
> > > > > -	bus->domain_nr = domain;
> > > > > +	return domain;
> > > > > +}
> > > > > +
> > > > > +void pci_bus_assign_domain_nr(struct pci_bus *bus, struct device *parent)
> > > > > +{
> > > > > +	bus->domain_nr = acpi_disabled ? of_pci_bus_domain_nr(parent) :
> > > > > +					 acpi_pci_bus_domain_nr(parent);
> > 
> > We have the pci_bus * here, so to_pci_host_bridge(bus->bridge) gives
> > us the struct pci_host_bridge.  I can't remember why we put domain_nr
> > in the struct pci_bus instead of in the struct pci_host_bridge.  It
> > seems like pci_host_bridge is the more logical place for it, because
> > every bus below the host bridge must have the same domain by
> > definition.
> > 
> > Would it be feasible to either (a) move domain_nr to the
> > pci_host_bridge, or (b) change acpi_pci_bus_domain_nr() so it uses the
> > struct pci_bus * or the struct device * to find the struct
> > acpi_pci_root where segment has already been stored by
> > acpi_pci_root_add()?
> 
> (b) is what JC implemented even though it works differently for
> different hosts since it all depends on what's in bus->sysdata.
> 
> It can certainly be done in a generic way (that works on X86 and IA64
> too), let's give it more thought.
> 
> > Another wrinkle is the quirk added by 1f09b09b4de0 ("x86/PCI: Ignore
> > _SEG on HP xw9300").  x86 doesn't use PCI_DOMAINS_GENERIC yet, so this
> > patch wouldn't break it, but I hope x86 can use PCI_DOMAINS_GENERIC in
> > the future, and then it will be a problem if we evaluate _SEG again.
> 
> Yes, I share your concern here and I thought about that, if that's the
> end goal let's find a solution that works across arches (or we temporarily
> use JC's code and we then generalize it).
> 
> Thanks,
> Lorenzo
> 
> > 
> > > > >  }
> > > > >  #endif
> > > > >  #endif
> > > > > diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> > > > > index 89ab057..a72e22d 100644
> > > > > --- a/include/linux/pci-acpi.h
> > > > > +++ b/include/linux/pci-acpi.h
> > > > > @@ -22,6 +22,7 @@ static inline acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
> > > > >  {
> > > > >  	return acpi_remove_pm_notifier(dev);
> > > > >  }
> > > > > +extern int acpi_pci_bus_domain_nr(struct device *parent);
> > > > >  extern phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle);
> > > > >  
> > > > >  static inline acpi_handle acpi_find_root_bridge_handle(struct pci_dev *pdev)
> > > > > @@ -109,6 +110,7 @@ extern const u8 pci_acpi_dsm_uuid[];
> > > > >  #else	/* CONFIG_ACPI */
> > > > >  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> > > > >  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> > > > > +static inline int acpi_pci_bus_domain_nr(struct device *parent) { return -1; }
> > > > >  #endif	/* CONFIG_ACPI */
> > > > >  
> > > > >  #ifdef CONFIG_ACPI_APEI
> > > > > -- 
> > > > > 1.9.1
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
