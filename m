Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5832C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD2C2087E
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfCYI3A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:29:00 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39533 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfCYI24 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:28:56 -0400
Received: by mail-vk1-f193.google.com with SMTP id s80so739379vke.6;
        Mon, 25 Mar 2019 01:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mg3z0KXEvr+3nwuXiySw3cD478oF0fgiMrHpIV+Rmww=;
        b=qtT5c4sO2auj3JVw75MPrBPrlxNy0iPCJCwUweWDPzFq6NaqBXyyMpsFJtYv1FdDyg
         0PfXj4ozMHKBHXETkzjBj1DKXjKhXunO3Ok9z32DT+airD6VeAfr3Pv9r+uieZbjFAnd
         sC0N91RSLjhvoA+5xYHkwFhzuFK/NdLx2pSbohilkn0t6Pcg3JpjxpjHMNw++yj9mvAL
         f0bHEungzTNM6xI+FHsa8l5mdv46zVjNUbvL9kvRDi7w9uvrd0gCoz1xfqiHpF0AfEnL
         fEMmCunMq1ZnDBm1aEjyIurf6oO6JqzdK2KNWxZXLbyiDIG8oBi6BstdCar+Qdh5K1A6
         ZE8Q==
X-Gm-Message-State: APjAAAVZ6oFFBGfEVXn8zPv57uGNZXVhDOElozrVSsp4mmFnm6Kn4Ruj
        RdGL4zDkvby7gUOY/NkDh5zwHIY8HSyqRUhYn0o=
X-Google-Smtp-Source: APXvYqy3/Wv/pV5IE4CQ0qIYCBhUr8HpVwUTLFKzRouCEfQUnDRRivaaW8J8GPbOXFBgkuKUTXux0JnPViAEj0ADEy8=
X-Received: by 2002:a1f:a5d3:: with SMTP id o202mr13922492vke.40.1553502535453;
 Mon, 25 Mar 2019 01:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015359.7231-1-marek.vasut@gmail.com> <20190323015359.7231-6-marek.vasut@gmail.com>
In-Reply-To: <20190323015359.7231-6-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:28:43 +0100
Message-ID: <CAMuHMdU-AbWoG+ZyVt-cyGu8etSmejK1t8jGdgi6n1e+A0gwWQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] PCI: rcar: Fix 64bit MSI message address handling
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

On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> The MSI message address in the RC address space can be 64 bit. The
> R-Car PCIe RC supports such a 64bit MSI message address as well.
> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> a reserved page for the MSI message address, and the return value
> of which can be a 64 bit physical address on 64 bit system.
>
> However, the driver only programs PCIEMSIALR register with the bottom
> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> SoCs, however may fail on new 64 bit R-Car SoCs.
>
> Since from a PCIe controller perspective, an inbound MSI is a memory
> write to a special address (in case of this controller, defined by
> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> cause memory corruption or other issues.
>
> There is however the possibility that if virt_to_phys(__get_free_pages())
> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> to 0x0 _and_ if the system had physical RAM at the address matching the
> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> physical address matching the value of PCIEMSIALR and a remote write to
> such a buffer by a PCIe card would trigger a spurious MSI.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for the nice explanation!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
