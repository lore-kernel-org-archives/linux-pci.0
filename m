Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:38132 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab3GAJYG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 1 Jul 2013 05:24:06 -0400
Date: Mon, 1 Jul 2013 17:24:00 +0800
From: Sean Cross <xobs@kosagi.com>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: devicetree-discuss@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-ID: <C89FF158E3384F0E90A288AE1A712972@kosagi.com>
In-Reply-To: <1372665061.36667486@f35.mail.ru>
References: <1372662947-27160-1-git-send-email-xobs@kosagi.com>
 <1372662947-27160-4-git-send-email-xobs@kosagi.com>
 <1372665061.36667486@f35.mail.ru>
Subject: Re: [PATCH 3/4] PCI: Add driver for i.MX6 PCI Express
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, July 1, 2013 at 3:51 PM, Alexander Shiyan wrote:
> > This adds a PCI Express port driver for the on-chip PCI Express port
> > present on the i.MX6 SoC. It is based on the PCI Express driver available
> > in the Freescale BSP.
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com (mailto:xobs@kosagi.com)>
> ...
> > +++ b/Documentation/devicetree/bindings/pci/imx6q-pcie.txt
> > @@ -0,0 +1,20 @@
> > +* Freescale i.MX6Q PCI Express bridge
> > +
> > +Example (i.MX6Q)
> > + pcie: pcie@01ffc000 {
> > + compatible = "fsl,imx6q-pcie";
> > + reg = <0x01ffc000 0x4000>,
> > + <0x01000000 0x100000>,
> > + <0x01100000 0xe00000>,
> > + <0x01f00000 0xfc000>;
> > + interrupts = <0 122 0x04>;
> > + clocks = <&clks 186>, <&clks 189>, <&clks 196>,
> > + <&clks 198>, <&clks 144>;
> > + clock-names = "sata_ref", "pcie_ref_125m", "lvds1_sel",
> > + "lvds1", "pcie_axi";
> > + power-enable = <&gpio7 12 0>;
> > + pcie-reset = <&gpio3 29 0>;
> 
> 
> 
> Can this be replaced with regulator/reset API?
I agree that power-enable might be better replaced with regulator API calls, and I'll rework this patch to incorporate a regulator.

I hadn't heard of the reset API before, and I note in the documentation that it says:

    Reset signals for whole standalone chips are most likely better represented as
    GPIOs, although there are likely to be exceptions to this rule.

This is a reset line going directly to a PCIe slot, which I think counts as a "standalone chip".

> > + wake-up = <&gpio3 22 0>;
> > + disable-endpoint = <&gpio2 16 0>;
> > + };
> 
> 
> 
> --- 


