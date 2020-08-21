Return-Path: <SRS0=IRj4=B7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167AAC433E1
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3999207DA
	for <linux-pci@archiver.kernel.org>; Fri, 21 Aug 2020 12:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgHUMeS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:34:18 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43570 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHUMeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Aug 2020 08:34:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id l84so1349595oig.10;
        Fri, 21 Aug 2020 05:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxTjsiZqAIPxCuWcFqzoDaPXHfxlScdVoNcCnJKLQBY=;
        b=GZasQvSvn6ALXxAWDx3Ppt4h0GjLaYouHY6h9gEQdKUHMq31FNRdv4FUcvaXi0OBii
         UT77beOIn0abAAeCqWDdKYuZosKwprk9Eptw8iXMhbyrKE+18/ph2EnkWoWDF9pzyDyV
         B2WHX4R7b+fMvg1dpm/Kk+JQb5dFuyuT6bbwMTdjqF0+Gm6bUH2IIzREgYSauf1iKjOi
         kZdJ0j7Eq0Z5vi1wnKhjJ186NDZoU/m6aGfkpb7a62sSpWze4vX9UGepRsTCyam2C+rJ
         9HUa6smUqMZ2Z2h/rLeB61ZM/yyYtXvLjmCkfBNn1LscosemworXIzcKg8TdYpnZvBOv
         zFFA==
X-Gm-Message-State: AOAM532W2SB0LPHJ17Nfb8oix5fBiI9emW3EKs11g/6rsMCf7fH0oZTa
        LW1o+FOQXoGyFtKQT3mvgwt+9/QFll1XQDtVTvE=
X-Google-Smtp-Source: ABdhPJw683FYSCiAUJJzNmFkddmHqHL+eESbIv91V5T0JnjnuMFo5KjhXD+qMXXY52Zo+VvJdhNUu4wltHj/AIe3XD4=
X-Received: by 2002:aca:4b54:: with SMTP id y81mr1580964oia.54.1598013256594;
 Fri, 21 Aug 2020 05:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200814173037.17822-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200814173037.17822-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 21 Aug 2020 14:34:05 +0200
Message-ID: <CAMuHMdXHmfxjx8unRojiNGug+AgSgMGCJr2zsa9qtD2nYJwt4Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: r8a774c0: Add PCIe EP node
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 14, 2020 at 7:34 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add PCIe EP node to R8A774C0 (RZ/G2E) SoC dtsi.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.10, with s/pcie_ep@/pcie-ep@/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
