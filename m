Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D18C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D3F2085A
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 09:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfCNJae (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:30:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbfCNJae (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 05:30:34 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h4Mh4-0002rU-Ig; Thu, 14 Mar 2019 10:30:30 +0100
Message-ID: <1552555830.2453.57.camel@pengutronix.de>
Subject: Re: [RFC 1/2] dt-bindings: imx6q-pcie: Add support for i.MX8QM/QXP
 PCIe
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Mar 2019 10:30:30 +0100
In-Reply-To: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

Am Mittwoch, den 13.03.2019, 09:15 +0000 schrieb Richard Zhu:
> Add codes needed to support i.MX8QM/QXP PCIe.
> - HSIO(High Speed IO) subsystem is new defined on i.MX8QM/QXP.
>   The PCIe and SATA modules are contained in the HSIO subsystem. There
>   are two PCIe, one SATA controllers and three mixed lane PHYs on
>   i.MX8QM. There are three use cases of the HSIO subsystem on i.MX8QM.
>   1. PCIea 2 lanes and one SATA AHCI port.
>   2. PCIea 1 lane, PCIeb 1 lane and one SATA AHCI port.
>   3. PCIea 2 lanes, PCIeb 1 lane.
>   i.MX8QXP only has PCIeb controller and one lane PHY.
>   Use the hsio-cfg property to specify the different modes.
> - The HSIO address map as viewed from system level is as shown below.
>   address [31:24]    Local address    Target    Address Size
>   5F                 0                HSIO      16MB
>   60-6F              40-4F            HSIO      256MB
>   70-7F              80-8F            HSIO      256MB
>   The property local-addr is required to specify it.
> - Both external OSC and internal PLL can be used as PCIe reference
>   clock, use the ext_osc property to distinguish them.
> - clock request GPIO for controlling the PCI reference clock request
>   signal. And should be configure OD when L1SS maybe enabled later.
> - One more power domain HSIO_GPIO and clock PCIE_PER are required by
>   i.MX8QM/QXP PCIe.
>   Add these specific properties to enable i.MX8QM/QXP PCIe.

All this HSIO handling should move into a separate PHY driver. This has
nothing to do with the PCIe controller itself. See for example the
Tegra XUSB PHY driver (drivers/phy/tegra/xusb.c), which is a similar
combined PCIE/USB3/SATA PHY driver.

Regards,
Lucas

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> index a7f5f5a..f7586c9 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> @@ -10,6 +10,8 @@ Required properties:
> >  	- "fsl,imx6qp-pcie"
> >  	- "fsl,imx7d-pcie"
> >  	- "fsl,imx8mq-pcie"
> > +	- "fsl,imx8qm-pcie"
> > +	- "fsl,imx8qxp-pcie"
>  - reg: base address and length of the PCIe controller
>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>    entry for each entry in the interrupt-names property.
> @@ -38,6 +40,10 @@ Optional properties:
>    The regulator will be enabled when initializing the PCIe host and
>    disabled either as part of the init process or when shutting down the
>    host.
> +- clkreq-gpio: Should specify the GPIO for controlling the PCI reference clock
> +  request signal.
> +- ext_osc: External OSC is used as PCIe reference clock or not. 0: Internal
> +  PLL. 1: External OSC.
>  
>  Additional required properties for imx6sx-pcie:
>  - clock names: Must include the following additional entries:
> @@ -60,6 +66,21 @@ Additional required properties for imx8mq-pcie:
>  - clock-names: Must include the following additional entries:
> >  	- "pcie_aux"
>  
> +Additional required properties for imx8qm/qxp pcie:
> +- power-domains: Must be set to a phandle pointing to PCIE, PCIE_PHY power and
> +  HSIO_GPIO domains
> +- power-domain-names: Must be "pcie", "pcie_phy", "hsio_gpio"
> +- clock-names: Must include the following additional entries:
> > +	- "pcie_per"
> +- hsio-cfg: hsio configration mode when the pcie node is supported.
> +  1: pciea 2 lanes and one sata ahci port.
> +  2: pciea 1 lane, pcieb 1 lane and one sata ahci port.
> +  3: pciea 2 lanes, pcieb 1 lane.
> +- local-addr: the local address used in hsio module on i.MX8QM/QXP.
> > +	Example:
> > +		hsio-cfg = <2>;
> > +		local-addr = <0x80000000>;
> +
>  Example:
>  
> >  	pcie@01000000 {
