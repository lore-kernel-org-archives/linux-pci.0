Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36A0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6611520823
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="V+4uCU5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfB0Q5X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:57:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43779 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfB0Q5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 11:57:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id d17so18735969wre.10
        for <linux-pci@vger.kernel.org>; Wed, 27 Feb 2019 08:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0lt3QPSb3rH/8nCr2nSW3mU0Ki/KzWtBS9cUwCG2xY=;
        b=V+4uCU5UrXkrF3KpUGNtfO5q9E+BVGNDU4uMvv+F2rdwTKl/rMZtnRFSfawRItq0HB
         l4jr0zO7FexrdLV137E0h1Otdu5+4AmUs2wR0yVQ+yBZJ/K4gK0EZmvoajzWcFXKj3u5
         yAIxFp9KXQ0lkMMFhjKfNKF4fZj7C2TAmiT1vDM3Q7fEcEwMBDPTBzLxuyMVe6TRq9C8
         kaJ9fC8jOMqDvLe/8EDZtjd7r4Gm0wG67BNy3ddZXxW/KEDwpsrBNEUbML3FI0J73k69
         nj6tWSfSzDScHh1gs3FNa0tlBajxrQHcvLnvfjwuRLMgAJto7470MZirYx/t6/5NisJE
         xj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0lt3QPSb3rH/8nCr2nSW3mU0Ki/KzWtBS9cUwCG2xY=;
        b=Mtx1/nWqkfieE7PbRN27OHk+BR2NPsJKXw8b2nmfmmu6SaugPf09IfZIskYwIlklcM
         RTY/r2bbl0qHKPJPh0kf9EIZqQnLFoBtG8SnwNqG8QZCy+dVXogmNucP4npMzdESAdHW
         c0hL4kW1aD/ZBJYs8B/ZRjOZ5dLyyIy4Y41QMaG83+++HamGUUS3x7n9TKn5bBWV5+qD
         k/ufexWcDRO7sKQuA+rLnBPoS0EwIu/fFT+aS7QrXpzmzaj60G8AksuIyd0DXv8KTUEe
         0/vS0xkFJ8BoJANOUC9Ljdm5/ZtgZIvBv3swZ62MUuNEPkUYBEj61Hd9ivsntlHs4tvD
         Z81g==
X-Gm-Message-State: APjAAAUlEltwFSkuloLYRkCwE1TtbIL2Br9TXSUlUfOKnjwLTyfLs22U
        8LFUNaZY2Pgg+itrAcAHNGXWr73bbcORtIveFg00ERGt
X-Google-Smtp-Source: APXvYqzDHmcIMn1BryMSG3S3lxkqK/NReZHsUWzc25bZpHLh+JsBiIwDPyY4i+03DGgHPaF9QJN59/IZgPXNHzZbapU=
X-Received: by 2002:a5d:690d:: with SMTP id t13mr3047826wru.135.1551286640529;
 Wed, 27 Feb 2019 08:57:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2XcJ+btfM64p4W7VrBvB6W89MZ=+8G5NYWP16MRrY56A@mail.gmail.com>
 <1551261667.2305.6.camel@pengutronix.de> <CAJ+vNU0b3ZwkYJBLJitCr=_m1wpK0R9KF-Tk2QZ6UwEPMwueqA@mail.gmail.com>
 <1551285598.2305.14.camel@pengutronix.de>
In-Reply-To: <1551285598.2305.14.camel@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 27 Feb 2019 08:57:09 -0800
Message-ID: <CAJ+vNU36nKkO=4Wbfe4MjjaP4Q9v3JPCqTZ_rRC+XAj795iDiA@mail.gmail.com>
Subject: Re: IMX6 dwc PCI regression through switch - unable to request
 (legacy) interrupt (pci=nomsi)
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 8:40 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Mittwoch, den 27.02.2019, 08:29 -0800 schrieb Tim Harvey:
> > > On Wed, Feb 27, 2019 at 2:01 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > >
> > > Hi Tim,
> > >
> > > Am Dienstag, den 26.02.2019, 13:13 -0800 schrieb Tim Harvey:
> > > > Greetings,
> > > >
> > > > I've got a miniPCIe card with a TW6869 8x frame grabber that stopped
> > > > working on an IMX6 based board with a PLX switch with Linux 4.17 as
> > > > the driver errors out with 'tw686x 0000:07:00.0: unable to request
> > > > interrupt' (request_irq() fails). I've found this only happens on
> > > > boards that have a switch. Note I'm booting with pci=nomsi as well as
> > > > the IMX6 has a limitation where legacy IRQ's wont fire if MSI irq's
> > > > are enabled. Strangely I don't see this issue with other cards such
> > > > as
> > > > the ath9k with msi disabled.
> > > >
> > > > I bisected the issue to 7c5925afbc58c6d6b384e1dc051bb992969bf787
> > > > 'PCI:
> > > > dwc: Move MSI IRQs allocation to IRQ domains hierarchical API' which
> > > > due to continued changes in drivers/pci/dwc can no longer be
> > > > reverted.
> > > >
> > > > Any ideas what happened here? IMX6 PCIe through a bridge always seems
> > > > not so well tested and very fragile over the past couple of years.
> > >
> > > Thanks for the report. Both the DWC PCIe core in general and the i.MX6
> > > integration have some rough edges, which makes things fall from time to
> > > time. Having a PCIe bridge in the mix does extend the test space quite
> > > a bit.
> > >
> > > Does the following patch help? I didn't test it yet, but it's based on
> > > my assumption of what is going wrong with the referenced commit.
> > >
> > > Regards,
> > > Lucas
> > >
> > > ----------------------------->8--------------------------------------
> > >
> > > From 40b4fc03878a935fa81af226a8e759d4c72a3603 Mon Sep 17 00:00:00 2001
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > > Date: Wed, 27 Feb 2019 10:50:20 +0100
> > > Subject: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
> > >
> > > Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> > > hierarchical API) the MSi init claims one of the controller IRQs as a
> > > chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> > > this line is shared with a PCIe legacy IRQ. When the line is claimed for
> > > the MSI domain, any device trying to use this legacy IRQs will fail to
> > > request this IRQ line.
> > >
> > > As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> > > as the core won't forward any legacy IRQs once any MSI has been enabled,
> > > users wishing to use legacy IRQs already need to explictly disable MSI
> > > support (usually via the pci=nomsi kernel commandline option). To avoid
> > > any issues with MSI conflicting with legacy IRQs, just skip all of the
> > > DWC MSI initalization, inclusing the IRQ line claim, when MSI is disabled.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 29a05759a294..f4a8494f616b 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > >         if (ret)
> > >                 pci->num_viewport = 2;
> > >
> > > -       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> > > +       if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
> > >                 /*
> > >                  * If a specific SoC driver needs to change the
> > >                  * default number of vectors, it needs to implement
> > > --
> > > 2.20.1
> >
> > Lucas,
> >
> > Yes, this patch resolves the issue. Where did this come from? It looks
> > like it came from back in September but never made it upstream?
>
> Nope, I wrote it just after your report, as seen in the "Date" line.
>
> > I'm a bit baffled why I see this issue pre-patch with 'and' without
> > pci=nomsi based on this patch? I do see other checks in
> > imx6_pcie_host_init() and imx6_add_pcie_port() for
> > IS_ENABLED(CONFIG_PCI_MSI) that do not have an accompanying check of
> > pci_msi_enabled() to see if its enabled at runtime... are these
> > problematic as well?
>
> I'll look over them, but I think with this added all the relevant
> places are covered.
>

Ok, thanks for the patch!

Regards,

Tim
