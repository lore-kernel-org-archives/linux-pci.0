Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46776 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab3JSFH3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Oct 2013 01:07:29 -0400
From: Marek Vasut <marex@denx.de>
To: "Zhu Richard-R65037" <r65037@freescale.com>
Subject: Re: [PATCH 5/6] PCI: imx6: Force Gen1 operation
Date: Sat, 19 Oct 2013 07:07:15 +0200
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1381853200-5534-1-git-send-email-marex@denx.de> <201310171934.34021.marex@denx.de> <0E83723C55F66F43A6041464FE31119D40FB22@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <0E83723C55F66F43A6041464FE31119D40FB22@039-SN2MPN1-011.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310190707.15783.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Richard,

> Hi Merak:
> Thanks for your great help on the imx6 pcie switch support on the latest
> kernel fristly.

Let's get this PCIe thing working well :)

[...]

> > > > > Since you are forcing RC to work in GEN1, so you will not be able
> > > > > to connect any device at GEN2 now.
> > > > 
> > > > I'd rather prefer to know WHY if the RC is operating in Gen2 mode by
> > > > default, I cannot see the PCIe switch (Pericom PI7C9X2G303)
> > > > connected to it. I was unable to figure this out. Tim pointed out
> > > > this thread [1] , so it might be related in some way.
> > > > 
> > > > [1] https://community.freescale.com/message/316162#316162
> > > > 
> > > > I tried switching the PCIe RC to Gen2 operation right after LinkUp
> > > > by writing this register with 0x2 again and re-issuing the LinkUp
> > > > check, which passed and the status register reported Gen2 operation,
> > > > but then the PCIe Intel NIC connected to the downstream port of the
> > > > Pericom switch still reported Gen1 operation for some reason.
> > >  
> > >  [Richard] Is your Inetl NIC GEN1 EP device?
> > 
> > Yes, the i210 is PCIe v2.1 (2.5GT/s) x1 device.
> > 
> > > > > Yes, There are some buggy PCIe devices which works with GEN1 only
> > > > > host.
> > > > 
> > > > The pericom one is Gen2 according to it's datasheet.
> > > 
> > > [Richard] Yes, it is. Pericom's PI7C9X2G303EL is GEN2 PCIe switch.
> > > It had been verified on FSL's 3.0.35 releases.
> > 
> > Verified how? What does it mean?
> > 
> > Note that when I followed [1] in this manner:
> > 
> > 1) Force GEN1 mode
> > 2) Wait for PHY link up
> > 3) Allow GEN2 mode
> > 4) Start GEN2 speed change
> > 5) Wait for PHY link up
> > 
> > my devices were detected and the link between pericom and mx6 was
> > operating in gen2 mode. Thus I suspect we might need to start the port
> > in Gen1 mode and switch to Gen2 only after link is up. Does that make
> > sense?
> > 
> > https://community.freescale.com/thread/304284
> 
> [Richard] Yes, it make sense regarding to the
> https://community.freescale.com/thread/304284.
> 
> The verification I said above means that the Pericom's PI7C9X2G303EL PCIe
> GEN2 switch can work well on 3.0.35 kernel in GEN2 mode(without GEN1
> force), and hand been tested by kinds of PCIe EP device(GEN1: Intel e1000e
> network card, GEN2 xHCI USB3.0 PCIe x1 card).

Oh, thanks for verifying this!

> Regarding to your comments why FORCE GEN1 mode in RC " Force Gen1
> operation. In case the IP block is in Gen2 operation mode, it does not
> detect the PCIe switch at all.", does the gen2 link can be set-up without
> force gen1 mode?

What I did in the end for testing purpose was I followed the thread at FSL 
community in the link above, forced the link into Gen1 mode , then waited for 
link up, then started directed gen2 switch and waited for linkup again. This 
worked and the PCIe indicated the link is in Gen2 mode.

Interestingly enough, I also implemented PCIe driver for MX6 for U-Boot (will 
submit it shortly to U-Boot ML) and use it with the Intel i210 ethernet NIC now. 
When I use the PCIe in U-Boot, I don't need the Force-Gen1 thing above. I 
suspect though, that the Gen1 setting is preserved from U-Boot, where I have 
this as well.

> About the errata mentioned in
> https://community.freescale.com/thread/304284, the errata-SW-workaround of
> initialization is contained in previous Sean Cross' codes, like this. /*
>          * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
>          * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
>          * If (MAC/LTSSM.state == Recovery.RcvrLock)
>          * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
>          * to gen2 is stuck
>          */

Is this not handling only the PHY part ? Honestly, I'm quite lost in the flurry 
of different opinions on the MX6 PCIe. Maybe you as a FSL guy could scrounge 
some internal knowledge ?

> > > > > So better solution should be to initialize RC by default at GEN2
> > > > > or highest speed. Further, a parameter say gen_only can be passed
> > > > > from DT to force GEN1 only mode.
> > > > > 
> > > > > What do you say?
> > > > 
> > > > I say I'd like to know the root cause of this problem. This Gen2 fix
> > > > was pulled from one of the myriad variants of the FSL PCIe driver,
> > > > so apparently this issue happens to other people as well. But why
> > > > and how to properly fix this so the whole PCIe bus does operate in
> > > > Gen2 mode, I cannot tell :-(
> > > 
> > > [Richard] GEN2 mode had been verified in FSL 3.0.35 kernel releases
> > > before. I don't know why it can't work in GEN2 mode in the latest
> > > kernel. BTW, Based on for-next branch of shawn's git reops and applied
> > > Merak's patch-set, my PI7C9X2G303EL with intel e1000e network card
> > > plugged can't be detected at all. :(.
> > 
> > I think we're still fighting some issue with resource mappings here. We
> > also agreed with Tim that my patches are incomplete. I will send out a
> > new version ASAP.
> 
> [Richard] What's I said above is just curious that I encounter different
> phenomena at my side With the almost same codes.

I talked to Tim about the mappings some more. It seems if the IOspace is 
disabled, everything works without hangs. If the IOspace is not disabled on the 
ethernet NICs, we get a hang.
