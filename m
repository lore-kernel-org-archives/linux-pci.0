Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34709 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab3JHU43 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 16:56:29 -0400
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Tue, 8 Oct 2013 22:56:28 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"Zhu Richard-R65037" <r65037@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	tharvey@gateworks.com, Frank Li <lznuaa@gmail.com>,
	Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org> <CAErSpo4JhjW5a-74eJp5bajmAMKSn4Vxknk8NoVdD462N=Ncug@mail.gmail.com>
In-Reply-To: <CAErSpo4JhjW5a-74eJp5bajmAMKSn4Vxknk8NoVdD462N=Ncug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310082256.28474.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

> On Wed, Sep 25, 2013 at 9:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Bjorn,
> > 
> > This is basically a resend of imx6 pcie driver patch for inclusion into
> > PCI tree.  Since we expect you apply the patch with your SoB, I dropped
> > your ACK tag there.
> > 
> > I have to ask you to carry the first patch which adds some macros to be
> > used by pcie driver patch.  Since imx6q-iomuxc-gpr.h gets rare updates
> > recently, it should be less likely we will run into merge conflict on it.
> > 
> > Changes since v6:
> > 
> > * Drop arch bits from driver patch, and will handle arch bits through
> > 
> >   arm-soc separately.
> > 
> > * Use devm_clk_get() instead of clk_get().
> > * Drop unnecessary (val != exp_val) check in pcie_phy_poll_ack() loop.
> > * Rename function imx6_init() to imx6_pcie_init().
> > 
> > Shawn
> > 
> > Sean Cross (2):
> >   ARM: imx6q: Add PCIe bits to GPR syscon definition
> >   PCI: imx6: Add support for i.MX6 PCIe controller
> >  
> >  .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
> >  drivers/pci/host/Kconfig                           |    6 +
> >  drivers/pci/host/Makefile                          |    1 +
> >  drivers/pci/host/pci-imx6.c                        |  576
> >  ++++++++++++++++++++ include/linux/mfd/syscon/imx6q-iomuxc-gpr.h       
> >  |    8 +
> >  5 files changed, 597 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/pci/host/pci-imx6.c
> 
> I merged both of these to my pci/host-imx6 branch for v3.13.
> 
> I made a couple minor spelling and whitespace corrections.

I have MX6 hardware with a PCIe switch, so I can test that stuff. Thus far, of 
course, the switch doesn't work. Is getting the switch to work only a matter of 
programming the RdWr0 vs. RdWr1 mode into the iATU or is there something more ?

Thanks!

Best regards,
Marek Vasut
