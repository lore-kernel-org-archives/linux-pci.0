Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 30 Nov 2017 10:06:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171130100622.GA10349@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171129182514.GA1087@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129182514.GA1087@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 29, 2017 at 06:25:15PM +0000, Lorenzo Pieralisi wrote:

[...]

> static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> 				      int where)
> 
> > +cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
> > +{
> > +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> > +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> > +	struct cdns_pcie *pcie = &rc->pcie;
> > +	unsigned int busn = bus->number;
> > +	u32 addr0, desc0;
> > +
> > +	if (busn < rc->bus_range->start || busn > rc->bus_range->end)
> > +		return NULL;
> 
> It does not hurt but I wonder whether you really need this check.
> 
> > +	if (busn == rc->bus_range->start) {
> > +		if (devfn)
> 
> I suspect I know why you need this check but I ask you to explain it
> anyway if you do not mind please.
> 
> > +			return NULL;
> > +
> > +		return pcie->reg_base + (where & 0xfff);
> > +	}
> > +
> > +	/* Update Output registers for AXI region 0. */
> > +	addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
> 
> Ok, so for every config access you reprogram addr0 to reflect the
> correct bus|devfn ID in the PCI bus TLP corresponding to an ECAM address
> in CPU physical address space, is my understanding correct ?

By re-reading it, it looks like this mechanism is there to just
associate a different RID TLP on the PCI bus to a fixed window
in CPU virtual address space.

> > +		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
> > +		CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(busn);
> > +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(0), addr0);
> > +
> > +	/* Configuration Type 0 or Type 1 access. */
> > +	desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
> > +		CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
> > +	/*
> > +	 * The bus number was already set once for all in desc1 by
> > +	 * cdns_pcie_host_init_address_translation().
> > +	 */
> > +	if (busn == rc->bus_range->start + 1)
> > +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
> > +	else
> > +		desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
> 
> I would like to ask you why you have to do it here and the root port
> does not figure it out by itself, I do not have the datasheet so I am
> just asking for my own information.
> 
> > +	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(0), desc0);
> > +
> > +	return rc->cfg_base + (where & 0xfff);
> > +}

[...]

> > +static int cdns_pcie_host_init(struct device *dev,
> > +			       struct list_head *resources,
> > +			       struct cdns_pcie_rc *rc)
> > +{
> > +	struct resource *bus_range = NULL;
> > +	int err;
> > +
> > +	/* Parse our PCI ranges and request their resources */
> > +	err = cdns_pcie_parse_request_of_pci_ranges(dev, resources, &bus_range);
> > +	if (err)
> > +		goto err_out;
> 
> I think that the err_out path should be part of:
> 
> cdns_pcie_parse_request_of_pci_ranges()
> 
> implementation and here you would just return.

I take it back, what you are doing is cleaner and allows you to
have code freeing the resource list in one single place so you
can leave this as-is.

Thanks,
Lorenzo
