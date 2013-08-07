Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58846 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756495Ab3HGJPs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 05:15:48 -0400
Date: Wed, 7 Aug 2013 11:13:54 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: [PATCHv5 08/11] ARM: pci: add ->add_bus() and ->remove_bus()
 hooks to hw_pci
Message-ID: <20130807111354.5e29a74c@skate>
In-Reply-To: <20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1373889167-27878-9-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130725165302.GA27802@dhcp-172-17-186-34.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Thierry Reding,

On Thu, 25 Jul 2013 09:53:03 -0700, Thierry Reding wrote:

> I just noticed two minor issues, see below.
> 
> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> [...]
> > @@ -36,6 +36,8 @@ struct hw_pci {
> >  					  resource_size_t start,
> >  					  resource_size_t size,
> >  					  resource_size_t align);
> > +	void            (*add_bus)(struct pci_bus *bus);
> > +	void            (*remove_bus)(struct pci_bus *bus);
> 
> This hunk...
> 
> > @@ -63,6 +65,8 @@ struct pci_sys_data {
> >  					  resource_size_t start,
> >  					  resource_size_t size,
> >  					  resource_size_t align);
> > +	void            (*add_bus)(struct pci_bus *bus);
> > +	void            (*remove_bus)(struct pci_bus *bus);
> >  	void		*private_data;	/* platform controller private data	*/
> >  };
> 
> and this one use inconsistent indentation (spaces instead of tabs).

Hum, I must be missing something here. Looking at the patch you're
quoting, and my code, I see one tab before 'void' in both cases, and
spaces between 'void' and the (*function) in both cases.

Am I missing something here?

> > diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> [...]
> > @@ -464,6 +478,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> >  		sys->swizzle = hw->swizzle;
> >  		sys->map_irq = hw->map_irq;
> >  		sys->align_resource = hw->align_resource;
> > +		sys->add_bus        = hw->add_bus;
> > +		sys->remove_bus     = hw->remove_bus;
> 
> And this one aligns the '=' sign, whereas none of the other assignments
> do.

Right, will be fixed as part of PATCHv7.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
