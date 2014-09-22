Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:49797 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbaIVNQ2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Sep 2014 09:16:28 -0400
Date: Mon, 22 Sep 2014 06:15:39 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, stable@vger.kernel.org,
	linux-pci@vger.kernel.org, l.stach@pengutronix.de
Subject: Re: [PATCH RFC 2/2] PCI: imx6: add imx6sx pcie support
Message-ID: <20140922131539.GB30055@kroah.com>
References: <1411376498-14653-1-git-send-email-r65037@freescale.com>
 <1411376498-14653-3-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411376498-14653-3-git-send-email-r65037@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 22, 2014 at 05:01:38PM +0800, Richard Zhu wrote:
> - imx6sx pcie has its own standalone pcie power supply.
> In order to turn on the imx6sx pcie power during
> initialization. Add the pcie regulator and the gpc regmap
> into the imx6sx pcie structure.
> - imx6sx pcie has the new added reset mechanism, add the
> reset operations into the initialization.
> - another dis_axi clk is mandatory required by imx6sx pcie.
> Add one new clk named pcie_sec into imx6_pcie structure.
> - pcie_ref_125m is not used as pcie_phy clk anymore on imx6sx.
> The parent clk (pcie_ref) of the pcie_bus(lvds1_gate)
> is used as pcie_phy clk.
> - Register one PM call-back, enter/exit L2 state of the ASPM
> during system suspend/resume.
> - wait the clocks to stabilize after the pcie_ref_en
> (IMX6Q_GPR1_PCIE_REF_CLK_EN) is set.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dts            |  15 ++
>  arch/arm/boot/dts/imx6sx.dtsi               |  33 ++--
>  arch/arm/mach-imx/Kconfig                   |   1 +
>  drivers/pci/host/pci-imx6.c                 | 228 ++++++++++++++++++++++++----
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  14 ++
>  5 files changed, 249 insertions(+), 42 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
