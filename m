Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83502C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419D12175B
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLbwUvSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419D12175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbeKOIxD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:53:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40819 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOIxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 03:53:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so6177402wmf.5;
        Wed, 14 Nov 2018 14:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sTgRbRtlBuRhiGv74EwLLuTsqUsnOf8/Os99kPorHs=;
        b=lLbwUvSelNmXfLk2Yoa8A09JyX9aA0x+aNMVXPm9z5O/oKfTmwGGvI1TFcvJWPMWNY
         JijCVvu5m2bfdYppKZyQN/uK4DJvbt0EwcTdjrAEMyIC6E7KoMLNiP+f3MaI65+RfYOj
         s/EPI+G+k460HYG2K9Aj/bSzRlzQdwuDE4+ZL4lvuuUEQHLcjdAqg01wdNqi/rFHvom0
         rJjiEV2I7vbaLQm41aIKaN6nVZBOwj8u2FJok22Mrkt99PnxG2CU5a1r/lMJ2+sQ86Z8
         keEtwQnqMda5SWm/5KYlom6jSEguLFAeHGR1DOXOC5Rqm6DhTqML1CRNnZumLXCUi+pE
         suwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sTgRbRtlBuRhiGv74EwLLuTsqUsnOf8/Os99kPorHs=;
        b=mNDOZDvK158RzDoVO3877l6ylZ20m25yHTOQcgR4fYjiVJmHQ5hzEUKxYibZF6KMLt
         yUfFxSkxbwO6It6000sY8zZr7XKiA8qGVvY3sGGHJSw/LsDNB/yQzG3D8z7wnZLEGE9j
         SUt3vr2goVq1rAupn+MNQgaNP3xcuuhVwMXvJQjPLwBPILs4IJBvyAY48BGFtqOlgI0M
         nDWq4hS9CMIixIo+twOcGKj4VmEqS+5rEX7tv4VKohLXyP4sVwAV5lh+SQ+1fmVO/qMe
         wk7CS9I6VqBmQ4y8uFI/Ot8hJg0NT+3Pm1UoGjSu/7wma9dgIDMeQ5rvT5DFZ/mwa/RE
         QY9g==
X-Gm-Message-State: AGRZ1gKDu0rHvtH9XSyhhYXQpRO5jlWOg4e81OVrggyXN6+35cHDuNof
        XSt00Z/10H6EEnR3m067q7PwXt4ZT7GUe69o8ig=
X-Google-Smtp-Source: AJdET5edpHXv2vOxVTMu+d+g9l4T6tYv4j6iNkf85M4fDpkkYrCxk1R497V5Ol1oiFJGyczWGwIprB88OUmL2+Tc2fw=
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr3267116wme.8.1542235669105;
 Wed, 14 Nov 2018 14:47:49 -0800 (PST)
