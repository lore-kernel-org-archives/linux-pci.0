Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B20C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 18:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E150A21873
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 18:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7PG1sjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLRSOl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:14:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41285 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeLRSOk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Dec 2018 13:14:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so16892401wrs.8;
        Tue, 18 Dec 2018 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R2IW6oZdYoMQnsGgIcxUNJDJQzxyJljdHvK78FWCkA=;
        b=J7PG1sjF/DKDNf37b/jiAdN9FsXoislCWpZKSmqTg59jTqSOw4IFGgZL4T21rWi+ne
         OSzzohKJ0UEmooMBKQwy+gPJxhnItMmpxgQ2miU9KkkMN3hdNbJxqh76+R2skeeM+PGY
         XkUzkieBWMPbeBhPirBFKrTYZU5CjIZ0K7cNf81XcRe2Xwl1JNUjaz3QZfEIcnkkL+nO
         Ajc4fqsFutmWnXzzjZvJ+gqOm2mTV+bgjxCYuxbPK6CQ6jZyoRDuuhjaXF5a7K3ZAV0d
         Fs0x3LuqOsFlN+UplIFy6Zfg88Dd0w+SIv0gf22SghH7OQuPJKOZF/kFGRqJnJDXuvSL
         /1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R2IW6oZdYoMQnsGgIcxUNJDJQzxyJljdHvK78FWCkA=;
        b=IH0A0lU+EjBRdjQBLiumVaVUDZauFLuB2HUbXEOjxgo9JWXbIqXLJBcD+edIOADe9l
         bJ+G9hdR8PdwtvCOWDaE9gWUOaSlxTxlaijgHzR6W1VVHsenlvM9nfnfFfw7aHmwtPfQ
         NdXHltzCaDJazd9H2kUdp8L/a6fh1omusFodi0OEhW+82XCHoXs3WgPG242ydH8T9PnC
         x4U05XIpueAwIdzFDX4u75gzk7a124hEZmYHW3foUB/z2tPtwtvdmhYWsJ5JTjaoDsMM
         16RntxknH4OEnLB6P48ZEkcMHQwSI4Cdz9JaHZVQBifMDQETzjft5LiqXGQONlFtQI1w
         qb8A==
X-Gm-Message-State: AA+aEWb9peqCZm1zdHJJ1W3De/Y96r+mWEvjQk91raXiZuoLmyctLoc8
        Kufh3brFSa+y+gmUJpj4SWL70ojEqCMQRQvpRfI=
X-Google-Smtp-Source: AFSGD/VmznuWHRt96sVx9keiQwcyhuA6Esgym6fwwg1RsaGDNCrX6pvn56l1/7ZID6xQthzVSKUAifRoxzOE9dtL5eo=
X-Received: by 2002:a05:6000:51:: with SMTP id k17mr14844433wrx.259.1545156878056;
 Tue, 18 Dec 2018 10:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20181218040702.29231-1-andrew.smirnov@gmail.com>
 <20181218040702.29231-4-andrew.smirnov@gmail.com> <8149d09e665c4a4efb85a9d60f266d478bee02d8.camel@nxp.com>
In-Reply-To: <8149d09e665c4a4efb85a9d60f266d478bee02d8.camel@nxp.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 18 Dec 2018 10:14:26 -0800
Message-ID: <CAHQ1cqEw47XSfNnohg=VJdQJ+fF-F-nucNm=Qqu5Tt-tZt2-PA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] PCI: imx6: Add support for i.MX8MQ
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 18, 2018 at 1:34 AM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On Mon, 2018-12-17 at 20:07 -0800, Andrey Smirnov wrote:
> > Add code needed to support i.MX8MQ variant.
>
> >  static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
> >  {
> > +
> > +
> Remove empty lines?
>

Sure, will do.

> > +     unsigned int mask, val, offset;
> > +
> > +     mask = IMX6Q_GPR12_DEVICE_TYPE;
> > +     val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT);
>
> ... snip ...
>
> > -     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > -                     IMX6Q_GPR12_DEVICE_TYPE, PCI_EXP_TYPE_ROOT_PORT << 12);
> > +     regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
>
> Maybe setting port type should be a separate function from init_phy?

Sure, will change in v4.

Thanks,
Andrey Smirnov
