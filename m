Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52221 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab3JPBY7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2013 21:24:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUQ00D7SMLHXV50@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Wed, 16 Oct 2013 10:24:58 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'Richard Zhu' <r65037@freescale.com>,
	'Sascha Hauer' <s.hauer@pengutronix.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'Shawn Guo' <shawn.guo@linaro.org>,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	'Srikanth T Shivanand' <ts.srikanth@samsung.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Troy Kisky' <troy.kisky@boundarydevices.com>,
	'Yinghai Lu' <yinghai@kernel.org>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1381853200-5534-1-git-send-email-marex@denx.de>
 <1381853200-5534-2-git-send-email-marex@denx.de>
In-reply-to: <1381853200-5534-2-git-send-email-marex@denx.de>
Subject: Re: [PATCH 1/6] PCI: imx6: Make reset-gpio optional
Date: Wed, 16 Oct 2013 10:24:56 +0900
Message-id: <006401ceca0e$86427be0$92c773a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 16, 2013 1:07 AM, Marek Vasut wrote:
> 
> Some boards do not have a PCIe reset GPIO. To avoid probe
> failure on these boards, make the reset GPIO optional as
> well.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

[.....]

> ---
>  .../devicetree/bindings/pci/designware-pcie.txt    |  2 +-
>  drivers/pci/host/pci-imx6.c                        | 29 +++++++++++-----------
>  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> index d5d26d4..b7a2279 100644
> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
> @@ -19,9 +19,9 @@ Required properties:
>  	to define the mapping of the PCIe interface to interrupt
>  	numbers.
>  - num-lanes: number of lanes to use
> -- reset-gpio: gpio pin number of power good signal
> 
>  Optional properties for fsl,imx6q-pcie
> +- reset-gpio: gpio pin number of power good signal
>  - power-on-gpio: gpio pin number of power-enable signal
>  - wake-up-gpio: gpio pin number of incoming wakeup signal
>  - disable-gpio: gpio pin number of outgoing rfkill/endpoint disable signal

(+cc Kishon Vijay Abraham I)

Also, 'reset-gpio' property can be used for 'samsung,exynos5440-pcie'.
Thus, it is not specific for 'fsl,imx6q-pcie'.

Please, modify it as below:

--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -19,6 +19,8 @@ Required properties:
        to define the mapping of the PCIe interface to interrupt
        numbers.
 - num-lanes: number of lanes to use
+
+Optional properties
 - reset-gpio: gpio pin number of power good signal

 Optional properties for fsl,imx6q-pcie

Best regards,
Jingoo Han

