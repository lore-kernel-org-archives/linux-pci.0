Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2290C10F00
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A7D20811
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfCRIfP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:35:15 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34728 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfCRIfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 04:35:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id e126so8724000vse.1;
        Mon, 18 Mar 2019 01:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVW2mzH66d9GyL2X4c6q4UhwwkR6cfrkULtHSUb+xbs=;
        b=FsX8Ret0+RN7s8R+x8XQiamkKzHlvAdYgLYgvN6QodL82DNyMRUm0r8qfFgIrvVxTH
         L2Y1KsssfavTUkDcobndU7voQ0IQKZDnCRV8XJZxOgKQ6Hkyy9M2jHQ7CE3H2vuu/ZeX
         NA6vWK4KN165fxTLGynE4SdbID8mSd+aa2jmv1S8kK/XI1NMnv905YuiwnTOzO17iR4t
         PJhTsN8bjhwO5Cl+RpBh/rC4Sxekt5xU47noOSaZOjuwHRQZxhUDXWF4LbJNTmndEl7x
         InlU4VF6nYDZcqwPYUMNAEV21J3n3xKI4/nbTS5G7uxgZE4GGxxOWM4opyY9SjN+RCv+
         Gz6g==
X-Gm-Message-State: APjAAAWfswahrnAVtUylz/wQP99L+mHyI38o2ztSLUKoJoflXKzWf7kA
        ww5hiLXV7S5/A0pqdbTGDuPvUMUwaVV2AX4Alsw=
X-Google-Smtp-Source: APXvYqyqhOnvbeBJeIHxc+AhS7ftRjRpxOmXsx4UDxwnxhmweKscG9TUrgzvoD72EPvBZ+rOYilVEbkNxPTsZJDi4bw=
X-Received: by 2002:a67:f2d0:: with SMTP id a16mr7633365vsn.96.1552898114304;
 Mon, 18 Mar 2019 01:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190317000608.24881-1-marek.vasut@gmail.com> <20190317000608.24881-2-marek.vasut@gmail.com>
In-Reply-To: <20190317000608.24881-2-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 09:35:02 +0100
Message-ID: <CAMuHMdV0fUV8De4QGq9Jjaepic06nVVby8p3W6DYr9X9MqM+Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The MSI address can be 64bit. Switch the data type used to hold the
> result of virt_to_phys() to phys_addr_t to reflect it's properties

Side note: probably this should use a proper DMA API instead of
get_free_pages()/virt_to_phys().

> correctly and program the top 32bits of PA into PCIEMSIAUR.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c

> @@ -930,7 +930,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>         base = virt_to_phys((void *)msi->pages);
>
>         rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
> -       rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
> +       rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);

Note that his register is now non-zero.
According to the documentation, clearing PCIEMSIALR.MSIFE should be
sufficient to disable MSI, and thus there's no need to zero PCIEMSIAUR
in rcar_pcie_teardown_msi().
So nothing to change there, good.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
