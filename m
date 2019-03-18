Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20CC43381
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAFA2083D
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCRJaZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:25 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33319 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfCRJaY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 05:30:24 -0400
Received: by mail-vs1-f65.google.com with SMTP id z6so9035108vsc.0;
        Mon, 18 Mar 2019 02:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rm6HunDBCexM9lkrAqlgwd9JUVztU8ygpQr9qORf+X4=;
        b=IvPQyMj3J0z7GGgn9NNNJKaFHOwEHmM/WFBq62gyEvZ32jop0FL4lS5yL90ZvkfW2b
         HqtsG5N9m7Bg8/b5J7/YTOgxeOgUWDntbXqg7VPEpzJpe+KnlQA0s3Pbk/68dOCtULFt
         KIzO/DYYaqgTtA5ps/GW46BfwhEcjrIiW3o5SDxEcsZilBXSZjNi3bG3BhFJpUPVpHxg
         nVeKclavz/xhzz/l2x5iSlXrOmpbN9eMyDjF+bFGGn7gHMJC3NHnRxCKJLzB+ZmDbarN
         qAnd3Dmh6WWDO3BEmsg+vQRm+oVWbjnieUFgUUyoiZsc4vyvjH57kW8z7WEZfyqeGH34
         Ydsw==
X-Gm-Message-State: APjAAAXUl/KM+8AJw6OZYSGkSTxI31GIZOUybUVJDsF7pqZsjl/O5NBm
        Ml2KZLlP9Pu9GXEvHr8Yo8ZikpGRhqCZgYZSU6I=
X-Google-Smtp-Source: APXvYqyJ2F2MHpeULHeWy1C0A2wvW7rnNspeqqaV0Rq9HHo6LKDn5zHgJnophUSVxMtJNNA0ZKAbRCmwM+38jyW7Xkg=
X-Received: by 2002:a67:f2d0:: with SMTP id a16mr7709289vsn.96.1552901421965;
 Mon, 18 Mar 2019 02:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190317000608.24881-1-marek.vasut@gmail.com> <20190317000608.24881-2-marek.vasut@gmail.com>
 <20190317091228.GB2268@kunai> <940fd646-0049-890a-ac00-8bc9361b2431@gmail.com>
 <CAMuHMdVXEqqRjkXR-9WPVVpNXu_C3Xg6yeZ0Nrhr1KbmHPuouw@mail.gmail.com>
In-Reply-To: <CAMuHMdVXEqqRjkXR-9WPVVpNXu_C3Xg6yeZ0Nrhr1KbmHPuouw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 10:30:10 +0100
Message-ID: <CAMuHMdWOL33eTMOWaHmxXpZoLmvMOtrcZN6Mi0REMbJvKwp+XQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: rcar: Allow 64bit MSI addresses
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Mon, Mar 18, 2019 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> > On 3/17/19 10:12 AM, Wolfram Sang wrote:
> > > On Sun, Mar 17, 2019 at 01:06:07AM +0100, marek.vasut@gmail.com wrote:
> > >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >>
> > >> The MSI address can be 64bit. Switch the data type used to hold the
> > >> result of virt_to_phys() to phys_addr_t to reflect it's properties
> > >> correctly and program the top 32bits of PA into PCIEMSIAUR.
> > >>
> > >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >
> > > Looks sane. Not being a PCI expert, I wonder: Were we just lucky to not
> > > hit a 64-bit MSI address before?
> >
> > I wonder about that, virt_to_phys(__get_free_pages(GFP_KERNEL, 0)) would
> > happily return 64bit address, but with the cards I tested (a few intel
> > NICs [igb, e1000e], PCIe NVME SSDs and xHCI HCD), I am getting the MSIs
> > either way.
>
> No doubt you would be receiving the MSIs, if you have RAM at the truncated
> address, but wouldn't that cause memory corruption?
>
> Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")
>
> When MSI support was added, only R-Car H1 and Gen2 were supported.
> H1 doesn't have LPAE. Gen2 has, but it might have been disabled.

Correction: as this is always mapped kernel memory, LPAE doesn't matter.
So the bug matters for arm64 only.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
