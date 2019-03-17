Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5710C10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 10:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A7B21738
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 10:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfCQKWl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:22:41 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36965 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQKWl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 06:22:41 -0400
Received: by mail-ua1-f66.google.com with SMTP id x1so4441671uaj.4;
        Sun, 17 Mar 2019 03:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0kxPGZBbddEzABRS/V0Z7FT/r5/iWk3ZsOyNCE3KMI=;
        b=IH9GlgkpgGwNguEPAQnwIVyLaynvEGvdvj81qO5OKCtv0G+XL8w3pYsFPF1by6owSM
         e6JsRfTY2RKlH9oUA0je1TQB5CZoigQG7jLCo2HGVyuorTgiSkdXtIR9mhtwFvouyqVt
         1ZL4BOe/lYKJZwklrwltau/W+eIWP7WzumTPAg0/Bs53zmIh8dhJEEcCT+2RABBICVkQ
         epLZEtpmGVKnWnEG7rSF0ta8t1neYQO7Id4pGdvdqiUUNQzECHX8MPQiI3Aj3MvaGtFH
         /u5wbH6kXtOxHcUoszJfDOQni8fGO9S9FIAwRKe7jzZqyb6JZxNZQdEY0zNtTkTISMf7
         Wz5g==
X-Gm-Message-State: APjAAAVNe9skKYQRxY+HkfjDCJ6GnZHgzgPo8mTe2kpElPGwE4UA+NJg
        fQaRni3u8JsozftaA82o/5g/UfTA1pR+9akUiuk=
X-Google-Smtp-Source: APXvYqyhMOjBpcm1U+uxvn5jwMMiNjQkWXD0SEeDtQRDAxQc7whtwy4PS5i2JPflsY4Je/gCQr6ILZrP7Ke0UBKhL/Y=
X-Received: by 2002:a9f:2d85:: with SMTP id v5mr3924300uaj.18.1552818160462;
 Sun, 17 Mar 2019 03:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190309005613.1493-1-marek.vasut@gmail.com> <20190309005613.1493-2-marek.vasut@gmail.com>
 <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com> <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com>
In-Reply-To: <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 17 Mar 2019 11:22:28 +0100
Message-ID: <CAMuHMdXWKWtzmm=MiSxmBk-C0Y2QSGVQNNYstJidSOp637f3+g@mail.gmail.com>
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

On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
> > On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
> >> --- a/drivers/pci/controller/pcie-rcar.c
> >> +++ b/drivers/pci/controller/pcie-rcar.c
> >> @@ -152,14 +152,12 @@ struct rcar_pcie {
> >>         struct                  rcar_msi msi;
> >>  };
> >>
> >> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> >> -                              unsigned long reg)
> >> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
> >
> > Doesn't unsigned int make more sense for reg?
>
> Isn't u32 more explicit ?

It's just an offset in the register block, with a range much smaller than u32.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
