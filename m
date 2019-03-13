Return-Path: <SRS0=vhAr=RQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5269DC43381
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 20:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBE3206DF
	for <linux-pci@archiver.kernel.org>; Wed, 13 Mar 2019 20:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAdTEpYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfCMUUV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:20:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36537 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfCMUUU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2019 16:20:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id e16so574577wme.1;
        Wed, 13 Mar 2019 13:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CnnZg2VxEevxfxXX+I1tR/pmqQb5tyjUWDT8HhKD6kA=;
        b=oAdTEpYTTgoher1BjAalRQX+HcFZvI5v3U1iQb9524NuZgG17V+X1xBSRaYoxb63k+
         cZL4hUVhRoasy9T8R4kVQeHf5cw+gzrXNR6YjsSsIyNX4PPWWJuCyR0snNXlI0sEQJTa
         Y3gJb/mhqEe8HbTqyfW2HwbTqPquSY8ZBK5mRDQ/nAPxtfc2DVRpGcEzmhbY8mjo1eJQ
         mGSlRG9sF+JRWr/J/Jb54DPltzSitsoQ9A6ZpX0RRkjcYB3j05+g3rAe/IaxDTt1p2I2
         Vfl4QK6/0jsI9aTiNej1fvi+4G9Sn2lwjvrieBoL3ca2PYyvsRorePiNBvhf4m1JT7yf
         SBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CnnZg2VxEevxfxXX+I1tR/pmqQb5tyjUWDT8HhKD6kA=;
        b=aBgl/jWu+4zCLsKfTzxTm75k7HUZtGYmfOUHn6OCcdIiPy+/qBt5TQ1WB/7WO3G3ry
         7j/8Kyq3c7xCaBa4OhDMQ4oj/rG0olwqlMdAPWTXTyzARNL3eF3XojzDkhCsP7aJMY5y
         x3/bMbE96xAdEF2i2W9glVSVXwS8oW87CIkRwRZHw9sbODmDFd/a/bAEFm2Whko4IpeL
         HkSCrWRU+PdcudYWIZSaEEOQFu27WgcBfqNOCD4elh2uvdUEK1AjX9Bc4BMvgj59U7CG
         gG0I+meDRWn642iD5F2DLUZaBTvH1KDwj2mT2ULqUGVBDQkLxttNtW9ZDks+v0wJUzLv
         2Bcw==
X-Gm-Message-State: APjAAAUpI2el1LbIX+QvIGm/N0M79jBWtnHqf5EI7ulRd1MtSuWBvHRl
        JAilIuMeBOm/QbvyfhcEGMeuNr/VwljzhwKQhZ0=
X-Google-Smtp-Source: APXvYqz21cBAnrnOM89skFU5FRSTisBKRVTM7R6VdLXQGoZdxYO5a5SUcydOC4JB1PjRkKDp8VMrfPWQgfGOGC3QCDU=
X-Received: by 2002:a7b:cd0c:: with SMTP id f12mr5439wmj.27.1552508415783;
 Wed, 13 Mar 2019 13:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <1552467452-538-1-git-send-email-hongxing.zhu@nxp.com> <1552467452-538-2-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1552467452-538-2-git-send-email-hongxing.zhu@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 13 Mar 2019 13:20:03 -0700
