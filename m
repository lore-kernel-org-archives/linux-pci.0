Return-Path: <SRS0=XYt1=NG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D7ECDE44
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F742085B
	for <linux-pci@archiver.kernel.org>; Fri, 26 Oct 2018 20:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F742085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJ0FhP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Oct 2018 01:37:15 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45284 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeJ0FhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Oct 2018 01:37:15 -0400
Received: by mail-oi1-f195.google.com with SMTP id e14-v6so2177669oie.12;
        Fri, 26 Oct 2018 13:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TdNNn7vkdTVr8zMRWL/VmBsZ84jriFw88GqtMts3wU=;
        b=KtlsUlJ7H4UfkI3jjueNRTSLwJGLCGOhVEMnw1Fzk+m7kO/frEZjfkl85fGxxXiZMJ
         PrBZMbxUwUvhne96iLvsKcGe+mo3x9bWbyZaPxANIdNIjTz/vZksOvH6nfr2Zqgjrsct
         KByTi6kE8TR/BsQ5n1PCylG/EfGAGffsmZx9eMyM50GZfTklB2EI8QO1yEOUtKSr+tXm
         XbTveLvuLpvAQ28FYrLUoCJC725NtWpGmOqpVltTuBq2yawk3tu70ycv5235Oo+qpbIu
         rO2OA4soarVx01YOsvJ7dJW9tGHP7GETbuEZGlmBKcVaQZU8s0aI5XBvgZrwM6rwH5fO
         3moQ==
X-Gm-Message-State: AGRZ1gIUiiak9G4KQjka0Q84ymm1Bhr4m07yTVFl7W2UL7NqD5Jk7U0z
        Q/53uJoAcSK+UFI/TU6bTYS9ESrYCMI=
X-Google-Smtp-Source: AJdET5dP5AtuyWMp4NnGki5NOLDOduTbVReLZwBiIMrDXVISK1cNEsKE5MP0pOI0L+6w/dlsdl3CVQ==
X-Received: by 2002:aca:f0e:: with SMTP id 14-v6mr3202978oip.202.1540587522129;
        Fri, 26 Oct 2018 13:58:42 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id w76-v6sm4081872oie.29.2018.10.26.13.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 13:58:41 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id x4so2338862otg.3;
        Fri, 26 Oct 2018 13:58:41 -0700 (PDT)
X-Received: by 2002:a9d:2817:: with SMTP id m23mr3285915otb.168.1540587520920;
 Fri, 26 Oct 2018 13:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181025094929.29481-1-Zhiqiang.Hou@nxp.com> <20181025094929.29481-4-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20181025094929.29481-4-Zhiqiang.Hou@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 26 Oct 2018 15:58:29 -0500
X-Gmail-Original-Message-ID: <CADRPPNQRofR6Upe6_pTNm-bqt0HMVWBOXyYSH8xGvD2g7_nwCA@mail.gmail.com>
Message-ID: <CADRPPNQRofR6Upe6_pTNm-bqt0HMVWBOXyYSH8xGvD2g7_nwCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] dts/arm/ls1021a: Clean PCIe controller compatible strings
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

On Thu, Oct 25, 2018 at 4:52 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:

The correct prefix for arm dts patches should be: "ARM: dts: ls1021a:
...", and it should be better to mention the string removed in the
title too.

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
>  arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index bdd6e66a79ad..1aaa3288a450 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -716,7 +716,7 @@
>                 };
>
>                 pcie@3400000 {
> -                       compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1021a-pcie";
>                         reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
>                                0x40 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> @@ -739,7 +739,7 @@
>                 };
>
>                 pcie@3500000 {
> -                       compatible = "fsl,ls1021a-pcie", "snps,dw-pcie";
> +                       compatible = "fsl,ls1021a-pcie";
>                         reg = <0x00 0x03500000 0x0 0x00010000   /* controller registers */
>                                0x48 0x00000000 0x0 0x00002000>; /* configuration space */
>                         reg-names = "regs", "config";
> --
> 2.17.1
>
