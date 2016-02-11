Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51595 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbcBKOUe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Feb 2016 09:20:34 -0500
Date: Thu, 11 Feb 2016 08:20:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160211142030.GA4507@localhost>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
 <20160204174155.GB19957@localhost>
 <20160204185442.GA4875@tassilo.jf.intel.com>
 <20160205015734.GA29929@localhost>
 <20160205033616.GF3696@two.firstfloor.org>
 <20160205163427.GD29306@localhost>
 <20160210222333.GK3696@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160210222333.GK3696@two.firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 10, 2016 at 11:23:33PM +0100, Andi Kleen wrote:
> On Fri, Feb 05, 2016 at 10:34:27AM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 05, 2016 at 04:36:17AM +0100, Andi Kleen wrote:
> > > > > But would actually anything use it?
> > > > 
> > > > You mean, would anything actually use the lspci output?  I don't know,
> > > > but why would we want it to print garbage?
> > > 
> > > In he kernel. I don't think lspci is that interesting.
> > > > 
> > > > And the kernel certainly uses the struct resource.  Setting
> > > > IORESOURCE_PCI_FIXED is not a way of saying "please ignore this
> > > > resource."
> > > 
> > > There is already another quirk that uses the same technique to handle
> > > a bad bar. I also didn't notice any bad side effects. Again what would it be
> > > used for?
> > 
> > I suppose you mean pci_siemens_interrupt_controller(), added by
> > 73a74ed3a6f8 ("PCI: i386: fixup for Siemens Nixdorf AG FSC
> > Multiprocessor Interrupt Controllers")?
> > 
> > Here are the problems I see:
> 
> All good points. I changed the patch to use a new flag
> IORESOURCE_PCI_IGNORE that skips the whole bar process
> (except for the BAR size, which are ok in my case at least).
> 
> Also fixed to handle all BARs.
> 
> Does that look better?
> 
> ------
> x86, pci: Add quirk for unsizeable Broadwell EP bar
>     
> The Home Agent and PCU PCI devices in Broadwell-EP have a BAR that returns a
> non zero value when read, but is still not sizeable (because it doesn't
> exist).  This causes several [Firmware error] messages at boot. It does
> not cause any functional problems, as the devices really have no BARs.
> 
> Add a PCI quirk to shut off the messages.
> 
> Since the message is printed before the normal header fixup add EARLY
> fixups. This requires changing the PCI probe code to not override
> the resource flags unconditionally, so that the quirk can set flags.
> 
> (I believe that's ok, they should be always zero before, but please double
> check)
> 
> I used a new resource flag that causes the BAR to be ignored
> 
> v2: Handle all BARs, not just BAR0 (Chaohong Guo)
> Switch over to using IORESOURCE_PCI_IGNORE over FIXED
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e585655..837acb7 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -540,3 +540,18 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
>          }
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
> +
> +/*
> + * Intel Broadwell EP. Prevent reading/updating BARs on Home Agent and PCU devices
> + * which are not real BARs, but still return non-null.
> + * This prevents a harmless warning message at boot.
> + */
> +static void pci_bdwep_ha_bar(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < 5; i++)
> +		dev->resource[i].flags |= IORESOURCE_PCI_IGNORE;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_ha_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_ha_bar);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d7ab9b..7c12e6d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -214,7 +214,9 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		l = 0;
>  
>  	if (type == pci_bar_unknown) {
> -		res->flags = decode_bar(dev, l);
> +		res->flags |= decode_bar(dev, l);
> +		if (res->flags & IORESOURCE_PCI_IGNORE)
> +			goto out;

Sorry, I really don't like this either.  For one thing, if these
registers are not BARs, I don't want to even read them.  I don't want
the possible side-effects from reading the register, and I don't want
to worry about what happens when we feed garbage to decode_bar().

But more importantly, I don't want to define a whole new IORESOURCE_*
flag just for this, and I don't want places that use resources to have
to check for the new flag.

There's lots of code that assumes "res->flags == 0" means "this
resource does not correspond to a BAR".  For examples, look at the
output of this:

  git grep -e 'if (!r.*->flags'

These Broadwell-EP resources don't correspond to valid BARs, so they
should look just like the resources we have for unimplemented BARs.  I
think the cleanest way to accomplish this is to make the registers
look like unimplemented BARs, i.e., by making pci_read_config_dword()
read zero.

I think it should be pretty easy to define your own pci_ops that
special-cases these registers on these devices and falls back to the
existing raw_pci_read() for everything else, and you could probably
install those ops with an early quirk.

We already do something very similar for quirk_pcie_aspm_ops.

>  		res->flags |= IORESOURCE_SIZEALIGN;
>  		if (res->flags & IORESOURCE_IO) {
>  			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 24bea08..5262102 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -104,7 +104,7 @@ struct resource {
>  
>  /* PCI control bits.  Shares IORESOURCE_BITS with above PCI ROM.  */
>  #define IORESOURCE_PCI_FIXED		(1<<4)	/* Do not move resource */
> -
> +#define IORESOURCE_PCI_IGNORE		(1<<5)	/* Ignore resource */
>  
>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