Message-ID: <CAHQ1cqE3fcCQ2mHk-SuLdBn3XDUy9U2h=qsTCS6aO+3za0Aptw@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: imx6: Add support for i.MX8QM/QXP PCIe
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 13, 2019 at 2:15 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Add codes needed to support i.MX8QM/QXP PCIe.
> - HSIO(High Speed IO) subsystem is new defined on i.MX8QM/QXP.
>   The PCIe and SATA modules are contained in the HSIO subsystem. There
>   are two PCIe, one SATA controllers and three mixed lane PHYs on
>   i.MX8QM. There are three use cases of the HSIO subsystem on i.MX8QM.
>   1. PCIea 2 lanes and one SATA AHCI port.
>   2. PCIea 1 lane, PCIeb 1 lane and one SATA AHCI port.
>   3. PCIea 2 lanes, PCIeb 1 lane.
>   i.MX8QXP only has PCIeb controller and one lane PHY.
> - The HSIO address map as viewed from system level is as shown below.
>   address [31:24]    Local address    Target    Address Size
>   5F                 0                HSIO      16MB
>   60-6F              40-4F            HSIO      256MB
>   70-7F              80-8F            HSIO      256MB
>   So, the cpu_addr_fixup is required to enable i.MX8QM/QXP PCIe.
> - Both external OSC and internal PLL can be used as PCIe reference
>   clock.
> - clock request GPIO for controlling the PCI reference clock request
>   signal. And should be configure OD when L1SS maybe enabled later.
> - One more power domain HSIO_GPIO and clock PCIE_PER are required by
>   i.MX8QM/QXP PCIe.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 392 +++++++++++++++++++++++++++++++++-
>  1 file changed, 387 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index aaa9489..aacefb6 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -39,6 +39,7 @@
>  #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE       BIT(11)
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE    GENMASK(11, 8)
>  #define IMX8MQ_PCIE2_BASE_ADDR                 0x33c00000
> +#define IMX8_HSIO_PCIEB_BASE_ADDR              0x5f010000
>
>  #define to_imx6_pcie(x)        dev_get_drvdata((x)->dev)
>
> @@ -48,10 +49,13 @@ enum imx6_pcie_variants {
>         IMX6QP,
>         IMX7D,
>         IMX8MQ,
> +       IMX8QM,
> +       IMX8QXP,
>  };
>
>  #define IMX6_PCIE_FLAG_IMX6_PHY                        BIT(0)
>  #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE       BIT(1)
> +#define IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP     BIT(2)

This is an IMX8Q* specific flag, so it probably should be called
something like IMX6_PCIE_FLAG_IMX8Qx_CPU_ADD_FIXUP.

