Return-Path: <SRS0=ffBy=LF=renesas.com=phil.edworthy@kernel.org>
Return-Path: <SRS0=ffBy=LF=renesas.com=phil.edworthy@kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Marek Vasut <marek.vasut@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Wolfram
 Sang <wsa@the-dreams.de>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1
 handling
Date: Wed, 22 Aug 2018 09:20:34 +0000
Message-ID: 
 <TY1PR01MB1769E4E90A3886D8C631F74FF5300@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20180611135912.GD75679@bhelgaas-glaptop.roam.corp.google.com>
 <77d1eaf8-e180-f5f5-50f0-34c45e72c553@gmail.com>
 <20180613135308.GB201807@bhelgaas-glaptop.roam.corp.google.com>
 <20180613155252.GA12210@e107981-ln.cambridge.arm.com>
 <20180613172559.GC201807@bhelgaas-glaptop.roam.corp.google.com>
 <1d543b91-ac4f-7b61-4b2c-d8865e06d31e@gmail.com>
 <9b91bbd9-64df-764e-e553-a37463549a92@gmail.com>
 <TY1PR01MB176994051783997958BAB14AF5320@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20180820144733.GA24413@red-moon>
 <TY1PR01MB1769D7656974C9EF15948159F5310@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <20180821153203.GB29550@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180821153203.GB29550@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 21 August 2018 16:32, Lorenzo Pieralisi wrote:
> On Tue, Aug 21, 2018 at 08:58:38AM +0000, Phil Edworthy wrote:
> > On 20 August 2018 15:48 Lorenzo Pieralisi wrote:
> > > On Mon, Aug 20, 2018 at 01:44:48PM +0000, Phil Edworthy wrote:
> > >
> > > [...]
> > >
> > > > However, both before and after this patch, the RP does not
> > > > transition
> > > > L1 when the endpoints change to L1.
> > > > This patch only transitions the RP to L1 during accessing a card's
> > > > config registers, if the RP is not in L1 link state and has
> > > > received
> > > > PM_ENTER_L1 DLLP (e.g. resume). After this, the hardware will
> > > > handle the transition out of L1.
> > > >
> > > > The relevant part of the rcar manual says: "After a recovery to
> > > > L0, if the device is in the Non-D0 state and PM_Enter_L1 DLLP is
> > > > transmitted from the downstream device, software should confirm
> > > > that hardware is in the L0 state (PMSR.PMSTATE =3D L0) and initiate
> > > > the L1 transition sequence again (write 1 to PMCTLR.L1IATN). In
> > > > this case, the sequence
> > > > is: L0 ??? L1 ??? L0 recovery ??? L1 again."
> > >
> > > Can you map these FSM steps to this patch code please ? I would like
> > > to understand what Link state maps to which command written and
> when.
> > I don't think I can because we are not initially entering L1. Looking
> > at this again, I think this section of the manual only helps in
> > indicating how to detect we should have gone into L1 and how to poke
> > the HW to initiate the transition to L1.
> >
> > On system suspend, the EP sends PM_Enter_L1 DLLP and enters L1 state.
>=20
> I am still struggling to understand what "EP enters L1 state" means. A li=
nk in
> L1 means both ends of the link are in electrical idle, it is a two-way
> handshake, see PCI express specifications 5.3.2.1 "Entry into the L1 stat=
e".
Sorry, I'm no PCIe expert and the rcar HW documentation doesn't provide
enough detail. I guess (that's all I can do with this) the following:
a) the EP sends the PM_Enter_L1 DLLP,
b) the RP sends a PM_Request_Ack DLLP.
c) The EP physical layer is then inactive.
However, the rcar RP doesn't complete L1 transition, so the RP physical lay=
er
is still active. Hence the EP thinks it is in L1, but the RP is not.


> > The rcar RP cannot enter L1 by HW alone, so is still in L0.
>=20
> See above.
>=20
> > The only way out of this from the PCIe spec FSM is for both EP and RP
> > to enter the Recovery state.
> > The patch simply detects that we should have gone into L1, and so
> > initiates that state change, and the HW will then handle the
> > transition from L1 to Recovery and then on to L0.
>=20
> That I can understand, I reckon it is to "reset" the RP link state machin=
e to a
> "sane" state.


Bjorn's comment added back:
> I think there's still a potential issue if the endpoint goes to a
> non-D0 state, the link is stuck in this transitional state (endpoint=20
> thinks it's L1, RP thinks it's L0), and the *endpoint* wants to exit=20
> L1, e.g., so it can send a PME message for a wakeup.  I don't know=20
> what happens then.

> > > > I don't think the potential issue that Bjorn talked about can
> > > > happen because the RP does go into L1. I could be wrong though...
> > >
> > > I do not understand this paragraph, mind elaborating on it ?
> > As rcar RP only supports D0 and D3hot/cold, (the manual says it
> > supports D3cold, but I cannot see how if it doesn't support L2 or L3
> > states), if you force the link to D3, we can only be in L1 state.
>=20
> D3 is a device state, not a link state. I still do not understand this st=
atement.
>=20
> The link between RP and EP can enter L1 when all functions in the EP are =
in a
> device state !=3D D0 but, as I mentioned above, it is still unclear what =
happens
> in this platform since I do not get what state in the PCI spec 5.3.2.1 st=
ate
> machine the RP Link state machine is in.
>=20
> If we programme the device into any D-state and the device wants to send =
a
> PME message _before_ we reset the RP state machine with the procedure
> described in this thread, what happens ? Or, more explicitly, what are in
> _HW_ the states of upstream and downstream link state machines when the
> EP is put in, say, D1 ?
rcar only supports D0 and D3, and L0/L0s/L1 so it's a bit simpler (I assume
devices can only be put into D states that are supported by the RP).=20
If I read the PCIe spec 5.3.2 correctly, for rcar, if the device is put int=
o D3,
the interconnect state must be L1. Hence my comment...

Re-reading Bjorn's comment, I believe he is discussing a different case.
I really don't know what will happen in this case.
Can you suggest a test to get a device to go from D3 to D0?
Would suspend using a NIC with WOL be enough? Or something simpler?


> That's in short our question. I would be happy to get to the bottom of th=
is
> since it is an interesting issue we are facing, we need HW details, I can=
 apply
> Marek's patch but I would be happier if I get the whole picture first.
Sure, I'll help if I can.

Thanks for your help
Phil
