Return-Path: <SRS0=lgj/=OY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0117DC43387
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B3220656
	for <linux-pci@archiver.kernel.org>; Sat, 15 Dec 2018 05:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1iTC/pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbeLOFXC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:23:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33557 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbeLOFXB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Dec 2018 00:23:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so7332018wrr.0;
        Fri, 14 Dec 2018 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KyWspEE7w1VDTUfQwdSqFJ0hR2sxKZBxKf+M5Sb4W1Y=;
        b=E1iTC/pWWL9NFG/+C9veT6qo/owl1NsXU5dWZJSG/P3mFupDnz6yJE12IMhNiaeh2V
         6GnuiVUGBZx4g7e91iqQaHmK1ciDutVVoaRjP1SyYxdntaY8hNS6GaBxZwCYvs2DTgrj
         WFA5gSZPteJPBFL+xI3cD9cxP4s//0BN6u34Xym/KqFiSaVY8QeFr60juCGBxx20NfWc
         +0ivfy5UfRaTTBohiooe+6Kvs81NCt8jBmWdgfHT8bMC746LPf4GWYtodiGY7Xg9MBzQ
         j4ApBjSb18qcRUNexPanqz0FZ5OmFdS6qkXxuY523y2BfJ81CLlRrMSBCwVmJDNRpt9w
         5EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyWspEE7w1VDTUfQwdSqFJ0hR2sxKZBxKf+M5Sb4W1Y=;
        b=Gx/BmKPdVohLQq2VplGMa3yxetx/PWns4+lSHiy5waIb7wWLDG70nphytuHqKwMvMM
         fajAEpqG/BqX+3KKGdL6wxdIGUFXEK1SPeTcUyv+Qwn6ggHUQNZedggoDtc8MItNTsmZ
         s9RSmQoHO8uXDSOUh/9WDrn73A5yvvYrZ8wXG+PkUZSgYS21FwCLdeRyxhPuszImc6w8
         SPCMTlkVhaHq1KQJ/mpMy6OVQ08wtje1UTKIZGmPXBZj/nYpMAuuUF2UvDkS35kv/jCO
         sB6xVU54i8UrEMcC4yGZH8NeONThrAskZBO1N2zLCPR3IIvGopc6tgkehxBtJ553b6Ej
         vpvw==
X-Gm-Message-State: AA+aEWb6tKVeTsGRnfVsGAYzKNtWrq11W6LTTbIVfYwW4eabTqU5MEW9
        jQk7MHx0lK9JljeWbWhZ1j6YoDBEQg51ogZAqPxFss5B
X-Google-Smtp-Source: AFSGD/VRSQTo5WD9+hAPfM0qo2Hf/qVPtfMiRICt0flGweyq+C0dv7LDbTJzYYMUsxsH+Iwn/+ORMq94hyroeDmjX1A=
X-Received: by 2002:adf:93e2:: with SMTP id 89mr4694110wrp.129.1544851378092;
 Fri, 14 Dec 2018 21:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20181206073545.10967-1-andrew.smirnov@gmail.com>
 <20181206073545.10967-4-andrew.smirnov@gmail.com> <20181214203042.GC20725@google.com>
In-Reply-To: <20181214203042.GC20725@google.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 14 Dec 2018 21:22:46 -0800
Message-ID: <CAHQ1cqFFm_YJne91yKVHWhMZY0KhpDfN0mbWL3YECnMo14JH4A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: imx: Add support for i.MX8MQ
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, gustavo@embeddedor.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 14, 2018 at 12:30 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Gustavo for fallthrough annotation]
>
> On Wed, Dec 05, 2018 at 11:35:45PM -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
>
> > @@ -245,7 +253,8 @@ static void imx6_pcie_reset_phy(struct imx6_pcie *imx6_pcie)
> >  {
> >       u32 tmp;
> >
> > -     if (imx6_pcie->variant == IMX7D)
> > +     if (imx6_pcie->variant == IMX7D ||
> > +         imx6_pcie->variant == IMX8MQ)
>
> This style looks like a maintenance problem: the code below is probably
> IMX6-specific, and you should test for *that* instead of adding to this
> list of things that are *not* IMX6, because that list is likely to
> continue growing.  There are more occurrences below.
>

Makes sense, I'll update that patches and send a v3 out.

> > @@ -301,6 +312,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >
> >       switch (imx6_pcie->variant) {
> >       case IMX7D:
> > +     case IMX8MQ: /* FALLTHROUGH */
> >               reset_control_assert(imx6_pcie->pciephy_reset);
> >               reset_control_assert(imx6_pcie->apps_reset);
> >               break;
>
> I'm not an expert on fallthrough annotation (Gustavo, cc'd, is), but
> this looks wrong.  It's the IMX7D case that falls through, not the
> IMX8MQ case.
>
> The recent annotations added by Gustavo are at the point where the
> "break" would normally be, e.g.,
>
>   case IMX7D:
>     /* fall through */                    <--- annotation
>   case IMX8MQ:
>     <code>
>     break;
>
> But in this case there's actually no IMX7D-specific *code* there, so I
> suspect the annotation is unnecessary.  It's obvious that IMX7D and
> IMX8MQ are handled the same, so there's really no opportunity for the
> "forgotten break" mistake -Wimplicit-fallthrough is trying to find.
>
> If we *do* want this annotation, we should spell it the same as
> Gustavo has been, i.e., "fall through".
>
> Again, more occurrences below.

Yes, definitely, same mistake of mine was already caught elsewhere in
the tree https://lore.kernel.org/lkml/20181214144406.0dbffbc8@canb.auug.org.au/

I'll fix it in v3.

Thanks,
Andrey Smirnov
