Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F798C43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1E72081C
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 20:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e60ZmAHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1E72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeK2HIY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 02:08:24 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeK2HIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Nov 2018 02:08:23 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so3714825wmh.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Nov 2018 12:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fz8LddaQEjkCkaTacFhWa7LpG1SU3Q3Y2YS19z/iptI=;
        b=e60ZmAHSXoOo7rzaOHqsGVQpBKm0Zhn7X4hKEyqTi3+hmpasLIYWirmzHgWUV8359L
         Y2/6jfXeCW7LNeUhgYHXUvczG2iTVDpnOLbv3baxZRuXjsrS/CishMWJJ51GmdOnnqCS
         8i0/emx7gTBT77Bet3hWZUSPPSsWvzuo0NMhFMZR2X1Rss7k7DZT3NT0diHFwdHuE4KK
         pPe0VtF3L0Zd78d1F2pn91u83DyiJFN3twa5xepcwjTBKoAN9rW8O8MwAID57lej/VVz
         vkELqnyQiEDx9X2VISxWNHzJEbk3Hl3c2OiIvQDaiZLYis8XaAf0IYTqZZTdXgvWymLA
         N4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fz8LddaQEjkCkaTacFhWa7LpG1SU3Q3Y2YS19z/iptI=;
        b=b47e4xvt9zhoK0Q0VQEkGdn/YOXkU1fq+kOOr+JFNQzO32OG6aUVLOVOKRfMosIcm0
         h/7LFh8GAf6ErIuag273QSuM/4gVJx0Xfly0PlTvPjJ5TBooBA4AK0ZrnZ0RpVGMv+vs
         2zD/gMfSQ4FzcJXtjPI0hh5Zj1rjA+0AqWWRh/aUnP1LLbnBjoAUcGF+M1QDb4Do+JTV
         qZpSs4nbUD/CzGt3zHfYa+U/1WhWz9oI/x+rPwD0EK09JPMs5+Wzn7twqjacgBquOM1J
         jOgaUjQPsyKAnbHNkRNwQF3aDO3rZ8KpJiKzs1rG2rXF+8KhxGD8OY9Jo69bTKY66QNj
         Fm5A==
X-Gm-Message-State: AA+aEWZGMA7pI6/z5PNiH5TcSEW1KT/HnmUCwJ3GQgbWOLRWHaUYsB1P
        jaxCEznK4pXaJ0Yp1WRL6+veBjUgZzD33ywZRbFA
X-Google-Smtp-Source: AFSGD/UfSH0fjxEGSSL0MTRJDlb12Z0SsVAD6SzCauM8lX7LQj5lIHliAMGXVsPui8Cca7ozOACTFwOyIrtKz+R7Dzs=
X-Received: by 2002:a1c:4046:: with SMTP id n67mr3860058wma.123.1543435532706;
 Wed, 28 Nov 2018 12:05:32 -0800 (PST)
MIME-Version: 1.0
References: <2960808.4YCFhzuD0k@aspire.rjw.lan> <1675729.7aZxPkvRd8@aspire.rjw.lan>
 <20181127202514.GB112381@google.com> <3669527.fZMjlSGqLg@aspire.rjw.lan>
In-Reply-To: <3669527.fZMjlSGqLg@aspire.rjw.lan>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 28 Nov 2018 14:05:21 -0600
Message-ID: <CAErSpo476FzJJ_OMGiPbR5SkJ2-41zR_Jy25Hhnw-dA51V5i6A@mail.gmail.com>
Subject: Re: [Bug] SD card reader in Acer Aspire S5 broken in 4.20-rc
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, ptalbert@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 6:13 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, November 27, 2018 9:25:14 PM CET Bjorn Helgaas wrote:
> > On Mon, Nov 26, 2018 at 11:37:20PM +0100, Rafael J. Wysocki wrote:
> > > On Monday, November 26, 2018 7:03:58 PM CET Rafael J. Wysocki wrote:
> > > > Hi Bjorn,
> > > >
> > > > The SD card reader in my Acer Aspire S5 doesn't work with 4.20-rc.
> > > >
> > > > Here's what lspci -v says about it (in a bad kernel):
> > > >
> > > > 02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5209 PCI Express Card Reader
> > > > (rev 01)
> > > >         Subsystem: Acer Incorporated [ALI] Device 0704
> > > >         Flags: bus master, fast devsel, latency 0, IRQ 35
> > > >         Memory at d9001000 (32-bit, non-prefetchable) [size=4K]
> > > >         Capabilities: [40] Power Management version 3
> > > >         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
> > > >         Capabilities: [70] Express Endpoint, MSI 00
> > > >         Capabilities: [100] Advanced Error Reporting
> > > >         Capabilities: [140] Device Serial Number 00-00-00-01-00-4c-e0-00
> > > >         Kernel driver in use: rtsx_pci
> > > >         Kernel modules: rtsx_pci
> >
> > Thanks a lot for bisecting this!
> >
> > With a good kernel (v4.19 or v4.20-rc with 17c91487364f reverted),
> > would you mind collecting "lspci -vv" output, the dmesg log with
> > "pci=earlydump", and the FADT dump?
>
> All of the information is attached to the BZ entry at
>
> https://bugzilla.kernel.org/show_bug.cgi?id=201801

Thanks!  I hope Patrick has a chance to look at this.  Per the
bugzilla mentioned in 17c91487364f, it fixes a problem with a custom
proprietary PCIe device, and there's a lot of good detailed analysis
there, so hopefully we can figure out a way to address both
situations.
