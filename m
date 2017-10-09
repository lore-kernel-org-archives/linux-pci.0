Return-Path: <SRS0=pqNZ=BI=arm.com=will.deacon@kernel.org>
Return-Path: <SRS0=pqNZ=BI=arm.com=will.deacon@kernel.org>
Date: Mon, 9 Oct 2017 17:46:07 +0100
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Graeme Gregory <graeme.gregory@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: pci-host-generic: add support for Synopsys
 DesignWare RC in ECAM mode
Message-ID: <20171009164607.GD30085@arm.com>
References: <20171006163919.14898-1-ard.biesheuvel@linaro.org>
 <20171006163919.14898-2-ard.biesheuvel@linaro.org>
 <20171006232158.GI25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171006232158.GI25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 06, 2017 at 06:21:59PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 06, 2017 at 05:39:18PM +0100, Ard Biesheuvel wrote:
> > diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
> > index 7d709a7e0aa8..01e81a30e303 100644
> > --- a/drivers/pci/host/pci-host-generic.c
> > +++ b/drivers/pci/host/pci-host-generic.c
> > @@ -35,6 +35,43 @@ static struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
> >  	}
> >  };
> >  
> > +static int pci_dw_ecam_config_read(struct pci_bus *bus, u32 devfn, int where,
> > +				   int size, u32 *val)
> > +{
> > +	struct pci_config_window *cfg = bus->sysdata;
> > +
> > +	/*
> > +	 * The Synopsys DesignWare PCIe controller in ECAM mode will not filter
> > +	 * type 0 config TLPs sent to devices 1 and up on its downstream port,
> > +	 * resulting in devices appearing multiple times on bus 0 unless we
> > +	 * filter out those accesses here.
> > +	 */
> > +	if (bus->number == cfg->busr.start && PCI_SLOT(devfn) > 0)
> > +		return PCIBIOS_DEVICE_NOT_FOUND;
> 
> I think we should return 0xffffffff data here, as we do in other
> similar accessors (dw_pcie_rd_conf(), altera_pcie_cfg_read(),
> rockchip_pcie_rd_conf()).
> 
> Actually, xilinx-nwl has a nice trick: it implements
> nwl_pcie_map_bus(), which returns NULL for invalid devices.  Then it
> can use the generic accessors, and pci_generic_config_read() already
> fills in ~0 for this case. 
> 
> What do you think of the following?  I put it on my pci/host-generic
> branch for now (pending your response and an ack from Will).

I'd probably just inline the device check in pci_dw_ecam_map_bus directly,
but either way:

Acked-by: Will Deacon <will.deacon@arm.com>

I'm assuming this is so small that there's no point in having a Kconfig
option for these guys that depends on the generic host driver?

Will
