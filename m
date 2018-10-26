Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0082DECDE46
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 21:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3AA2082B
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 21:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3AA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeJ0Fjj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:39:39 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38307 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJ0Fjj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Oct 2018 01:39:39 -0400
Received: by mail-oi1-f196.google.com with SMTP id k19-v6so2208011oiw.5;
        Fri, 26 Oct 2018 14:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVlDeIxXOJFWyvrYSVlklmDwdDxaa13w01/V7QPawOM=;
        b=eZ+QEd4E5AmtxExrWiRvyYGBTfIRGWv2XX3uwvwShe+UxpTVGwFxe7eXxB6E9Tv4ND
         XeHwSyuCl4Nv9zwCKiRh3TdAaRIvDoTPuV0/xps5iuwfQH2pinqvPu5mtB6Yho6Y68GS
         vdZfUM4SgUTBGvNQhoZYu7gO8M9X5Jq7NmyxiR7mEIr2yRyEBBpFQEirzbJvRq6BCWHi
         /0aDzef183aYBgBgBVZ6ftY+ihBkyanhxHTx2RlClk6N2xe8+JJBA6BocPIDgjOVgc/w
         WGpSjm8doXHFXKGU0RZs6N6+VFneHMLDoOF3oIrx9ezoFl+717ny6c85uWGL3T0kV0uo
         lAAg==
X-Gm-Message-State: AGRZ1gJxJZbkx1Qqz997H3pwGLPVRYuegxECkKiaKSBTFRfqLQ9SCss4
        6tXZ2nyVeC01M1ms9K5Eysac35JGQxo=
X-Google-Smtp-Source: AJdET5c3/tCBRpHA1Somyum7rQ4Ms8TVq3nTvPwxjNppuzpwYydq47wn5UezxfkH9xYkcpPJfDpkSQ==
X-Received: by 2002:aca:e087:: with SMTP id x129-v6mr3292500oig.221.1540587664953;
        Fri, 26 Oct 2018 14:01:04 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id 143-v6sm5540031oii.16.2018.10.26.14.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 14:01:04 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id r127-v6so475266oie.3;
        Fri, 26 Oct 2018 14:01:03 -0700 (PDT)
X-Received: by 2002:aca:5215:: with SMTP id g21-v6mr2773754oib.351.1540587663497;
 Fri, 26 Oct 2018 14:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com> <20181025094929.29481-5-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025094929.29481-5-Zhiqiang.Hou@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 26 Oct 2018 16:00:52 -0500
X-Gmail-Original-Message-ID: <CADRPPNQ=cyi5b+86VvoS2XRycU-WvWM5s2RXYopi=RaMjjYpLg@mail.gmail.com>
Message-ID: <CADRPPNQ=cyi5b+86VvoS2XRycU-WvWM5s2RXYopi=RaMjjYpLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dts/arm64/layerscape: Clean PCIe controller
 compatible strings
To:     Zhiqiang Hou <zhiqiang.hou@nxp.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Minghuan Lian <minghuan.lian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 25, 2018 at 4:53 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:

The correct prefix for arm64 dts patches should be: "arm64: dts:
layerscape: ...", and it should be better to mention the string
removed in the title too.

>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Removed the wrong compatible string "snps,dw-pcie", in case
> match incorrect driver.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - no change
>
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  6 +++---
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  8 ++++----
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 12 ++++--------
>  6 files changed, 18 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 5da732f82fa0..028a6daa5597 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -475,7 +475,7 @@
>                 };
>
>                 pcie@3400000 {
> -                       compatible = "fsl,ls1012a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1012a-pcie";
>                         reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>                                0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 3fed504b5381..5480d6c4c548 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -661,7 +661,7 @@
>                 };
>
>                 pcie@3400000 {
> -                       compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1043a-pcie";
>                         reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>                                0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -686,7 +686,7 @@
>                 };
>
>                 pcie@3500000 {
> -                       compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1043a-pcie";
>                         reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>                                0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -711,7 +711,7 @@
>                 };
>
>                 pcie@3600000 {
> -                       compatible = "fsl,ls1043a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1043a-pcie";
>                         reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>                                0x50 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 51cbd50012d6..519315c5d507 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -630,7 +630,7 @@
>                 };
>
>                 pcie@3400000 {
> -                       compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1046a-pcie";
>                         reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>                                0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -655,7 +655,7 @@
>                 };
>
>                 pcie@3500000 {
> -                       compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1046a-pcie";
>                         reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>                                0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -680,7 +680,7 @@
>                 };
>
>                 pcie@3600000 {
> -                       compatible = "fsl,ls1046a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1046a-pcie";
>                         reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>                                0x50 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index a07f612ab56b..10b253c88a16 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -512,7 +512,7 @@
>                 };
>
>                 pcie@3400000 {
> -                       compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1088a-pcie";
>                         reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>                                0x20 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -536,7 +536,7 @@
>                 };
>
>                 pcie@3500000 {
> -                       compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1088a-pcie";
>                         reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>                                0x28 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -560,7 +560,7 @@
>                 };
>
>                 pcie@3600000 {
> -                       compatible = "fsl,ls1088a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1088a-pcie";
>                         reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>                                0x30 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> index 7c882da3f6b0..a5f668d786b8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> @@ -119,7 +119,7 @@
>  };
>
>  &pcie1 {
> -       compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
> +       compatible = "fsl,ls2088a-pcie";
>         reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
>                0x20 0x00000000 0x0 0x00002000>; /* configuration space */
>
> @@ -128,7 +128,7 @@
>  };
>
>  &pcie2 {
> -       compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
> +       compatible = "fsl,ls2088a-pcie";
>         reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
>                0x28 0x00000000 0x0 0x00002000>; /* configuration space */
>
> @@ -137,7 +137,7 @@
>  };
>
>  &pcie3 {
> -       compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
> +       compatible = "fsl,ls2088a-pcie";
>         reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
>                0x30 0x00000000 0x0 0x00002000>; /* configuration space */
>
> @@ -146,7 +146,7 @@
>  };
>
>  &pcie4 {
> -       compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
> +       compatible = "fsl,ls2088a-pcie";
>         reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
>                0x38 0x00000000 0x0 0x00002000>; /* configuration space */
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index d188774a36e8..80cc40f76a4a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -630,8 +630,7 @@
>                 };
>
>                 pcie1: pcie@3400000 {
> -                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
> -                                    "snps,dw-pcie";
> +                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>                         reg-names = "regs", "config";
>                         interrupts = <0 108 0x4>; /* Level high type */
>                         interrupt-names = "intr";
> @@ -651,8 +650,7 @@
>                 };
>
>                 pcie2: pcie@3500000 {
> -                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
> -                                    "snps,dw-pcie";
> +                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>                         reg-names = "regs", "config";
>                         interrupts = <0 113 0x4>; /* Level high type */
>                         interrupt-names = "intr";
> @@ -672,8 +670,7 @@
>                 };
>
>                 pcie3: pcie@3600000 {
> -                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
> -                                    "snps,dw-pcie";
> +                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>                         reg-names = "regs", "config";
>                         interrupts = <0 118 0x4>; /* Level high type */
>                         interrupt-names = "intr";
> @@ -693,8 +690,7 @@
>                 };
>
>                 pcie4: pcie@3700000 {
> -                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie",
> -                                    "snps,dw-pcie";
> +                       compatible = "fsl,ls2080a-pcie", "fsl,ls2085a-pcie";
>                         reg-names = "regs", "config";
>                         interrupts = <0 123 0x4>; /* Level high type */
>                         interrupt-names = "intr";
> --
> 2.17.1
>
