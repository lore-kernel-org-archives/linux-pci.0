Return-Path: <SRS0=uRTt=SQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54E5C10F13
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A856420850
	for <linux-pci@archiver.kernel.org>; Sun, 14 Apr 2019 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Zmrvja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfDNSse (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:48:34 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39823 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDNSsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 14:48:33 -0400
Received: by mail-it1-f193.google.com with SMTP id 139so23364040ita.4
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2019 11:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRReejV+ReKMaBqAcE6qclju3Gg7BJViOL4seQmKp+E=;
        b=F7ZmrvjauiZ1NPSMtrpXu+JECS1yvCIev4QuTOxO2RJ3ZsASMYc3Un+RvrtiMarZVF
         2pfTD8JAsQUzjIORjQ6+PKKpmjKFZdQNd90FUfGdQVSBbuPAk3O9Ct4haioBrNKaz9ar
         n2k1aijl6sVy3yUVDZ9jHE2bpjzhHz2L5RxI17nVi8Qb2cnzgpBNOYwIhySn30tDb7du
         k4m6qK57HXkjSsVEwVqqm/y5qOsJl6j4sd+REFFCQIBJYrRDyBqCAEKJYv2MZGCdgIoj
         Xj0lJWDGGJPN9sQj5I4+Pld7m4PfbD18TzwQIVNRoCtG/wX477wakmZ5AAskFRg/v2y8
         uZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRReejV+ReKMaBqAcE6qclju3Gg7BJViOL4seQmKp+E=;
        b=WuRm05uGBwKqQpq2zydmi5LIzoUbhtge01qY1WzOfB0c2x8QNfGcQqxp9WORRCMGF0
         SS16vFgMEzsV1wbOxalJtU9+UwhmfC/5YKn9XL867LTZlcgCNGujzbsqvPkkCMnZBW3Z
         5lYUWKYFc5BkBa+ojeUo9COCwtY2Nt3IeyCyRTjY++prokJPbXUXsncPXO5Eo9LxikNh
         yUcF6fwvHZwmE1iebIxkpb69bfZ3qPrJcKxyDgqtWsVLvh+wEaFvbaU7A5tiPRSNRZR1
         bGU3n0O44BbBAWi8pxWJQppCV3GtPAMKUZqORjX3DvyxEjZjkTfOOqKwmEVRZ2jX7il9
         lvCw==
X-Gm-Message-State: APjAAAXyiDhxDP0DgHekY2JLZoxd8d5Eh20FDrsZjuze5i4oWZS81VFz
        0hrNNVykP02rX/OXetQh7BTehquahVoIcx3U1GLXoQ==
X-Google-Smtp-Source: APXvYqyw4kri6+yTWT1FKLeiT3ZEn/l6XQw06DLod+pofxBDrzBw9X40mubvgeABqj9DWu+I7EsR6SDk3zz8XaX9zMY=
X-Received: by 2002:a24:9a86:: with SMTP id l128mr20858791ite.126.1555267713000;
 Sun, 14 Apr 2019 11:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
 <20190401042547.14067-12-andrew.smirnov@gmail.com> <1555086376.11529.40.camel@pengutronix.de>
In-Reply-To: <1555086376.11529.40.camel@pengutronix.de>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sun, 14 Apr 2019 11:48:21 -0700
Message-ID: <CAHQ1cqF+8s+oDHqd+g_9b5hbOH2cNQpR0YpWeovFMWEcqUfdJA@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] PCI: imx6: Replace calls to udelay() with usleep_range()
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 9:26 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Sonntag, den 31.03.2019, 21:25 -0700 schrieb Andrey Smirnov:
> > In both cases udelay() is called in non-atomic context, so there's
> > really no need to use it there. Change the code to use usleep_range()
> > instead.
> >
> > > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index c9431a8a7ca1..3f13022991ec 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -167,7 +167,7 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
> >               if (val == exp_val)
> >                       return 0;
> >
> > -             udelay(1);
> > +             usleep_range(10, 100);
>
> I'm not sure we want to change this. This is dragging out the timeout
> considerably while the really short delay, together with the low number
> of max loop iterations suggests that the condition is usually met very
> quickly.
>
> Maybe this would even want a change in the other direction by replacing
> the udelay with a cpu_relax to speed up the condition detection and
> stall the CPU in device memory loads, instead of having it spin in a
> tight inner loop.
>

OK, will do.

Thanks,
Andrey Smirnov
