Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56125 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3J3Pau (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Oct 2013 11:30:50 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/6] PCI: imx6: Random fixes
Date: Wed, 30 Oct 2013 15:52:28 +0100
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm" <linux-arm-kernel@lists.infradead.org>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
References: <1381853200-5534-1-git-send-email-marex@denx.de> <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
In-Reply-To: <CAErSpo6v4nvKQ4W9BhnUsNEjzsXoCiLxeFY-K=z=bMZ4AFOyGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310301552.28866.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

> On Tue, Oct 15, 2013 at 10:06 AM, Marek Vasut <marex@denx.de> wrote:
> > Set of random fixes for the PCIe driver for i.MX6 . With these fixes, my
> > setup with MX6Q -> PCIe bridge -> i210 ethernet adapter works as
> > expected.
> > 
> > NOTE: I'm sure this will start some discussion. There are quite a few
> > patches
> > 
> >       that are more of a hacks. Shawn, I didn't ignore your remark about
> >       the clock patches, I will test it ASAP, I just want to have these
> >       fixes in the public so others can comment/test.
> > 
> > Marek Vasut (6):
> >   PCI: imx6: Make reset-gpio optional
> >   PCI: imx6: Fix the clock for PCIe
> >   ARM: dts: imx6qdl: Fix the clock for PCIe
> >   PCI: imx6: Probe the PCIe in fs_initcall()
> >   PCI: imx6: Force Gen1 operation
> >   PCI: designware: Fix DT resource retrieval
> >  
> >  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
> >  arch/arm/boot/dts/imx6qdl.dtsi                     |  4 +-
> >  drivers/pci/host/pci-imx6.c                        | 63
> >  ++++++++++++++++------ drivers/pci/host/pcie-designware.c              
> >    | 17 +++---
> >  4 files changed, 55 insertions(+), 31 deletions(-)
> 
> I'm ignoring this series for now.  I assume you'll post an updated
> series as mentioned in your Oct 17 response to "[Patch 5/6] PCI: imx6:
> Force Gen1 operation."  Please mark that series as "v2" when you post
> it.  My assumption is still that Shawn Guo will ack the
> drivers/pci/host/ pieces before I apply them [1].

Can you maybe pick at least these two:

PCI: imx6: Make reset-gpio optional
PCI: imx6: Probe the PCIe in fs_initcall()

I think they should be harmless and the later one fixes a problem on MX6. I'm 
now digging in the PCIe MX6 again btw.

Best regards,
Marek Vasut
