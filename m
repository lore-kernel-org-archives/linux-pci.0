Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:57056
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751088AbaIWDLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 23:11:39 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH RFC 2/2] PCI: imx6: add imx6sx pcie support
Date: Tue, 23 Sep 2014 03:11:51 +0000
Message-ID: <67d9cee1f44d4c9ba97a85b266afb993@DM2PR0301MB0862.namprd03.prod.outlook.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
 <1411376498-14653-3-git-send-email-r65037@freescale.com>
 <20140922131539.GB30055@kroah.com>
In-Reply-To: <20140922131539.GB30055@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Monday, September 22, 2014 9:16 PM
> To: Zhu Richard-R65037
> Cc: linux-pci-owner@vger.kernel.org; stable@vger.kernel.org; linux-
> pci@vger.kernel.org; l.stach@pengutronix.de
> Subject: Re: [PATCH RFC 2/2] PCI: imx6: add imx6sx pcie support
> 
> On Mon, Sep 22, 2014 at 05:01:38PM +0800, Richard Zhu wrote:
> > - imx6sx pcie has its own standalone pcie power supply.
> > In order to turn on the imx6sx pcie power during initialization. Add
> > the pcie regulator and the gpc regmap into the imx6sx pcie structure.
> > - imx6sx pcie has the new added reset mechanism, add the reset
> > operations into the initialization.
> > - another dis_axi clk is mandatory required by imx6sx pcie.
> > Add one new clk named pcie_sec into imx6_pcie structure.
> > - pcie_ref_125m is not used as pcie_phy clk anymore on imx6sx.
> > The parent clk (pcie_ref) of the pcie_bus(lvds1_gate) is used as
> > pcie_phy clk.
> > - Register one PM call-back, enter/exit L2 state of the ASPM during
> > system suspend/resume.
> > - wait the clocks to stabilize after the pcie_ref_en
> > (IMX6Q_GPR1_PCIE_REF_CLK_EN) is set.
> >
> > Signed-off-by: Richard Zhu <r65037@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6sx-sdb.dts            |  15 ++
> >  arch/arm/boot/dts/imx6sx.dtsi               |  33 ++--
> >  arch/arm/mach-imx/Kconfig                   |   1 +
> >  drivers/pci/host/pci-imx6.c                 | 228 ++++++++++++++++++++++++-
> ---
> >  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  14 ++
> >  5 files changed, 249 insertions(+), 42 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the stable
> kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>
[Richard] Roger that, thanks for your reminder.
It's my fault to make a mistake to send the patch review to table kernel mail-list. Sorry about that.

Best Regards
Richard Zhu