MIME-Version: 1.0
References: <984fcef6d928632241a4a3bce41e2645a304d335.1541598751.git.leonard.crestez@nxp.com>
In-Reply-To: <984fcef6d928632241a4a3bce41e2645a304d335.1541598751.git.leonard.crestez@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 14 Nov 2018 14:47:37 -0800
Message-ID: <CAHQ1cqFx+5otBNGA1Cx1s=HuCLgOi9yM9z=qwrP=OASUcH21=A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: imx: Add imx6sx suspend/resume support
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 7, 2018 at 5:57 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> Enable PCI suspend/resume support on imx6sx socs. This is similar to
> imx7d with a few differences:
>
> * The PM_Turn_Off bit is exposed through an IOMUX GPR, like all other
> pcie control bits on 6sx.
> * The pcie_inbound_axi clk needs to be turned off in suspend. On resume
> it is restored via resume -> deassert_core_reset -> enable_ref_clk.
>
> Most of the resume logic is shared with the initial reset after probe.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
> ---
> Changes since v1:
> * Use a switch statement in imx6_pcie_pm_turnoff. The DT-based turnoff
> path is still an if statement.
> * Did not split imx6_pcie_clk_disable or call it from other paths, this
> would bring complications and is somewhat unrelated.
> * See v1 comments: https://lore.kernel.org/patchwork/patch/996806/
>
>  drivers/pci/controller/dwc/pci-imx6.c       | 44 ++++++++++++++++++---
>  include/linux/mfd/syscon/imx6q-iomuxc-gpr.h |  1 +
>  2 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 2cbef2d7c207..54625569d0bc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -771,41 +771,75 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
>         }
>  }
>
>  static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
>  {
> -       reset_control_assert(imx6_pcie->turnoff_reset);
> -       reset_control_deassert(imx6_pcie->turnoff_reset);
> +       struct device *dev = imx6_pcie->pci->dev;
> +
> +       /* Some variants have a turnoff reset in DT */
> +       if (imx6_pcie->turnoff_reset) {
> +               reset_control_assert(imx6_pcie->turnoff_reset);
> +               reset_control_deassert(imx6_pcie->turnoff_reset);
> +               goto pm_turnoff_sleep;
> +       }
> +
> +       /* Others poke directly at IOMUXC registers */
> +       switch (imx6_pcie->variant) {
> +       case IMX6SX:
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +                               IMX6SX_GPR12_PCIE_PM_TURN_OFF,
> +                               IMX6SX_GPR12_PCIE_PM_TURN_OFF);
> +               regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +                               IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
> +               break;
> +       default:
> +               dev_err(dev, "PME_Turn_Off not implemented\n");
> +               return;

Purely optionally, if you feel like avoiding goto you can change this to:

default:
    if (!imx6_pcie->turnoff_reset) {
        dev_err(dev, "PME_Turn_Off not implemented\n");
        return;
    }

    reset_control_assert(imx6_pcie->turnoff_reset);
    reset_control_deassert(imx6_pcie->turnoff_reset);
    break;

but that's up to you. FWIW, patch looks reasonable:

Reviewed-by: Andrey Smirnov <andrew.smirnov@gmail.com>

> +       }
>
>         /*
>          * Components with an upstream port must respond to
>          * PME_Turn_Off with PME_TO_Ack but we can't check.
>          *
>          * The standard recommends a 1-10ms timeout after which to
>          * proceed anyway as if acks were received.
>          */
> +pm_turnoff_sleep:
>         usleep_range(1000, 10000);
>  }
>
>  static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
>  {
>         clk_disable_unprepare(imx6_pcie->pcie);
>         clk_disable_unprepare(imx6_pcie->pcie_phy);
>         clk_disable_unprepare(imx6_pcie->pcie_bus);
>
> -       if (imx6_pcie->variant == IMX7D) {
> +       switch (imx6_pcie->variant) {
> +       case IMX6SX:
> +               clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> +               break;
> +       case IMX7D:
>                 regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
>                                    IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
>                                    IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +               break;
> +       default:
> +               break;
>         }
>  }
>
> +static inline bool imx6_pcie_supports_suspend(struct imx6_pcie *imx6_pcie)
> +{
> +       return (imx6_pcie->variant == IMX7D ||
> +               imx6_pcie->variant == IMX6SX);
> +}
> +
>  static int imx6_pcie_suspend_noirq(struct device *dev)
>  {
>         struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>
> -       if (imx6_pcie->variant != IMX7D)
> +       if (!imx6_pcie_supports_suspend(imx6_pcie))
>                 return 0;
>
>         imx6_pcie_pm_turnoff(imx6_pcie);
>         imx6_pcie_clk_disable(imx6_pcie);
>         imx6_pcie_ltssm_disable(dev);
> @@ -817,11 +851,11 @@ static int imx6_pcie_resume_noirq(struct device *dev)
>  {
>         int ret;
>         struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
>         struct pcie_port *pp = &imx6_pcie->pci->pp;
>
> -       if (imx6_pcie->variant != IMX7D)
> +       if (!imx6_pcie_supports_suspend(imx6_pcie))
>                 return 0;
>
>         imx6_pcie_assert_core_reset(imx6_pcie);
>         imx6_pcie_init_phy(imx6_pcie);
>         imx6_pcie_deassert_core_reset(imx6_pcie);
> diff --git a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> index 6c1ad160ed87..c1b25f5e386d 100644
> --- a/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> +++ b/include/linux/mfd/syscon/imx6q-iomuxc-gpr.h
> @@ -438,10 +438,11 @@
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_LCDIF1              (0x0 << 1)
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_LVDS                        (0x1 << 1)
>  #define IMX6SX_GPR5_DISP_MUX_DCIC1_MASK                        (0x1 << 1)
>
>  #define IMX6SX_GPR12_PCIE_TEST_POWERDOWN               BIT(30)
> +#define IMX6SX_GPR12_PCIE_PM_TURN_OFF                  BIT(16)
>  #define IMX6SX_GPR12_PCIE_RX_EQ_MASK                   (0x7 << 0)
>  #define IMX6SX_GPR12_PCIE_RX_EQ_2                      (0x2 << 0)
>
>  /* For imx6ul iomux gpr register field define */
>  #define IMX6UL_GPR1_ENET1_CLK_DIR              (0x1 << 17)
> --
> 2.17.1
>
