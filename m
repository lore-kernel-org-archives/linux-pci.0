Return-Path: <SRS0=ZQO4=QM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6F8C282CB
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8B5217D9
	for <linux-pci@archiver.kernel.org>; Tue,  5 Feb 2019 06:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="aHKYf56s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfBEGJP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:09:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54121 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfBEGJO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Feb 2019 01:09:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so2239745wmb.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Feb 2019 22:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lcuTAIKDk5Jru1SXfKsJlExjF4BZoU+yuw8KbMKy3Xg=;
        b=aHKYf56soptJIGbTxy7Ay36ZHzUZt9ByQKrEbQ7YWyTZVa+yiJZOJHfEKe98OTeMoS
         Ljq2AWY7gjINK4jUO3Z9Z7PD/iKhdYAFp/MgKTrbZdzECgYkGrc91tdIBO29k8lt0mRX
         FBKJTN6RWQS6W35+KhHDJ1ni4pNvaHl/6QKSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcuTAIKDk5Jru1SXfKsJlExjF4BZoU+yuw8KbMKy3Xg=;
        b=VJF3Kgbi1E2rlC4yX3fKccO8HLwhkuCJJNVFULOBATp2gzIqV6efi/r5OYdy4wd5iM
         6ynZsWQWuNKglr1iNcAEZ31uG4kS6f8nH/LupLl/hTlw0/UmwgmIZ+OHWud/Hzkrxbqj
         lpEzbQ9XUEx7eCqN698aT4Xhxsp53ATszn6lc9DEHVceEYO5pRSEoeUnNwdHbowtzC+a
         4D9+RtZIPTSJHI/aUMkl4LMieJdknXFdqWjPxTGNYe908DqayHuC6W0qsEaZpZlzith+
         nB9rGBwtXUKHPx6jcuujrREL62s5p1Ev4DX8CqnX5nRVPp4juIz1HIFLghsXeVd292UY
         Iicw==
X-Gm-Message-State: AHQUAuZprzn/WBYSSb1CTPebv0KiczwL3IlVztfYtj0Y9j/UzF9BSuUP
        AEfqNqPzoSx7c63s7HCB315BL+rZ38X9Tgny91qLXA==
X-Google-Smtp-Source: AHgI3IZumWg/zzG2QOKGcQXa9PNHDYnUquuVdKoMcZ7AX7vf59yven64VfaW8r82JD0Gxa7ySeRxSWJBzW1SPVxlXTc=
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr1986937wmt.0.1549346952749;
 Mon, 04 Feb 2019 22:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-12-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Tue, 5 Feb 2019 11:41:46 +0530
Message-ID: <CAFZiPx0ea9Dnef_H+R0WcS-7V1WDCQTCU1dzta5+LsJjo+M_BQ@mail.gmail.com>
Subject: Re: [PATCHv3 11/27] PCI: mobiveil: only fix up the Class Code field
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
> Fix up the Class Code to PCI bridge, do not change the Revision ID.
> And move the fixup to mobiveil_host_init function.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge
> IP driver")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index 78e575e71f4d..8eee1ab7ee24 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -653,6 +653,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>                                    type, resource_size(win->res));
>         }
>
> +       /* fixup for PCIe class register */
> +       value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
> +       value &= 0xff;
> +       value |= (PCI_CLASS_BRIDGE_PCI << 16);
> +       csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
> +
>         /* setup MSI hardware registers */
>         mobiveil_pcie_enable_msi(pcie);
>
> @@ -896,9 +902,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
>                 goto error;
>         }
>
> -       /* fixup for PCIe class register */
> -       csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
> -
>         /* initialize the IRQ domains */
>         ret = mobiveil_pcie_init_irq_domain(pcie);
>         if (ret) {
> --
> 2.17.1
>
