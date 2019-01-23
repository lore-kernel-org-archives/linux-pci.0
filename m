Return-Path: <SRS0=s0ql=P7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1363C282C0
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC092184C
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jan 2019 17:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfAWRFP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:05:15 -0500
Received: from foss.arm.com ([217.140.101.70]:44540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfAWRFP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jan 2019 12:05:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A07DEEBD;
        Wed, 23 Jan 2019 09:05:14 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1FF53F237;
        Wed, 23 Jan 2019 09:05:11 -0800 (PST)
Date:   Wed, 23 Jan 2019 17:05:09 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108162441.5278-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 08, 2019 at 05:24:25PM +0100, Miquel Raynal wrote:
> Hello,
> 
> As part of an effort to bring suspend to RAM support to Armada 3700
> SoCs (main target: ESPRESSObin), this series handles the work around
> the PCIe IP.
> 
> First, more configuration is done in the 'setup' helper as inspired
> from the U-Boot driver. This is needed to entirely initialize the IP
> during future resume operation (patch 1).
> 
> Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> current device trees do not provide the corresponding properties, not
> finding one of these properties is not an error and just produces a
> warning. However, if the property is present, an error during PHY
> initialization will fail the probe of the driver.
> 
> Note: To be sure the clock will be resumed before this driver, a first
> series adding links between clocks and consumers has been submitted,
> see [1]. Anyway, having the clock series applied first is not needed.

I do not understand what this means, in particular in relation
to the blocking clock calls in the suspend/resume NOIRQ hooks.

Thanks,
Lorenzo

> Patch 5 adds suspend/resume hooks, re-using all the above.
> 
> Finally, bindings and device trees are updated to reflect the hardware
> (patch 6-12). While the clock depends on the SoC, the reset GPIO and
> the PHY depends on the board so the clock is added in the
> armada-37xx.dtsi file while the two other properties are added in
> armada-3720-espressobin.dts.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623885.html
> 
> Thanks,
> Miqu??l
> 
> 
> Changes since v2:
> =================
> * Minor patches reordering.
> * Added pinctrl patches from Gregory Clement fixing the PCIe pins. His
>   changes implied modifications in the DT/bindings patches adding PCIe
>   reset pin support.
> * Added a new patch that enlarges the PIO timeout of the driver
>   (explanations in the commit log).
> * With the timeout changed, removed the "experimental delay" that was
>   needed at resume time before accessing any register.
> 
> Changes since v1:
> =================
> * Change the capitalization in commit titles to follow the PCI
>   subsystem rules.
> * Added Suggested-by tag to the patch adding PHY support and to the
>   patch adding the PHY property in the DT.
> * Added Rob's Reviewed-by tags on bindings.
> * I am following the discussion about calling functions that might
>   sleep in a NOIRQ context. As there is no real problem yet (as per my
>   understanding), I did not change anything on this regard.
> 
> 
> Miquel Raynal (15):
>   PCI: aardvark: Enlarge PIO timeout
>   PCI: aardvark: Configure more registers in the configuration helper
>   PCI: aardvark: Add clock support
>   PCI: aardvark: Add PHY support
>   PCI: aardvark: Add PCIe warm reset support
>   PCI: aardvark: Add external reset GPIO support
>   PCI: aardvark: Add suspend to RAM support
>   dt-bindings: PCI: aardvark: Describe the clocks property
>   dt-bindings: PCI: aardvark: Describe the PHY property
>   dt-bindings: PCI: aardvark: Describe the PCIe endpoint card reset pins
>   dt-bindings: PCI: aardvark: Describe the reset-gpios property
>   ARM64: dts: marvell: armada-37xx: declare PCIe clock
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe PHY
>   ARM64: dts: marvell: armada-37xx: declare PCIe reset pin
>   ARM64: dts: marvell: armada-3720-espressobin: declare PCIe warm reset
>     pin
> 
>  .../devicetree/bindings/pci/aardvark-pci.txt  |  14 ++
>  .../dts/marvell/armada-3720-espressobin.dts   |   3 +
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  10 +
>  drivers/pci/controller/pci-aardvark.c         | 217 +++++++++++++++++-
>  4 files changed, 243 insertions(+), 1 deletion(-)
> 
> -- 
> 2.19.1
> 
