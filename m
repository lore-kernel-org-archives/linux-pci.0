Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6976C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9029C2087F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbfCYIHw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:07:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36381 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729812AbfCYIHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:07:51 -0400
Received: by mail-vs1-f68.google.com with SMTP id n4so4850020vsm.3;
        Mon, 25 Mar 2019 01:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAZ6fU2HAwKyKgw0pGD9D1gUaWG4FPDiI8lCJ0obCbI=;
        b=hQdeFyivkSskaiQrj2id9Ys3Ji0axvKssVqzypFQGG/PGmiM9vRU49E+47kmKvE13s
         +MMwqCdCr+GsMmpTTcNlf/4j94PnE1AyZQ+DrugG2eRQC3howemAUeyvTctTz9xCnM0P
         rZ/Lx8qMMzPZihdJA8bd398Y1id+cCGlnwUFx/aWXMYrY1bl4jLV9jBDol7/jSXHvnp9
         J9PehQIMzt7LGGEU6yWXtIvLv3qlTzsRkb6DGeZFo1I/d5xVNMyk5t0eEERnBIRprakN
         Z/WXY8JttRZMD3bChqf3Nrl/SK3m+NX0D0n6HO/9qx6O3pPLQSVWHrWPhi3Ll1cAi+O7
         Vi1A==
X-Gm-Message-State: APjAAAVuuhPMutOYR1N8J5/5bBZUhft5eD2mAD1w8Vr6Py3JznXpUM7J
        MIfyS4520zEfR0sFUUhG1RZs1vwp/Kte7o5zcNM=
X-Google-Smtp-Source: APXvYqzcCVCfJzITqm2XRaQiujZvugyAldYbUtuT1ql9655rNA00xbRSMrn0C3QhaN3cInFsOpTa/zYPGc1uTjt1aEQ=
X-Received: by 2002:a67:f843:: with SMTP id b3mr14052842vsp.152.1553501269383;
 Mon, 25 Mar 2019 01:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015359.7231-1-marek.vasut@gmail.com> <20190323015359.7231-2-marek.vasut@gmail.com>
In-Reply-To: <20190323015359.7231-2-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:07:37 +0100
Message-ID: <CAMuHMdVad84pxwQHP4kQTUxabKbNyD9nURpYkoJnZrQULN1sbA@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] PCI: rcar: Replace unsigned long with u32 in
 register accessors
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace unsigned long with u32 in register accessor functions,
> since they access 32bit registers.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> V2: Bundle this patch with other cleanups before resending
> V3: Add Wolfram's R-B

Forgot mine?
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -152,14 +152,12 @@ struct rcar_pcie {
>         struct                  rcar_msi msi;
>  };
>
> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> -                              unsigned long reg)
> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)

reg is is not a register value, but a simple integer offset.

>  {
>         writel(val, pcie->base + reg);
>  }
>
> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
> -                                      unsigned long reg)
> +static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, u32 reg)

Likewise.

>  {
>         return readl(pcie->base + reg);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