>
>  struct imx6_pcie_drvdata {
>         enum imx6_pcie_variants variant;
> @@ -60,10 +64,12 @@ struct imx6_pcie_drvdata {
>
>  struct imx6_pcie {
>         struct dw_pcie          *pci;
> +       int                     clkreq_gpio;

Is this really necessary? On i.MX8MQ vendor tree for some unknown
reason would reconfigure a dedicated CLKREQ_B signal as a GPIO and
then use it as CLKREQ signal that way instead of controlling it via
dedicated bits in register file, so I am wondering if that is the case
with QM and QXP.

>         int                     reset_gpio;
>         bool                    gpio_active_high;
>         struct clk              *pcie_bus;
>         struct clk              *pcie_phy;
> +       struct clk              *pcie_per;
>         struct clk              *pcie_inbound_axi;
>         struct clk              *pcie;
>         struct clk              *pcie_aux;
> @@ -77,6 +83,9 @@ struct imx6_pcie {
>         u32                     tx_deemph_gen2_6db;
>         u32                     tx_swing_full;
>         u32                     tx_swing_low;
> +       u32                     hsio_cfg;
> +       u32                     ext_osc;
> +       u32                     local_addr;
>         int                     link_gen;
>         struct regulator        *vpcie;
>         void __iomem            *phy_base;
> @@ -85,6 +94,8 @@ struct imx6_pcie {
>         struct device           *pd_pcie;
>         /* power domain for pcie phy */
>         struct device           *pd_pcie_phy;
> +       /* power domain for hsio gpio used by pcie */
> +       struct device           *pd_hsio_gpio;
>         const struct imx6_pcie_drvdata *drvdata;
>  };
>
> @@ -92,6 +103,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_MAX_RETRIES  2000
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MIN   50
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX   200
> +#define L2_ENTRY_WAIT_MAX_RETRIES      10000
>
>  /* PCIe Root Complex registers (memory-mapped) */
>  #define PCIE_RC_IMX6_MSI_CAP                   0x50
> @@ -157,6 +169,43 @@ struct imx6_pcie {
>  #define PHY_RX_OVRD_IN_LO_RX_DATA_EN (1 << 5)
>  #define PHY_RX_OVRD_IN_LO_RX_PLL_EN (1 << 3)
>
> +/* iMX8 HSIO registers */
> +#define IMX8QM_CSR_PHYX2_OFFSET                        0x00000
> +#define IMX8QM_CSR_PHYX1_OFFSET                        0x10000
> +#define IMX8QM_CSR_PHYX_STTS0_OFFSET           0x4
> +#define IMX8QM_CSR_PCIEA_OFFSET                        0x20000
> +#define IMX8QM_CSR_PCIEB_OFFSET                        0x30000
> +#define IMX8QM_CSR_PCIE_CTRL1_OFFSET           0x4
> +#define IMX8QM_CSR_PCIE_CTRL2_OFFSET           0x8
> +#define IMX8QM_CSR_PCIE_STTS0_OFFSET           0xC
> +#define IMX8QM_CSR_MISC_OFFSET                 0x50000
> +
> +#define IMX8QM_CTRL_LTSSM_ENABLE               BIT(4)
> +#define IMX8QM_CTRL_READY_ENTR_L23             BIT(5)
> +#define IMX8QM_CTRL_PM_XMT_TURNOFF             BIT(9)
> +#define IMX8QM_CTRL_BUTTON_RST_N               BIT(21)
> +#define IMX8QM_CTRL_PERST_N                    BIT(22)
> +#define IMX8QM_CTRL_POWER_UP_RST_N             BIT(23)
> +
> +#define IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2      BIT(13)
> +#define IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST      BIT(19)
> +#define IMX8QM_STTS0_LANE0_TX_PLL_LOCK         BIT(4)
> +#define IMX8QM_STTS0_LANE1_TX_PLL_LOCK         BIT(12)
> +
> +#define IMX8QM_PCIE_TYPE_MASK                  GENMASK(27, 24)
> +
> +#define IMX8QM_PHYX2_CTRL0_APB_MASK            GENMASK(1, 0)
> +#define IMX8QM_PHY_APB_RSTN_0                  BIT(0)
> +#define IMX8QM_PHY_APB_RSTN_1                  BIT(1)
> +
> +#define IMX8QM_MISC_IOB_RXENA                  BIT(0)
> +#define IMX8QM_MISC_IOB_TXENA                  BIT(1)
> +#define IMX8QM_CSR_MISC_IOB_A_0_TXOE           BIT(2)
> +#define IMX8QM_CSR_MISC_IOB_A_0_M1M0_MASK      GENMASK(4, 3)
> +#define IMX8QM_CSR_MISC_IOB_A_0_M1M0_2         BIT(4)
> +#define IMX8QM_MISC_PHYX1_EPCS_SEL             BIT(12)
> +#define IMX8QM_MISC_PCIE_AB_SELECT             BIT(13)
> +
>  static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, int exp_val)
>  {
>         struct dw_pcie *pci = imx6_pcie->pci;
> @@ -373,14 +422,65 @@ static int imx6_pcie_attach_pd(struct device *dev)
>                 return PTR_ERR(link);
>         }
>
> +       switch (imx6_pcie->drvdata->variant) {
> +       case IMX8QM:
> +       case IMX8QXP:
> +               imx6_pcie->pd_hsio_gpio = dev_pm_domain_attach_by_name(dev,
> +                               "hsio_gpio");
> +               if (IS_ERR(imx6_pcie->pd_hsio_gpio))
> +                       return PTR_ERR(imx6_pcie->pd_hsio_gpio);
> +
> +               link = device_link_add(dev, imx6_pcie->pd_hsio_gpio,
> +                               DL_FLAG_STATELESS |
> +                               DL_FLAG_PM_RUNTIME |
> +                               DL_FLAG_RPM_ACTIVE);
> +               if (!link) {
> +                       dev_err(dev, "Failed to add device_link to gpio pd.\n");
> +                       return -EINVAL;
> +               }
> +
> +               break;
> +       default:
> +               break;
> +       }
> +
>         return 0;
>  }
>
>  static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
> +       u32 addr;
> +       int i;
>         struct device *dev = imx6_pcie->pci->dev;
>
>         switch (imx6_pcie->drvdata->variant) {
> +       case IMX8QXP:
> +               addr = IMX8QM_CSR_PCIEB_OFFSET + IMX8QM_CSR_PCIE_CTRL2_OFFSET;

This and similar "IMX8QM_CSR_PCIEA_OFFSET + i * SZ_64K" pattern keeps
popping up quite frequently in the code. I think at the very least it
would be good to calculate this offset in probe and store it as a
member of struct imx6_pcie. However I do wonder if this should
actually be handle by either declaring an additional syscon regmap of
additional reg/reg-name property.

> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                               IMX8QM_CTRL_BUTTON_RST_N,
> +                               IMX8QM_CTRL_BUTTON_RST_N);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                               IMX8QM_CTRL_PERST_N,
> +                               IMX8QM_CTRL_PERST_N);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                               IMX8QM_CTRL_POWER_UP_RST_N,
> +                               IMX8QM_CTRL_POWER_UP_RST_N);
> +               break;
> +       case IMX8QM:
> +               for (i = 0; i <= imx6_pcie->controller_id; i++) {

This loop is a bit surprising to me. It's hard to tell why you'd
iterate from 0 to controller_id. I think it'd be good to add a comment
explaining the logic behind this code.


> +                       addr = IMX8QM_CSR_PCIEA_OFFSET + i * SZ_64K;
> +                       addr += IMX8QM_CSR_PCIE_CTRL2_OFFSET;
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                                       IMX8QM_CTRL_BUTTON_RST_N,
> +                                       IMX8QM_CTRL_BUTTON_RST_N);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                                       IMX8QM_CTRL_PERST_N,
> +                                       IMX8QM_CTRL_PERST_N);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr, addr,
> +                                       IMX8QM_CTRL_POWER_UP_RST_N,
> +                                       IMX8QM_CTRL_POWER_UP_RST_N);
> +               }
> +               break;
>         case IMX7D:
>         case IMX8MQ:
>                 reset_control_assert(imx6_pcie->pciephy_reset);
> @@ -477,6 +577,21 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>                                    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
>                                    IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
>                 break;
> +       case IMX8QXP:
> +       case IMX8QM:
> +               ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
> +               if (ret) {
> +                       dev_err(dev, "unable to enable pcie_axi clock\n");
> +                       break;
> +               }
> +               ret = clk_prepare_enable(imx6_pcie->pcie_per);
> +               if (ret) {
> +                       dev_err(dev, "unable to enable pcie_per clock\n");
> +                       clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +                       break;
> +               }
> +
> +               break;
>         }
>
>         return ret;
> @@ -501,6 +616,63 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
>         dev_err(dev, "PCIe PLL lock timeout\n");
>  }
>
> +static int imx8_hsio_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
> +{
> +       u32 retries, addr, val, lock = 0;
> +       int ret;
> +       struct dw_pcie *pci = imx6_pcie->pci;
> +       struct device *dev = pci->dev;
> +
> +       addr = IMX8QM_CSR_PCIEA_OFFSET + imx6_pcie->controller_id * SZ_64K;
> +       addr += IMX8QM_CSR_PCIE_STTS0_OFFSET;
> +       for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
> +               regmap_read(imx6_pcie->iomuxc_gpr, addr, &val);
> +               if ((val & IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST) == 0)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       if ((val & IMX8QM_CTRL_STTS0_PM_REQ_CORE_RST) != 0) {
> +               dev_err(dev, "ERROR: PM_REQ_CORE_RST is still set.\n");
> +               return -ENODEV;
> +       }
> +

You can really cut down on boilerplate here by using regmap_read_poll_timeout()

> +       addr = IMX8QM_CSR_PHYX2_OFFSET + imx6_pcie->controller_id * SZ_64K;
> +       addr += IMX8QM_CSR_PHYX_STTS0_OFFSET;
> +       for (retries = 0; retries < PHY_PLL_LOCK_WAIT_MAX_RETRIES; retries++) {
> +               regmap_read(imx6_pcie->iomuxc_gpr, addr, &val);
> +               if (imx6_pcie->hsio_cfg == 2) {
> +                       if (imx6_pcie->controller_id == 0)
> +                               lock = IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
> +                       else
> +                               lock = IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
> +               } else if (imx6_pcie->hsio_cfg == 3) {
> +                       lock = IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
> +                       if (imx6_pcie->controller_id == 0)
> +                               lock |= IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
> +               } else if (imx6_pcie->hsio_cfg == 1) {
> +                       lock = IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
> +                       lock |= IMX8QM_STTS0_LANE1_TX_PLL_LOCK;
> +               } else {
> +                       dev_err(dev, "ERROR: illegal hsio_cfg value.\n");
> +                       return -EINVAL;
> +               }
> +               val &= lock;
> +               if (val == lock)
> +                       break;
> +               udelay(10);
> +       }
> +
> +       if (retries >= PHY_PLL_LOCK_WAIT_MAX_RETRIES) {
> +               dev_info(dev, "pcie phy pll can't be locked.\n");
> +               ret = -ENODEV;
> +       } else {
> +               dev_info(dev, "pcie phy pll is locked.\n");
> +       }
> +

Ditto.

> +       return ret;
> +}
> +
>  static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>  {
>         struct dw_pcie *pci = imx6_pcie->pci;
> @@ -553,6 +725,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>         }
>
>         switch (imx6_pcie->drvdata->variant) {
> +       case IMX8QXP:
> +       case IMX8QM:
> +               /* wait for phy pll lock firstly. */
> +               imx8_hsio_pcie_wait_for_phy_pll_lock(imx6_pcie);
> +               break;
>         case IMX8MQ:
>                 reset_control_deassert(imx6_pcie->pciephy_reset);
>                 break;
> @@ -613,25 +790,114 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>
>  static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
>  {
> -       unsigned int mask, val;
> -
> -       if (imx6_pcie->drvdata->variant == IMX8MQ &&
> +       unsigned int offset, mask, val;
> +
> +       if (imx6_pcie->drvdata->variant == IMX8QM ||
> +           imx6_pcie->drvdata->variant == IMX8QXP) {

Since there's now more than two possibilities, it'd probably make
sense to convert this code to use switch statement.

> +               offset = IMX8QM_CSR_PCIEA_OFFSET +
> +                       imx6_pcie->controller_id * SZ_64K;
> +               mask   = IMX8QM_PCIE_TYPE_MASK;
> +               val    = FIELD_PREP(IMX8QM_PCIE_TYPE_MASK,
> +                                   PCI_EXP_TYPE_ROOT_PORT);
> +       } else if (imx6_pcie->drvdata->variant == IMX8MQ &&
>             imx6_pcie->controller_id == 1) {
> +               offset = IOMUXC_GPR12;
>                 mask   = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
>                 val    = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>                                     PCI_EXP_TYPE_ROOT_PORT);
>         } else {
> +               offset = IOMUXC_GPR12;
>                 mask = IMX6Q_GPR12_DEVICE_TYPE;
>                 val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
>                                   PCI_EXP_TYPE_ROOT_PORT);
>         }
>
> -       regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
> +       regmap_update_bits(imx6_pcie->iomuxc_gpr, offset, mask, val);
>  }
>
>  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
>  {
>         switch (imx6_pcie->drvdata->variant) {
> +       case IMX8QXP:
> +       case IMX8QM:
> +               if (imx6_pcie->hsio_cfg == 1) {
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_PHYX2_OFFSET,
> +                               IMX8QM_PHYX2_CTRL0_APB_MASK,
> +                               IMX8QM_PHY_APB_RSTN_0 |
> +                               IMX8QM_PHY_APB_RSTN_1);
> +
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PHYX1_EPCS_SEL,
> +                               IMX8QM_MISC_PHYX1_EPCS_SEL);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PCIE_AB_SELECT,
> +                               0);
> +               } else if (imx6_pcie->hsio_cfg == 2) {
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_PHYX2_OFFSET,
> +                               IMX8QM_PHYX2_CTRL0_APB_MASK,
> +                               IMX8QM_PHY_APB_RSTN_0 |
> +                               IMX8QM_PHY_APB_RSTN_1);
> +
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PHYX1_EPCS_SEL,
> +                               IMX8QM_MISC_PHYX1_EPCS_SEL);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PCIE_AB_SELECT,
> +                               IMX8QM_MISC_PCIE_AB_SELECT);
> +               } else if (imx6_pcie->hsio_cfg == 3) {
> +                       if (imx6_pcie->controller_id)
> +                               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                                       IMX8QM_CSR_PHYX1_OFFSET,
> +                                       IMX8QM_PHY_APB_RSTN_0,
> +                                       IMX8QM_PHY_APB_RSTN_0);
> +                       else
> +                               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                                       IMX8QM_CSR_PHYX2_OFFSET,
> +                                       IMX8QM_PHYX2_CTRL0_APB_MASK,
> +                                       IMX8QM_PHY_APB_RSTN_0 |
> +                                       IMX8QM_PHY_APB_RSTN_1);
> +
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PHYX1_EPCS_SEL, 0);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_PCIE_AB_SELECT,
> +                               IMX8QM_MISC_PCIE_AB_SELECT);
> +               }
> +

