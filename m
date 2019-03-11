Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D447CC4360F
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7102075C
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCKJmE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:42:04 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39354 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfCKJmD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Mar 2019 05:42:03 -0400
Received: by mail-vs1-f66.google.com with SMTP id w14so2275940vso.6;
        Mon, 11 Mar 2019 02:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57gL7QIWBOjEMnDeiMi1khiiWRbmBvZUkq/P810Uygo=;
        b=RWr/Aqe7lYJG+hM3Ns48aNsN0MwND/1KBn4sStYCeYSoJ4xkboEiwoE4RUb5V8wpiX
         z+jRL9gbFyVrDTVDaWddRC6CFLbuq7bbYOfPNZoic0RRPxCoaiSfqQiWq8MxWlOtrwdJ
         ZQOPBHz/0qsjdtnHngeQiz+3u6uirE+Cu84NFsgYpWLnqsJFF6MGrWb7avjjEoBnx1zh
         Hk8DCT9ltnTGT9iHdAIpKbi69XTH8ZjK3hK6bIIsaEA5I27iCaPbc/f2biQrb65Qduce
         qNMfcgFOXh/C5sre9xc9nEeytDSzjQdJSFR+SKwZ9Z1nWJSvUhaq5MbgteIRkTmFBhhy
         wQcQ==
X-Gm-Message-State: APjAAAUhCZo7bZWNTFukizZY04VoZVscOdAkzLyKneV9Kk/vJEpRrNGa
        w7/vxeDr04dfnzW2rn3fovIFKyDpT3SP2Dfm9Dc=
X-Google-Smtp-Source: APXvYqz3odPDnMaAqUwgKEsuXF9q5oEMmdw00B2yhdRbxTFyjF/f74GcHeS9ONdgNRXghs1SQsGlerVYQrzxWbbHAxY=
X-Received: by 2002:a67:78ce:: with SMTP id t197mr16171138vsc.152.1552297322801;
 Mon, 11 Mar 2019 02:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190309005613.1493-1-marek.vasut@gmail.com> <20190309005613.1493-2-marek.vasut@gmail.com>
In-Reply-To: <20190309005613.1493-2-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Mar 2019 10:41:51 +0100
Message-ID: <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: rcar: Replace unsigned long with u32 in register accessors
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

On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> Replace unsigned long with u32 in register accessor functions,
> since they access 32bit registers.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Thanks for your patch!

Minor nit below.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

BTW, there are a few more suspicious/incorrect uses of unsigned long:
  - incorrect debug prints on arm64,
  - more unsigned long register values,
  - phys_addr_t
Care to fix these as well?

Thanks!

> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -152,14 +152,12 @@ struct rcar_pcie {
>         struct                  rcar_msi msi;
>  };
>
> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> -                              unsigned long reg)
> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)

Doesn't unsigned int make more sense for reg?

>  {
>         writel(val, pcie->base + reg);
>  }
>
> -static unsigned long rcar_pci_read_reg(struct rcar_pcie *pcie,
> -                                      unsigned long reg)
> +static u32 rcar_pci_read_reg(struct rcar_pcie *pcie, u32 reg)

Likewise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
