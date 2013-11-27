Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:33653
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072Ab3K0Hm0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Nov 2013 02:42:26 -0500
From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
To: Pratyush Anand <pratyush.anand@st.com>, Marek Vasut <marex@denx.de>
CC: Tim Harvey <tharvey@gateworks.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: RE: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Wed, 27 Nov 2013 07:42:22 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D466C99@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <20131023064051.GA7646@pratyush-vbox> <201311262146.09780.marex@denx.de>
 <20131127035056.GA12773@pratyush-vbox>
In-Reply-To: <20131127035056.GA12773@pratyush-vbox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pratyush:

> -----Original Message-----
> From: Pratyush Anand [mailto:pratyush.anand@st.com]
> Sent: Wednesday, November 27, 2013 11:51 AM
> To: Marek Vasut
> Cc: Tim Harvey; Kishon Vijay Abraham I; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Bjorn Helgaas; Frank Li; Jingoo Han; Mohit KUMAR
> DCG; Zhu Richard-R65037; Sascha Hauer; Sean Cross; Shawn Guo; Siva Reddy
> Kallam; Srikanth T Shivanand; Troy Kisky; Yinghai Lu
> Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
> 
> On Wed, Nov 27, 2013 at 04:46:09AM +0800, Marek Vasut wrote:
> > Dear Pratyush Anand,
> >
> > > Hi,
> > >
> > > On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > > > The IMX6 iATU is used for address translation between the AXI bus
> > > > address space and PCI address space.  This is used for type0 and
> > > > type1 config cycles but is not necessary for outbound io/mem regions.
> > > >
> > > > This patch removes the calls that inappropriately re-configures
> > > > the ATU viewport for outbound memory and IO after config cycles
> > > > and removes them altogether as they are not necessary.
> > > >
> > > > This resolves issues with PCI devices behind switches and has been
> > > > tested with a Gige device behind a PLX PEX860x switch.  More
> > > > testing is needed for other configurations.
> > >
> > > It seems to me that in your controller you have only one view port.
> > > Also mem_base and mem_bus_addr is same. Thats why it works in your
> > > case.
> >
> > MX6 has 4 In/4 Out viewports AFAICT.
> 
> Then if I do not miss anything, MX6 should work even without this patch.

[Richard] Regarding to the commit message, and tests at my side, 
the switch wouldn't work well on imx6 platforms, if "the calls that inappropriately re-configures
 the ATU viewport for outbound memory and IO after config cycles " are not removed.

> 
> Regards
> Pratyush
> >
> > Best regards,
> > Marek Vasut

Best Regards
Richard Zhu


