Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32905 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3K1FyX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Nov 2013 00:54:23 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY0062HLQK4O30@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 28 Nov 2013 14:54:20 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>
Cc: 'Tim Harvey' <tharvey@gateworks.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1382504143-27915-1-git-send-email-tharvey@gateworks.com>
 <201311262146.09780.marex@denx.de> <20131127035056.GA12773@pratyush-vbox>
 <201311270924.47277.marex@denx.de> <20131127083637.GD12773@pratyush-vbox>
In-reply-to: <20131127083637.GD12773@pratyush-vbox>
Subject: Re: [PATCH RFC] PCI: imx6: remove outbound io/mem ATU region mapping
Date: Thu, 28 Nov 2013 14:54:19 +0900
Message-id: <006401ceebfe$47ab6b00$d7024100$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, November 27, 2013 5:37 PM, Pratyush Anand wrote:
> On Wed, Nov 27, 2013 at 04:24:47PM +0800, Marek Vasut wrote:
> > > On Wed, Nov 27, 2013 at 04:46:09AM +0800, Marek Vasut wrote:
> > > > Dear Pratyush Anand,
> > > >
> > > > > Hi,
> > > > >
> > > > > On Wed, Oct 23, 2013 at 12:55:43PM +0800, Tim Harvey wrote:
> > > > > > The IMX6 iATU is used for address translation between the AXI bus
> > > > > > address space and PCI address space.  This is used for type0 and
> > > > > > type1 config cycles but is not necessary for outbound io/mem
> > > > > > regions.
> > > > > >
> > > > > > This patch removes the calls that inappropriately re-configures the
> > > > > > ATU viewport for outbound memory and IO after config cycles and
> > > > > > removes them altogether as they are not necessary.
> > > > > >
> > > > > > This resolves issues with PCI devices behind switches and has been
> > > > > > tested with a Gige device behind a PLX PEX860x switch.  More testing
> > > > > > is needed for other configurations.
> > > > >
> > > > > It seems to me that in your controller you have only one view port.
> > > > > Also mem_base and mem_bus_addr is same. Thats why it works in your
> > > > > case.
> > > >
> > > > MX6 has 4 In/4 Out viewports AFAICT.
> > >
> > > Then if I do not miss anything, MX6 should work even without this patch.
> >
> > Yes, yet, it does not. On the other hand, this defect is only problematic if you
> > use the devices behind a switch. Do you use a PCIe switch on your platform
> > please?
> 
> I had tested with device under bridge.
> Mohit is in process of validating SPEAr patches with latest kernel.
> Mohit, see if we can arrange a switch and test, once SPEAr platform is
> ready with latest kernel.

I agree with Pratyush Anand's opinion.
One of our engineers had tested PCI cards under switch.
As far as I know, there was no issue about this.
However, currently, I don't have any switches. So, I
Cannot test this on Exynos platform.

Mohit,
If you test a switch on SPEAr platform, it will be
very helpful. Thank you.

Best regards,
Jingoo Han

