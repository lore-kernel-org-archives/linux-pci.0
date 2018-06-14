Return-Path: <SRS0=U0OH=JA=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=U0OH=JA=arm.com=lorenzo.pieralisi@kernel.org>
Date: Thu, 14 Jun 2018 12:43:24 +0100
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
Message-ID: <20180614114324.GB20780@e107981-ln.cambridge.arm.com>
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
> On Wed, Jun 13, 2018 at 04:52:52PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Jun 13, 2018 at 08:53:08AM -0500, Bjorn Helgaas wrote:
> > > On Wed, Jun 13, 2018 at 01:54:51AM +0200, Marek Vasut wrote:
> > > > On 06/11/2018 03:59 PM, Bjorn Helgaas wrote:
> > > > > On Sun, Jun 10, 2018 at 03:57:10PM +0200, Marek Vasut wrote:
> > > > >> On 11/17/2017 06:49 PM, Lorenzo Pieralisi wrote:
> > > > >>> On Fri, Nov 10, 2017 at 10:58:42PM +0100, Marek Vasut wrote:
> > > > >>>> From: Phil Edworthy <phil.edworthy@renesas.com>
> > > > >>>>
> > > > >>>> Most PCIe host controllers support L0s and L1 power states via ASPM.
> > > > >>>> The R-Car hardware only supports L0s, so when the system suspends and
> > > > >>>> resumes we have to manually handle L1.
> > > > >>>> When the system suspends, cards can put themselves into L1 and send a
> > > > >>>
> > > > >>> I assumed L1 entry has to be negotiated depending upon the PCIe
> > > > >>> hierarchy capabilities, I would appreciate if you can explain to
> > > > >>> me what's the root cause of the issue please.
> > > > >>
> > > > >> You should probably ignore the suspend/resume part altogether. The issue
> > > > >> here is that the cards can enter L1 state, while the controller won't do
> > > > >> that automatically, it can only detect that the link went into L1 state.
> > > > >> If that happens,the driver must manually put the controller to L1 state.
> > > > >> The controller can transition out of L1 state automatically though.
> > > > > 
> > > > > From earlier discussion I thought the R-Car root port did not
> > > > > advertise L1 support.
> > > > 
> > > > Which discussion ? This one or somewhere else ?
> > > 
> > > https://lkml.kernel.org/r/HK2PR0601MB1393D917D343E6363484CA68F5CB0@HK2PR0601MB1393.apcprd06.prod.outlook.com
> > > 
> > > Re-reading that, I think I see my misunderstanding.  I was only
> > > considering L1 in the ASPM context.  I didn't realize the L1
> > > implications of devices being in states other than D0.
> > > 
> > > Obviously L1 support for ASPM is optional and advertised via Link
> > > Capabilities.  But per PCIe r4.0, sec 5.2, L1 support is required for
> > > PCI-PM compatible power management, and is entered "whenever all
> > > Functions ... are programmed to a D-state other than D0."
> > > 
> > > So I guess this means *every* device is supposed to support L1 when it
> > > is in a non-D0 power state.  I think *this* is the case you're
> > > solving.
> > > 
> > > A little more of this detail, e.g., that this issue has nothing to do
> > > with ASPM, it's probably an R-Car erratum that the RC can't transition
> > > from L1 to L0, etc., in the changelog would really help clear things
> > > up for me.
> > 
> > I think that the issue is related to the L0->L1 transition upon system
> > suspend (ie the kernel must force the controller into L1 when all
> > devices are in a sleep state) and for this specific reason I still think
> > that checking for a PM_Enter_L1 DLLP reception and doing the L0->L1
> > transition within a config access is wrong and prone to error (what's
> > the rationale behind that ?), this ought to be done using PM methods in
> > the host controller driver.
> 
> But doesn't the problem happen whenever the link goes to L1, for any
> reason?  E.g., runtime power management might put an endpoint in D3
> even if we're not doing a whole system suspend.  A user could even
> force the endpoint to D3 by writing to PCI_PM_CTRL with "setpci".  If
> that's the case, I don't think the host controller PM methods will be
> enough to work around the issue.

By PM methods I included runtime PM (and related device dependencies)
but you are right there, I missed some use cases (which are not
necessarily the most common but we have to cope with them anyway).

> The comment in the patch ("If we are not in L1 link state and we have
> received PM_ENTER_L1 DLLP, transition to L1 link state") suggests that
> the R-Car host doesn't handle step 10 in PCIe r4.0, sec 5.3.2.1
> correctly, i.e., it doesn't complete the transition of the link to L1.
> 
> Putting this workaround in the config accessor makes sense to me
> because in this situation the endpoint thinks it's in L1 and it won't
> receive TLPs for config accesses.  Apparently forcing the RP to L1
> completes the L1 entry, and the RP correctly handles the "Exit from L1
> State" (sec 5.3.2.2) that's required when the RP needs to send a TLP
> to the endpoint.

Yep, see above, I do not like it but I do not see how we can solve it
in another way either.

> I think there's still a potential issue if the endpoint goes to a
> non-D0 state, the link is stuck in this transitional state (endpoint
> thinks it's L1, RP thinks it's L0), and the *endpoint* wants to exit
> L1, e.g., so it can send a PME message for a wakeup.  I don't know
> what happens then.

That's for Marek to explain and the explanation has to go along
with this discussion in the resulting commit log.

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
