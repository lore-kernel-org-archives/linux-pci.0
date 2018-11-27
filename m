Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7109DC43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6EF2086B
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 21:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDwh57dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6EF2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeK1IDV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:03:21 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39286 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbeK1IDU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 03:03:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id n133so416559wmd.4;
        Tue, 27 Nov 2018 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4E6AziKpUktxFa6iczYeboLTlCGjBaA9rElEZUd4CY=;
        b=qDwh57dZ9OBD+u01EL/MLoYuOisq0LxV8OAig8SEnNngyFRFS46u+t8BfKVGb06puk
         mx1e+yNHXhR3MYejmnTkS+j30C/Rvd9PfgOMgNo56b2y6D1Q3NFLxMkoKRn4Wqa5PmO/
         WPoPGsjVT10IaUxifgwRbY21jW7g1yF7ORa9DqAggbHA7iA5xPi2hhH5zzzqatgF3FWC
         F9SM45paW0aQCUvB2zWC7EDtU6ev8IwQJ/buIifZZGLha090Zv+zZk9GAD7ZhoSb7fpT
         BMYpixAQbRW1GPrgY0Y2hz12H1JrN4T3t/qoEP+W2HgXMWVDsGNM9HvMjzhpKiEhOVB5
         2l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4E6AziKpUktxFa6iczYeboLTlCGjBaA9rElEZUd4CY=;
        b=ZizzjBofwjccoFylPG+g0earEgg3Z5Zp1Fb+HeSgxI7R8tMz1ysSUlkqIQKBzEtabi
         J9eQHuYnrna33iZCZuQaYDBinTrA66+tbpYCs2rKiLrP5bmm/uSWortDoiizL0K20io5
         N1oTNmdJeMINThn9+AkZVL8X20P8wgRIAYplvQsBCW3WqyI2jtXFPh4SNSYCCTZurkmc
         HqHgMq+mxuYv1edhZOPzzkT1U37Byox5O2tM9dQ9bv/pBcntKrQBY5ha0kqJLmWd3HiX
         mRvdod/3O6gQexztJEtaSpJ0Sa7euA12ZBtD0a+PqhZP5y1qcHvVqdej1rk73kwJol+E
         znPA==
X-Gm-Message-State: AA+aEWbiHExwtghuRiZ3RaT2pvYXjD1AvVkhnhyK1qTenXQzDrYH5pfE
        W5vRtSMQ+RtTTzwBOOihFgHHBDINqEpy/u4uSGA=
X-Google-Smtp-Source: AFSGD/X7t0K22byKif+cygagNZRGsmR8TU5VQ7ypbM/q1jvVQOc/01ze5G6+pIwfS9Y/6rZ/yPQAZI8qjTBxtEa2jAc=
X-Received: by 2002:a1c:f0e:: with SMTP id 14mr390009wmp.37.1543352648847;
 Tue, 27 Nov 2018 13:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
 <20181117181225.10737-4-andrew.smirnov@gmail.com> <ce2ac1a880ce2a7a39f0e42b5059676daa748e52.camel@nxp.com>
 <CAHQ1cqH6LT4GsxUchrmVG1m3fqawgyUjxdHvh=SzxhBiQOd8eg@mail.gmail.com> <VI1PR04MB553359EA5E0F88701A92A3AEEED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB553359EA5E0F88701A92A3AEEED00@VI1PR04MB5533.eurprd04.prod.outlook.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 27 Nov 2018 13:03:56 -0800
Message-ID: <CAHQ1cqE0cUUsT99A5ZM6XkNd7E5+17qjZRkCdCERSp2-nWsf=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: imx: Add support for i.MX8MQ
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        Chris Healy <cphealy@gmail.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 27, 2018 at 2:16 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 11/26/18 8:24 PM, Andrey Smirnov wrote:
> > On Tue, Nov 20, 2018 at 2:49 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
> >> On Sat, 2018-11-17 at 10:12 -0800, Andrey Smirnov wrote:
>
> >>> +             if (of_property_read_u32_array(
> >>> +                         node, "fsl,gpr12-device-type",
> >>> +                         imx6_pcie->device_type,
> >>> +                         ARRAY_SIZE(imx6_pcie->device_type))) {
> >>> +                     dev_err(dev, "Failed to get device type
> >>> mask/value\n");
> >>> +                     return -EINVAL;
> >>> +             }
> >>
> >> The device type can be set on multiple SOCs, why are you adding a
> >> mandatory property only for 8m?
> >
> > My thinking was that other SoCs don't really have two controllers, so
> > they don't really need to have that property, but, more importantly,
> > not forcing them to have this property should preserve backwards
> > compatibility with old DTBs.
>
> The "device_type" registers determine Root Complex versus End Point
> mode. This is not yet supported on imx in upstream but it can be done on
> many soc versions.
>

Yeah, I am aware, I wasn't really trying to make it possible to
configure IP block to be a EP, that is just an unavoidable consequence
of the approach taken.

> Looking at other pcie controllers (and dwc core) this is normally done
> with a different compatible string with an "-ep" suffix. It feels wrong
> to expose bitmasks and values directly in DT instead.
>
> For this patch you should probably just hardcode RC mode.

Hmm, given how the mask/value have to be different for each
controller, the only way to hardcode it  that I can think of would be
to change the property pass a bit offset instead of mask/value pair.
Is that what you are suggesting?

Thanks,
Andrey Smirnov
