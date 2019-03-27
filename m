Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C67BC10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0813B21734
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 12:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC0MWT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 08:22:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43813 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0MWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 08:22:19 -0400
Received: by mail-vs1-f65.google.com with SMTP id i207so9736735vsd.10;
        Wed, 27 Mar 2019 05:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGrNea8lqZcnie44+KuMcw930p3XxUZwDotVRxbGavE=;
        b=UpmJcQu2xneByxfS+k/sFGDTBtqwHjBEge0TLcXVFmmbA+4MVPB1lcbVfXE4nVSQqS
         gZE6OhfN8Ig1ajyGS0fPptx8mO3S4h3E+TmUVjqHRZFrQcrV4oqBxz+K9WaN/9SDfIfo
         564Na8T03+TlHeQI6KtO4JVV/YN/T5iJA8y5XQCbVtCiYrFgCGGRbM3v/COGdQk5B4iY
         I043twsrTzfCGr+vWsnpH41qDac/M+pRtK1oFRohl8/1cljdDeNPvfRoBnxsEDXOM5bB
         CdnkKra77okb8CGANcKBTxiqrSDcFrzPg+Vyh4qbIDLeD5boIhZ430WVbwj+dP3Actok
         tSzQ==
X-Gm-Message-State: APjAAAU/J4nRJ4eiELuF5tLNJY/ANBf6sKj5OANYmLEc4oAaWDNTTHN1
        OCgB5Zhc/+ciyPE+EAxg9NYmgWphPAu/YMWFjHA=
X-Google-Smtp-Source: APXvYqxW/qFQkhMbO6V8P8LqHQaZR7FyclyAPTV3eJwc22Y2D7153JyMf85sdXuwnx2/HXliYj7UZNFtVAZkvUGdydk=
X-Received: by 2002:a05:6102:199:: with SMTP id r25mr687288vsq.166.1553689337935;
 Wed, 27 Mar 2019 05:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190325114101.10198-1-marek.vasut@gmail.com> <20190325114101.10198-6-marek.vasut@gmail.com>
 <20190327113023.zhnx5v5spcx7uoqj@verge.net.au>
In-Reply-To: <20190327113023.zhnx5v5spcx7uoqj@verge.net.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Mar 2019 13:22:05 +0100
Message-ID: <CAMuHMdW_6hutek-vk+mwDHJ1kBUytLvtkgLKb2mkSEFFasJ_0g@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
To:     Simon Horman <horms@verge.net.au>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 27, 2019 at 12:30 PM Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 25, 2019 at 12:41:01PM +0100, marek.vasut@gmail.com wrote:
> > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > The MSI message address in the RC address space can be 64 bit. The
> > R-Car PCIe RC supports such a 64bit MSI message address as well.
> > The code currently uses virt_to_phys(__get_free_pages()) to obtain
> > a reserved page for the MSI message address, and the return value
> > of which can be a 64 bit physical address on 64 bit system.
> >
> > However, the driver only programs PCIEMSIALR register with the bottom
> > 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> > not program the top 32 bits into PCIEMSIAUR, but rather programs the
> > PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> > SoCs, however may fail on new 64 bit R-Car SoCs.
> >
> > Since from a PCIe controller perspective, an inbound MSI is a memory
> > write to a special address (in case of this controller, defined by
> > the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> > never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> > driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> > in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> > cause memory corruption or other issues.
> >
> > There is however the possibility that if virt_to_phys(__get_free_pages())
> > returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> > to 0x0 _and_ if the system had physical RAM at the address matching the
> > value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> > physical address matching the value of PCIEMSIALR and a remote write to
> > such a buffer by a PCIe card would trigger a spurious MSI.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > To: linux-pci@vger.kernel.org
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Does this warrant a Fixes tag?

(digging in old sent email)
Fixes: 290c1fb358605402 ("PCI: rcar: Add MSI support for PCIe")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
