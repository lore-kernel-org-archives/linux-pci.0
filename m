Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:39520
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751316AbcBLOqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2016 09:46:17 -0500
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
	'Bjorn Helgaas' <helgaas@kernel.org>
CC: "'robh+dt@kernel.org'" <robh+dt@kernel.org>,
	"'pawel.moll@arm.com'" <pawel.moll@arm.com>,
	"'mark.rutland@arm.com'" <mark.rutland@arm.com>,
	"'ijc+devicetree@hellion.org.uk'" <ijc+devicetree@hellion.org.uk>,
	"'galak@codeaurora.org'" <galak@codeaurora.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>,
	"'bhelgaas@google.com'" <bhelgaas@google.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'tinamdar@apm.com'" <tinamdar@apm.com>,
	"'treding@nvidia.com'" <treding@nvidia.com>,
	"'rjui@broadcom.com'" <rjui@broadcom.com>,
	"'Minghuan.Lian@freescale.com'" <Minghuan.Lian@freescale.com>,
	"'m-karicheri2@ti.com'" <m-karicheri2@ti.com>,
	"'hauke@hauke-m.de'" <hauke@hauke-m.de>,
	"'marc.zyngier@arm.com'" <marc.zyngier@arm.com>,
	"'dhdang@apm.com'" <dhdang@apm.com>,
	"'sbranden@broadcom.com'" <sbranden@broadcom.com>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
	"'linux-arm-kernel@lists.infradead.org'"
	<linux-arm-kernel@lists.infradead.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
	Ravikiran Gummaluri <rgummal@xilinx.com>,
	"'Paul Burton'" <paul.burton@imgtec.com>,
	'Thierry Reding' <thierry.reding@gmail.com>,
	'Stephen Warren' <swarren@wwwdotorg.org>,
	'Alexandre Courbot' <gnurou@gmail.com>
Subject: RE: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
Date: Fri, 12 Feb 2016 14:45:50 +0000
Message-ID: <8520D5D51A55D047800579B094147198258821DA@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1448798633-12697-1-git-send-email-bharatku@xilinx.com>
 <20151209231921.GI31930@localhost>
 <8520D5D51A55D047800579B09414719825869A85@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20151210201817.GB367@localhost>
 <8520D5D51A55D047800579B09414719825869EDC@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B0941471982586BC8D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160110220819.GA25883@localhost>
 <8520D5D51A55D047800579B09414719825870721@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B0941471982587422C@XAP-PVEXMBX01.xlnx.xilinx.com>