This doesn't look controller independent/local. What would happen if
controller 0 specifies hsio_cfg == 2 and controller 1 specifies
hsio_cfg == 1?

> +               if (imx6_pcie->ext_osc) {
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_IOB_RXENA,
> +                               IMX8QM_MISC_IOB_RXENA);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_IOB_TXENA, 0);
> +               } else {
> +                       /* Try to used the internal pll as ref clk */
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_IOB_RXENA, 0);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_MISC_IOB_TXENA,
> +                               IMX8QM_MISC_IOB_TXENA);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               IMX8QM_CSR_MISC_OFFSET,
> +                               IMX8QM_CSR_MISC_IOB_A_0_TXOE |
> +                               IMX8QM_CSR_MISC_IOB_A_0_M1M0_MASK,
> +                               IMX8QM_CSR_MISC_IOB_A_0_TXOE |
> +                               IMX8QM_CSR_MISC_IOB_A_0_M1M0_2);
> +               }

Same here. It looks like specifying "ext_osc" for one controller and
leaving it out for another would lead to different outcome based on
which controller gets initialized first.

It seems that maybe abstracting all of this away via a generic PHY
subsystem would be a better path. See for example pci-dra7xx.c which
looks like it might be a good example.

> +
> +               break;
>         case IMX8MQ:
>                 /*
>                  * TODO: Currently this code assumes external
> @@ -763,6 +1029,7 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
>
>  static void imx6_pcie_ltssm_enable(struct device *dev)
>  {
> +       u32 val;
>         struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>
>         switch (imx6_pcie->drvdata->variant) {
> @@ -777,6 +1044,15 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
>         case IMX8MQ:
>                 reset_control_deassert(imx6_pcie->apps_reset);
>                 break;
> +       case IMX8QXP:
> +       case IMX8QM:
> +               val = IMX8QM_CSR_PCIEA_OFFSET +
> +                       imx6_pcie->controller_id * SZ_64K;
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_LTSSM_ENABLE,
> +                               IMX8QM_CTRL_LTSSM_ENABLE);
> +               break;
>         }
>  }
>
> @@ -908,13 +1184,25 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
>         return 0;
>  }
>
> +static u64 imx6_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> +{
> +       struct pcie_port *pp = &pcie->pp;
> +       struct imx6_pcie *imx6_pcie = to_imx6_pcie(pcie);
> +
> +       if (imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_CPU_ADDR_FIXUP)
> +               return (cpu_addr + imx6_pcie->local_addr - pp->mem_base);

If you do

cpu_addr += mx6_pcie->local_addr - pp->mem_base;

you won't need an else below.

> +       else
> +               return cpu_addr;
> +}
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -       /* No special ops needed, but pcie-designware still expects this struct */
> +       .cpu_addr_fixup = imx6_pcie_cpu_addr_fixup,
>  };
>
>  #ifdef CONFIG_PM_SLEEP
>  static void imx6_pcie_ltssm_disable(struct device *dev)
>  {
> +       u32 val;
>         struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>
>         switch (imx6_pcie->drvdata->variant) {
> @@ -926,6 +1214,17 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>         case IMX7D:
>                 reset_control_assert(imx6_pcie->apps_reset);
>                 break;
> +       case IMX8QXP:
> +       case IMX8QM:
> +               val = IMX8QM_CSR_PCIEA_OFFSET +
> +                       imx6_pcie->controller_id * SZ_64K;
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_LTSSM_ENABLE, 0);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               val + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_READY_ENTR_L23, 0);
> +               break;
>         default:
>                 dev_err(dev, "ltssm_disable not supported\n");
>         }
> @@ -933,6 +1232,8 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>
>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  {
> +       int i;
> +       u32 addr, val;
>         struct device *dev = imx6_pcie->pci->dev;
>
>         /* Some variants have a turnoff reset in DT */
> @@ -951,6 +1252,34 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>                 regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>                                 IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
>                 break;
> +       case IMX8QXP:
> +       case IMX8QM:
> +               addr = IMX8QM_CSR_PCIEA_OFFSET +
> +                       imx6_pcie->controller_id * SZ_64K;
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_PM_XMT_TURNOFF,
> +                               IMX8QM_CTRL_PM_XMT_TURNOFF);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_PM_XMT_TURNOFF, 0);

