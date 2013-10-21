Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:33575
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752238Ab3JUGdo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Oct 2013 02:33:44 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Marek Vasut <marex@denx.de>
CC: Pratyush Anand <pratyush.anand@st.com>,
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
Subject: RE: [PATCH 5/6] PCI: imx6: Force Gen1 operation
Date: Mon, 21 Oct 2013 06:33:35 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D41096D@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <201310171934.34021.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D40FB22@039-SN2MPN1-011.039d.mgd.msft.net>
 <201310190707.15783.marex@denx.de>
In-Reply-To: <201310190707.15783.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Merak:
> Hi Richard,
> 
> > Hi Merak:
> > Thanks for your great help on the imx6 pcie switch support on the
> > latest kernel fristly.
> 
> Let's get this PCIe thing working well :)
> 
> [...]
> 
> 
> > Regarding to your comments why FORCE GEN1 mode in RC " Force Gen1
> > operation. In case the IP block is in Gen2 operation mode, it does not
> > detect the PCIe switch at all.", does the gen2 link can be set-up
> > without force gen1 mode?
> 
> What I did in the end for testing purpose was I followed the thread at FSL
> community in the link above, forced the link into Gen1 mode , then waited for
> link up, then started directed gen2 switch and waited for linkup again. This
> worked and the PCIe indicated the link is in Gen2 mode.
> 
> Interestingly enough, I also implemented PCIe driver for MX6 for U-Boot (will
> submit it shortly to U-Boot ML) and use it with the Intel i210 ethernet NIC
> now.
> When I use the PCIe in U-Boot, I don't need the Force-Gen1 thing above. I
> suspect though, that the Gen1 setting is preserved from U-Boot, where I have
> this as well.
> 
[Richard] It's great, thanks.
> > About the errata mentioned in
> > https://community.freescale.com/thread/304284, the
> > errata-SW-workaround of initialization is contained in previous Sean Cross'
> codes, like this. /*
> >          * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
> >          * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
> >          * If (MAC/LTSSM.state == Recovery.RcvrLock)
> >          * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
> >          * to gen2 is stuck
> >          */
> 
> Is this not handling only the PHY part ? Honestly, I'm quite lost in the
> flurry of different opinions on the MX6 PCIe. Maybe you as a FSL guy could
> scrounge some internal knowledge ?
> 
[Richard] Take it easy, maybe there is a misunderstand between you and me.
It is handling only the PHY part.
The errata "PCIe: Clock pointers can lose sync during clock rate changes",
 I mentioned previously is discussed in 
(https://community.freescale.com/message/316162#316162) too.

Charies Powe think that the SW workaround contained in FSL BSP is not complete for the errata.
Because I couldn't reproduce this issue at my side, the complete version of the SW workaround
of this errata is not included in the BSP yet.
That's all. Thanks.

> > > > > > So better solution should be to initialize RC by default at
> > > > > > GEN2 or highest speed. Further, a parameter say gen_only can
> > > > > > be passed from DT to force GEN1 only mode.
> > > > > >
> > > > > > What do you say?
> > > > >
> > > > > I say I'd like to know the root cause of this problem. This Gen2
> > > > > fix was pulled from one of the myriad variants of the FSL PCIe
> > > > > driver, so apparently this issue happens to other people as
> > > > > well. But why and how to properly fix this so the whole PCIe bus
> > > > > does operate in
> > > > > Gen2 mode, I cannot tell :-(
> > > >
> > > > [Richard] GEN2 mode had been verified in FSL 3.0.35 kernel
> > > > releases before. I don't know why it can't work in GEN2 mode in
> > > > the latest kernel. BTW, Based on for-next branch of shawn's git
> > > > reops and applied Merak's patch-set, my PI7C9X2G303EL with intel
> > > > e1000e network card plugged can't be detected at all. :(.
> > >
> > > I think we're still fighting some issue with resource mappings here.
> > > We also agreed with Tim that my patches are incomplete. I will send
> > > out a new version ASAP.
> >
> > [Richard] What's I said above is just curious that I encounter
> > different phenomena at my side With the almost same codes.
> 
> I talked to Tim about the mappings some more. It seems if the IOspace is
> disabled, everything works without hangs. If the IOspace is not disabled on
> the ethernet NICs, we get a hang.
[Richard] Ok, I see. Thanks.


Best Regards
Richard.