In-Reply-To: <8520D5D51A55D047800579B0941471982587422C@XAP-PVEXMBX01.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Ping
> 
> > Subject: RE: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for
> > Xilinx NWL PCIe Host Controller
> >
> >  > On Mon, Dec 21, 2015 at 05:23:47AM +0000, Bharat Kumar Gogada wrote:
> > > > Hi Bjorn, can you comment on this. Marc has also replied for query
> > > > on
> > > irq_dispose_mapping().
> > >
> > > I'm not sure exactly what you want me to comment on.
> > I wanted you to check for Marc's reply.
> > >
> > > > > Subject: RE: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support for
> > > > > Xilinx NWL PCIe Host Controller
> > > > >
> > > > > > Subject: Re: [PATCH v11] PCI: Xilinx-NWL-PCIe: Added support
> > > > > > for Xilinx NWL PCIe Host Controller
> > > > > >
> > > > > > [+cc Marc for irq_dispose_mapping() question]
> > > > > >
> > > > > > On Thu, Dec 10, 2015 at 02:10:34PM +0000, Bharat Kumar Gogada
> > > wrote:
> > > > > > I'm trying to figure out what the difference is between these
> > > > > > two checks and why you have both of them:
> > > > > >
> > > > > > > +	if (bus->number == pcie->root_busno && devfn > 0)
> > > > > > > +	if (bus->primary == pcie->root_busno && devfn > 0)
> > > > > >
> > > > > > If I understand correctly, pcie->root_busno is the bus number
> > > > > > of the Root Port device (likely 00).  I think the "bus->number
> > > > > > ==
> > > > > > pcie->root_busno && devfn > 0" check means that the Root Port,
> > > > > > pcie->e.g.,
> > > > > > 00:00.0, is the only device allowed on bus 00.  Often a Root
> > > > > > Complex contains several Root Ports and other integrated
> > > > > > devices that typically are
> > > > > on bus 00.
> > > > > > But in your case, I think you're saying there is only the
> > > > > > single Root Port and no other devices.
> > > > > >
> > > > > > I think that first check takes care of everything on bus 00,
> > > > > > so I'm trying to figure out what the second check is for.
> > > > > > Assume your Root Port is device
> > > > > > 00:00.0 and it is a bridge to [bus 01-ff].  Then we have two
> > > > > > pci_bus structs with these values:
> > > > > >
> > > > > >   bus->number = 00
> > > > > >   bus->primary = 00
> > > > > >   bus->busn_res = [bus 00-ff]
> > > > > >
> > > > > >   bus->number = 01
> > > > > >   bus->primary = 00
> > > > > >   bus->busn_res = [bus 01-ff]
> > > > > >
> > > > > > Because of the first check, 00:00.0 is the only possible
> > > > > > device on bus 00, and because of the second check, 01:00.0 is
> > > > > > the only possible device on
> > > > > bus 01.
> > > > > > Therefore, you don't support a multifunction device connected
> > > > > > to the Root Port.  Right?
> > > > > >
> > > > > We support multifunction devices also, so this check should not
> > > > > be there, will remove this check in next patch.
> > >
> > > It looks like you're planning to change this.
> > No, our core supports multifunction devices it was my
> > misunderstanding, due to which this condition was present.
> > > > > > > > > +		return false;
> > > > > > > > > +
> > > > > > > > > +	return true;
> > > > > > > > > +}
> > > > > > > > > + * nwl_setup_sspl - Set Slot Power limit
> > > > > > > > > + *
> > > > > > > > > + * @pcie: PCIe port information  */ static int
> > > > > > > > > +nwl_setup_sspl(struct nwl_pcie *pcie)
> > > > > > > >
> > > > > > > The Set_Slot_Power_Limit Message includes a one DW data
> > payload.
> > > > > > > The data payload is copied from the Slot Capabilities
> > > > > > > register of the Downstream Port and is written into the
> > > > > > > Device Capabilities register of the Upstream Port on the
> > > > > > > other side of the Link. Bits 9:8 of the data payload map to
> > > > > > > the Slot Power Limit Scale field and bits 7:0 map to the
> > > > > > > Slot Power Limit Value field. Bits 31:10 of the data payload
> > > > > > > must be set to all 0's by the Transmitter and ignored by the
> > > > > Receiver.
> > > > > >
> > > > > > > This Message is sent automatically by the Downstream Port
> > > > > > > (of a Root Complex or a Switch) when one of the following
> > > > > > > events
> > occurs:
> > > > > > > -> On a Configuration Write to the Slot Capabilities
> > > > > > > -> register (see
> > > > > > > Section 7.8.9) when the Data Link Layer reports DL_Up status.
> > > > > >
> > > > > > I interpret this as meaning "the *hardware* automatically
> > > > > > sends a Set_Slot_Power_Limit Message."  There's no mention of
> > > > > > software doing anything other than the configuration write.
> > > > > >
> > > > > > If your hardware doesn't do that, I think it's a defect.  It's
> > > > > > fine to work around it, but we should have a comment to that
> > > > > > effect so people don't copy the code to new drivers that don't
> > > > > > need
> > it.
> > > > >
> > > > > Our hardware is not capable of doing it, so we are doing it
> > > > > software. Yes I will add some comments.
> > >
> > > And add a comment here.
> > >
> > You meant to add comments for the function clearly mentioning that
> > hardware doesn't support this so doing it software ?
> >
> > > > > > It's a little strange that 7.8.9 talks about writing to this
> > > > > > register when all of its fields are HwInit and supposedly
> > > > > > read-only.  I had assumed devices would use strapping or
> > > > > > implementation-specific registers to set the Slot Power
> > > > > > values, but maybe some devices use direct
> > > > > writes to Slot Capabilities instead.
> > > > > >
> > > > > > BTW, I noticed a related lspci bug: it didn't decode the
> > > > > > Capture Slot Power Limit in Device Capabilities of Endpoints.
> > > > > > I posted a fix for that
> > > > > separately.
> > > > > >
> > > > > > The Slot Power Limit (in Slot Capabilities) indicates how much
> > > > > > power the slot can supply to a downstream device.  That's a
> > > > > > function of the platform design, so it seems like this is
> > > > > > something you want to set via DT or some other mechanism that
> > > > > > knows
> > > about the platform.
> > > > > > Intercepting all config writes and updating it with whatever
> > > > > > the caller supplies doesn't sound wise.  The value might be
> > > > > > coming from setpci or some other source with no knowledge of the
> platform.
> > > > >
> > > > > Agreed, but this is what can be done, it is difficult to
> > > > > determine who does what.
> > >
> > > Your driver is based on DT.  What prevents you from adding a DT
> > > property that shows the slot power capability?
> > >
> > You meant to add a DT property, Example: xlnx,slot_power_cap; as
> > required property, and use this property to call nwl_setup_sspl
> > function. Currently this function is being invoked in config write
> > function if the condition meets a write to slot power capabilities register.
> > > > > > > > > +			status = nwl_bridge_readl(pcie,
> > > > > TX_PCIE_MSG)
> > > > > > > > > +						  &
> MSG_DONE_BIT;
> > > > > > > > > +			if (status) {
> > > > > > > > > +				status =
> nwl_bridge_readl(pcie,
> > > > > > > > TX_PCIE_MSG)
> > > > > > > > > +						  &
> > > > > MSG_DONE_STATUS_BIT;
> > > > > >
> > > > > > > > It's not clear to me whether you need to re-read
> > > > > > > > TX_PCIE_MSG
> > > here.
> > > > > > >
> > > > > > > MSG_DONE_BIT qualifies MSG_DONE_STATUS_BIT; so value of
> > > > > > > MSG_DONE_STATUS_BIT is valid only when MSG_DONE_BIT = 1
> > > > > >
> > > > > > That doesn't answer the question of whether another read is
> > required.
> > > > > > In fact, I would argue that if MSG_DONE_STATUS_BIT is only
> > > > > > valid when MSG_DONE_BIT = 1, you *should* only do one read,
> > > > > > because
> > > you
> > > > > > want to capture both bits simultaneously so you know they're
> > > > > > consistent, e.g.,
> > > > > >
> > > > > >   status = nwl_bridge_readl(pcie, TX_PCIE_MSG);
> > > > > >   if (status & MSG_DONE_BIT) {
> > > > > >     if (status & MSG_DONE_STATUS_BIT)
> > > > > >       ...
> > > > > >   }
> > > > > >
> > > > > > If you read the register twice, you always have to worry about
> > > > > > what changes MSG_DONE_BIT, and how you guarantee that the
> > > second
> > > > > > read happens before MSG_DONE_BIT changes.
> > > > > >
> > > > > Agreed, will do it in this way, once will also confirm with IP
> > > > > owner regarding both bits being updated parallel.
> > >
> > > It sounds like you're working on resolving this.
> > >
> > > Did I miss a question for me?
> >
> > Since IP owner is different, we don't have exact information by that
> > time we commented, now we got Information from owner that both buts
> > simultaneously.
> >
> > Bharat
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
