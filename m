Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:55810
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750863Ab3JQHD2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Oct 2013 03:03:28 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Marek Vasut <marex@denx.de>, Pratyush Anand <pratyush.anand@st.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
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
Date: Thu, 17 Oct 2013 07:02:19 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D40F6D8@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-6-git-send-email-marex@denx.de>
 <20131016055427.GB2740@pratyush-vbox> <201310161557.41041.marex@denx.de>
In-Reply-To: <201310161557.41041.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek:

> -----Original Message-----
[...]
> > > ---
> > >
> > >  drivers/pci/host/pci-imx6.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/host/pci-imx6.c
> > > b/drivers/pci/host/pci-imx6.c index ca8c5de..8402e9a 100644
> > > --- a/drivers/pci/host/pci-imx6.c
> > > +++ b/drivers/pci/host/pci-imx6.c
> > > @@ -321,6 +321,7 @@ static void imx6_pcie_host_init(struct pcie_port
> > > *pp)
> > >
> > >  {
> > >
> > >  	int count = 0;
> > >  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> > >
> > > +	uint32_t tmp;
> > >
> > >  	imx6_pcie_assert_core_reset(pp);
> > >
> > > @@ -330,13 +331,23 @@ static void imx6_pcie_host_init(struct
> > > pcie_port
> > > *pp)
> > >
> > >  	dw_pcie_setup_rc(pp);
> > >
> > > +	/*
> > > +	 * FIXME:
> > > +	 * Force Gen1 operation. In case the IP block is in Gen2 operation
> > > +	 * mode, it does not detect the PCIe switch at all.
> > > +	 */
> > > +	tmp = readl(pp->dbi_base + 0x7c);
> > > +	tmp &= ~0xf;
> > > +	tmp |= 0x1;
> > > +	writel(tmp, pp->dbi_base + 0x7c);
> > > +
> >
> > Since you are forcing RC to work in GEN1, so you will not be able to
> > connect any device at GEN2 now.
> 
> I'd rather prefer to know WHY if the RC is operating in Gen2 mode by default,
> I cannot see the PCIe switch (Pericom PI7C9X2G303) connected to it. I was
> unable to figure this out. Tim pointed out this thread [1] , so it might be
> related in some way.
> 
> [1] https://community.freescale.com/message/316162#316162
> 
> I tried switching the PCIe RC to Gen2 operation right after LinkUp by writing
> this register with 0x2 again and re-issuing the LinkUp check, which passed and
> the status register reported Gen2 operation, but then the PCIe Intel NIC
> connected to the downstream port of the Pericom switch still reported Gen1
> operation for some reason.
> 
 [Richard] Is your Inetl NIC GEN1 EP device?

> > Yes, There are some buggy PCIe devices which works with GEN1 only host.
> 
> The pericom one is Gen2 according to it's datasheet.
[Richard] Yes, it is. Pericom's PI7C9X2G303EL is GEN2 PCIe switch.
It had been verified on FSL's 3.0.35 releases.

> 
> > So better solution should be to initialize RC by default at GEN2 or
> > highest speed. Further, a parameter say gen_only can be passed from DT
> > to force GEN1 only mode.
> >
> > What do you say?
> 
> I say I'd like to know the root cause of this problem. This Gen2 fix was
> pulled from one of the myriad variants of the FSL PCIe driver, so apparently
> this issue happens to other people as well. But why and how to properly fix
> this so the whole PCIe bus does operate in Gen2 mode, I cannot tell :-(
[Richard] GEN2 mode had been verified in FSL 3.0.35 kernel releases before.
I don't know why it can't work in GEN2 mode in the latest kernel.
BTW, Based on for-next branch of shawn's git reops and applied Merak's patch-set,
 my PI7C9X2G303EL with intel e1000e network card plugged can't be detected at all. :(.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html


Best Regards
Richard Zhu

