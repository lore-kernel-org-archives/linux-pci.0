Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97359C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E48217D9
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545167462;
	bh=4TSoy7am50zcJFdCj0qlkmFgh7ve6nj0hZ7RxM5K9Po=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ltHJwsamJy3T6e3tt5z84JoTm29lQimBBND9+M8RgnhSLn3GB2rwvdtfthiQmIJIu
	 k+9hu2kSR+/wifDXGmTSBxcaS687ohJjhESYdDMVBtiXRYIMdzrCLVBfRa3l9dUD7R
	 zNhb4AXM/6NWPCoazfKkE5Cm7mSlXCC0sgkvDjbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeLRVK4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLRVK4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 16:10:56 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD82A218A4;
        Tue, 18 Dec 2018 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545167455;
        bh=4TSoy7am50zcJFdCj0qlkmFgh7ve6nj0hZ7RxM5K9Po=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IJBUb327rfAXUE1s+r/hAEIDd0rS0Z5jodnjPsyMu1eVoUNReMdMsntsciGu5MBVm
         6sP95GSgyvAslUH5JBJOpIejDZ0NZjD/6JcqsBpmWJanoryEpBwjdZpvliqtTHMMSu
         3/Hb6tfjHnIRkRsFfTrsMMSEP4rUGZLLZptABCLE=
Received: by mail-qk1-f174.google.com with SMTP id q70so10401527qkh.6;
        Tue, 18 Dec 2018 13:10:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbQ64PIJnPiM57nsLaTsj3Bf+9yOxh85h224RePJzOGn5gmNDRm
        9KqT6xQqXNDYGbW9ooVkcegJcHIFRESKRJ16GA==
X-Google-Smtp-Source: AFSGD/XDMMsXDqTSKfsppkIWD2amigNADiMJP2tAz6O2uo7RqRXdFgiaPggf87D75bHQhJxasdYd+0hDUMxCGYVSHXU=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18087864qkg.147.1545167454899;
 Tue, 18 Dec 2018 13:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com> <20181218151533.GA2922@bogus>
 <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533533242C036C5CF6352BAEEBD0@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Dec 2018 15:10:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
Message-ID: <CAL_JsqJb24ZpM7qQfy_F7RUVEGyceBAXOndbZcTMh3a__k38UQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 12:09 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 12/18/2018 5:15 PM, Rob Herring wrote:
> > On Mon, Dec 17, 2018 at 08:07:02PM -0800, Andrey Smirnov wrote:
> >> Add code needed to support i.MX8MQ variant.
> >>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
>
> >> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> >>
> >> +Additional required properties for imx8mq-pcie:
> >> +- fsl,controller-id: Logical ID of a given PCIE controller. PCIE1 is 0, PCIE2 is 1;
> >> +
> >
> > Remove this.
> >
> > If GPR register offset is what you need, then put that into DT.
> > Typically, we'd have a property with iomuxc phandle and offset.
>
> This series initially added explicit offsets but I suggested a single
> "controller-id" because:
>   * There are multiple bit and byte offsets
>   * Other imx8 SOCs also have 2x pcie with other bit/byte offsets
>
> Hiding this behind a compatible string and single "controller-id" seem
> preferable to elaborating register maps in dt bindings. It also makes
> upgrades simpler: if features are added which use other bits there is no
> need to describe them in DT and deal with compatibility headaches.

You already have an id for the controllers: the address. Use that if
you don't want to put the register offsets in DT.

Rob
