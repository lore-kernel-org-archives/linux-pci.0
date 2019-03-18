Return-Path: <SRS0=G860=RV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45786C4360F
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207F520811
	for <linux-pci@archiver.kernel.org>; Mon, 18 Mar 2019 08:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCRITP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:19:15 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41939 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfCRITP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Mar 2019 04:19:15 -0400
Received: by mail-vs1-f68.google.com with SMTP id z25so7607302vsk.8;
        Mon, 18 Mar 2019 01:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuoiFj8Beu8UvhC6V1qbCHl0K2yHsBl4TuxKWVXjmJ8=;
        b=ExJJFKhxlJwOksL1Fss739JMJv3UIBYe2y1iAvP4s6dbVLEo6wcEE6duvCMxQlK2Ns
         ewaNJyGWT5GmTY8t+64YGtyJwmwROIH1lKTtrwh1WT9v8HQmMeu2NY4ovWSAy3DNRCDS
         xhPs/t6fz6HJ2JKVy/Nz5K852DxkswRuU2h1W/9/DQ8iL1uCkMvEtZg23k86d2hxx4/W
         ifxH0fMj0y0tulSi6SroKmDya7os2834ziK2mGkZ5kWyZDN1Ec7RVP0ScTQoXPp8QzLU
         /cdhQANx6Sujoca3qYy3m3JaeSiIR9bgepQDR7G/XgZh63ufWYfWCjP3fSuXb59z/SMD
         OVrw==
X-Gm-Message-State: APjAAAWXfTaexV76ADFJm9qF7IJXcw2NKG3yzG9iX3vl+6gyQ6Odd8AJ
        Vt0EVSW32lZLpft9CAjKc+evJJm70GoBnoqJi2cqrK2E
X-Google-Smtp-Source: APXvYqwQybXkHntYdEvgk0D8IvvhZhQIAQcJfpt4gQBEN0RjRhmF3jSEvShIHBMcqPYWg+V64p+R93/MYsYoOYTeQMk=
X-Received: by 2002:a67:8588:: with SMTP id h130mr8139526vsd.11.1552897154301;
 Mon, 18 Mar 2019 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190309005613.1493-1-marek.vasut@gmail.com> <20190309005613.1493-2-marek.vasut@gmail.com>
 <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com>
 <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com> <CAMuHMdXWKWtzmm=MiSxmBk-C0Y2QSGVQNNYstJidSOp637f3+g@mail.gmail.com>
 <e3dc95ed-c331-2b92-8e3f-8e69937c8d66@gmail.com>
In-Reply-To: <e3dc95ed-c331-2b92-8e3f-8e69937c8d66@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Mar 2019 09:19:02 +0100
Message-ID: <CAMuHMdWCY-QjnrG83MezY0Qq=h1nMqayYKantssSBxJrHJrAaw@mail.gmail.com>
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

On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 3/17/19 11:22 AM, Geert Uytterhoeven wrote:
> > On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
> >>> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
> >>>> --- a/drivers/pci/controller/pcie-rcar.c
> >>>> +++ b/drivers/pci/controller/pcie-rcar.c
> >>>> @@ -152,14 +152,12 @@ struct rcar_pcie {
> >>>>         struct                  rcar_msi msi;
> >>>>  };
> >>>>
> >>>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> >>>> -                              unsigned long reg)
> >>>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
> >>>
> >>> Doesn't unsigned int make more sense for reg?
> >>
> >> Isn't u32 more explicit ?
> >
> > It's just an offset in the register block, with a range much smaller than u32.
>
> We could use u16 ?

u16 may be more expensive on some processor architectures
(MIPS comes too mind, don't know about ARM).

> However, Bjorn's concern was that using unsigned long
> for registers was not recommended ;

Wasn't that comment meant for the size of the register values?

> how's unsigned int better ?

Basic rule "If you don't care about the size, use (unsigned) int"?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
