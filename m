Return-Path: <SRS0=6qAi=K5=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=6qAi=K5=arm.com=lorenzo.pieralisi@kernel.org>
Date: Tue, 14 Aug 2018 17:25:22 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1
 handling
Message-ID: <20180814162522.GA4986@e107981-ln.cambridge.arm.com>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-5-marek.vasut+renesas@gmail.com>
 <20171117174906.GB22599@red-moon>
 <3e0bc374-d296-675c-f290-256cc530feb7@gmail.com>
 <20180611135912.GD75679@bhelgaas-glaptop.roam.corp.google.com>
 <77d1eaf8-e180-f5f5-50f0-34c45e72c553@gmail.com>
 <20180613135308.GB201807@bhelgaas-glaptop.roam.corp.google.com>
 <20180613155252.GA12210@e107981-ln.cambridge.arm.com>
 <20180613172559.GC201807@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613172559.GC201807@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 13, 2018 at 12:25:59PM -0500, Bjorn Helgaas wrote:

<snip>

> Putting this workaround in the config accessor makes sense to me
> because in this situation the endpoint thinks it's in L1 and it won't
> receive TLPs for config accesses.  Apparently forcing the RP to L1
> completes the L1 entry, and the RP correctly handles the "Exit from L1
> State" (sec 5.3.2.2) that's required when the RP needs to send a TLP
> to the endpoint.
> 
> I think there's still a potential issue if the endpoint goes to a
> non-D0 state, the link is stuck in this transitional state (endpoint
> thinks it's L1, RP thinks it's L0), and the *endpoint* wants to exit
> L1, e.g., so it can send a PME message for a wakeup.  I don't know
> what happens then.

What is not clear to me is whether the endpoint link state can really be
in electrical idle (so ready for L1) if it has not received a
PM_Request_Ack DLLP from the host controller.

It is not clear whether the host controller sends it upon PM_Enter_L1
DLLP reception (ie does it actually carry out step 9 in PCIe specs
5.3.2.1 "Entry into L1 state") or it has to be coerced into L1 to send
it.

I agree with Bjorn that this is not clear at all and it boils down to
how HW is designed. We need to understand what "Endpoint in L1, RP in
L0" means in this context and for that we need an errata document
otherwise that's impossible to untangle.

Lorenzo