Is setting IMX8QM_CTRL_PM_XMT_TURNOFF on and then off necessary? I'd
add a comment to highlight that this is intentional.

> +               regmap_update_bits(imx6_pcie->iomuxc_gpr,
> +                               addr + IMX8QM_CSR_PCIE_CTRL2_OFFSET,
> +                               IMX8QM_CTRL_READY_ENTR_L23,
> +                               IMX8QM_CTRL_READY_ENTR_L23);
> +               /* check the L2 is entered or not. */
> +               for (i = 0; i < L2_ENTRY_WAIT_MAX_RETRIES; i++) {
> +                       regmap_read(imx6_pcie->iomuxc_gpr,
> +                                       addr + IMX8QM_CSR_PCIE_STTS0_OFFSET,
> +                                       &val);
> +                       if (val & IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2)
> +                               break;
> +                       udelay(10);
> +               }
> +               if ((val & IMX8QM_CTRL_STTS0_PM_LINKST_IN_L2) == 0)
> +                       dev_err(dev, "PCIE%d can't enter into L2.\n",
> +                                       imx6_pcie->controller_id);

regmap_read_poll_timeout()

> +               break;
>         default:
>                 dev_err(dev, "PME_Turn_Off not implemented\n");
>                 return;
> @@ -985,6 +1314,11 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>         case IMX8MQ:
>                 clk_disable_unprepare(imx6_pcie->pcie_aux);
>                 break;
> +       case IMX8QXP:
> +       case IMX8QM:
> +               clk_disable_unprepare(imx6_pcie->pcie_per);
> +               clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);

