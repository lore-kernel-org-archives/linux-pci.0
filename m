Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66404C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DECC222B1
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 13:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axoP+5s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfBMNYP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:24:15 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39054 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfBMNYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 08:24:15 -0500
Received: by mail-ed1-f44.google.com with SMTP id b14so1908824edt.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Feb 2019 05:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ss85CM4K/Nn+klRfDs2ht8nxtzIxkQr99X+lrOd7gOs=;
        b=axoP+5s6JuneGo0LNdCU1u8Rjzl50EkLQwUnPHtInnFyKX3QYEwEMguUi8ooH/nRgS
         eV5Iw4VCjhRQuiTYnT0Nfnr6fmoTDrWnzx4b6kaR0QHVJhNhlKq59QCZUNpXVniVYq4q
         v5cRibH5rwgAfQnLapaQJgiStJtziIw5s/TW3ImRMdA1xANfH2RsKOH14ZJ3BWHHDKgW
         T0sKr1LjRLKj+71C3CkMdt0QHI5TtA2zpz2XBCJ0H85kkoJ3LyHe9bgBaYd9GKm5enA7
         zgAQNFf4jeqXF4RhTKJ0bVJcITW5b0MEqgzRniYX/OpiLP8aoWPqrPAUYiGBZ1hsHwqZ
         4JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ss85CM4K/Nn+klRfDs2ht8nxtzIxkQr99X+lrOd7gOs=;
        b=t9L4gzGb8XU92PPrGEvBQvS88ltesl/NxC9zc0sEKpeXiF/0GCy+BCAApHu92F2X+L
         eJCenUe8NtODodR2vsvsjiLk0Y9SmAbqmqxFBvPSKtaZasXk5Sx/bwser49sQfGXeMr7
         jDyYo5gfZZ+iJNaVSqvPzizlDa50XIGZ/2ZA5evsLCycg33m2Xn+aipKL/yy9PhdXZEj
         W/PHk48dLFFju+n6oRp+AOUWGn0XsWRutf3piylaGMoT/qwfH+JZ2/t+JyYVBvwBFq6M
         2G3IaR2fkRvCkTvG2LBFxH41ym5itzN1ynEKsvw174HkyMzEa8f8SzPgJidTA+2yijr0
         31rA==
X-Gm-Message-State: AHQUAuYztHcJdmo51fNQkuUv6iDY7pGM0DKBgjvnfPLWPDPfZydQTyX/
        TiL+vme7+ZR5VMIFizOrh47JHNNa7iQ4gb440prllQ==
X-Google-Smtp-Source: AHgI3IYVTWNBH4QbZnm32egO4fO165eiCBHNwYFPrQCDtrtHYr0WGoCL5ReTqRIRW3PmLejLcx8JUhyg1/AqOZc1HI0=
X-Received: by 2002:a17:906:2296:: with SMTP id p22mr382877eja.92.1550064253189;
 Wed, 13 Feb 2019 05:24:13 -0800 (PST)
MIME-Version: 1.0
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
 <20181218144702.752d97cd@windsurf> <20181218153404.45b038cf@windsurf>
 <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
 <20181218213716.70d27f1f@windsurf> <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
 <20190108114817.2bb15d5e@windsurf> <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
 <20190109091520.23641675@windsurf> <CAEzXK1oHqOb3pojfX7JqrirxjOFj=UZZfi6tNNO4y6yC3u9LAA@mail.gmail.com>
 <CAEzXK1r_Xf=-JSzrP8+0pgeqE+RE0Vx0JAKM0PW7qzc4fgQLNg@mail.gmail.com>
 <20190212144156.655f6824@windsurf> <CAEzXK1prnOXSkOEtTqXaR05pND=OMr2qiFHfqvnbUh+qyMyY-A@mail.gmail.com>
 <20190213133348.607ebec9@windsurf>
In-Reply-To: <20190213133348.607ebec9@windsurf>
From:   =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date:   Wed, 13 Feb 2019 13:24:01 +0000
Message-ID: <CAEzXK1pE+RQYX3KR246XGwNf6wYH-taWDxQazkMQ06Mz0gZ26Q@mail.gmail.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated bridge
 config space
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, great!! Thank you too, for sorting this out.

On Wed, Feb 13, 2019 at 12:33 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
>
> Hello Luis,
>
> On Wed, 13 Feb 2019 11:34:36 +0000
> Lu=C3=ADs Mendes <luis.p.mendes@gmail.com> wrote:
>
> > The kernel with pci-mvebu-fix you provided is working nicely with the
> > AMD graphics card, and other PCI cards that I've tested including an
> > Intel I350.
> >
> > If you want you can add a:
> > Tested-by: Luis Mendes <luis.p.mendes@gmail.com>
>
> Thanks a lot, glad to hear that it fixes the problem. I will submit
> those patches, and see what the feedback is.
>
> Thanks!
>
> Thomas
> --
> Thomas Petazzoni, CTO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
