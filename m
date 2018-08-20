Return-Path: <SRS0=Qn04=LD=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=Qn04=LD=arm.com=lorenzo.pieralisi@kernel.org>
Date: Mon, 20 Aug 2018 15:47:33 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Wolfram Sang <wsa@the-dreams.de>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V2 4/5] PCI: rcar: Support runtime PM, link state L1
 handling
Message-ID: <20180820144733.GA24413@red-moon>
References: <20171117174906.GB22599@red-moon>
 <3e0bc374-d296-675c-f290-256cc530feb7@gmail.com>
 <20180611135912.GD75679@bhelgaas-glaptop.roam.corp.google.com>
 <77d1eaf8-e180-f5f5-50f0-34c45e72c553@gmail.com>
 <20180613135308.GB201807@bhelgaas-glaptop.roam.corp.google.com>
 <20180613155252.GA12210@e107981-ln.cambridge.arm.com>
 <20180613172559.GC201807@bhelgaas-glaptop.roam.corp.google.com>
 <1d543b91-ac4f-7b61-4b2c-d8865e06d31e@gmail.com>
 <9b91bbd9-64df-764e-e553-a37463549a92@gmail.com>
 <TY1PR01MB176994051783997958BAB14AF5320@TY1PR01MB1769.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <TY1PR01MB176994051783997958BAB14AF5320@TY1PR01MB1769.jpnprd01.prod.outlook.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 01:44:48PM +0000, Phil Edworthy wrote:

[...]

> However, both before and after this patch, the RP does not transition L1
> when the endpoints change to L1.
> This patch only transitions the RP to L1 during accessing a card's
> config registers, if the RP is not in L1 link state and has received
> PM_ENTER_L1 DLLP (e.g. resume). After this, the hardware will handle
> the transition out of L1.
> 
> The relevant part of the rcar manual says: "After a recovery to L0, if
> the device is in the Non-D0 state and PM_Enter_L1 DLLP is transmitted
> from the downstream device, software should confirm that hardware is
> in the L0 state (PMSR.PMSTATE = L0) and initiate the L1 transition
> sequence again (write 1 to PMCTLR.L1IATN). In this case, the sequence
> is: L0 → L1 → L0 recovery → L1 again."

Can you map these FSM steps to this patch code please ? I would like
to understand what Link state maps to which command written and when.

> I don’t think the potential issue that Bjorn talked about can happen
> because the RP does go into L1. I could be wrong though...

I do not understand this paragraph, mind elaborating on it ?

> The driver should also have a runtime-PM hook to transition to L1 on 
> suspend in order to save power. However, that is somewhat separate
> to the problem the patch fixes.

Yes that's a separate patch.

Thanks for chiming in, let's try to get to the bottom of this thread.

Lorenzo
