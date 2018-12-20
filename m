Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9030CC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 00:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C37820873
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYLpaLOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbeLTArk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:47:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51122 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbeLTArk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 19:47:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so284424wmd.0;
        Wed, 19 Dec 2018 16:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AbdAJWgzqrgiKeUVUyhCN6wgu0RENht0s9o392+B19o=;
        b=aYLpaLOGNEz8s+JXblOJEXsg7azyVXjG8HEl4gLhm2YYm3OHvVb74JpN8RyZrav7hr
         Cm+6kqhZFXJIHTcDhh45NHkSxFF978VfdLlLZGcn5rIvpX0BwoJl0q5hMUGmjtO3Sgt2
         IGbbmezz1urmF3HEzDd3K7CBcOOHg3LRwHliwZzcJHBgTSd5vSVoEJuC4iIyNsd561Ac
         XGuDtQ6Rum3XGdMNI8jiB1+K8T7xabwi6VQiK3HohTTH3U7NI5dkTbooUujM5DDMuwYX
         27CVa1QiWpO774MZgs0lmqgkzoK56CCSmb++o+14XbNiJV48Djg87ya4uJjYKP7GuxHp
         rdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AbdAJWgzqrgiKeUVUyhCN6wgu0RENht0s9o392+B19o=;
        b=NV3GnFqtMJ5ylEPLgNyBos0fJcU5MW+O7HpTi+xsiddBYSx1KwU4uHvQt237RNZ1Yl
         3Kacar8B/xMoQzBav8Tze3vkhN8uK5kS21F93vYoWQ3rULVKCiId6uZNvgxM0MF7E1W2
         BQMm1Ef46EObBARMEwXdDI6XU4X9KFFLKl6G/ja1hCToi5emuUM7RXdS6xtu2UxvsoVf
         epntCJt7NkeE9+DGMqJiGZPOpkbY6zk+ChVNKd9CaICYb1ddWOKQPHWKy9nsEfDi0dPz
         0W+VeRvAbHIHaKmg+B1BRZCXNjZqEwqKOTC/PaAT7e+sMv5CHGNFZ66weO0DPOZHARBU
         NNOQ==
X-Gm-Message-State: AA+aEWYtHhXDnjtnYea0N78Fwo7tCDy6v7HVNyd6lvCpT74r1gpqXZzR
        64A4RUYgCUERlgTVZhG7IAww89Q6XH1JtHuvKqY=
X-Google-Smtp-Source: AFSGD/WV4tWAZ4QuNLDSV06RKJQcz+HdgXWWX1kqNu5IPQ+J5SrBqhDqZGX2YqAjwol4D4Noij/e8amOXWRD7mr0oiw=
X-Received: by 2002:a7b:c44d:: with SMTP id l13mr9225146wmi.144.1545266856554;
 Wed, 19 Dec 2018 16:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com> <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Wed, 19 Dec 2018 16:47:25 -0800
Message-ID: <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 1:10 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Dec 18, 2018 at 12:09 PM Leonard Crestez
> <leonard.crestez@nxp.com> wrote:
> >
> > On 12/18/2018 5:15 PM, Rob Herring wrote:
> > > On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> > >> Add code needed to support i.MX8MQ variant.
> > >>
> > >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> >
> > >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > >>
> > >> +Additional required properties for imx8mq-pcie:
> > >> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> > >> +
> > >
> > > Remove this.
> > >
> > > If GPR register offset is what you need, then put that into DT.
> > > Typically, we'd have a property with iomuxc phandle and offset.
> >
> > This series initially added explicit offsets but I suggested a single
> > "controller-id" because:
> >   * There are multiple bit and byte offsets
> >   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
> >
> > Hiding this behind a compatible string and single "controller-id" seem
> > preferable to elaborating register maps in dt bindings. It also makes
> > upgrades simpler: if features are added which use other bits there is no
> > need to describe them in DT and deal with compatibility headaches.
>
> You already have an id for the controllers: the address. Use that if
> you don't want to put the register offsets in DT.
>

Lucas, are you on board with this?

Thanks,
Andrey Smirnov
