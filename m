Return-Path: <SRS0=l1Je=6N=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=l1Je=6N=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 10 Jul 2017 16:49:24 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Paul Burton <paul.burton@imgtec.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] MIPS/PCI: Fix pcibios_scan_bus() NULL check code path
Message-ID: <20170710154924.GA13344@red-moon>
References: <20170710123409.9043-1-lorenzo.pieralisi@arm.com>
 <20170710123409.9043-2-lorenzo.pieralisi@arm.com>
 <20170710145553.GA20365@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170710145553.GA20365@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 09:55:53AM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 10, 2017 at 01:34:09PM +0100, Lorenzo Pieralisi wrote:
> > If pci_scan_root_bus() fails (ie returns NULL) pcibios_scan_bus() must
> > return immediately since the struct pci_bus pointer it returns is not
> > valid and cannot be used.
> > 
> > Move code checking the pci_scan_root_bus() return value to reinstate
> > proper pcibios_scanbus() error path behaviour.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> 
> I agree this is certainly broken.  In fact, I think I broke it with
> 9e808eb6a768 ("PCI: Cleanup control flow") in 2015.  So probably v4.14
> material?

Yes that makes sense, I spotted it since I am preparing patches to
remove pci_fixup_irqs() from the kernel (by removing it from all arches
that still use it), I think that technically:

88555b481958 ("MIPS: PCI: Support for CONFIG_PCI_DOMAINS_GENERIC")

created a possible breakage (ie by using the possible NULL bus pointer),
if you merge it in one branch for 4.14 I will base the pci_fixup_irqs()
removal on top of it and post the series, just let me know please.

Thanks !
Lorenzo

> > ---
> >  arch/mips/pci/pci-legacy.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> > index 174575a..71d62f8 100644
> > --- a/arch/mips/pci/pci-legacy.c
> > +++ b/arch/mips/pci/pci-legacy.c
> > @@ -89,16 +89,16 @@ static void pcibios_scanbus(struct pci_controller *hose)
> >  	pci_add_resource(&resources, hose->busn_resource);
> >  	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
> >  				&resources);
> > -	hose->bus = bus;
> > -
> > -	need_domain_info = need_domain_info || pci_domain_nr(bus);
> > -	set_pci_need_domain_info(hose, need_domain_info);
> > -
> >  	if (!bus) {
> >  		pci_free_resource_list(&resources);
> >  		return;
> >  	}
> >  
> > +	hose->bus = bus;
> > +
> > +	need_domain_info = need_domain_info || pci_domain_nr(bus);
> > +	set_pci_need_domain_info(hose, need_domain_info);
> > +
> >  	next_busno = bus->busn_res.end + 1;
> >  	/* Don't allow 8-bit bus number overflow inside the hose -
> >  	   reserve some space for bridges. */
> > -- 
> > 2.10.0
> > 