You can probably piggy back on IMX6SX since it has "pcie_inbound_axi" as well.

> +               break;
>         default:
>                 break;
>         }
> @@ -1084,7 +1418,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
>
> +       if (of_property_read_u32(node, "hsio-cfg", &imx6_pcie->hsio_cfg))
> +               imx6_pcie->hsio_cfg = 0;
> +       if (of_property_read_u32(node, "ext_osc", &imx6_pcie->ext_osc) < 0)
> +               imx6_pcie->ext_osc = 0;
> +       if (of_property_read_u32(node, "local-addr", &imx6_pcie->local_addr))
> +               imx6_pcie->local_addr = 0;

All of these properties will be initialized to zero by kzalloc and
of_property_read_u32() won't modify output variable unless it is
successful, so you can probably skip error checking.

> +
>         /* Fetch GPIOs */
> +       imx6_pcie->clkreq_gpio = of_get_named_gpio(node, "clkreq-gpio", 0);
> +       if (gpio_is_valid(imx6_pcie->clkreq_gpio)) {
> +               ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->clkreq_gpio,
> +                                           GPIOF_OUT_INIT_LOW, "PCIe CLKREQ");
> +               if (ret) {
> +                       dev_err(&pdev->dev, "unable to get clkreq gpio\n");
> +                       return ret;
> +               }
> +       } else if (imx6_pcie->clkreq_gpio == -EPROBE_DEFER) {
> +               return imx6_pcie->clkreq_gpio;
> +       }
> +
>         imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
>         imx6_pcie->gpio_active_high = of_property_read_bool(node,
>                                                 "reset-gpio-active-high");
> @@ -1155,6 +1508,25 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>                         return PTR_ERR(imx6_pcie->pcie_aux);
>                 }
>                 break;
> +       case IMX8QM:
> +       case IMX8QXP:
> +               if (dbi_base->start == IMX8_HSIO_PCIEB_BASE_ADDR)
> +                       imx6_pcie->controller_id = 1;
> +
> +               imx6_pcie->pcie_per = devm_clk_get(dev, "pcie_per");
> +               if (IS_ERR(imx6_pcie->pcie_per)) {
> +                       dev_err(dev, "pcie_per clock source missing or invalid\n");
> +                       return PTR_ERR(imx6_pcie->pcie_per);
> +               }
> +
> +               imx6_pcie->pcie_inbound_axi = devm_clk_get(&pdev->dev,
> +                               "pcie_inbound_axi");
> +               if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
> +                       dev_err(&pdev->dev,
> +                               "pcie clock source missing or invalid\n");
> +                       return PTR_ERR(imx6_pcie->pcie_inbound_axi);
> +               }

On i.MX8MQ "pcie_bus" clock in vendor tree wasn't actually pointing to
actual PCIE bus clock, so it might be worth checking if that's the
case for i.MX8QM/X and you actually need one more clock.

Thanks,
Andrey Smirnov
