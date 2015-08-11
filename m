Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:36577 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbbHKVCO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Aug 2015 17:02:14 -0400
Received: by ioeg141 with SMTP id g141so590538ioe.3
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2015 14:02:14 -0700 (PDT)
Date: Tue, 11 Aug 2015 16:02:10 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, tony@atomide.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	bcousson@baylibre.com, linux@arm.linux.org.uk, nsekhar@ti.com
Subject: Re: [PATCH 0/2] pci: am57xx-evm: Fix PCIe card enumeration issue
Message-ID: <20150811210210.GK13982@google.com>
References: <1438090750-11604-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438090750-11604-1-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 28, 2015 at 07:09:08PM +0530, Kishon Vijay Abraham I wrote:
> This series fixes PCIe card enumeration issue in am57xx-evm.
> 
> In the case of am57xx-evm, the PERST# line is connected to a gpio line
> and this has to be driven low in order to perform a fundamental reset
> of the card. If the gpio line is driven high, there is no way the card
> can come out of reset.
> 
> Add support in the pcie-dra7xx driver to make gpio drive PERST# line.
> 
> The PERST# line can be used to perform reset not during the power on
> sequence too (warm reset) but we are not adding support for this as the
> PCIe express base sepcification doesn't explain how to perform warm
> reset
> 
> "In some cases, it may be possible for the Fundamental Reset mechanism
> to be triggered by hardware without the removal and re-application of
> power to the component. This is called a warm reset. This document does
> not specify a means for generating a warm reset."
> 
> Kishon Vijay Abraham I (2):
>   pci: host: pci-dra7xx: Add support to make gpio drive PERST# line
>   ARM: dts: am57xx-evm: Add 'gpios' property with gpio2_8
> 
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    3 +++
>  arch/arm/boot/dts/am57xx-beagle-x15.dts          |    5 +++++
>  arch/arm/boot/dts/dra7.dtsi                      |    2 +-
>  drivers/pci/host/pci-dra7xx.c                    |   24 ++++++++++++++++++++--
>  4 files changed, 31 insertions(+), 3 deletions(-)

Applied with Tony's ack (for patch 2) to pci/host-dra7xx for v4.3, thanks!
