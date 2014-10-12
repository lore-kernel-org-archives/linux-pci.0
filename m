Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43538 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbaJLOjP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 12 Oct 2014 10:39:15 -0400
Message-ID: <1413124703.2459.18.camel@antimon.intern.lynxeye.de>
Subject: Re: [PATCH v5 8/9] ARM: imx6sx: add imx6sx pcie related gpr bits
 definitions
From: Lucas Stach <l.stach@pengutronix.de>
To: Richard Zhu <richard.zhu@freescale.com>
Cc: linux-pci@vger.kernel.org, shawn.guo@freescale.com,
	festevam@gmail.com, tharvey@gateworks.com,
	Richard Zhu <r65037@freescale.com>
Date: Sun, 12 Oct 2014 16:38:23 +0200
In-Reply-To: <1412919676-25344-9-git-send-email-richard.zhu@freescale.com>
References: <1412919676-25344-1-git-send-email-richard.zhu@freescale.com>
	 <1412919676-25344-9-git-send-email-richard.zhu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 10.10.2014, 13:41 +0800 schrieb Richard Zhu:
> From: Richard Zhu <r65037@freescale.com>
> 
> Signed-off-by: Richard Zhu <richard.zhu@freescale.com>

You are using those defines in the PCIe driver changes, so the need to
be sorted before them in the series as they need to be picked up by
Bjorn to make sure we don't introduce build regressions.

> ---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index ff44374..3273b87 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -301,6 +301,7 @@
>  #define IMX6Q_GPR12_DEVICE_TYPE			(0xf << 12)
>  #define IMX6Q_GPR12_PCIE_CTL_2			BIT(10)
>  #define IMX6Q_GPR12_LOS_LEVEL			(0x1f << 4)
> +#define IMX6Q_GPR12_LOS_LEVEL_9			(0x9 << 4)
>  
>  #define IMX6Q_GPR13_SDMA_STOP_REQ		BIT(30)
>  #define IMX6Q_GPR13_CAN2_STOP_REQ		BIT(29)
> @@ -395,4 +396,12 @@
>  #define IMX6SL_GPR1_FEC_CLOCK_MUX1_SEL_MASK    (0x3 << 17)
>  #define IMX6SL_GPR1_FEC_CLOCK_MUX2_SEL_MASK    (0x1 << 14)
>  
> +/* For imx6sx iomux gpr register field define */
> +#define IMX6SX_GPR5_PCIE_BTNRST			BIT(19)
> +#define IMX6SX_GPR5_PCIE_PERST			BIT(18)
> +
> +#define IMX6SX_GPR12_PCIE_PM_TURN_OFF		BIT(16)
> +#define IMX6SX_GPR12_PCIE_TEST_PD		BIT(30)
> +#define IMX6SX_GPR12_RX_EQ_MASK			(0x7 << 0)
> +#define IMX6SX_GPR12_RX_EQ_2			(0x2 << 0)
>  #endif /* __LINUX_IMX6Q_IOMUXC_GPR_H */


