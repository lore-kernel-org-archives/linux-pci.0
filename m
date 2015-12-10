Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"tinamdar@apm.com" <tinamdar@apm.com>,
	"treding@nvidia.com" <treding@nvidia.com>,
	"rjui@broadcom.com" <rjui@broadcom.com>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"m-karicheri2@ti.com" <m-karicheri2@ti.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"marc.zyngier@arm.com" <marc.zyngier@arm.com>,
	"dhdang@apm.com" <dhdang@apm.com>,
	"sbranden@broadcom.com" <sbranden@broadcom.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"Michal Simek" <michals@xilinx.com>,
	Paul Burton <paul.burton@imgtec.com>,
	"Thierry Reding" <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>
Subject: RE: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Thu, 10 Dec 2015 14:10:34 +0000
Message-ID: <8520D5D51A55D047800579B09414719825869A85@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost>
In-Reply-To: <20151209231921.GI31930@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: Re: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
> PCIe Host Controller
> > +
> It's a bit sloppy here to return 0, 1, or -EINVAL from a function declared to
> return "bool".  A bool function should return "true" or "false".
> 
> I think the best thing is to split this into two functions:
> 
>   static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
>   {
>     if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> PCIE_PHY_LINKUP_BIT)
>       return true;
>     return false;
>   }
> 
>   static bool nwl_phy_link_up(struct nwl_pcie *pcie)
>   {
>     if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) &
> PHY_RDY_LINKUP_BIT)
>       return true;
>     return false;
>   }
> 
> Then there's no possibility of a caller passing an invalid "check_link_up"
> argument, so you don't have to worry about an -EINVAL return.

Yes, agreed will address it in next patch
> 
> > +}
> > +
> > +static bool nwl_pcie_valid_device(struct pci_bus *bus, unsigned int
> > +devfn) {
> > +	struct nwl_pcie *pcie = bus->sysdata;
> > +
> > +	/* Check link,before accessing downstream ports */
> > +	if (bus->number != pcie->root_busno) {
> > +		if (!nwl_pcie_link_up(pcie, PCIE_USER_LINKUP))
> > +			return false;
> > +	}
> > +
> > +	/* Only one device down on each root port */
> > +	if (bus->number == pcie->root_busno && devfn > 0)
> > +		return false;
> > +
> > +	/*
> > +	 * Do not read more than one device on the bus directly attached
> > +	 * to root port.
> > +	 */
> > +	if (bus->primary == pcie->root_busno && devfn > 0)
> 
> Why is this?  Do you have some restriction on the PCIe topology below the
> Root Port?  If there's a spec-compliant link coming from the Root Port, it
> seems like any legal PCIe device could be attached, including a multifunction
> device.
> 
Primary refers to root port itself, this check is not for devices downstream on link. 

> > +		return false;
> > +
> > +	return true;
> > +}
> > + * nwl_setup_sspl - Set Slot Power limit
> > + *
> > + * @pcie: PCIe port information
> > + */
> > +static int nwl_setup_sspl(struct nwl_pcie *pcie)
> 
> This function needs a little explanation because it doesn't really make any
> sense when compared with the PCIe spec.  The spec says the Slot Power
> Limit Value is HwInit, which means it's supposed to be initialized by firmware
> or hardware, and it should be read-only by the time we get here.
> I think the value there should reflect parameters of the hardware design; we
> wouldn't want a user to write an arbitrary limit that would tell a card it can
> pull more power than the slot can supply.
> 
> But I saw another driver recently (pcie-snpsdev.c) that's doing something
> similar, so there must be something else going on here.  In any case, a
> comment here about exactly *what* is going on would be much appreciated.

The spec says the following:
The Set_Slot_Power_Limit Message includes a one DW data payload. The data payload is copied
from the Slot Capabilities register of the Downstream Port and is written into the Device
Capabilities register of the Upstream Port on the other side of the Link. Bits 9:8 of the data payload
map to the Slot Power Limit Scale field and bits 7:0 map to the Slot Power Limit Value field. Bits
31:10 of the data payload must be set to all 0's by the Transmitter and ignored by the Receiver. This
Message is sent automatically by the Downstream Port (of a Root Complex or a Switch) when one
of the following events occurs:
-> On a Configuration Write to the Slot Capabilities register (see Section 7.8.9) when the Data Link
Layer reports DL_Up status.
->  Anytime when a Link transitions from a non-DL_Up status to a DL_Up status (see
Section 2.9.2).

