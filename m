Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33547 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbcCHEc7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2016 23:32:59 -0500
Received: by mail-pf0-f170.google.com with SMTP id 124so3934756pfg.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Mar 2016 20:32:59 -0800 (PST)
Date: Tue, 8 Mar 2016 11:32:53 +0700
From: Lee Jones <lee.jones@linaro.org>
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] MFD: imx6sx: Add PCIe register definitions for
 iomuxc gpr
Message-ID: <20160308043253.GH13692@x1>
References: <1456411669-4699-1-git-send-email-chf.fritz@googlemail.com>
 <1456411669-4699-2-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1456411669-4699-2-git-send-email-chf.fritz@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 25 Feb 2016, Christoph Fritz wrote:

> This patch adds macros to define masks and bits for imx6sx
> PCIe registers. This is based on a patch by Richard Zhu.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h | 5 +++++
>  1 file changed, 5 insertions(+)

I will change the non-conformant $SUBJECT line for you this time, but
please be more vigilant in the future.

Patch applied.

> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index 558a485..238c8db 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -422,6 +422,7 @@
>  #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_MASK		(0x1 << 26)
>  #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_ENABLE	(0x1 << 26)
>  #define IMX6SX_GPR5_VADC_TO_CSI_CAPTURE_EN_DISABLE	(0x0 << 26)
> +#define IMX6SX_GPR5_PCIE_BTNRST_RESET			BIT(19)
>  #define IMX6SX_GPR5_CSI1_MUX_CTRL_MASK			(0x3 << 4)
>  #define IMX6SX_GPR5_CSI1_MUX_CTRL_EXT_PIN		(0x0 << 4)
>  #define IMX6SX_GPR5_CSI1_MUX_CTRL_CVD			(0x1 << 4)
> @@ -435,6 +436,10 @@
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS			(0x1 << 1)
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK			(0x1 << 1)
>  
> +#define IMX6SX_GPR12_PCIE_TEST_POWERDOWN		BIT(30)
> +#define IMX6SX_GPR12_PCIE_RX_EQ_MASK			(0x7 << 0)
> +#define IMX6SX_GPR12_PCIE_RX_EQ_2			(0x2 << 0)
> +
>  /* For imx6ul iomux gpr register field define */
>  #define IMX6UL_GPR1_ENET1_CLK_DIR		(0x1 << 17)
>  #define IMX6UL_GPR1_ENET2_CLK_DIR		(0x1 << 18)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
