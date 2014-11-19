Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dliviu.plus.com ([80.229.23.120]:60988 "EHLO smtp.dudau.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756313AbaKSTDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Nov 2014 14:03:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.dudau.co.uk (Postfix) with SMTP id 41483FFB32
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2014 19:03:22 +0000 (GMT)
Date: Wed, 19 Nov 2014 19:03:17 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tony Luck <tony.luck@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-xtensa@linux-xtensa.org,
	x86@kernel.org, sparclinux@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] PCI: Rip out pci_bus_add_devices() from
 pci_scan_root_bus()
Message-ID: <20141119190317.GC9162@bart.dudau.co.uk>
References: <1416382369-13587-1-git-send-email-wangyijing@huawei.com>
 <1416382369-13587-6-git-send-email-wangyijing@huawei.com>
 <1645037.uypArjN50l@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1645037.uypArjN50l@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 19, 2014 at 01:11:41PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 15:32:49 Yijing Wang wrote:
> > Just like pci_scan_bus(), we also should rip out
> > pci_bus_add_devices() from pci_scan_root_bus().
> > Lots platforms first call pci_scan_root_bus(), but
> > after that, they call pci_bus_size_bridges() and
> > pci_bus_assign_resources(). Place pci_bus_add_devices()
> > in pci_scan_root_bus() hurts PCI scan logic.
> 
> I think we really need to wait for Bjorn to comment on this patch,
> as I mentioned the idea behind pci_scan_root_bus() was to integrate
> the scanning part, which you now undo, though I can still see this
> working out in the long run.
> 
> > Should no functional change.
> 
> But you are moving the pci_bus_add_devices() later in a couple of
> places. While this seems entirely reasonable, I would consider
> it a functional change.
> 
> > diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> > index 076c35c..97f9730 100644
> > --- a/arch/alpha/kernel/pci.c
> > +++ b/arch/alpha/kernel/pci.c
> > @@ -334,6 +334,8 @@ common_init_pci(void)
> >  
> >  		bus = pci_scan_root_bus(NULL, next_busno, alpha_mv.pci_ops,
> >  					hose, &resources);
> > +		if (bus)
> > +			pci_bus_add_devices(bus);
> >  		hose->bus = bus;
> >  		hose->need_domain_info = need_domain_info;
> >  		next_busno = bus->busn_res.end + 1;
> 
> How about making pci_bus_add_devices() handle a NULL argument to save
> the if() here and elsewhere?

Actually, I would stop there if the bus is NULL and start cleaning up. If not,
things are going to blow up three lines down when next_busno is calculated.

Best regards,
Liviu


> > diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
> > index 1bf60b1..f083688 100644
> > --- a/arch/mips/pci/pci.c
> > +++ b/arch/mips/pci/pci.c
> > @@ -113,6 +113,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
> >  		if (!pci_has_flag(PCI_PROBE_ONLY)) {
> >  			pci_bus_size_bridges(bus);
> >  			pci_bus_assign_resources(bus);
> > +			pci_bus_add_devices(bus);
> >  		}
> >  	}
> >  }
> 
> This one looks wrong, I think you still want to call pci_bus_add_devices()
> even with PCI_PROBE_ONLY set.
> 
> > diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
> > index 1f80a88..007466e 100644
> > --- a/arch/tile/kernel/pci.c
> > +++ b/arch/tile/kernel/pci.c
> > @@ -308,6 +308,8 @@ int __init pcibios_init(void)
> >  			pci_add_resource(&resources, &iomem_resource);
> >  			bus = pci_scan_root_bus(NULL, 0, controller->ops,
> >  						controller, &resources);
> > +			if (bus)
> > +				pci_bus_add_devices(bus);
> >  			controller->root_bus = bus;
> >  			controller->last_busno = bus->busn_res.end;
> >  		}
> 
> Should the pci_bus_add_devices come after setting the bus numbers here?
> 
> 	Arnd
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...

