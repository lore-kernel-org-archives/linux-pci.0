Return-Path: <SRS0=NgI7=SB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95A6C43381
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 13:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4FD2146F
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 13:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YFyUHNT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfC3NFP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 30 Mar 2019 09:05:15 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:37606 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730799AbfC3NFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2019 09:05:15 -0400
X-Greylist: delayed 461 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Mar 2019 09:05:13 EDT
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-05.nifty.com with ESMTP id x2UCroh0022231
        for <linux-pci@vger.kernel.org>; Sat, 30 Mar 2019 21:53:50 +0900
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2UCrNxw007752;
        Sat, 30 Mar 2019 21:53:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2UCrNxw007752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553950404;
        bh=2bJ6Rz8EsFR+S/vsYNns82RctdtVzrPs2oGgHbgn+l8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YFyUHNT1njYCY4ZzQroCC8CKNOgwEcHdCrfLvaddXQrQUkCiWpU69DmSbIGqXaenR
         1iH19hsN9Hvd1uQGHD7DtBo+WGxr3VjNl1DCjqzcAo6xmeITixpeEgYFwtfNsRYb0L
         lR0su/USKtErkVB4fRewoCGqCo8W7QDUKmnjV0AHYMSK7mde95AROp940vVf10H1jp
         PXhz0ZcMo/kh8pXTZ/38zOnEd7WfeWR20uzJAORHCfE8hbN0wxRDGUX+8hd7X7RGDI
         AL0nUZpkRkV5IaqYLSa2cvbyKDPbQD459k3rTFWUFjXuHtJHhPs+b9SlyJA5Taguyg
         1oxMKGD8ocRRQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id w13so1870212vsc.4;
        Sat, 30 Mar 2019 05:53:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWIfcBHFqyF/dHGVqy5aSGf8ns23ueV42R1YX2uYXhpNqhdrubs
        /bhXokJFl6o7AXFVbqcigJ+ny5dyrCp0qmfLGCY=
X-Google-Smtp-Source: APXvYqxG1xe6Q0IBtKRSagLOMjCqZIMaW/ypjHUgEzQXmw9IPRtIaKQHi2wMyryG/cURnQYPx9GJGU0QEkmMpUSDpkc=
X-Received: by 2002:a67:7f44:: with SMTP id a65mr15672913vsd.179.1553950402678;
 Sat, 30 Mar 2019 05:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190325181425.247227-1-helgaas@kernel.org> <20190325181425.247227-5-helgaas@kernel.org>
 <20190325182608.GS251185@google.com>
In-Reply-To: <20190325182608.GS251185@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 30 Mar 2019 21:52:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKqbb1L4LzofncJsYCUL1iDwUyy6WOTOE0X82ydVPDdg@mail.gmail.com>
Message-ID: <CAK7LNATKqbb1L4LzofncJsYCUL1iDwUyy6WOTOE0X82ydVPDdg@mail.gmail.com>
Subject: Re: [PATCH 4/4] CPER: Remove unnecessary use of user-space types
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 26, 2019 at 3:26 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Mar 25, 2019 at 01:14:25PM -0500, helgaas@kernel.org wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > "__u32" and similar types are intended for things exported to user-space,
> > including structs used in ioctls; see include/uapi/asm-generic/int-l64.h.
> >
> > They are not needed for the CPER struct definitions, which not exported to
> > user-space and not used in ioctls.  Replace them with the typical "u32" and
> > similar types.  No functional change intended.
> >
> > The reason for changing this is to remove the question of "why do we use
> > __u32 here instead of u32?"  We should use __u32 when there's a reason for
> > it; otherwise, we should prefer u32 for consistency.
> >
> > Reference: Documentation/process/coding-style.rst
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > CC: Masahiro Yamada <yamada.masahiro@socionext.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: Andrew Morton <akpm@linux-foundation.org>
>
> I cc'd you folks because you were part of this conversation:
>
>   https://lore.kernel.org/lkml/1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com/T/#u
>
> I *think* the conclusion there was that this sort of change makes
> sense, but I want to make sure.  If it does make sense, I'm surprised
> at how much stuff in include/linux/ still uses __u32 when it doesn't
> appear to need it.


This patch looks good to me.

I still fail to understand Greg's comment in
the referred URL, though.


"__u32" and similar types are intended for things exported to user-space.

This is clearly documented.

Documentation/process/coding-style.rst:

 (e) Types safe for use in userspace.

     In certain structures which are visible to userspace, we cannot
     require C99 types and cannot use the ``u32`` form above. Thus, we
     use __u32 and similar types in all structures which are shared
     with userspace.



I'd be eager to see a document that suggests __u32 and similar types
in ioctl structures.




--
Best Regards
Masahiro Yamada
