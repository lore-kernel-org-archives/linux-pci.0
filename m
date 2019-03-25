Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B8FC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9EB20830
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 08:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfCYIGu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:06:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44928 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbfCYIGu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 04:06:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so4816495vsd.11;
        Mon, 25 Mar 2019 01:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjLKWIUx3YeG1y9wQI8W7hbnwgjH04Ju49Fv/Pcahrg=;
        b=NoBP2HuZnbVuIqoHIcSFC/yjOOnNhbBZ+HC5DKZhTrIHv+5PMUQW31r1SVHfISt7t/
         9YRNBhLoJQP/venwEyqfGUKVKvU/VPuhJ5YYLGmNUx2NHSR5TQaKXmfWvWD6GMdQIQ8E
         JPSAjDCP/zyUSJxpeyu67KyUaR22ADkbyub/LbEXJ3f17Qx1HXNLYd7kKI5ufoFvWA4Z
         bWtgTDV0KbFQywvvteNs3gEINP5V7P9mUFJdIhJWay7TJ8SmlxhoSb+a2jZetSvwfpQj
         CwiL7+74u6ZySOGfeFd+72J8A0ghctXakc71DpyKIoMg/w2tHUyFaT74uedz4KrpLqci
         CYGA==
X-Gm-Message-State: APjAAAV04F0uzSwwm8EwqjuPMRavtJUCs8PScNNsg2Ibqr/JlFyAWAcs
        4ePORwrp97gQMwQd96lnqD27y3iTlyYHYhAU9hM=
X-Google-Smtp-Source: APXvYqxu7JlerF4iSMHh4ASOyo73wXvx5yM+CIWvSKw0SvmqQt0T99NECxtH+/VXh8ErpmfqpNwvpKZBBeIWcXQyFaY=
X-Received: by 2002:a67:8588:: with SMTP id h130mr13354010vsd.11.1553501208904;
 Mon, 25 Mar 2019 01:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190309005613.1493-1-marek.vasut@gmail.com> <20190309005613.1493-2-marek.vasut@gmail.com>
 <CAMuHMdXGn50+hAoPBmnatf+onXezhNUwDWv+izj3j_QVMMFNGw@mail.gmail.com>
 <d49be905-2e59-e65f-cf3b-191eb972ec45@gmail.com> <CAMuHMdXWKWtzmm=MiSxmBk-C0Y2QSGVQNNYstJidSOp637f3+g@mail.gmail.com>
 <e3dc95ed-c331-2b92-8e3f-8e69937c8d66@gmail.com> <CAMuHMdWCY-QjnrG83MezY0Qq=h1nMqayYKantssSBxJrHJrAaw@mail.gmail.com>
 <c715f6e2-e7bb-791b-4c85-e09cf1b7758c@gmail.com>
In-Reply-To: <c715f6e2-e7bb-791b-4c85-e09cf1b7758c@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 09:06:37 +0100
Message-ID: <CAMuHMdURsR3ReGejsMnToQu+xoXCdaoRWxFg1r8yAcmWvQAXOw@mail.gmail.com>
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

On Thu, Mar 21, 2019 at 4:20 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 3/18/19 9:19 AM, Geert Uytterhoeven wrote:
> > On Mon, Mar 18, 2019 at 12:39 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> >> On 3/17/19 11:22 AM, Geert Uytterhoeven wrote:
> >>> On Sun, Mar 17, 2019 at 1:06 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> >>>> On 3/11/19 10:41 AM, Geert Uytterhoeven wrote:
> >>>>> On Sat, Mar 9, 2019 at 1:56 AM <marek.vasut@gmail.com> wrote:
> >>>>>> --- a/drivers/pci/controller/pcie-rcar.c
> >>>>>> +++ b/drivers/pci/controller/pcie-rcar.c
> >>>>>> @@ -152,14 +152,12 @@ struct rcar_pcie {
> >>>>>>         struct                  rcar_msi msi;
> >>>>>>  };
> >>>>>>
> >>>>>> -static void rcar_pci_write_reg(struct rcar_pcie *pcie, unsigned long val,
> >>>>>> -                              unsigned long reg)
> >>>>>> +static void rcar_pci_write_reg(struct rcar_pcie *pcie, u32 val, u32 reg)
> >>>>>
> >>>>> Doesn't unsigned int make more sense for reg?
> >>>>
> >>>> Isn't u32 more explicit ?
> >>>
> >>> It's just an offset in the register block, with a range much smaller than u32.
> >>
> >> We could use u16 ?
> >
> > u16 may be more expensive on some processor architectures
> > (MIPS comes too mind, don't know about ARM).
>
> On armv8a, none.
>
> >> However, Bjorn's concern was that using unsigned long
> >> for registers was not recommended ;
> >
> > Wasn't that comment meant for the size of the register values?
> >
> >> how's unsigned int better ?
> >
> > Basic rule "If you don't care about the size, use (unsigned) int"?
>
> This only applies to the $shift variable, yes ? The rest are u32 since
> those contain actual values read/written into the registers.

There is no "shift" variable. "reg" is a register offset, not an actual register
value.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