Captured Slot Power Limit Value (Upstream Ports only) - In
combination with the Slot Power Limit Scale value, specifies the
upper limit on power supplied by slot.
Power limit (in Watts) calculated by multiplying the value in this
field by the value in the Slot Power Limit Scale field.
This value is set by the Set_Slot_Power_Limit Message or
hardwired to 0000 0000b (see Section 6.9). The default value is
0000 0000b.> 

"With Set_Slot_Power_Limit Message also this value is set"

> > +{
> > +	unsigned int status;
> > +			mdelay(2);
> 
> Arnd suggested a sleep instead of delay here, but I didn't see a response.
> See http://lkml.kernel.org/r/2677327.lnRZhqx5GI@wuerfel
Agreed, will address in next patch.
> 
> > +			status = nwl_bridge_readl(pcie, TX_PCIE_MSG)
> > +						  & MSG_DONE_BIT;
> > +			if (status) {
> > +				status = nwl_bridge_readl(pcie,
> TX_PCIE_MSG)
> > +						  & MSG_DONE_STATUS_BIT;
> > +				if (status == SLVERR) {
> > +					dev_err(pcie->dev, "AXI slave
> error");
> > +					retval = SLVERR;
> > +				} else if (status == DECERR) {
> > +					dev_err(pcie->dev, "AXI Decode
> error");
> > +					retval = DECERR;
> > +				}
> 
> I think both these cases (SLVERR and DECERR) are impossible:
> 
>   #define MSG_DONE_STATUS_BIT                     (BIT(25) | BIT(24))
>   #define SLVERR                                  0x02
>   #define DECERR                                  0x03
> 
> MSG_DONE_STATUS_BIT is 0x3000000, so after masking status with it, the
> result can never be 0x02 or 0x03.
> 
> 
Agreed, will address in next patch.
> > +			} else {
> > +				retval = 1;
> > +			}
> 
> You only set "retval = 1" here in the case when "status == 0", which means
> you'll exit the loop, so this would be slightly simpler as:
> 
>   status = nwl_bridge_readl(pcie, TX_PCIE_MSG) & MSG_DONE_BIT;
>   if (!status)
>     return 1;
> 
>   status = nwl_bridge_readl(pcie, TX_PCIE_MSG) &
> MSG_DONE_STATUS_BIT;
>   ...
> 
> It's not clear to me whether you need to re-read TX_PCIE_MSG here.

MSG_DONE_BIT qualifies MSG_DONE_STATUS_BIT; so value of MSG_DONE_STATUS_BIT is valid only when MSG_DONE_BIT = 1
> 
> > +		}
> > +	} while (status);
> > +
> > +	return retval;
> > 
> > +	for (i = 0; i < 4; i++) {
> > +		irq = irq_find_mapping(pcie->legacy_irq_domain, i + 1);
> > +		if (irq > 0)
> > +			irq_dispose_mapping(irq);
> > +	}
> > +	if (pcie->legacy_irq_domain)
> > +		irq_domain_remove(pcie->legacy_irq_domain);
> 
> Something seems wrong here.  I don't know when irq_dispose_mapping() is
> required, but it's not used consistently in drivers/pci, and it should be.
> Currently, only pci-tegra.c, pcie-xilinx.c, and this new driver use it.  Tegra uses
> it only for MSIs, and Xilinx seems to use it for both MSIs and INTx.  What's
> right?
Its not related to MSI or INTx, its related to domain, for freeing irq descriptor associated with irq.

> > +
> > +	nwl_msi_free_irq_domain(pcie);
> > +}
> > +
> > +	}
> > +
> > +	pcie->legacy_irq_domain =
> irq_domain_add_linear(legacy_intc_node, 4,
> 
> This "4", the one in nwl_pcie_free_irq_domain(), and the one in
> nwl_pcie_leg_handler() should all be replaced by a #define so we know they
> all refer to the same thing.
> 
> I see that xilinx_pcie_init_irq_domain() and
> dra7xx_pcie_init_irq_domain() have a similar issue, and it'd be nice to fix
> them, too (in a separate patch, of course).
> Agreed, will address in next patch.
> > +
> 	&legacy_domain_ops,
> > +	/* Check for msii_present bit */
> > +	ret = nwl_bridge_readl(pcie, I_MSII_CAPABILITIES) & MSII_PRESENT;
> > +	if (!ret) {
> > +		dev_err(pcie->dev, "MSI not present\n");
> > +		ret = -EIO;
> > +		goto err;
> 
> These error paths leak msi->bitmap.
Agreed, will address in next patch.
> > +	}
> > +
> > +	/* Disable high range msi interrupts */
> 
> The comments before each line make the code harder to read.  Something
> like this might be useful:
 Agreed, will address in next patch.
>   /*
>    * For high range MSI interrupts: disable, clear any pending, register
>    * the handler, and enable.
>    */
> 
> I think you could move the platform_get_irq_byname() calls up so they're
> not in the middle of the hardware twiddling code.  That would also help the
> code read better.
Agreed, will address in next patch.
> > +	nwl_bridge_writel(pcie, (u32)~MSGF_MSI_SR_HI_MASK,
> > +MSGF_MSI_MASK_HI);
> > +
> > +	/* Clear pending high range msi interrupts */
> > +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> MSGF_MSI_STATUS_HI) &
> > +			  MSGF_MSI_SR_HI_MASK, MSGF_MSI_STATUS_HI);
> > +	/* Get msi_1 IRQ number */
> > +	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
> > +	if (msi->irq_msi1 < 0) {
> > +		dev_err(&pdev->dev, "failed to get IRQ#%d\n", msi-
> >irq_msi1);
> > +		goto err;
> 
> "ret" contains "I_MSII_CAPABILITIES & MSII_PRESENT", so I think this and
> the subsequent error paths return junk.
> 
Agreed will update retval accordingly.
> > +}
> > +
> > +	do {
> > +		err = nwl_pcie_link_up(pcie, PHY_RDY_LINKUP);
> > +		if (err != 1) {
> 
> nwl_pcie_link_up() is defined to return "bool", so you should use it that way,
> e.g., save the result in something like "link_up" and test as "if (!link_up)"
> instead of testing a bool against "1".
Agreed, will address in next patch.
> 
> > +			check_link_up++;
> > +			if (check_link_up > LINKUP_ITER_CHECK)
> > +				return -ENODEV;
> > +			msleep(1000);
> > +		}
> > +	} while (!err);
> > +
> > +	/* Check for ECAM present bit */
> 
> Superfluous comment.
Agreed, will address in next patch.
> > +	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CAPABILITIES) &
> > +
> > +	/* Enable ECAM */
> 
> This comment is useful, but the ones below are distracting because you can
> read the same thing from the code.
Agreed, will address in next patch.
> > +	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL)
> |
> Remove the comment; it's obvious from the code.
Agreed, will address in next patch.
> > +	pcie->link_up = nwl_pcie_link_up(pcie, PCIE_USER_LINKUP);
> > +	if (!pcie->link_up)
> > +		dev_info(pcie->dev, "Link is DOWN\n");
> > +	else
> > +		dev_info(pcie->dev, "Link is UP\n");
> 
> Avoid the negation with:
> 
>   if (pcie->link_up)
>     dev_info(pcie->dev, "Link is UP\n");
>   else
>     dev_info(pcie->dev, "Link is DOWN\n");
> 
> or
> 
>   dev_info(pcie->dev, "Link is %s\n", pcie->link_up ? "UP" : "DOWN");
Agreed, will address in next patch.
> > +
> > +	/* Disable all misc interrupts */
> > +static const struct of_device_id nwl_pcie_of_match[] = {
> > +	{ .compatible = "xlnx,nwl-pcie-2.11", },
> > +	{}
> > +};
> > +	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	err = nwl_pcie_parse_dt(pcie, pdev);
> > +	if (err) {
> > +		dev_err(pcie->dev, "Parsing DT failed\n");
> > +		return err;
> 
> This leaks the nwl_pcie struct you just allocated.  And all the subsequent
> error paths do too, of course.
> 
Its resource-managed kzalloc(), kernel will take care of it.
> 
Bharat
