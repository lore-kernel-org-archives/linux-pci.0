Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53888C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2538B20874
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhY8iEjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbeLQSDu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:03:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52563 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbeLQSDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 13:03:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so143166wml.2;
        Mon, 17 Dec 2018 10:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iKE+lrdN0BbU0LrEqoXbpQFtnEmptT9/m4IOJh64Kk=;
        b=UhY8iEjjcRJnz14DlYAmcIR5A6CDKJuEStszagzquRc+JQrkAvUMy6ZbpUwx1WJgE4
         q5ACnchqXh3DBdnilP6EvA4iHAogkKJ9xcLIsb41Ip1lzoEa1m6gRNwgtDMHXhdaemuZ
         ilRSaYp6GWr+bB8C1W1G7DktRL3tu3VAB3xNnYzNLV6N7Tid8sNX4VScdOoT9B7x3/HY
         vV2FsY2KzP+ikY92JijZWzsTR4qRwKYWvzhrWDYCVP+pedMaApu54QlgKPLYG1Alv7Lk
         2KxqdVlh+hptcrjXeVOJFx91nptm9Gl198MlsAELSLFPvPBPVPANEnqnhweBMBWv3CCj
         K6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iKE+lrdN0BbU0LrEqoXbpQFtnEmptT9/m4IOJh64Kk=;
        b=GH9fdmqtvET3ua0SBi2qFgjRYVGPEnS47Y8UFPrad5JdflPO2nCYDEp3/0Ckknlvi3
         QRGKsHtKs/vhcYXuWeuU8ywQ0XdauEW7hVGLtlp1NWcieEg5mq+ws1YMxLZTdevwF8YM
         Y9JjYOxK26V5k3Yq3x2aRK1oty0OeZkjBpurUrBPZ0UYOcEHPaPJEkbAYSo8rBVSBhAd
         4/55MKxvcDGTUW9SyApqNWaIkgF23V86ArQ3qNslODUQSbHjTPp7xKYRnKz43eQXn7U8
         K4tDpIvBJ6OgeDyGKenrdNRodn646AF0z6yC3yE3W0z8bdHzqjid5AI5RMdivdmx7Kjp
         XPpw==
X-Gm-Message-State: AA+aEWZy0nLRCbZp7d+4J8Arwcjb2rxs7LXpB7VJe7AvP24zHht4C8KM
        n3mOqKEOG8h0rowzoml63j3FcTweHlI9ukXBoAE=
X-Google-Smtp-Source: AFSGD/WC972fXIggXO9uTv5qdxGYibRZXFJUvhQaud5o/Jv6YiX3ZIg1rFnEv/SCIBd7Cta/P3ym0otTCVYrXGd5Zco=
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr101622wmf.127.1545069827299;
 Mon, 17 Dec 2018 10:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
 <20181216230916.22982-4-andrew.smirnov@gmail.com> <20181217135833.GJ20725@google.com>
In-Reply-To: <20181217135833.GJ20725@google.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 17 Dec 2018 10:03:36 -0800
Message-ID: <CAHQ1cqGA1xxY7qQMWBoo0_jbSa4=OBD=6_Du6dOKN5xsdqOj4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx6: Make fallthrough comments more consistent
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 17, 2018 at 5:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Dec 16, 2018 at 03:09:16PM -0800, Andrey Smirnov wrote:
> > Convert all fallthrough comments to say "fall through", as well as
> > modify their placement to the point where the "break" would normally
> > be.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Leonard Crestez <leonard.crestez@nxp.com>
> > Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > Cc: linux-imx@nxp.com
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pci@vger.kernel.org
> > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>
> I didn't make it very clear, but my suggestion was really to remove
> the annotation completely; see below.
>
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 59658577e81d..a0510e185d44 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -362,7 +362,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
> >
> >       switch (imx6_pcie->variant) {
> >       case IMX7D:
> > -     case IMX8MQ: /* FALLTHROUGH */
> > +             /* fall through */
> > +     case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);
> >               reset_control_assert(imx6_pcie->apps_reset);
> >               break;
>
> IMO this use of "fall through" is superfluous and unusual in the Linux
> source.
>
> A "fall through" comment would be useful if the IMX7D case had
> executable code but no "break".  Then the comment shows that the
> intent was to execute *both* the IMX7D code and the IMX8MQ code and
> the lack of a "break" was intentional.
>
> In this case, the intent is to treat IMX7D and IMX8MQ the same, and
> there's no executable code specifically for the IMX7D.  I think it's
> easiest to read that when the list of identical cases is all together
> without the comment in the middle, i.e., as
>
> >       case IMX7D:
> >       case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);
>
> rather than this:
>
> >       case IMX7D:
> >               /* fall through */
> >       case IMX8MQ:
> >               reset_control_assert(imx6_pcie->pciephy_reset);

OK, understood, will remove in next version.

Thanks,
Andrey Smirnov