> If there were a real erratum writeup for this, it would probably
> discuss this situation.
> 
> > > > > If that's the case, we shouldn't enable L1
> > > > > entry on a card.  Is the core ASPM code doing something wrong here?
> > > > 
> > > > I can double-check, am I looking for some particular register in the
> > > > PCIe space ?
> > > > 
> > > > >>>> PM_ENTER_L1 DLLP to the host controller. At this point, we can no longer
> > > > >>>> access the card's config registers.
> > > > >>>>
> > > > >>>> The R-Car host controller will handle taking cards out of L1 as long as
> > > > >>>> the host controller has also been transitioned to L1 link state.
> > > > >>>
> > > > >>> I wonder why this can't be done in a PM restore hook but that's not
> > > > >>> really where my question is.
> > > > >>
> > > > >> I suspect because the link can be in L1 during startup too?
> > > > >>
> > > > >>>> Ideally, we would detect the PM_ENTER_L1 DLLP using an interrupt and
> > > > >>>> transition the host to L1 immediately. However, this patch just ensures
> > > > >>>> that we can talk to cards after they have gone into L1.
> > > > >>>
> > > > >>>> When attempting a config access, it checks to see if the card has gone
> > > > >>>> into L1, and if so, does the same for the host controller.
> > > > >>>>
> > > > >>>> This is based on a patch by Hien Dang <hien.dang.eb@rvc.renesas.com>
> > > > >>>>
> > > > >>>> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > > >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >>>> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > > > >>>> Cc: Simon Horman <horms+renesas@verge.net.au>
> > > > >>>> Cc: Wolfram Sang <wsa@the-dreams.de>
> > > > >>>> Cc: linux-renesas-soc@vger.kernel.org
> > > > >>>> ---
> > > > >>>> V2: - Drop extra parenthesis
> > > > >>>>     - Use GENMASK()
> > > > >>>>     - Fix comment "The HW will handle coming of of L1.", s/of of/out of/
> > > > >>>> ---
> > > > >>>>  drivers/pci/host/pcie-rcar.c | 24 ++++++++++++++++++++++++
> > > > >>>>  1 file changed, 24 insertions(+)
> > > > >>>>
> > > > >>>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > > > >>>> index ab61829db389..068bf9067ec1 100644
> > > > >>>> --- a/drivers/pci/host/pcie-rcar.c
> > > > >>>> +++ b/drivers/pci/host/pcie-rcar.c
> > > > >>>> @@ -92,6 +92,13 @@
> > > > >>>>  #define MACCTLR			0x011058
> > > > >>>>  #define  SPEED_CHANGE		BIT(24)
> > > > >>>>  #define  SCRAMBLE_DISABLE	BIT(27)
> > > > >>>> +#define PMSR			0x01105c
> > > > >>>> +#define  L1FAEG			BIT(31)
> > > > >>>> +#define  PM_ENTER_L1RX		BIT(23)
> > > > >>>> +#define  PMSTATE		GENMASK(18, 16)
> > > > >>>> +#define  PMSTATE_L1		GENMASK(17, 16)
> > > > >>>> +#define PMCTLR			0x011060
> > > > >>>> +#define  L1_INIT		BIT(31)
> > > > >>>>  #define MACS2R			0x011078
> > > > >>>>  #define MACCGSPSETR		0x011084
> > > > >>>>  #define  SPCNGRSN		BIT(31)
> > > > >>>> @@ -191,6 +198,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
> > > > >>>>  		unsigned int devfn, int where, u32 *data)
> > > > >>>>  {
> > > > >>>>  	int dev, func, reg, index;
> > > > >>>> +	u32 val;
> > > > >>>>  
> > > > >>>>  	dev = PCI_SLOT(devfn);
> > > > >>>>  	func = PCI_FUNC(devfn);
> > > > >>>> @@ -232,6 +240,22 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
> > > > >>>>  	if (pcie->root_bus_nr < 0)
> > > > >>>>  		return PCIBIOS_DEVICE_NOT_FOUND;
> > > > >>>>  
> > > > >>>> +	/*
> > > > >>>> +	 * If we are not in L1 link state and we have received PM_ENTER_L1 DLLP,
> > > > >>>> +	 * transition to L1 link state. The HW will handle coming out of L1.
> > > > >>>> +	 */
> > > > >>>> +	val = rcar_pci_read_reg(pcie, PMSR);
> > > > >>>> +	if (val & PM_ENTER_L1RX && (val & PMSTATE) != PMSTATE_L1) {
> > > > >>>> +		rcar_pci_write_reg(pcie, L1_INIT, PMCTLR);
> > > > >>>> +
> > > > >>>> +		/* Wait until we are in L1 */
> > > > >>>> +		while (!(val & L1FAEG))
> > > > >>>> +			val = rcar_pci_read_reg(pcie, PMSR);
> > > > >>>> +
> > > > >>>> +		/* Clear flags indicating link has transitioned to L1 */
> > > > >>>> +		rcar_pci_write_reg(pcie, L1FAEG | PM_ENTER_L1RX, PMSR);
> > > > >>>> +	}
> > > > >>>
> > > > >>> I do not get why you need to add the DLLP check for _every_ given config
> > > > >>> access and how/why it is just related to suspend/resume and not eg cold
> > > > >>> boot (I supposed it is because devices can enter L1 upon suspend(?)), I
> > > > >>> would ask you please to provide a thorough explanation so that I can
> > > > >>> actually review this patch (the commit log must be rewritten nonetheless,
> > > > >>> I do not think it is clear, at least it is not for me).
> > > > >>
> > > > >> See above
> > > > >>
> > > > >> -- 
> > > > >> Best regards,
> > > > >> Marek Vasut
> > > > 
> > > > 
> > > > -- 
> > > > Best regards,
> > > > Marek Vasut
