Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:55621
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195Ab3JIFXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Oct 2013 01:23:51 -0400
From: Zhu Richard-R65037 <r65037@freescale.com>
To: Marek Vasut <marex@denx.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"tharvey@gateworks.com" <tharvey@gateworks.com>,
	Frank Li <lznuaa@gmail.com>, Sean Cross <xobs@kosagi.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: [PATCH v7 0/2] Add PCIe support for i.MX6q
Date: Wed, 9 Oct 2013 05:23:45 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D401869@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1380165887-13506-1-git-send-email-shawn.guo@linaro.org>
 <CAErSpo4JhjW5a-74eJp5bajmAMKSn4Vxknk8NoVdD462N=Ncug@mail.gmail.com>
 <201310082256.28474.marex@denx.de>
In-Reply-To: <201310082256.28474.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek:
Thanks for your kindly tests.

Regarding to my experience on 3.0.35 kernel, besides the programming the RdWr0 vs. RdWr1 mode into the iATU.
The INTx should be configured properly, for example, like the following one:

static int __init imx_pcie_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
{
       switch (pin) {
       case 1: return MXC_INT_PCIE_3;
       case 2: return MXC_INT_PCIE_2;
       case 3: return MXC_INT_PCIE_1;
       case 4: return MXC_INT_PCIE_0;
       default: return -1;
       }
}

static struct hw_pci imx_pci __initdata = {
        .nr_controllers = 1,
        .swizzle        = pci_std_swizzle,
        .setup          = imx_pcie_setup,
        .scan           = imx_pcie_scan_bus,
        .map_irq        = imx_pcie_map_irq,
};
Best Regards
Richard Zhu


-----Original Message-----
From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Marek Vasut
Sent: Wednesday, October 09, 2013 4:56 AM
To: linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas; Shawn Guo; Zhu Richard-R65037; linux-pci@vger.kernel.org; tharvey@gateworks.com; Frank Li; Sean Cross; Sascha Hauer
Subject: Re: [PATCH v7 0/2] Add PCIe support for i.MX6q

Hi,

> On Wed, Sep 25, 2013 at 9:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Bjorn,
> > 
> > This is basically a resend of imx6 pcie driver patch for inclusion 
> > into PCI tree.  Since we expect you apply the patch with your SoB, I 
> > dropped your ACK tag there.
> > 
> > I have to ask you to carry the first patch which adds some macros to 
> > be used by pcie driver patch.  Since imx6q-iomuxc-gpr.h gets rare 
> > updates recently, it should be less likely we will run into merge conflict on it.
> > 
> > Changes since v6:
> > 
> > * Drop arch bits from driver patch, and will handle arch bits 
> > through
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
> >  5 files changed, 597 insertions(+), 1 deletion(-)  create mode 
> > 100644 drivers/pci/host/pci-imx6.c
> 
> I merged both of these to my pci/host-imx6 branch for v3.13.
> 
> I made a couple minor spelling and whitespace corrections.

I have MX6 hardware with a PCIe switch, so I can test that stuff. Thus far, of course, the switch doesn't work. Is getting the switch to work only a matter of programming the RdWr0 vs. RdWr1 mode into the iATU or is there something more ?

Thanks!

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


