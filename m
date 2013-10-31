Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55955 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab3JaBip (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 21:38:45 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVI002Q6F855TA0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 31 Oct 2013 10:38:43 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Shawn Guo' <shawn.guo@linaro.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>
Cc: 'Marek Vasut' <marex@denx.de>, linux-pci@vger.kernel.org,
	'linux-arm' <linux-arm-kernel@lists.infradead.org>,
	'Frank Li' <lznuaa@gmail.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
 <201310301552.28866.marex@denx.de>
 <CAErSpo5dcqA+OkORmPO41THd+QaG53jXgZPogw3U5-1GP-hyoA@mail.gmail.com>
 <20131031012615.GA19362@S2101-09.ap.freescale.net>
In-reply-to: <20131031012615.GA19362@S2101-09.ap.freescale.net>
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
Date: Thu, 31 Oct 2013 10:38:42 +0900
Message-id: <003101ced5d9$ee6f63a0$cb4e2ae0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 31, 2013 10:26 AM, Shawn Guo wrote:
> On Wed, Oct 30, 2013 at 10:25:37AM -0600, Bjorn Helgaas wrote:
> > > Can you maybe pick at least these two:
> > >
> > > PCI: imx6: Make reset-gpio optional
> 
> Isn't there a comment from Jingoo on this patch unresolved?

(+cc Kishon Vijay Abraham I)

Oh, right.
Please fix the Documentation part as below.
: http://www.spinics.net/lists/linux-pci/msg25951.html

> 
> > > PCI: imx6: Probe the PCIe in fs_initcall()
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> > >
> > > I think they should be harmless and the later one fixes a problem on MX6. I'm
> > > now digging in the PCIe MX6 again btw.
> >
> > I'm fine with taking these as long as Shawn acks them.
> >
> > Bjorn

