Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7EBC43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE67D218AE
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 01:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrQZzQQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfCABQg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:16:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53177 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfCABQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Feb 2019 20:16:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so11051938wml.2;
        Thu, 28 Feb 2019 17:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i4ygx22LOUdRqlYNAEC5fBDNS9ew8UErJ+sc47ljCzk=;
        b=qrQZzQQfod1pzn+QvcKzNCVyRV8cQ/0eHZipvWWvznPEp6hZakMcfyiq9cT644tC6C
         Pza/Sx1CTeP0wiHLZK97Gyue6Lsnq2UlBpmDPCQLkOGknE4rW7XtGdbes793rx9wpsJx
         ijqnuGikUDqeLxxsfnhtJdh85wasadGh/yHOfBLpg/0dzz/45CtiIqSojMy255GzXbCV
         Fl6Ss/xVuKT34yM3bknZmGLj51CYq5g54dNWhdDm00jHICearBI91n2WC7WGbdYfBGHH
         4DJU4lwYQibc5q/GBUpf1dIosQ4pHmMzqiI8H6cwS5Cp1Y+Q5IgbFV/JzMx5xw7+Xnra
         iRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i4ygx22LOUdRqlYNAEC5fBDNS9ew8UErJ+sc47ljCzk=;
        b=edAIQR7ddZ30jOS9+G4WBBxKQ4MqKWOb7qykRI7OyDp1NmFTvlxnnUCqJ7u3U/TAxo
         ftcICsjXG4mVwCE0HQfXDvCmirWD9WE3WRCx3u5XleRwDpElBVv6tZB0kk7kDiiBPwxL
         uW3fl2H72DpewTmDszAekAu0FezNi8wm9ShvQSxSp7pIsl5f2h0pHArBXtNxXyx9ujty
         z6JaiNIZ9gQh1J4CunA8HR+4Q20unWx1A1gS7Xzm54d/iGf/jNkJxFpBPKfSekV0ZqjB
         KHQElvDG8z2+pNL/l9kbgKe+9h5CEDC3cIGnmFo/HRQYTtdyrJ0ZDqIVH2sIdn8eh4Cl
         WaxA==
X-Gm-Message-State: AHQUAuZR0YXa/NsaeLflVMtf154xjBqVFivz8pC3evUTto5YwOJPjC11
        Atce+l8N0j/N+edbWWmBRMI18Xrn9PjO7u/nWCA=
X-Google-Smtp-Source: APXvYqzMRqxZNnv8gdAZk8UO9eAVdBhnWbWJwhsYufyeZXqLrDnA06Cf49zdyH59MrtbQ4KNwiYahEXbR2kfr6zvrmM=
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr1478052wmg.144.1551402993002;
 Thu, 28 Feb 2019 17:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20190212015108.16952-1-andrew.smirnov@gmail.com>
 <20190212015108.16952-3-andrew.smirnov@gmail.com> <1549964166.2546.21.camel@pengutronix.de>
 <1551389037.6059.3.camel@impinj.com>
In-Reply-To: <1551389037.6059.3.camel@impinj.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 28 Feb 2019 17:16:21 -0800
Message-ID: <CAHQ1cqHfFivDSwt2Xo7n8qnrnZxSuzmx0he3irYg6Oxp_g=--w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: imx6: Add code to request/control "pcie_aux"
 clock for i.MX8MQ
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 28, 2019 at 1:24 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
> On Tue, 2019-02-12 at 10:36 +0100, Lucas Stach wrote:
> > Am Montag, den 11.02.2019, 17:51 -0800 schrieb Andrey Smirnov:
> > > PCIe IP block has additional clock, "pcie_aux", that needs to be
> > > controlled by the driver. Add code to support that.
>
> This breaks iMX7d.
>

Ugh, my bad, sorry about that.

> > >
> > > @@ -1049,6 +1059,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >                     dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > >                     return PTR_ERR(imx6_pcie->apps_reset);
> > >             }
> > > +
> > > +           imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
> > > +           if (IS_ERR(imx6_pcie->pcie_aux)) {
> > > +                   dev_err(dev, "pcie_aux clock source missing or invalid\n");
> > > +                   return PTR_ERR(imx6_pcie->pcie_aux);
> > > +           }
> > >             break;
> > >     default:
> > >             break;
>
> One can't see enough context in the patch above, but in linux-next this
> section is under
>
>          case IMX7D:
>          case IMX8MQ:
>
> It's being applied to imx7d and not just imx8mq and so breaks because
> imx7d dts files don't have this clock.  Not sure if this is a bug in
> this commit or some kind of merge/rebase mistake.
>

This is just a regular bug, I spaced out and missed the fact that this
path is shared between the two. I'll submit a patch moving "pci_aux"
clock request into a i.MX8MQ specific patch shortly.

Thanks,
Andrey Smirnov
