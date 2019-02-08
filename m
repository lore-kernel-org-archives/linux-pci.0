Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCFEC169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B938217D8
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="RRsVGm7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfBHMje (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:39:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54924 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfBHMje (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:39:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so3256982wmh.4
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8TiUMbeW9gx3E0RaTlHXWjEpmH+gOGQ7pHr2BlHGy88=;
        b=RRsVGm7He3M1H0dan/L6W9QFbvDfV4DdV22eijIGeVYXVK7Fj4k2o8H3QdRJhyv0Rr
         7n10xPbAa1F4rmoR21AM5Lg2l/uNqfcx630EIcVu2AW4AIqDUfyGDv9NJUf49sk7ddvQ
         XmvC0OGenZFfPlD42kmOca47Wol7zADKtTD1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8TiUMbeW9gx3E0RaTlHXWjEpmH+gOGQ7pHr2BlHGy88=;
        b=mTdYb0c/zrXptS4lSOoqRgR5iQARM4lFOlXW5640BkIQHb0ZLgZ8mWv1PnzJpOqI7K
         ooZ0dCqmQjgPVknOfyM3QCbv3cRpAigyOCu4ar/+oDvD5+FTfrlK5Bv9qW9QVHPIw4I4
         p+iw7stepppbouXGjNJcInGDKtmYUKNk+vIMUJiB7ZVFWGmnKg2naubhL/Ggp1/vDw3E
         XMdluuVhvHfiYo4w1ZC4LA5JCxOMMQpgqz7A2mbug5fzcHxACTYTiY7JQALEYoj9oAbx
         Ob5oCfkUNjY8R8jPLo6DOT6JuQhAnSjWn3oYEqQdczlYvfxNjfJiwImW2amABWZNbQgw
         T4pQ==
X-Gm-Message-State: AHQUAubZcgnhrY/B/STACf1DBxi6+BPc5CAgl0tr+1cmSI6W8cftmWik
        lfq/U5jF7nKp9y2TTEmSda3QsVKttRjPKs0X1RAC4w==
X-Google-Smtp-Source: AHgI3IYytYbKN3VNWvXrhJ8UXMmfHdlGAb4mQC3bNjTkJAEpyHTpW4Q3ArQ7aHNEE3zrZzqi5u7Jngf15GXxJYIcaMQ=
X-Received: by 2002:a1c:9e4a:: with SMTP id h71mr11825119wme.82.1549629572788;
 Fri, 08 Feb 2019 04:39:32 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-20-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-20-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:12:12 +0530
Message-ID: <CAFZiPx1B7iTKgyr4uRJDescLx+NRLdOhjBdMyCoYA2Hja6Xy2g@mail.gmail.com>
Subject: Re: [PATCHv3 19/27] PCI: mobiveil: disabled IB and OB windows set by bootloader
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

On Tue, Jan 29, 2019 at 1:40 PM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Disabled all inbound and outbound windows before set up the windows
> in kernel, in case transactions match the window set by bootloader.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  .../controller/mobiveil/pcie-mobiveil-host.c   |  7 +++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.c    | 18 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h    |  2 ++
>  3 files changed, 27 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index d1765d572f44..d028cdf31d0e 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -221,6 +221,13 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>  {
>         u32 value, pab_ctrl, type;
>         struct resource_entry *win;
> +       int i;
> +
> +       /* Disable all inbound/outbound windows */
> +       for (i = 0; i < pcie->apio_wins; i++)
> +               mobiveil_pcie_disable_ob_win(pcie, i);
> +       for (i = 0; i < pcie->ppio_wins; i++)
> +               mobiveil_pcie_disable_ib_win(pcie, i);
>
>         /* setup bus numbers */
>         value = csr_readl(pcie, PCI_PRIMARY_BUS);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> index 370658d6546d..49d471b75925 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -226,3 +226,21 @@ int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
>
>         return -ETIMEDOUT;
>  }
> +
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num)
> +{
> +       u32 val;
> +
> +       val = csr_readl(pci, PAB_PEX_AMAP_CTRL(win_num));
> +       val &= ~(1 << AMAP_CTRL_EN_SHIFT);
> +       csr_writel(pci, val, PAB_PEX_AMAP_CTRL(win_num));
> +}
> +
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num)
> +{
> +       u32 val;
> +
> +       val = csr_readl(pci, PAB_AXI_AMAP_CTRL(win_num));
> +       val &= ~(1 << WIN_ENABLE_SHIFT);
> +       csr_writel(pci, val, PAB_AXI_AMAP_CTRL(win_num));
> +}
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index eb4cb61291a8..81685840b378 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -171,6 +171,8 @@ void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
>                         u64 pci_addr, u32 type, u64 size);
>  void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
>                         u64 pci_addr, u32 type, u64 size);
> +void mobiveil_pcie_disable_ob_win(struct mobiveil_pcie *pci, int win_num);
> +void mobiveil_pcie_disable_ib_win(struct mobiveil_pcie *pci, int win_num);
>  u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
>  void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
>
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
