Return-Path: <SRS0=MAma=XG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3E2C5ACAE
	for <linux-pci@archiver.kernel.org>; Wed, 11 Sep 2019 11:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E552D222C1
	for <linux-pci@archiver.kernel.org>; Wed, 11 Sep 2019 11:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3IP81L3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfIKLtI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:49:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33367 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfIKLtI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 07:49:08 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so45106410ioo.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2019 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pt9n59Xh89lcvDG7F3KB+ad2c5bCRWrFgBU89mDdIF0=;
        b=s3IP81L3ko+a35IbBsxOpDaYKcaLR+XsiyXdS+gACPhd3Zg9tpfEB5s0WqsNCkb/ld
         jzTUe0fr1/fKFvBulJ05ljCkKy7aFniUsx/6UVED3kqEIStfMaB42lhaQZ6EzbV5QXY4
         noCXTdBBYecwqpAwxOla7XRqIqdkiIkbdI/FZx1MdWF6MlBDq+sIMJjoKAK497BZfbez
         lzT/1oSxZ598DrjH0jMYFrrYBNm63v6Mcuam5ZhavAkwpykZp+yxR3QJPKxFGYHrVHBt
         7mJJp2Xc2WiAbX6JH4hmNJXZgnvgemVDhBPkYw7uHXbKMiIOu/deHKuCywSvZJdYqLHk
         YIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pt9n59Xh89lcvDG7F3KB+ad2c5bCRWrFgBU89mDdIF0=;
        b=cTLmoFfjSR7kzc+hrdNsG2WdTfadGSL4BRrfaRSuLE6BUyBF6egYEv+T8Zeue/1UaP
         QSOJSRdHKRCtRWQQTqgCoMyiw785QqSuM54fkiikKjtQ8Cs8971A/piDMwGHStC6yQdC
         nYxSdphx+cMikWlS1gs11yVxG3qPLn6tobLm02RCJyMMHQkhcOhb1ux2ORIlOPMYRrvi
         JqR1gIkhecoe5DecJCz8W1XisU1WgS3o3IrcG9+udrE9oyIGKV8mrnc/Y5JhWhnOW5su
         q07sQETCOYDUZ17ppJwVLl/R/tA2Sek1/r/18/0hBo4Pj0UCrR8cDA3WbRnXt5nQwp/J
         GnoA==
X-Gm-Message-State: APjAAAUr9kDJcR6RD1z0q0Il9rFJ4V2hEksUx54h3q/noK9sE9pzZHeh
        yZbMCAnVESBIzEA/N6zQoRv2mdZIoTy0EQsSK/YEkQ==
X-Google-Smtp-Source: APXvYqxlBQa/pWCmQtM8lPVAXpB2e9g5uT8Bm+hPW3kKFvwwJtOaLE+5YYKw8CrWQllIEI6Nk4MBeu28X+R8MWb0zlk=
X-Received: by 2002:a6b:b213:: with SMTP id b19mr6876408iof.58.1568202545749;
 Wed, 11 Sep 2019 04:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
 <20190905161759.28036-4-mathieu.poirier@linaro.org> <20190910143459.GC3362@kroah.com>
In-Reply-To: <20190910143459.GC3362@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 11 Sep 2019 05:48:55 -0600
Message-ID: <CANLsYkzE+Qnb4v-WQMy1OYQOdwjXhjPAdD7gWnChmVTQNcxs+A@mail.gmail.com>
Subject: Re: [BACKPORT 4.14.y 03/18] drm/omap: panel-dsi-cm: fix driver
To:     Greg KH <greg@kroah.com>
Cc:     "# 4 . 7" <stable@vger.kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Sep 2019 at 08:35, Greg KH <greg@kroah.com> wrote:
>
> On Thu, Sep 05, 2019 at 10:17:44AM -0600, Mathieu Poirier wrote:
> > From: Tony Lindgren <tony@atomide.com>
> >
> > commit e128310ddd379b0fdd21dc41d176c3b3505a0832 upstream
> >
> > This adds support for get_timings() and check_timings()
> > to get the driver working and properly initializes the
> > timing information from DT.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 56 +++++++++++++++++--
> >  1 file changed, 51 insertions(+), 5 deletions(-)
>
> THis looks like a "new feature", right?  Why is this a stable patch?

I thought it was part of 4.19.y but looking at it again I see that it
is there as part of the mainline base rather than a backport.

Please drop.

Thanks,
Mathieu

>
> thanks,
>
> greg k-h
