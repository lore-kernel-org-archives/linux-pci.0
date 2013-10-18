Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [213.199.154.252] ([213.199.154.252]:45344 "EHLO
	db9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754971Ab3JRCOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Oct 2013 22:14:55 -0400
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
Date: Fri, 18 Oct 2013 02:12:52 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40FB22@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <201310161557.41041.marex@denx.de>
 <0E83723C55F66F43A6041464FE31119D40F6D8@039-SN2MPN1-011.039d.mgd.msft.net>
 <201310171934.34021.marex@denx.de>
In-Reply-To: <201310171934.34021.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Merak:
Thanks for your great help on the imx6 pcie switch support on the latest kernel fristly.

> -----Original Message-----
> From: Marek Vasut [mailto:marex@denx.de]
> Sent: Friday, October 18, 2013 1:35 AM
> To: Zhu Richard-R65037
> Cc: Pratyush Anand; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Frank Li; Jingoo Han; Mohit KUMAR DCG; Sascha
> Hauer; Sean Cross; Shawn Guo; Siva Reddy Kallam; Srikanth T Shivanand; Tim
> Harvey; Troy Kisky; Yinghai Lu
> Subject: Re: [PATCH 5/6] PCI: imx6: Force Gen1 operation
> 
> Hi Richard,
> 
> > Hi Marek:
> > > -----Original Message-----
> >
> > [...]
> >
> > > > > ---
> > > > >
> > > > >  drivers/pci/host/pci-imx6.c | 13 ++++++++++++-
> > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/host/pci-imx6.c
> > > > > b/drivers/pci/host/pci-imx6.c index ca8c5de..8402e9a 100644
> > > > > --- a/drivers/pci/host/pci-imx6.c
> > > > > +++ b/drivers/pci/host/pci-imx6.c
> > > > > @@ -321,6 +321,7 @@ static void imx6_pcie_host_init(struct
> > > > > pcie_port
> > > > > *pp)
> > > > >
> > > > >  {
> > > > >
> > > > >  	int count = 0;
> > > > >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > > > >
> > > > > +	uint32_t tmp;
> > > > >
> > > > >  	imx6_pcie_assert_core_reset(pp);
> > > > >
> > > > > @@ -330,13 +331,23 @@ static void imx6_pcie_host_init(struct
> > > > > pcie_port
> > > > > *pp)
> > > > >
> > > > >  	dw_pcie_setup_rc(pp);
> > > > >
> > > > > +	/*
> > > > > +	 * FIXME:
> > > > > +	 * Force Gen1 operation. In case the IP block is in Gen2
> operation
> > > > > +	 * mode, it does not detect the PCIe switch at all.
> > > > > +	 */
> > > > > +	tmp = readl(pp->dbi_base + 0x7c);
> > > > > +	tmp &= ~0xf;
> > > > > +	tmp |= 0x1;
> > > > > +	writel(tmp, pp->dbi_base + 0x7c);
> > > > > +
> > > >
> > > > Since you are forcing RC to work in GEN1, so you will not be able
> > > > to connect any device at GEN2 now.
> > >
> > > I'd rather prefer to know WHY if the RC is operating in Gen2 mode by
> > > default, I cannot see the PCIe switch (Pericom PI7C9X2G303)
> > > connected to it. I was unable to figure this out. Tim pointed out
> > > this thread [1] , so it might be related in some way.
> > >
> > > [1] https://community.freescale.com/message/316162#316162
> > >
> > > I tried switching the PCIe RC to Gen2 operation right after LinkUp
> > > by writing this register with 0x2 again and re-issuing the LinkUp
> > > check, which passed and the status register reported Gen2 operation,
> > > but then the PCIe Intel NIC connected to the downstream port of the
> > > Pericom switch still reported Gen1 operation for some reason.
> >
> >  [Richard] Is your Inetl NIC GEN1 EP device?
> 
> Yes, the i210 is PCIe v2.1 (2.5GT/s) x1 device.
> 
> > > > Yes, There are some buggy PCIe devices which works with GEN1 only host.
> > >
> > > The pericom one is Gen2 according to it's datasheet.
> >
> > [Richard] Yes, it is. Pericom's PI7C9X2G303EL is GEN2 PCIe switch.
> > It had been verified on FSL's 3.0.35 releases.
> 
> Verified how? What does it mean?
> 
> Note that when I followed [1] in this manner:
> 
> 1) Force GEN1 mode
> 2) Wait for PHY link up
> 3) Allow GEN2 mode
> 4) Start GEN2 speed change
> 5) Wait for PHY link up
> 
> my devices were detected and the link between pericom and mx6 was operating in
> gen2 mode. Thus I suspect we might need to start the port in Gen1 mode and
> switch to Gen2 only after link is up. Does that make sense?
> 
> https://community.freescale.com/thread/304284
> 
[Richard] Yes, it make sense regarding to the https://community.freescale.com/thread/304284.

The verification I said above means that the Pericom's PI7C9X2G303EL PCIe GEN2 switch can 
work well on 3.0.35 kernel in GEN2 mode(without GEN1 force), and hand been tested by kinds
 of PCIe EP device(GEN1: Intel e1000e network card, GEN2 xHCI USB3.0 PCIe x1 card).

Regarding to your comments why FORCE GEN1 mode in RC " Force Gen1 operation. In case the IP block
is in Gen2 operation mode, it does not detect the PCIe switch at all.",
 does the gen2 link can be set-up without force gen1 mode?

About the errata mentioned in https://community.freescale.com/thread/304284,
 the errata-SW-workaround of initialization is contained in previous Sean Cross' codes, like this.
        /*
         * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
         * Wait 2ms (LTSSM timeout is 24ms, PHY lock is ~5us in gen2).
         * If (MAC/LTSSM.state == Recovery.RcvrLock)
         * && (PHY/rx_valid==0) then pulse PHY/rx_reset. Transition
         * to gen2 is stuck
         */

> > > > So better solution should be to initialize RC by default at GEN2
> > > > or highest speed. Further, a parameter say gen_only can be passed
> > > > from DT to force GEN1 only mode.
> > > >
> > > > What do you say?
> > >
> > > I say I'd like to know the root cause of this problem. This Gen2 fix
> > > was pulled from one of the myriad variants of the FSL PCIe driver,
> > > so apparently this issue happens to other people as well. But why
> > > and how to properly fix this so the whole PCIe bus does operate in
> > > Gen2 mode, I cannot tell :-(
> >
> > [Richard] GEN2 mode had been verified in FSL 3.0.35 kernel releases before.
> > I don't know why it can't work in GEN2 mode in the latest kernel.
> > BTW, Based on for-next branch of shawn's git reops and applied Merak's
> > patch-set, my PI7C9X2G303EL with intel e1000e network card plugged
> > can't be detected at all. :(.
> 
> I think we're still fighting some issue with resource mappings here. We also
> agreed with Tim that my patches are incomplete. I will send out a new version
> ASAP.
[Richard] What's I said above is just curious that I encounter different phenomena at my side
With the almost same codes.

Thanks again.

Best Regards
Richard Zhu


