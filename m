Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80AC43610
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 21:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9341321104
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 21:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9LWi4gI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9341321104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbeK1IOT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:14:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeK1IOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 03:14:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id j2so24207224wrw.1;
        Tue, 27 Nov 2018 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cke1sTS+A87UV3r1vzgzLnjfWNjpjwinc/lnl7tc5qc=;
        b=D9LWi4gIhRSAW+JDG06KMzIttQZAwK73aiDYv1ahqhHpByhQ52Op2LMOkO0sRkK4jE
         GFoaHiuQxK5YzaG2WgZ1PPyLBPBiaKT8DxV5K1fpOf9nBDm5H6meLXhVwspsg1MYiroK
         mH/wMabi3eaTw6OuaE/7cNl3u3zzxOayy18DTGnMOl9J0Xpx7XVr46ovm6B/M71/qTkI
         OMKxm75oSDEejHJ2EENQEot9Ws81DOSOokfKnqXrK6u6kbqDUyTC/4FcOiV3smWS3j4g
         pklB6URjz0LshuVhrGM/KmzPY0RZsKtw8rtlzfX94egsF2ijnQT5hu11yDm2H8CLHI42
         x8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cke1sTS+A87UV3r1vzgzLnjfWNjpjwinc/lnl7tc5qc=;
        b=kQwCWtX/1z2ztfxyqgbXAq31EgAFgJFpvOrUhRQPwbSRkAUDZe8USJNQF6lcHuddUX
         xmyDMP69Kl8JmRRjEm9CeZQaM9lgQbGN/7YZ7aAnYU06unC4JOzXEGOUf9VWc/KtQ+vg
         gJEZ2+7vUh5gEM/kjatpcPLq38aCANs1FOJ0MBfNLzrR8R9zwqw/JsrwcQkdEHZ/nnyR
         /tjS3eOGpboJprSt/igWDUnmrSpiXKvkNU5WwGkM/5ZTGVyTxfGklHipq4vtfVQ3B6k6
         BMlnoBmYtA7F45MN/GWf3eVZjkZHHUnccogOvKn1ErfjJylP5l5m1occjgZ/I7UooWd+
         jy7w==
X-Gm-Message-State: AA+aEWbNoN00H4Zo2xRyNkQUemMWgBRguib876is1HGeTt1OTttn/TEL
        0Ab9Z+NSjxetvJA3Wg6/JdOOEMUZrABzBQNDOgDM2yz7xtI=
X-Google-Smtp-Source: AFSGD/VJuZDVpXnAQn6MMwW1MiogX97yYqgAdBi5DORyRCY6y8r4/ShMCdLO/3DiNc1zqj2hk+NB0FkHHDjWRs/iisM=
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr21642457wrg.52.1543353305687;
 Tue, 27 Nov 2018 13:15:05 -0800 (PST)
MIME-Version: 1.0
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com> <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
 <1543313169.2507.39.camel@pengutronix.de> <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB5533DE497786CD80D4FE0941EED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 27 Nov 2018 13:14:54 -0800
Message-ID: <CAHQ1cqEGABcH3EG9yGo7Ns2fPR1s_u1YPtFoKRjUh50=aa=J2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 2:46 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 11/27/18 12:06 PM, Lucas Stach wrote:
> > Hi Andrey,
> >
> > Am Montag, den 26.11.2018, 10:24 -0800 schrieb Andrey Smirnov:
> >> On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >>>
> >>> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> >>>> @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >>>> -     case IMX7D:
> >>>> +     case IMX8MQ:
> >>>> +             if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> >>>> +                                      &imx6_pcie->gpr1x)) {
> >>>> +                     dev_err(dev, "Failed to get GPR1x address\n");
> >>>> +                     return -EINVAL;
> >>>> +             }
> >>>
> >>> This is for distinguishing multiple controllers on the SOC but other
> >>> registers and bits might differ. Isn't it preferable to have a property
> >>> for controller id instead of adding many registers to DT?
> >>
> >> I liked encoding necessary info in DT directly slightly better than
> >> encoding abstract ID and then decoding it further in the driver code.
> >> OTOH, I am not really attached to that path. Lucas, can you comment on
> >> this please?
> >
> > Yes, after rereading the patch with this in mind I agree that having
> > the GPR offset on DT directly is IMO the better approach than an
> > abstract ID.
>
> But it's not a single offset, for example the device_type (EP/RC) has
> bits for the two controllers side-by-side in GPR12.
>

Playing devil's advocate for a bit:

More specifically, currently the following per-controller bits need to
be configured:

- Location of the "device type" field within GPR12
- GPR register to use to control PCIn_CLKREQ_B_OVERRIDE_EN and
PCIn_CLKREQ_B_OVERRIDE_EN (GPR14 vs GPR16)
- Now that Philip spoke against PCIE_CTRL_APPS_CLK_REQ being exposed
via reset controller driver, we need to know which SRC register to use
to control that bit (SRC_PCIEPHY_RCR vs. SRC_PCIE2_RCR)

Thanks,
Andrey Smirnov
