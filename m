Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED453C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FE9218D3
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545318017;
	bh=PgdcFzzFJRfg9e6GuRKfjwKRt1qszJo4vAoki4ZdPow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XjKdjshIz4N5Fl0tuXMi7uhyuUmgCeQEpw4zMKlqVQNLtbloLag+3+r/qRsGHgnGv
	 KP+Q4/BFbdSrXKq3M6WPwuRQxCcOpALBC0+aGqCpXcwJuhcjA7Oa4yfVeCkWOzyQKR
	 B5Dr/++Ao1Txa59HZxO+3nyJYLOm/cANPovvQaJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeLTPAQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbeLTPAQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 10:00:16 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86A48218D4;
        Thu, 20 Dec 2018 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545318015;
        bh=PgdcFzzFJRfg9e6GuRKfjwKRt1qszJo4vAoki4ZdPow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdnUMcCFDBFzHEAMdpyHRqX9GgShwKo+QWg59/9Oe4NJ82DCoTOfLtLzZYMANPtwQ
         L0sUq2vX5mD6Af6yxTOnQuLhXBpFkmQnsid16WJWPW1iqe/fF8awRHmT6MQ7y6YWYx
         uTqdoLMVoIEznpEq3UtzC3+ivOhjCz4zQIY5fcgI=
Received: by mail-qt1-f182.google.com with SMTP id n21so2087877qtl.6;
        Thu, 20 Dec 2018 07:00:15 -0800 (PST)
X-Gm-Message-State: AA+aEWZD9ZHfvcQaslGzxG/VXmjuRWEdT70KEsKyW5DwZHqucR/NtYdH
        jX1DIFWQD/fMmHqQCC4HYheZb7t44w32ujKQ6A==
X-Google-Smtp-Source: AFSGD/UI6ZKZCM3DWOK3vRuT6L0eQh3X21IsbTvynvSnAaNVyobUIJbREiqUsj9quGSzKi6VGzTplbsMOKm35Uj5ark=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr26745039qvk.106.1545318014699;
 Thu, 20 Dec 2018 07:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com> <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
 <CAHQ1cqEMxxo9JGN5be4XQWAtPz7nC2JyLCr3qasnD5QK7_hOYQ@mail.gmail.com> <1545268969.22930.77.camel@impinj.com>
In-Reply-To: <1545268969.22930.77.camel@impinj.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Dec 2018 09:00:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJBxZw225qqWfCFa8UqADtGOUCjFogo6Pb2bd8bKwz3nA@mail.gmail.com>
Message-ID: <CAL_JsqJBxZw225qqWfCFa8UqADtGOUCjFogo6Pb2bd8bKwz3nA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 7:22 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Wed, 2018-12-19 at 16:47 -0800, Andrey Smirnov wrote:
> >
> > > > This series initially added explicit offsets but I suggested a single
> > > > "controller-id" because:
> > > >   * There are multiple bit and byte offsets
> > > >   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
> > > >
> > > > Hiding this behind a compatible string and single "controller-id" seem
> > > > preferable to elaborating register maps in dt bindings. It also makes
> > > > upgrades simpler: if features are added which use other bits there is no
> > > > need to describe them in DT and deal with compatibility headaches.
> > >
> > > You already have an id for the controllers: the address. Use that if
> > > you don't want to put the register offsets in DT.
> > >
> >
> > Lucas, are you on board with this?
>
> Does address here mean the address from the controller's reg property?

Yes.

> How do you map that address to the controller's index?  A giant table
> of every soc so the soc type plus controller register address pair than
> can be looked up in the driver?

You only need the 2-Nth instance addresses. A non-matching address can
be instance 0.

> I.e., on iMX8MQ the controller at 0x33800000 is controller 0 and so on
> for every possible SoC address combination?
>
> Not really a fan of that.

Well, this was not my first suggestion.

> The situation here is that some registers for these controllers are
> interleaved, right?  I.e., there's one register somewhere where bit 0
> means enable controller 0 and bit 1 means enable controller 1 and so
> on.

So? The only difference here is an additional mapping step.

> Isn't cell-index already the standard device tree property for this
> kind of setup?
>
> I know cell-index was historically also (ab)used in an attempt to
> provide a fixed kernel device enumeration order, something now handled
> better by chosen node aliases.

Don't use cell-index. Consider it a deprecated relic from OF that is
not used on FDT (though there probably are some cases it did get
used).

Rob
