Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D4C10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4033720879
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfCYION (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:14:13 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35089 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbfCYION (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:14:13 -0400
Received: by mail-vs1-f66.google.com with SMTP id e1so4853867vsp.2;
        Mon, 25 Mar 2019 01:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5zqcd0Im10pWvz52VTtyD3jJpSVuSEo8x/E7QlBOXTo=;
        b=QTRplgXVO4irr3CUTfYRJjvAS0r0olMcKGsMSzEJHzW9LCVYkLPAAAMDbxDDhdjgBk
         Su5cCu5y2DDShoNeR4CY4IWs/LHYNrvYl4AfFWUqGhHhooGsAjF4hdnIkPQI9LELJJ0q
         dWiefnGvoE1fysctHyUgu6tVHWUvo8z0rtvd9ijoR//FwGOA0i4OldFt24v2HmTXdjiJ
         oy/Xrb2apVteBul8PxjUJdBgXnFRuyIlL0fDgJloKOMyhxIbyMMmh/08TvAfZEJmAdZO
         UsSX8tDoaiiSx5eCVonmhmZCQN3N4fbF7Mk7TlzO5vFU/KHV15qPQpCQ+7zaHKrQNSeP
         92RA==
X-Gm-Message-State: APjAAAX7zaeEBufek0USNdirulVyZVb00JRiwu+G4pt1KVwkYswD5iKV
        CdHmPtkwkWLyJzjZ/uMKfSVhZEf0c3agO1vDbes=
X-Google-Smtp-Source: APXvYqz5m5jaqesix16W4MHeAoiP4kHyV4w6/PmivMHGA06sg/v3RmqYL7ypo33QklTifXXBzmGGpKQhCMOI+NOzW8c=
X-Received: by 2002:a67:8588:: with SMTP id h130mr13365623vsd.11.1553501652362;
 Mon, 25 Mar 2019 01:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190323015359.7231-1-marek.vasut@gmail.com> <20190323015359.7231-3-marek.vasut@gmail.com>
In-Reply-To: <20190323015359.7231-3-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:14:00 +0100
Message-ID: <CAMuHMdWUv4-T4n_7Cft83-HEUEz4oSFmeAP5k50=41vemmxsAg@mail.gmail.com>
Subject: Re: [PATCH V3 3/6] PCI: rcar: Replace various variable types with
 unsigned ones for register values
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

On Sat, Mar 23, 2019 at 2:54 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace various variable types with u32 or unsigned int type for
> variables holding register values, since the registers are 32bit.
> Note that rcar_pcie_msi_irq() still uses various variable types
> because both find_first_bit() and __fls() require various variable
> types as an argument.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c

> @@ -190,7 +190,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>                 unsigned char access_type, struct pci_bus *bus,
>                 unsigned int devfn, int where, u32 *data)
>  {
> -       int dev, func, reg, index;
> +       unsigned int dev, func, index;
> +       u32 reg;

"reg" is not a register value, but an (unsigned) register offset, so IMHO
"unsigned int" is the right type.

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
