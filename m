Return-Path: <SRS0=NdPK=RR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DFBC10F06
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 07:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B942184C
	for <linux-pci@archiver.kernel.org>; Thu, 14 Mar 2019 07:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCNHaU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:30:20 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37517 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNHaU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2019 03:30:20 -0400
Received: by mail-vs1-f68.google.com with SMTP id y19so2637118vsc.4;
        Thu, 14 Mar 2019 00:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7L5fel6JCqFPZpkNzFwwfkIvlfvqIt2Q2h0Ef4ZsU6o=;
        b=RShXDCl6YG2Yb89640nvbwBgcI0ya535jI7aCG1hgfjxTABZzm+4xUFoQE/WMMJ3lS
         OIkEYW3MiKHtcDPBzEjbZdBB3oAhkv6qZvPRsVVZ03jPt5NJvaREXdEJhpAls1nqLSwK
         DXRJbUwQMSkaegUJ6bGsuH8hXPZZWo63Opx2aTbvIi5/OzU1hSwOa8cHH0rpp4IdUtar
         AtUugOmYo6xLegE7lM2FYv7CzQTQUE3lkXIqLyL/l+rHvLOIi1mHGlKOYb7GG+CvHEtH
         I//aTj5HT9dG+Lz8Nj26I0BOIJWXIPFqvKtQkY7HOatL1QoEBulgbSsa44G15+GCYUKk
         +1iA==
X-Gm-Message-State: APjAAAXS+pXTUE59T1Nmijn2rkqHenmk56ezYS2n92Uhjc3ELqp+BAZy
        A/kODYwxyfD3T3OwoiqYBq94ytIBSybaSpdYk40=
X-Google-Smtp-Source: APXvYqx2BI0bEIFAlhH43xRFJZUR4l7SKdhf4u6vWPmLW+ztXH6G8tJBPrOXPxyng/dAKoaPE2Lqem3tEsgJMNn1yUk=
X-Received: by 2002:a67:8588:: with SMTP id h130mr24141458vsd.11.1552548619064;
 Thu, 14 Mar 2019 00:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190314055608.5209-1-kjlu@umn.edu>
In-Reply-To: <20190314055608.5209-1-kjlu@umn.edu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 08:30:07 +0100
Message-ID: <CAMuHMdVJENz5wnOV=TX5cVdTsOZD25SwprSLpetZpAsMcPtvEA@mail.gmail.com>
Subject: Re: [PATCH] pci: pcie-rcar: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kangjie,

On Thu, Mar 14, 2019 at 6:56 AM Kangjie Lu <kjlu@umn.edu> wrote:
> In case __get_free_pages fails and returns NULL, the fix returns
> -ENOMEM and releases resources to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -929,6 +929,12 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>
>         /* setup MSI data target */
>         msi->pages = __get_free_pages(GFP_KERNEL, 0);
> +       if (!msi->pages) {
> +               dev_err(dev, "failed to get free pages\n");

Please drop the dev_err().
The memory allocation core will already have printed a warning, cfr.
warn_alloc() in mm/page_alloc.c.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +               err = -ENOMEM;
> +               goto err;
> +       }
> +

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
