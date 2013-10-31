Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:59563
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730Ab3JaB0Z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 21:26:25 -0400
Date: Thu, 31 Oct 2013 09:26:18 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Marek Vasut <marex@denx.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
Message-ID: <20131031012615.GA19362@S2101-09.ap.freescale.net>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
 <201310301552.28866.marex@denx.de>
 <CAErSpo5dcqA+OkORmPO41THd+QaG53jXgZPogw3U5-1GP-hyoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo5dcqA+OkORmPO41THd+QaG53jXgZPogw3U5-1GP-hyoA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 30, 2013 at 10:25:37AM -0600, Bjorn Helgaas wrote:
> > Can you maybe pick at least these two:
> >
> > PCI: imx6: Make reset-gpio optional

Isn't there a comment from Jingoo on this patch unresolved?

> > PCI: imx6: Probe the PCIe in fs_initcall()

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> >
> > I think they should be harmless and the later one fixes a problem on MX6. I'm
> > now digging in the PCIe MX6 again btw.
> 
> I'm fine with taking these as long as Shawn acks them.
> 
> Bjorn

