Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:10616
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751942Ab3IPJKR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2013 05:10:17 -0400
Date: Mon, 16 Sep 2013 17:11:01 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sean Cross <xobs@kosagi.com>
CC: <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Zhu Richard-R65037 <r65037@freescale.com>,
	<tharvey@gateworks.com>, <bhelgaas@google.com>
Subject: Re: [PATCH v6 0/3] Add PCIe support for i.MX6q
Message-ID: <20130916091059.GM31147@S2101-09.ap.freescale.net>
References: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1379319655-20210-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 16, 2013 at 08:20:51AM +0000, Sean Cross wrote:
> Sean Cross (3):
>   ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
>   ARM: imx6q: Add PCIe bits to GPR syscon definition
>   PCI: imx6: Add support for i.MX6 PCIe controller

The series looks good to me except that the devm_clk_get() should be
used in driver .probe function rather than clk_get().  I will wait for
another couple of days.  If there is no comments coming up, I can fix
it up and apply the series.

Shawn

> 
>  .../devicetree/bindings/clock/imx6q-clock.txt      |    4 +
>  .../devicetree/bindings/pci/designware-pcie.txt    |    7 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                     |   16 +
>  arch/arm/mach-imx/Kconfig                          |    2 +
>  arch/arm/mach-imx/clk-imx6q.c                      |   24 +-
>  drivers/pci/host/Kconfig                           |    6 +
>  drivers/pci/host/Makefile                          |    1 +
>  drivers/pci/host/pci-imx6.c                        |  576 ++++++++++++++++++++
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    8 +
>  9 files changed, 642 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/host/pci-imx6.c
> 
> -- 
> 1.7.9.5
> 

