Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD2C43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931202184D
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 19:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbfC2TdC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:33:02 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39654 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfC2TdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 15:33:02 -0400
Received: by mail-vs1-f65.google.com with SMTP id g127so1977613vsd.6;
        Fri, 29 Mar 2019 12:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWLmwvZAAxLsT9+jFtv+e7DR810spvONxYuvHA6hllQ=;
        b=Z3LJMPBkSDkVC4uQ9GGXD5zjKHKwq5K4fHFHPtEWvbpukPFMvGx+DiNfd38uhtUC65
         0P3UgXuV6vFuoyNfB6rupXuxUtOUX7HKMP5dotu8rVO2T3DgNURaLYAyoQ6CYQB1mle6
         bmDVHxiGgirIGQaptheTZZJ9TsKX9lJDtHBhWWfICtGUvUdVY1z4bLxwGGs+Cy3sSCiZ
         DxpqIGwyoGysbPHvIZ0hajcEm90YeOkMmK8ODLlBCcmbV2zjFgLV4c6Ri1+2unnEJXSg
         zTA5c8a6tzB9FNTmU/pH1sOkLf6nNRdqLlykMkSpneN6uCcJ802/j6NCXGfHUW68NONq
         2Wgw==
X-Gm-Message-State: APjAAAWg62Xpm5EgKunZufXRn5x9ME0+KYZZppibNu4BhzUcjXRbXAJM
        tIc6nXkf8GtaqU0KMjTvAdlA9xyLrAwWbumbtcM=
X-Google-Smtp-Source: APXvYqynfsD+TSNzWJkdHPAz4MFxkuOSAX8G0soSsMAA4Kikb8bS1hQaRCySMpmzv28wZMimM08r9bEGWSYttJ0k2nQ=
X-Received: by 2002:a67:ba03:: with SMTP id l3mr22915700vsn.96.1553887981148;
 Fri, 29 Mar 2019 12:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190325114101.10198-1-marek.vasut@gmail.com> <20190325114101.10198-6-marek.vasut@gmail.com>
In-Reply-To: <20190325114101.10198-6-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Mar 2019 20:32:49 +0100
Message-ID: <CAMuHMdUEDR+oTAXeE+rjzHw5HzsjB_SerJZP4b8uDtfxTht-ew@mail.gmail.com>
Subject: Re: [PATCH V4 6/6] PCI: rcar: Fix 64bit MSI message address handling
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

Hi Marek,

On Mon, Mar 25, 2019 at 12:41 PM <marek.vasut@gmail.com> wrote:
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
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: - s/it's/its/ in commit message
>     - Add R-B from Geert
> V3: - Reworded commit message and thus dropped Geerts R-B
> V4: - Add Geert's R-B again
> ---
>  drivers/pci/controller/pcie-rcar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index c6013f95bdb2..62d2de9fbf1c 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -890,7 +890,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  {
>         struct device *dev = pcie->dev;
>         struct rcar_msi *msi = &pcie->msi;
> -       unsigned long base;
> +       phys_addr_t base;
>         int err, i;
>
>         mutex_init(&msi->lock);
> @@ -932,7 +932,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>         base = virt_to_phys((void *)msi->pages);
>
>         rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
> -       rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
> +       rcar_pci_write_reg(pcie, base >> 32, PCIEMSIAUR);

As reported by 0day, this causes a warning on arm32 without LPAE:

    drivers/pci/controller/pcie-rcar.c:935:32: warning: right shift
count >= width of type

Using upper_32_bits() instead of an explicit shift should fix that.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
