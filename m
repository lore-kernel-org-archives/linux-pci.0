Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4351FC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF920855
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ593CjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AF920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725723AbeK0FTk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:19:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725199AbeK0FTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Nov 2018 00:19:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so19193288wmc.5;
        Mon, 26 Nov 2018 10:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HktZkRW68wtQ+u0+5VCsyAi7ntvCc/+mmzCpYmd0SF0=;
        b=KJ593CjEAnaLLhkDZXsBrkQ30oM1RgoLVJFL/nGixd3v5Dks5DPPjsTr4BL2gvFznv
         E2NiOBwJG8YDdGes8ygjVM9Q1O4t5YHaYad3gHO289SgerVSorBOD0rGshu9osGn8bHT
         dSjSumFDKNNKEur3h+FpcZbxejHqz68csw2IPxJg2yG8paOyibuHbKyMvzwcZtma0TbA
         nfKmIHzPYiaUVKDXGSwM5f0uEOvo+2+sAw8SCiKtGmwnvnqvvp/797mSOY+LcYbJkXOg
         TRYYNj6UQ5dqSGBZXOJ3llGcHV/3Si3vn2usc+wAxgREuoKKCjlyLsf3LWVCrXHr0rqV
         dV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HktZkRW68wtQ+u0+5VCsyAi7ntvCc/+mmzCpYmd0SF0=;
        b=j3u2rd4PhYQGLZmgM3qz1oazvVqTi/Q5sv7r07JFVvntghgsFvWii/5nCilJ5y8TV3
         b97c2qR5CwT4HMGj6XeVOxzcp9/uDNsCBEpLaHEQEM3EXD9gW4Guy5f3Au1uA1cNkr4L
         OtaJe3ERIub/q02ucKbYiv6vvXXf5MEnvpCpSiX9FudvydqFr5dyPOsxh2DoWY/uZeVF
         gP3raZJmtxziGnsuj2J/c5Ix7NZrGA+YARnlFaXCVf9eY5OPNY2WewUFhaOqpSaJVSgB
         UVEE6BGfjARX2Aygzyf8pW+AGFOU3gI/ZcThEgRILzick2ob154pqb/5L+25kMSV54ky
         sAIg==
X-Gm-Message-State: AA+aEWYO6/4KYU4rNiDiu/3r02pPdP4puN3i4wtDfdosVaUbJdOGy0HB
        /78HPeQb74N7Cp7qBCtVYj/tQCUmi6mODla9cS4=
X-Google-Smtp-Source: AFSGD/WvJwpnmg6G+JIxrcu/0zWD0ptuFa+rPDmRF5nzKaS68LhJG339wGap2FYj3I+rG6tzbev68wDW95Mf7/n9dOo=
X-Received: by 2002:a7b:c404:: with SMTP id k4mr25017154wmi.144.1543256682743;
 Mon, 26 Nov 2018 10:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com> <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
In-Reply-To: <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Nov 2018 10:24:31 -0800
Message-ID: <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com>
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

On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
> > @@ -921,7 +1004,28 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > -     case IMX7D:
> > +     case IMX8MQ:
> > +             if (of_property_read_u32(node, "fsl,iomux-gpr1x",
> > +                                      &imx6_pcie->gpr1x)) {
> > +                     dev_err(dev, "Failed to get GPR1x address\n");
> > +                     return -EINVAL;
> > +             }
>
> This is for distinguishing multiple controllers on the SOC but other
> registers and bits might differ. Isn't it preferable to have a property
> for controller id instead of adding many registers to DT?
>

I liked encoding necessary info in DT directly slightly better than
encoding abstract ID and then decoding it further in the driver code.
OTOH, I am not really attached to that path. Lucas, can you comment on
this please?

> > +
> > +             if (of_property_read_u32_array(
> > +                         node, "fsl,gpr12-device-type",
> > +                         imx6_pcie->device_type,
> > +                         ARRAY_SIZE(imx6_pcie->device_type))) {
> > +                     dev_err(dev, "Failed to get device type
> > mask/value\n");
> > +                     return -EINVAL;
> > +             }
>
> The device type can be set on multiple SOCs, why are you adding a
> mandatory property only for 8m?

My thinking was that other SoCs don't really have two controllers, so
they don't really need to have that property, but, more importantly,
not forcing them to have this property should preserve backwards
compatibility with old DTBs.

>
> There should probably be a separate patch with documented DT bindings.
>

Yes, definitely, I just wanted to come up with a set of bindings
agreed on by the driver maintainers first.

Thanks,
Andrey Smirnov
