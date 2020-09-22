Return-Path: <SRS0=cLGU=C7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF4C4727D
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D755220739
	for <linux-pci@archiver.kernel.org>; Tue, 22 Sep 2020 08:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuVLgPgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIVIko (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Sep 2020 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgIVIko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 04:40:44 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCA3C061755;
        Tue, 22 Sep 2020 01:40:43 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 133so5031600ybg.11;
        Tue, 22 Sep 2020 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+OZiUP1vnnZHS8QHCk/3wxoJQlfFggJgv3Kp7po0iw=;
        b=NuVLgPgziheHwTfP5LjhFY4SesKJN6z12RILB1pN4/SeYDJzsHHvNKezR7ZYNY4dks
         R0rzGhN6Udmt//3tnPZXjgTsNr/c3ToPlEYCpNKg+XX1/tON4IljkX1fpQmsFLu4fysH
         ZjJ86XJRSYLhpVFJDKRk9CJOC4RjlB+fC4P1iwaz1sZk4aKze740Q52vngewtGl/oIyY
         Y45SYNMv6ibCl+2Vx1HERK0vRajzkUQ1kQpv9q64EgtEFcw7fBDhONQWuRZU8tl15Q5p
         dapvzfVuitIIPO3bUQ/+iHaSDz56C4mqO4AuLzfsHRSyNQkmm471kLn7Lwusf38OStzE
         yLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+OZiUP1vnnZHS8QHCk/3wxoJQlfFggJgv3Kp7po0iw=;
        b=V4Dsro4+lFjeFdaVIcURwTKwb9hB2isUYSy3tdcmi4AE+LepaLjwOIPiLYiPJx0frl
         cLk42+AFL+OWynJsD2xkkJKvGpSF0LR52PoL8/gxavMaMeDW7FJHv1OKPTiNMUUiKRTu
         QVNZNR/EHJI3bNbs7dlN+LRDaNNVneNwuFFjTRWtPY88D2/k0+ZOdlW9hCvITi5ELZp4
         taV710LI6Z9PTC4SL5c01MMqGw63ifPtf8bXlyvWRmOQN6YChWBFj66G8Ilicvd8r7CM
         /r85iG4sJqb9zW2AcHwqyBTcvn7VPgLrwoB+JOnDZQMPat791AyWxZzxTOMpbTqwGDNW
         2P0g==
X-Gm-Message-State: AOAM533MjfZ69pZZ+pN6Q0uCxIo8gH86xf/4wqkf+EPdBvQgRs+EAmOF
        1+7sgWi0bBw+rxk77DpxLIDZxKNBPmR+Z9fpY1k=
X-Google-Smtp-Source: ABdhPJz7tp5/sbJjNYhmIjZ7Es4Bbt3UXUUN5/fc2NbqpCJMyZa2zZxOrHHSujRQO3IVOmIzjvH6zmqGIz2tZe5DpxI=
X-Received: by 2002:a25:aba1:: with SMTP id v30mr5709473ybi.518.1600764043123;
 Tue, 22 Sep 2020 01:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594919915-5225-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vJ2n3KEL8P+XmVob2zjoWaX+s4a6c1TV_WoPFkwdkZmA@mail.gmail.com>
 <20200920140824.GA2915460@kroah.com> <CAMuHMdUyXMfZcVKkqaZHJ8tJf-3Kotqg+S2NHMZT0VFO0ZJJww@mail.gmail.com>
 <20200922083909.GA2092905@kroah.com>
In-Reply-To: <20200922083909.GA2092905@kroah.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 22 Sep 2020 09:40:16 +0100
Message-ID: <CA+V-a8u_0+XqyBiV6vxuc1d6_eDZdzO8dy3qBrmO1ke3L4BROQ@mail.gmail.com>
Subject: Re: [PATCH 07/20] dt-bindings: usb: renesas,usb3-peri: Document
 r8a774e1 support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas <niklas.soderlund@ragnatech.se>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 9:38 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 21, 2020 at 09:30:39AM +0200, Geert Uytterhoeven wrote:
> > Hi Greg,
> >
> > On Sun, Sep 20, 2020 at 4:08 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sat, Sep 19, 2020 at 11:50:07AM +0100, Lad, Prabhakar wrote:
> > > > On Thu, Jul 16, 2020 at 6:19 PM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > >
> > > > > Document RZ/G2H (R8A774E1) SoC bindings.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > Could you please pick this patch.
> > >
> > > Don't DT patches have to be acked by a DT maintainer first?
> >
> > https://lore.kernel.org/r/20200721033508.GA3504365@bogus
>
> Ah, missed that, sorry.  This, and patch 11/20, now queued up.
>
Thank you.

Cheers,
Prabhakar
