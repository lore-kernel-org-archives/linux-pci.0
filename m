Return-Path: <SRS0=h2G5=PB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4586C43387
	for <linux-pci@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E34421721
	for <linux-pci@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kRDf7uuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbeLXJ1y (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:27:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55433 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLXJ1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Dec 2018 04:27:54 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so15210491ith.5
        for <linux-pci@vger.kernel.org>; Mon, 24 Dec 2018 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HPezM66pVmxTxhKD/0frKbX9UwCxSC89V6zm7ebpruo=;
        b=kRDf7uuyvhxEj23tQDxxx5PSLRBVG75DFCkp4boAk779KVCLjsmp8T5E4bqR925SG+
         Brc85PzYQTn8TISAkfc4AMLLHQRUWBcJsl1CibxgyojE2PnuvyvpnbHOf0JsyPtNEJTA
         ZOfkqEKx5yO3OMpE/IoqcD0gaD5qZyTb2NZS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HPezM66pVmxTxhKD/0frKbX9UwCxSC89V6zm7ebpruo=;
        b=G1kqAwCHjAto5IzY2FTTOXf6L4hdJ5Q7H4hBGGSzY5a5CO7IQXUd5Oz0kOstcF3I8Y
         qP8yklh3NsZNMAZsZoJzXtbKsZRDzNWjsHNLcNANt6IlRd1ESm1wODrlvqHd1I3XgprK
         PcpcsGidnBCW2ExEV1PKew4Vw0WoHT8lJC4HwNdlQecFtC0cAKxU1G7PVfutcemcLg+p
         uzWaZQwwxCB9zPryH07a/vkO16XEyWqask6NZYwsIK3mBldUkOziDDTtZDS5mB17NoJ7
         rozSWDcKnUr6j+nSgcIP0rXi4GCvC60atHzGm1ww7oCUCvl6HFmi0WcIYcDUt1d10mqh
         9ZDg==
X-Gm-Message-State: AA+aEWYQc4CQXCZ1Rm8EB+0r5zOY1fCkCc8z8JRNDrAHMNPytxWOx03r
        +Wsh0o01+vOxZfo8s8pM8Cc6SJkoZykliT3JfF9MBg==
X-Google-Smtp-Source: AFSGD/UaXnsZF+nOGv2w6ZnXKGo/qDe5JpIzakfyj+ieSWvhTg5F+o38zlITQJNxRHNdK89M6RCrgpGr6B+I0J6DG7Q=
X-Received: by 2002:a02:85ae:: with SMTP id d43mr8113309jai.70.1545643673277;
 Mon, 24 Dec 2018 01:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20181222090720.19234-1-okaya@kernel.org> <20181222090720.19234-4-okaya@kernel.org>
 <20181222164013.2l7etklpxjrrobnm@wunner.de> <CAK9iUCNkQR=bUhBPYp_3kr6fo7Y0Jtko=BSjU4QozuOs9mA+kQ@mail.gmail.com>
 <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
In-Reply-To: <20181223171501.4hwqu6wn4jzwrcmn@wunner.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 24 Dec 2018 10:27:28 +0100
Message-ID: <CAKMK7uGcqZA7ZXNhmd8mwhho9wxobAkZdhknaWXF6wAz9rsRjw@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Sinan Kaya <Okaya@kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 23, 2018 at 6:15 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sun, Dec 23, 2018 at 02:00:15AM +0300, Sinan Kaya wrote:
> > On Sat, Dec 22, 2018 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
> > > > This driver depends on the PCI infrastructure but the dependency has not
> > > > been explicitly called out.
> > > >
> > > > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > > > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > >
> > > This series doesn't have a cover letter so it's unclear to me through
> > > which tree it's supposed to go in?  Each patch through the individual
> > > subsystem tree or all through the same tree?  If the former I guess I
> > > could push this to drm-misc...
> >
> > Feel free to apply individual patches independently. Let me know which
> > one you applied so that I can drop them on the next rev.
>
> I've realized only now that this patch fixes fallout of commit
> 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> which is part of Rafael's acpi pull for v4.21.
>
> Usually such fixes go through the same tree as the offending commit,
> so I'd expect Raphael to pick up the whole series and forward it to
> Linus in the second half of the merge window.  I'm not sure if that's
> how it'll play out though given the holidays.

Yeah, best to get this merged through the tree that broke things.
Acked-by: Daniel Vetter <daniel.ffwll.ch> for that.

> Additionally, drm-misc is currently in a somewhat confusing state:
> Normally fixes targeting v4.21 should have been applied to
> drm-misc-next-fixes for the last 2 weeks, yet no new commits have
> been applied to that branch since December 5, but plenty of stuff
> that should have been applied (various fixes and a MAINTAINERS change)
> went to drm-misc-next instead.  So it looks like a lot of folks picked
> the wrong branch and drm-misc-next is now a mix of v4.22 features and
> v4.21 fixes.  I think I should rather not add to this mess before a
> drm-misc maintainer has had a chance to sort it out.

If a patch has been misplaced the only way to fix it is to cherry-pick
it over. Hence no need to wait for maintainers to sort out anything if
you have patches for drm-misc-next-fixes, you can't make it worse :-)

> I'll be sure to keep an eye on this though.  The fallout addressed by
> the patch is mostly confined to randconfigs I think, so waiting a few
> more days probably won't hurt much.

Agreed.
-Daniel
>
> Thanks,
>
> Lukas
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
