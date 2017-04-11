Return-Path: <SRS0=UqO1=3T=chromium.org=mka@kernel.org>
Return-Path: <SRS0=UqO1=3T=chromium.org=mka@kernel.org>
Date: Tue, 11 Apr 2017 10:23:07 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Mason <slash.tmp@free.fr>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Grant Grundler <grundler@chromium.org>,
	Greg Hackmann <ghackmann@google.com>,
	Michael Davidson <md@google.com>
Subject: Re: [PATCH] PCI: Add cast when assigning PCI_ROM_ADDRESS_MASK to a
 32-bit variable
Message-ID: <20170411172307.GC28657@google.com>
References: <20170410222457.113155-1-mka@chromium.org>
 <20170411012445.GA8025@bhelgaas-glaptop.roam.corp.google.com>
 <6111642d-9f1d-f8bf-5920-82f4eb427cff@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6111642d-9f1d-f8bf-5920-82f4eb427cff@free.fr>
List-ID: <linux-pci.vger.kernel.org>

El Tue, Apr 11, 2017 at 12:08:38PM +0200 Mason ha dit:

> On 11/04/2017 03:24, Bjorn Helgaas wrote:
> 
> > On Mon, Apr 10, 2017 at 03:24:57PM -0700, Matthias Kaehlcke wrote:
> >
> >> This fixes a clang warning about "implicit conversion from 'unsigned
> >> long' to 'u32'"
> >>
> >> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> >> ---
> >>  drivers/pci/probe.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index dfc9a2794141..148e80d5caf1 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -180,7 +180,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> >>  	u16 orig_cmd;
> >>  	struct pci_bus_region region, inverted_region;
> >>  
> >> -	mask = type ? PCI_ROM_ADDRESS_MASK : ~0;
> >> +	mask = type ? (u32)PCI_ROM_ADDRESS_MASK : ~0;
> > 
> > Can we put the cast in the PCI_ROM_ADDRESS_MASK #define so we don't have to
> > repeat it in all the uses?
> 
> Fixing these "implicit conversion" warnings, especially for
> unsigned types, is a slippery slope. (The behavior of the
> conversion is well-defined.)
> 
> How about changing the type of PCI_ROM_ADDRESS_MASK instead?
> It's defined as ~0x7ffUL but it's only used in the context
> of u32.
> 
> So make it an unsigned int:
> #define PCI_ROM_ADDRESS_MASK (~0x7ffU)
> 
> AFAIU, unsigned int is 32 bits on all platforms supported
> by Linux.

I considered this initially, but wasn't sure if the unsigned long
mask might be needed in some cases. From the comments I interpret that
there should be no problems with using a 32 bit mask everywhere.

I'll send out an updated patch shortly.

Thanks

Matthias
