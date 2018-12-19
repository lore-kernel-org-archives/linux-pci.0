Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F6CC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9131218AE
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbm18p51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeLSPHx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:07:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42312 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbeLSPHw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 10:07:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so19364971otk.9;
        Wed, 19 Dec 2018 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbKqp4NchEsk0Y5pDvdp0xLoLpKUrrKeIL2kRETgat4=;
        b=vbm18p51VNbfayvQaSLvBsDz1tDzt531L9luy0YF2BXDewxaLjhcIUgQgsQIOa08aE
         KLlppkBXUQpak9WjYAJ+B7os2j4eNLehJT96+1Bt2LyXf3gTtoDoH16z7TdMmzTTahit
         h1JwsJe4uBf3Ec+a8yxbaVDE60iwh6DjyoN0R/DvwXDhiupVyNy22uua+qp2XQ+JzYQY
         Egrr7xjX85vwBR1dAESmzmL8hwiiCVLxZB8gYc8Ob3MCF6i2afHEZMXblPqNPfwHX7gI
         s4D2Mm9+w1qaySCKimLq5emGOUGUPRLaD4eLDnVOp6dtd5PBL4w4Za+aZQ9lymdDw7IL
         Nb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbKqp4NchEsk0Y5pDvdp0xLoLpKUrrKeIL2kRETgat4=;
        b=ZSL+xRVEEI1YTxbo43EfhFUk6YXLuZGyK+4q90i+UrEeEHKuRvFmEEsm2dknGNYCmf
         CQ8F2Iv8FaWwuxKO13O/9/qcD8NH1Yx5UrerUHLv2quXIbs8NGmcH+ed3OYHT8dhnRnU
         J/+lte6hW1UZl7KITM4zXuV/nVe5yes04KLx0XUF95CTJbtZsjf6K1GR/zBCe1ggjZp8
         qDnvg3klLCnX5gy0EgvlyCPPDrbehsduKxhDqOWHUgFSDNGNuATtnd1obVekzdPvxGH6
         mm1jQQGIfQcdePRTQcOKcqj4QqOLZo9dJA2kh5ZqX0kvGhpKIR1PTf5+mUCyjmZO0U4z
         wLaQ==
X-Gm-Message-State: AA+aEWb6YmQi1KZ/ZSddTM0G7tWx6qfCnHguHLhYFQVx5P64CQx1W5dD
        xuyY3WIi81X+QTBUIlUltzJ89LYM3yg25cPdeoU=
X-Google-Smtp-Source: AFSGD/VxRmpyCwn19DqVTH7qG9H0Ij68NPQFRQtQugomr5GzLTmc86PyYfEq30W+7n84/CucVOujb5oOO+A52B7gjNs=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr16586291otp.225.1545232070400;
 Wed, 19 Dec 2018 07:07:50 -0800 (PST)
MIME-Version: 1.0
References: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 19 Dec 2018 10:07:39 -0500
Message-ID: <CAGngYiW5Y9+_kajQHKahUN-vGFoQvuO4-b0nzzCBSAt2TykQDg@mail.gmail.com>
Subject: Re: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch seems to fix the regression on my board: i.MX6 with a
tg3-based pcie NIC:
   CPU identified as i.MX6Q, silicon rev 1.5
   tg3 0000:03:00.0 eth0: Tigon3 [partno(BCM57780) rev 57780001] (PCI Express)

Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>

On Wed, Dec 19, 2018 at 12:25 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
> trigger MSI on i.MX6 PCIe.
> This bit would be asserted when CONFIG_PCIEPORTBUS=y.
> Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".
>
> Assert it unconditionally when MSI is enabled.
> Otherwise, the MSI wouldn't be triggered although the EP is present and
> the MSIs are assigned.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Changes v1 -> v2:
> * Assert the MSI_EN unconditionally when MSI is supported.
> Changes v2 -> v3:
> * Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
> PCI_MSI_IRQ_DOMAIN
> * Extended with a check for pci_msi_enabled() to see if the user
> explicitly want legacy IRQs
> Changes v3 -> v4:
> * Refer to Bjorn's comments, refine the subject and commit log and change
> the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
> Changes v4 -> v5:
> * Correct one spell mistake from PCIE_RC_MSI_IMX6_CAP to
> PCIE_RC_IMX6_MSI_CAP.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e563ca9..73542dd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX   200
>
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_IMX6_MSI_CAP                   0x50
>  #define PCIE_RC_LCR                            0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1       0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2       0x2
> @@ -999,6 +1000,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         struct resource *dbi_base;
>         struct device_node *node = dev->of_node;
>         int ret;
> +       u16 val;
>
>         imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>         if (!imx6_pcie)
> @@ -1149,6 +1151,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 return ret;
>
> +       if (pci_msi_enabled()) {
> +               val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +                               PCI_MSI_FLAGS);
> +               val |= PCI_MSI_FLAGS_ENABLE;
> +               dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +                               PCI_MSI_FLAGS, val);
> +       }
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
