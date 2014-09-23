Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbaIWKVH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Sep 2014 06:21:07 -0400
Message-ID: <1411467663.3256.11.camel@pengutronix.de>
Subject: Re: [PATCH v2 4/5] PCI: imx6: add imx6sx pcie related gpr bits
 definitions
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <r65037@freescale.com>
Cc: linux-pci-owner@vger.kernel.org, linux-pci@vger.kernel.org,
	shawn.guo@freescale.com, festevam@gmail.com, tharvey@gateworks.com
Date: Tue, 23 Sep 2014 12:21:03 +0200
In-Reply-To: <1411445498-20250-5-git-send-email-r65037@freescale.com>
References: <1411445498-20250-1-git-send-email-r65037@freescale.com>
	 <1411445498-20250-5-git-send-email-r65037@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 23.09.2014, 12:11 +0800 schrieb Richard Zhu:
> Signed-off-by: Richard Zhu <r65037@freescale.com>

I don't think those _CLR defines make any sense. Can we just use the
mask and a value of 0 in the regmap updates? I don't see how those
defines add any value.

> ---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index ff44374..f02875e 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -113,10 +113,12 @@
>  #define IMX6Q_GPR1_MIPI_IPU1_MUX_GASKET		0x0
>  #define IMX6Q_GPR1_MIPI_IPU1_MUX_IOMUX		BIT(19)
>  #define IMX6Q_GPR1_PCIE_TEST_PD			BIT(18)
> +#define IMX6Q_GPR1_PCIE_TEST_PD_CLR		0x0
>  #define IMX6Q_GPR1_IPU_VPU_MUX_MASK		BIT(17)
>  #define IMX6Q_GPR1_IPU_VPU_MUX_IPU1		0x0
>  #define IMX6Q_GPR1_IPU_VPU_MUX_IPU2		BIT(17)
>  #define IMX6Q_GPR1_PCIE_REF_CLK_EN		BIT(16)
> +#define IMX6Q_GPR1_PCIE_REF_CLK_CLR		0x0
>  #define IMX6Q_GPR1_USB_EXP_MODE			BIT(15)
>  #define IMX6Q_GPR1_PCIE_INT			BIT(14)
>  #define IMX6Q_GPR1_USB_OTG_ID_SEL_MASK		BIT(13)
> @@ -300,7 +302,9 @@
>  #define IMX6Q_GPR12_ARMP_APB_CLK_EN		BIT(24)
>  #define IMX6Q_GPR12_DEVICE_TYPE			(0xf << 12)
>  #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
> +#define IMX6Q_GPR12_PCIE_CTL_2_CLR		0x0
>  #define IMX6Q_GPR12_LOS_LEVEL			(0x1f << 4)
> +#define IMX6Q_GPR12_LOS_LEVEL_9			(0x9 << 4)
>  
>  #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
>  #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
> @@ -395,4 +399,14 @@
>  #define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
>  #define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
>  
> +/* For imx6sx iomux gpr register field define */
> +#define IMX6SX_GPR5_PCIE_BTNRST			BIT(19)
> +#define IMX6SX_GPR5_PCIE_BTNRST_CLR		0x0
> +#define IMX6SX_GPR5_PCIE_PERST			BIT(18)
> +#define IMX6SX_GPR5_PCIE_PERST_CLR		0x0
> +
> +#define IMX6SX_GPR12_PCIE_TEST_PD		BIT(30)
> +#define IMX6SX_GPR12_PCIE_TEST_PD_CLR		0x0
> +#define IMX6SX_GPR12_RX_EQ_MASK			(0x7 << 0)
> +#define IMX6SX_GPR12_RX_EQ_2			(0x2 << 0)
>  #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

