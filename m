Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDFAC282CB
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A38A2073D
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="eK5Pp9Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfBHM3M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 07:29:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfBHM3L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Feb 2019 07:29:11 -0500
Received: by mail-wr1-f67.google.com with SMTP id a16so3426409wrv.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Feb 2019 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9nFuyNIknlIPIGeHUyXP6qUPfqzFzQLiNuJwZvm5cU=;
        b=eK5Pp9RuVMmtIWtg7h7fgU66oyZMjz3hwMnNA+eP++5q7EFsskUTciNTLlXSPxZ3ja
         b413Rwfl8CdiPQedqr0B+riZ3+ruwnAFU1hHFHgWVzk8X5aAU/g/bP6B3hmcGnCobjN1
         xvjy2sUSCVGYEXtrv8VepBlC51tsCRacZ1Dig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9nFuyNIknlIPIGeHUyXP6qUPfqzFzQLiNuJwZvm5cU=;
        b=a4ZKloeKEeAPSlTo+WwG2gQ2DrJi/mnw9Coz9fdHzrYQb0y7tGdiydGfSpeqWzysyb
         t1ew659GKR741eHqyUVwjCoA9Inr7l19W6fAdEVsdWtLpjTczb8xk6cQAECW7LEWBbBy
         piq/ksTjA03exWkmp0QHHp+b8lyv7aldSQYrLIfJiqWqyJIlJfj2vunUnWSvDPKpoNhw
         /jBzVKwmtcnFTl0xMIeJvkYf9P13rQtcq5yTBbyYe/ibkeJBteoRjkXAqI5p4kpaVv7c
         3Xx+WVhB3gdnWOKjM5/BGK+ASO4mFT5adQZMPoiZIzUsjqGX7wq8MXUAFYho2hsPVVe2
         jHiQ==
X-Gm-Message-State: AHQUAuauY06u/3nT+FZo+9HcRMbZr0dq8T61T+Gv/Mm4jhCNNcLeRBxh
        lQhKnKSdi3rIJ0+tqvHq7y9cCGFjQFdiLZl6eSU4DA==
X-Google-Smtp-Source: AHgI3IY1p3Yuz0ID0EDGHal6AKMUbD4D2TsUhOweezQ/5aEp+LsUms5K76ATBXPhfhNeKqUgYORS/92rCevTgNKKe88=
X-Received: by 2002:adf:b201:: with SMTP id u1mr3445624wra.165.1549628949513;
 Fri, 08 Feb 2019 04:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20190129080926.36773-1-Zhiqiang.Hou@nxp.com> <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190129080926.36773-15-Zhiqiang.Hou@nxp.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Fri, 8 Feb 2019 18:01:48 +0530
Message-ID: <CAFZiPx3qPHWfyz8R1xhsvZyS40WdyWGCZzSd8xgcQ3q+H9WCYQ@mail.gmail.com>
Subject: Re: [PATCHv3 14/27] PCI: mobiveil: initialize Primary/Secondary/Subordinate
 bus number
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
> The reset value is all zero, so set a workable value for Primary,
> Secondary and Subordinate bus numbers.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
> V3:
>  - No change
>
>  drivers/pci/controller/pcie-mobiveil.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index db7ecb021c63..9210165fe8c0 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -582,6 +582,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
>         u32 value, pab_ctrl, type;
>         struct resource_entry *win;
>
> +       /* setup bus numbers */
> +       value = csr_readl(pcie, PCI_PRIMARY_BUS);
> +       value &= 0xff000000;
> +       value |= 0x00ff0100;
> +       csr_writel(pcie, value, PCI_PRIMARY_BUS);
> +
>         /*
>          * program Bus Master Enable Bit in Command Register in PAB Config
>          * Space
> --
> 2.17.1
>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
