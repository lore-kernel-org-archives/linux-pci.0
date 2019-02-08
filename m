Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B05C169C4
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF7F2086C
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="LTW9Gy9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfBHMmT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:42:19 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37155 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfBHMmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:42:19 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so3432674wrs.4
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
        b=LTW9Gy9VdLkzCaQ8/6LR1RN5CMBX4DNv4zx8Vt+n9WPe5s5U2j2SkWi9d6uJPlV/zx
         q2zfeEvtPuL0+gE773N8fRvWzd+7hhAGOqytTlwdAVErVEIm+4ioBVY8sc175wb7NQiV
         F8Ywgr5UzWMCXiEm92JA1qgPgSj1rA8WtsmdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcNSWtz/94EAq7Zt0ztZtaogVS62SwmBQ8CLMNUPaIE=;
        b=Yvy0G/ojGI5/dCCtBQNm5fvXutG2KloZchAyGWbw5SEK55OEWlG3APVuQw5gGJ8lS4
         QnV1JHWMy3IW7cjY3IQbOjophcBaZJ5rAlgJ08DmV6FCfZDWpom72Jl417t/ATbKjbfv
         XFV8aVnxVEXsow2ltMcbHNeyInzNof7EbHXhQpore1er2EvtplATqqIaZTyN7XoGZyAQ
         PlcW56OKOKk9eQuI5hYLVY8dH/tS6TQbqz9d/GSdBGK60TTjMLvIzm8izs+bsZBtqKfL
         Ga3wR8ct0sXTK4Dud8V96FP8XW/jku1XQapuoTcT08XaZfYkRA+B6nK048MALPVFTv/u
         da+w==
X-Gm-Message-State: AHQUAubH5wbjrV64FUtZWke1mcS3C2QLfhxhLFXoyjjcYdmPDmwLxgvg
        9EPlAxJUjRG5REN95U6Pc0cESSpkCx40WD/qjWWRmQ==
X-Google-Smtp-Source: AHgI3IaFmjXxGwVIVl/tppCIeLz9HYPH8Ihh1C5K04cAMhMPJi87YuzbKG67WoAepyYFp1mHlKOJKR7kpdPF70VdDj4=
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16532537wrr.105.1549629737745;
 Fri, 08 Feb 2019 04:42:17 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-21-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:14:57 +0530
Message-ID: <CAFZiPx1esvy7uqAymR7oU+hXSAUwLbKgUo3dK3CoHSajsD41-A@mail.gmail.com>
Subject: Re: [PATCHv3 20/27] PCI: mobiveil: add Byte and Half-Word width
 register accessors
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
> As there are some Byte and Half-Work width registers in PCIe
> configuration space, add Byte and Half-Word width register
> accessors.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 81685840b378..933c2f34bc52 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -181,9 +181,29 @@ static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
>         return csr_read(pcie, off, 0x4);
>  }
>
> +static inline u32 csr_readw(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x2);
> +}
> +
> +static inline u32 csr_readb(struct mobiveil_pcie *pcie, u32 off)
> +{
> +       return csr_read(pcie, off, 0x1);
> +}
> +
>  static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
>  {
>         csr_write(pcie, val, off, 0x4);
>  }
>
> +static inline void csr_writew(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x2);
> +}
> +
> +static inline void csr_writeb(struct mobiveil_pcie *pcie, u32 val, u32 off)
> +{
> +       csr_write(pcie, val, off, 0x1);
> +}
> +
>  #endif /* _PCIE_MOBIVEIL_H */
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
