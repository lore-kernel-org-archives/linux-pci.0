Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F1C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0E92080D
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="p9GLObg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBEGIy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:08:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37159 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBEGIx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:08:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so2303960wmd.2
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ELibCrneAOqwWPIu61khxaNFyTEmcNLtmVqUCXdZgZI=;
        b=p9GLObg0JIzLvnYv92UNo3hutvaKV76mneDoQ2L9/iTDSMkv3BmHlcM2r2diWaexun
         +bwDe1L79unhjKqIc7PdW6AxCpdjScxefjOqXn1Bp2WyEuEvsc8rTypwqcYBZfdaGNcp
         1avY7a1g6ehg1Q1DcR74Aj1fpp0U0Op9aInUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ELibCrneAOqwWPIu61khxaNFyTEmcNLtmVqUCXdZgZI=;
        b=kcSHEiVXSKCSBtVEjudlj8V9stsoU6/r9nGlDXnpPFXDsUgzeVV5EonlRiJxghGM5d
         tS40+JuROZOnnqpKvE6dklCyUByLYldH+uy6IgjiLxN0YsN2OlkHWZQJyL9l8qkOoLxc
         EYKm+i6GNnLDmDpRNjj2gkJXwL7PHr4HYeOvasXH+8pQ4yA+vo9p13PF5haQdS/pr72c
         MofuJq4TfMIqAsGgOSmqzYDGzjxaCmnW/utysdNfvP0/uP0x4e1i3jqXuNa7PvRchaJs
         cHh4dPwyvPQLpXFRsSB7nBMrZVscVzRMsy1gT6HuLCV6JgjWXZgDmhe+sMdQLJBw/rWE
         tYpg==
X-Gm-Message-State: AHQUAuYO0Pn4x54iEBdHxNCTRnGpzHFbzhUJ0G4Pfh/4xcUPPS1d9xVu
        l5Jh/d0v0wUI4cob4EA25RKG09Hqiai5xBlO3pYTng==
X-Google-Smtp-Source: AHgI3IZ7vYwWoGmUAjYcSLDuLlos9cVh2whMlbvpfSVJ8Ytix0mKWBdHfrN2urnd6jPoX1ucPPMGeuzPxTUEa4j1BaQ=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr2221588wmu.52.1549346931639;
 Mon, 04 Feb 2019 22:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-11-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:41:25 +0530
Message-ID: <CAFZiPx3niFC67o-p_NRi-ReuWYDcSJqUWmVfqKj+R2LnzAMPFA@mail.gmail.com>
Subject: Re: [PATCHv3 10/27] PCI: mobiveil: fix the INTx process error
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>

On Tue, Jan 29, 2019 at 1:39 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> In the loop block, there is not code change the loop key,
> this patch updated the loop key by re-read the INTx status
> register.
>
> This patch also change to clear the handled INTx status.
>
> Note: Need MV to test this fix.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host
> Bridge IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 4ba458474e42..78e575e71f4d 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -361,6 +361,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>         /* Handle INTx */
>         if (intr_status & PAB_INTP_INTX_MASK) {
>                 shifted_status = csr_readl(pcie, PAB_INTP_AMBA_MISC_STAT);
> +               shifted_status &= PAB_INTP_INTX_MASK;
>                 shifted_status >>= PAB_INTX_START;
>                 do {
>                         for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
> @@ -372,12 +373,16 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
>                                         dev_err_ratelimited(dev, "unexpected IRQ, INT%d\n",
>                                                             bit);
>
> -                               /* clear interrupt */
> -                               csr_writel(pcie,
> -                                          shifted_status << PAB_INTX_START,
> +                               /* clear interrupt handled */
> +                               csr_writel(pcie, 1 << (PAB_INTX_START + bit),
>                                            PAB_INTP_AMBA_MISC_STAT);
>                         }
> -               } while ((shifted_status >> PAB_INTX_START) != 0);
> +
> +                       shifted_status = csr_readl(pcie,
> +                                                  PAB_INTP_AMBA_MISC_STAT);
> +                       shifted_status &= PAB_INTP_INTX_MASK;
> +                       shifted_status >>= PAB_INTX_START;
> +               } while (shifted_status != 0);
>         }
>
>         /* read extra MSI status register */
> --
> 2.17.1
>
