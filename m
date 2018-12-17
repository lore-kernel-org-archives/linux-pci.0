Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE21C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342AC2133F
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 17:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3J5kLXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLQRSs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:18:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52496 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeLQRSs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 12:18:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so14290wml.2;
        Mon, 17 Dec 2018 09:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvrFg58Xr7iAG870iC1XAuJqs0RSBPPYSssQ5mYZXxo=;
        b=h3J5kLXLyG4YEqNDrWlYKIgTR7jr1V+sRY12WOWpzfeRJrS6riohdYo1B9ljvFfg3y
         PNENQkDoXNPA74fP/K8Lm8ozH9iWDXXLDNfiv1YsW3kDyZMPgBNxmQnoz2DKq3KKOIfV
         BcoDAMkpZjDgQfzUCwwl1Gz5lnL71Wqf3WPQn5pzVmXZqhCBl4+575YBpubSzvwGu905
         KrO9f1Twm/4HV7j/rvwJ/1l++hsQBxPW2Fl9AR/Wyc2SLefir1bauY5/m+i9xsmjnIvw
         w+ADBoTZinP585lTbGg4M7diXewzqugyuOlq8jHiP2jAa4zMhyXdoHOS9q3YyNh5hBlT
         u3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvrFg58Xr7iAG870iC1XAuJqs0RSBPPYSssQ5mYZXxo=;
        b=txLD6/CiyKHU/llT2VZ/6uzqLEhtXtJouHHUHK0kCcrEBWaXo90gsZbO1H/SdE4aB/
         wk0RFHbJuqEgRlkwnfdxhr2QvXleiMFT3tQAGHvoF4kj+uPDMutXPpyf+DT9m/GMmEvO
         WyL/Yg+9SjcFzcxsg3ErRttp+7g9iFbVTZE7KuTr12hrO2gPOSfmckMbzNnD7IpN6mtG
         seGpt+GOilTIiIg+I1hA6xlS10xcMXMgElLExhZorwzz0DJJOXtDNjyBk+CBk8EdL3ua
         wyqtJj0GcLgU5bl4PvSzaYUNByglWXpvnqO+GJgGKctsokv8KrXvKheyxHD/HwiKHrrU
         zqyQ==
X-Gm-Message-State: AA+aEWazfXWeH1KIfkHpBgj5bLGEXNqPSHYwGYkiI0pWLi2WDlWjrvxD
        chGukytO4FxcKRGaW4tZaGXy+lQuwL/1xA3kvk0=
X-Google-Smtp-Source: AFSGD/UKs/hdAbRBRBaOpV1wODw4xv0GWd5eBW79CPX2dWIkg7rWWmPQpVgmnHx+ftNSuxNfbkf3B5NZcoBqQyxsPLs=
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr12584685wmf.27.1545067125966;
 Mon, 17 Dec 2018 09:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20181216230916.22982-1-andrew.smirnov@gmail.com> <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 17 Dec 2018 09:18:34 -0800
Message-ID: <CAHQ1cqGoMV1EF2kpATvdp=bYueYM5MRSV+Lstf+gv-SZDEWRYw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
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

On Mon, Dec 17, 2018 at 3:01 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Sun, Dec 16, 2018 at 03:09:13PM -0800, Andrey Smirnov wrote:
> > Lorenzo:
> >
> > These are patches fixing things pointed out by Bjorn in [1] and [2] as
> > well as something I noticed while giving pci/next branch a try (#endif
> > placement). Hopefully this is at least somewhat helpful.
> >
> > Thanks,
> > Andrey Smirnov
> >
> > [1] lkml.kernel.org/r/20181214203828.GD20725@google.com
> > [2] lkml.kernel.org/r/20181214203042.GC20725@google.com
> >
> > Andrey Smirnov (3):
> >   PCI: imx6: Fixup Kconfig and #endif placement
> >   PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
> >     imx6_setup_phy_mpll()
> >   PCI: imx6: Make fallthrough comments more consistent
> >
> >  drivers/pci/controller/dwc/Kconfig    |  4 ++--
> >  drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
> >  2 files changed, 21 insertions(+), 12 deletions(-)
>
> Andrey,
>
> please follow-up Lucas' remarks and submit a self-consistent patchset
> that I can apply on top of my pci/dwc branch (where I removed your
> previously queued patches).
>

Sure, will do.

Thanks,
Andrey Smirnov
