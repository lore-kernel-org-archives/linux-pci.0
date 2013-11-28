Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:31738 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab3K1FtJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2013 00:49:09 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY00541LHVNX30@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 28 Nov 2013 14:49:07 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, 'Tim Harvey' <tharvey@gateworks.com>
Cc: 'Pratyush Anand' <pratyush.anand@st.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>, 'Harro Haan' <hrhaan@gmail.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1385500248-6551-1-git-send-email-marex@denx.de>
 <1385500248-6551-2-git-send-email-marex@denx.de>
 <20131127043009.GB12773@pratyush-vbox> <201311270944.09383.marex@denx.de>
In-reply-to: <201311270944.09383.marex@denx.de>
Subject: Re: [PATCH 2/7] [RFC] PCI: imx6: remove outbound io/mem ATU region
 mapping
Date: Thu, 28 Nov 2013 14:49:06 +0900
Message-id: <006301ceebfd$8d4ba040$a7e2e0c0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 27, 2013 5:44 PM, Marek Vasut wrote:
> Wednesday, November 27, 2013 1:30 PM, Pratyush Anand wrote:
> > On Wed, Nov 27, 2013 at 05:10:43AM +0800, Marek Vasut wrote:
> > > From: Tim Harvey <tharvey@gateworks.com>
> > >
> > > The IMX6 iATU is used for address translation between the AXI bus
> > > address space and PCI address space.  This is used for type0 and type1
> > > config cycles but is not necessary for outbound io/mem regions.
> > >
> > > This patch removes the calls that inappropriately re-configures the ATU
> > > viewport for outbound memory and IO after config cycles and removes them
> > > altogether as they are not necessary.
> >
> > Yes, they are not necessary for all the cases where translation is one
> > to one. So so for sure all the platform till now introduced should
> > work.
> > But, what about a platform where memory translation is not one to one?
> >
> > Existing code should work with all sort of memory translation on a
> > platform having atleast two viewports capable of programming any type
> > of outbound transaction.
> 
> Full ACK, that's why it's called RFC.
> 
> > > This resolves issues with PCI devices behind switches and has been tested
> > > with a Gige device behind a PLX PEX860x switch.  More testing is needed
> > > for other configurations.
> >
> > I do not understand if MX6 has 4 Outbound Viewport then how this patch
> > helps?
> > -- PCI devices behind switches would not have been working because
> > CFG1 transaction would not have been correct.
> > -- It works with this patch. This patch changes viewport for CFG1 from
> > 1 to 0.
> > -- Can it be possible that MX6 has some restriction on viewport
> > programming capability. I mean,like only viewport0 can be programmed
> > for CFG0/1?
> 
> Tim ?
> 
> Here is the MX6 datasheet [1], the section 48.3.9.1.1 and 48.3.9.1.2 describe
> the iATU configuration on MX6. My understanding from this description is that
> the MX6 has 4 inbound and 4 outbound iATU regions. Am I wrong ?

The numbers of inbound and outbound are hardware-configurable features.
Thus, these numbers  can be confirmed by Freescale  hardware engineers.
How about asking Freescale hardware engineers, if possible?

Best regards,
Jingoo Han
> 
> [1] http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6DQRM.pdf
> 
> > Otherwise I do not find any convincing reason that why this patch
> > helps in resolving issues with PCI devices behind switches.

