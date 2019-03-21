Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE61C10F00
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DD4218D3
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 07:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCUHbz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 03:31:55 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42611 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfCUHby (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 03:31:54 -0400
Received: by mail-vs1-f66.google.com with SMTP id f15so355223vsk.9;
        Thu, 21 Mar 2019 00:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+YChVJl4NjwguJjT50EdRi4vKVlR8vqZWdsjGrIfdc=;
        b=Xx2eK3CKA8vcrsrVIQOtvy0kVTN8W77NIX2Sggi6i/Pp9iKhVnud1agKbZElWk+GWC
         5jZmHJnVPq8xC1g5HBvO9dwm8yWRZK8ONdv30MUeBZlO2mvMxS2R+2eivRG4ceqcUYZd
         m0UtMmgfcj161xs90Tm13tUJ98NYRCgkIFRHr6XU6henOwBrqWEEVJBjuYDcQbyIYmw2
         M5rLcV7HYCPd8ooK3EIfcHaglA0i+bMxnWlYug7ROG2YQn8ylGxyDqMG7GD/Zsk8zLQ9
         soBQ+7/32I8dJdAHz5q7YJ3X85m8qQTcSILajxEy/6UmGymKtsutjgi5ul8+fmA0Hx2D
         xvmw==
X-Gm-Message-State: APjAAAWZfKv3JUqYLQW/cLilaVMU63c0nKLooPN1nJmQUeiT9HNWHrK3
        4r7BlZdFs2JehafqCrKHBXJIg9F1VZsq3I5kdkg=
X-Google-Smtp-Source: APXvYqxLazc9EzSefIBwppbkf9d0BlgC+g1ULVBGN/715ckGAmAvybktgSJpZCcuZdG/IycFSMJUZd9c43hyEvGtu8Y=
X-Received: by 2002:a67:f843:: with SMTP id b3mr1085126vsp.152.1553153513604;
 Thu, 21 Mar 2019 00:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190317000608.24881-1-marek.vasut@gmail.com> <CAMuHMdW5+aKVFdQYF-xiO3JyoyNYDwOTQqF8BJgku1b7ZzD1Mw@mail.gmail.com>
 <c7fa1a3c-f3cb-2c9c-3321-c8b53da609f2@gmail.com>
In-Reply-To: <c7fa1a3c-f3cb-2c9c-3321-c8b53da609f2@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Mar 2019 08:31:41 +0100
Message-ID: <CAMuHMdUYM=Yux+uoAuwGgKzzdvkr-3-JSHHWisZVPHiH=GqEiQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: rcar: Replace unsigned long with u32 for
 register values
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

On Thu, Mar 21, 2019 at 5:14 AM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 3/18/19 9:47 AM, Geert Uytterhoeven wrote:
> > On Sun, Mar 17, 2019 at 1:06 AM <marek.vasut@gmail.com> wrote:
> >> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> >>
> >> Replace unsigned long with u32 type for variables holding
> >> register values, since the registers are 32bit. Note that
> >> rcar_pcie_msi_irq() still uses unsigned long because both
> >> find_first_bit() and __fls() require unsigned long as an
> >> argument.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> >> Cc: Simon Horman <horms+renesas@verge.net.au>
> >> Cc: Wolfram Sang <wsa@the-dreams.de>
> >> Cc: linux-renesas-soc@vger.kernel.org
> >> To: linux-pci@vger.kernel.org
> >> ---
> >>  drivers/pci/controller/pcie-rcar.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> >> index 1408c8aa758b..857d88fd03d5 100644
> >> --- a/drivers/pci/controller/pcie-rcar.c
> >> +++ b/drivers/pci/controller/pcie-rcar.c
> >> @@ -169,7 +169,7 @@ enum {
> >>
> >>  static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
> >>  {
> >> -       int shift = 8 * (where & 3);
> >> +       u32 shift = 8 * (where & 3);
> >
> > shift is not a register value, so IMHO the original type is fine (the "int"
> > comes from the pci_ops API, BTW).
>
> I presume it should be at least unsigned ?

Yes, and "where" too.

Note that the other uses of "where" are also int, and IMHO should be
unsigned, too. But changing that means changing the PCI API and all
drivers, sigh...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
