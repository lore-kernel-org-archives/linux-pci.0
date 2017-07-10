Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754218AbdGJQin (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 12:38:43 -0400
Date: Mon, 10 Jul 2017 11:38:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] MIPS/PCI: Fix pcibios_scan_bus() NULL check code path
Message-ID: <20170710163830.GC20365@bhelgaas-glaptop.roam.corp.google.com>
References: <20170710123409.9043-1-lorenzo.pieralisi@arm.com>
 <20170710123409.9043-2-lorenzo.pieralisi@arm.com>
 <20170710145553.GA20365@bhelgaas-glaptop.roam.corp.google.com>
 <20170710154924.GA13344@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710154924.GA13344@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 04:49:24PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Jul 10, 2017 at 09:55:53AM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 10, 2017 at 01:34:09PM +0100, Lorenzo Pieralisi wrote:
> > > If pci_scan_root_bus() fails (ie returns NULL) pcibios_scan_bus() must
> > > return immediately since the struct pci_bus pointer it returns is not
> > > valid and cannot be used.
> > > 
> > > Move code checking the pci_scan_root_bus() return value to reinstate
> > > proper pcibios_scanbus() error path behaviour.
> > > 
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > I agree this is certainly broken.  In fact, I think I broke it with
> > 9e808eb6a768 ("PCI: Cleanup control flow") in 2015.  So probably v4.14
> > material?
> 
> Yes that makes sense, I spotted it since I am preparing patches to
> remove pci_fixup_irqs() from the kernel (by removing it from all arches
> that still use it), I think that technically:
> 
> 88555b481958 ("MIPS: PCI: Support for CONFIG_PCI_DOMAINS_GENERIC")
> 
> created a possible breakage (ie by using the possible NULL bus pointer),
> if you merge it in one branch for 4.14 I will base the pci_fixup_irqs()
> removal on top of it and post the series, just let me know please.

Ah, you're right.  I created some poor style (checking the return
value after intervening code) with 9e808eb6a768, and then 88555b481958
fell into the trap I had laid.

I put this on pci/irq-fixups for a continuation of your work and
started it off with this patch.

I will rebase the branch after -rc1, but that shouldn't be a problem
for you because I normally apply patches from email rather than
pulling them directly.  I'll be on vacation July 14-28, so that
probably won't happen until August.

Thanks!

> > > ---
> > >  arch/mips/pci/pci-legacy.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> > > index 174575a..71d62f8 100644
> > > --- a/arch/mips/pci/pci-legacy.c
> > > +++ b/arch/mips/pci/pci-legacy.c
> > > @@ -89,16 +89,16 @@ static void pcibios_scanbus(struct pci_controller *hose)
> > >  	pci_add_resource(&resources, hose->busn_resource);
> > >  	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
> > >  				&resources);
> > > -	hose->bus = bus;
> > > -
> > > -	need_domain_info = need_domain_info || pci_domain_nr(bus);
> > > -	set_pci_need_domain_info(hose, need_domain_info);
> > > -
> > >  	if (!bus) {
> > >  		pci_free_resource_list(&resources);
> > >  		return;
> > >  	}
> > >  
> > > +	hose->bus = bus;
> > > +
> > > +	need_domain_info = need_domain_info || pci_domain_nr(bus);
> > > +	set_pci_need_domain_info(hose, need_domain_info);
> > > +
> > >  	next_busno = bus->busn_res.end + 1;
> > >  	/* Don't allow 8-bit bus number overflow inside the hose -
> > >  	   reserve some space for bridges. */
> > > -- 
> > > 2.10.0
> > > 
