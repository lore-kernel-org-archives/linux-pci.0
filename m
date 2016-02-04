Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42030 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756161AbcBDRmA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Feb 2016 12:42:00 -0500
Date: Thu, 4 Feb 2016 11:41:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, pci: Add quirk for unsizeable Broadwell EP bar
Message-ID: <20160204174155.GB19957@localhost>
References: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452896279-22034-1-git-send-email-andi@firstfloor.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andi,

On Fri, Jan 15, 2016 at 02:17:59PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Home Agent and PCU PCI devices in Broadwell-EP have a BAR that returns a
> non zero value when read, but is still not sizeable (because it doesn't
> exist).  This causes several [Firmware error] messages at boot. It does
> not cause any functional problems, as the devices really have no BARs.

Wow, this is a pretty egregious PCI spec violation.  I'm sure there's
some reason behind it, but it does irk me to have to put code in the
core to work around such an obvious problem.  

It sounds like these devices have some device-specific register where
BAR 0 is supposed to be?  Setting IORESOURCE_PCI_FIXED doesn't seem
like the right solution to me.  Even if we set that, the core still
believes this resource corresponds to some address space consumed by
the device.  I think we will still try to size the BAR and decode its
type.  I think it will still show up via lspci.  That's all
meaningless.

How do you deal with this on Windows?

I think you need to replace the config accessor with a special one
that knows that this register is not a BAR, and they can return zero.
Or maybe the accessor should hide these devices completely, i.e.,
return 0xffffffff for the vendor/device ID.  Or maybe you even have a
switch the BIOS can use to hide them from the OS.

Bjorn

> Add a PCI quirk to shut off the messages.
> 
> Since the message is printed before the normal header fixup add EARLY
> fixups. This requires changing the PCI probe code to not override
> the resource flags unconditionally, so that the quirk can set flags.
> 
> (I believe that's ok, they should be always zero before, but please double
> check)
> 
> Also don't print the invalid BAR message for FIXED BARs.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/pci/fixup.c | 12 ++++++++++++
>  drivers/pci/probe.c  |  8 +++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index e585655..86bbdd6 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -540,3 +540,15 @@ static void twinhead_reserve_killing_zone(struct pci_dev *dev)
>          }
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x27B9, twinhead_reserve_killing_zone);
> +
> +/*
> + * Intel Broadwell EP. Prevent reading/updating BAR on Home Agent and PCU devices
> + * which are not real BARs, but still return non-null.
> + * This prevents a harmless warning message at boot.
> + */
> +static void pci_bdwep_ha_bar(struct pci_dev *dev)
> +{
> +	dev->resource[0].flags |= IORESOURCE_PCI_FIXED;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_ha_bar);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_ha_bar);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index edb1984..f7926e8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -214,7 +214,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		l = 0;
>  
>  	if (type == pci_bar_unknown) {
> -		res->flags = decode_bar(dev, l);
> +		res->flags |= decode_bar(dev, l);
>  		res->flags |= IORESOURCE_SIZEALIGN;
>  		if (res->flags & IORESOURCE_IO) {
>  			l64 = l & PCI_BASE_ADDRESS_IO_MASK;
> @@ -251,8 +251,10 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  
>  	sz64 = pci_size(l64, sz64, mask64);
>  	if (!sz64) {
> -		dev_info(&dev->dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
> -			 pos);
> +		/* Don't print this message for a fixed BAR */
> +		if (!(res->flags & IORESOURCE_PCI_FIXED))
> +			dev_info(&dev->dev, FW_BUG "reg 0x%x: invalid BAR (can't size)\n",
> +				 pos);
>  		goto fail;
>  	}
>  
> -- 
> 2.4.3
> 
