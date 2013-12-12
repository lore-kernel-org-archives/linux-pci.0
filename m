Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41962 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab3LLCqc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 21:46:32 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO0030LADAWLB0@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 11:46:22 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Marek Vasut' <marex@denx.de>, linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Frank Li' <lznuaa@gmail.com>, 'Harro Haan' <hrhaan@gmail.com>,
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
	'Jingoo Han' <jg1.han@samsung.com>,
	'Kishon Vijay Abraham I' <kishon@ti.com>
References: <1386757818-5154-1-git-send-email-marex@denx.de>
In-reply-to: <1386757818-5154-1-git-send-email-marex@denx.de>
Subject: Re: [PATCH 1/7] PCI: imx6: Make reset-gpio optional
Date: Thu, 12 Dec 2013 11:46:21 +0900
Message-id: <002a01cef6e4$57583ce0$0608b6a0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 7:30 PM, Marek Vasut wrote:
> 
> Some boards do not have a PCIe reset GPIO. To avoid probe
> failure on these boards, make the reset GPIO optional as
> well.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Frank Li <lznuaa@gmail.com>
> Cc: Harro Haan <hrhaan@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Mohit KUMAR <Mohit.KUMAR@st.com>
> Cc: Pratyush Anand <pratyush.anand@st.com>
> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Sean Cross <xobs@kosagi.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
> Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Troy Kisky <troy.kisky@boundarydevices.com>
> Cc: Yinghai Lu <yinghai@kernel.org>
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

(+cc Kishon Vijay Abraham I)

As I said earlier,
'reset-gpio' property can be used for 'samsung,exynos5440-pcie'.
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

