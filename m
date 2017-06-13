Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:18298 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdFMFnR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2017 01:43:17 -0400
From: =?iso-8859-1?Q?Sch=F6fegger_Stefan?=
        <Stefan.Schoefegger@ginzinger.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:PCI DRIVER FOR IMX6"
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 1/1] PCI: imx6: Add pcie compliance test option
Date: Tue, 13 Jun 2017 05:43:14 +0000
Message-ID: <2668097.SlerkO2uVy@en-pc05>
References: <1472121518-9340-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <1496835374-13053-1-git-send-email-stefan.schoefegger@ginzinger.com>
 <20170612234924.GE4379@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170612234924.GE4379@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, June 12, 2017 6:49:24 PM CEST Bjorn Helgaas wrote:
> On Wed, Jun 07, 2017 at 01:36:11PM +0200, Stefan Schoefegger wrote:
> > Link speed must not be limited to gen1 during link test for compliance
> > tests
> > 
> > Signed-off-by: Stefan Schoefegger <stefan.schoefegger@ginzinger.com>
> > ---
> > 
> > Changes since v1:
> >  - pci-imx6.c moved to dwc directory
> >  
> >  drivers/pci/dwc/Kconfig    | 10 ++++++++++
> >  drivers/pci/dwc/pci-imx6.c | 21 ++++++++++++---------
> >  2 files changed, 22 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig
> > index b7e15526d676..b6e9ced5a45d 100644
> > --- a/drivers/pci/dwc/Kconfig
> > +++ b/drivers/pci/dwc/Kconfig
> > @@ -77,6 +77,16 @@ config PCI_IMX6
> > 
> >  	select PCIEPORTBUS
> >  	select PCIE_DW_HOST
> > 
> > +config PCI_IMX6_COMPLIANCE_TEST
> > +	bool "Enable pcie compliance tests on imx6"
> > +	depends on PCI_IMX6
> > +	default n
> > +	help
> > +	  Enables support for pcie compliance test on FSL iMX SoCs.
> > +	  The link speed wouldn't be limited to gen1 when enabled.
> > +	  Enable only during compliance tests, otherwise
> > +	  link detection will fail on some peripherals.
> 
> I'm puzzled about why we would want to merge this patch.  It looks
> like we're trying to game the system to make the device pass
> compliance testing when it isn't really compliant.  Is this config
> option useful to users, or is it only useful during internal
> development of iMX SoCs?

It's not for passing compliance tests, it is necessary to do the compliance 
tests. Without this patch only gen 1 speed is possible to test. Also i.mx6 is 
not fully gen2 compliant (withour external clk) we should have the option to 
do gen2 tests. Switching from gen1 to gen2 is done with a 100MHz (1ms) clk 
pulse on the receiver. Without this patch link speed is forced to gen1 
afterwards.
Yes it is only useful for board setup, it is comparable to 
CONFIG_USB_EHSET_TEST_FIXTURE for usb (ok, this is more general and not host 
specific).

> 
> >  config PCIE_SPEAR13XX
> >  
> >  	bool "STMicroelectronics SPEAr PCIe controller"
> >  	depends on PCI
> > 
> > diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
> > index 19a289b8cc94..b0fbe52e25b0 100644
> > --- a/drivers/pci/dwc/pci-imx6.c
> > +++ b/drivers/pci/dwc/pci-imx6.c
> > @@ -533,15 +533,18 @@ static int imx6_pcie_establish_link(struct imx6_pcie
> > *imx6_pcie)> 
> >  	u32 tmp;
> >  	int ret;
> > 
> > -	/*
> > -	 * Force Gen1 operation when starting the link.  In case the link is
> > -	 * started in Gen2 mode, there is a possibility the devices on the
> > -	 * bus will not be detected at all.  This happens with PCIe switches.
> > -	 */
> > -	tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > -	tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > -	tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > -	dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > +	if (!IS_ENABLED(CONFIG_PCI_IMX6_COMPLIANCE_TEST)) {
> > +		/*
> > +		 * Force Gen1 operation when starting the link.  In case the
> > +		 * link is started in Gen2 mode, there is a possibility the
> > +		 * devices on the bus will not be detected at all.  This
> > +		 * happens with PCIe switches.
> > +		 */
> > +		tmp = dw_pcie_readl_dbi(pci, PCIE_RC_LCR);
> > +		tmp &= ~PCIE_RC_LCR_MAX_LINK_SPEEDS_MASK;
> > +		tmp |= PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1;
> > +		dw_pcie_writel_dbi(pci, PCIE_RC_LCR, tmp);
> > +	}
> > 
> >  	/* Start LTSSM. */
> >  	if (imx6_pcie->variant == IMX7D)
