Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77049C282D9
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6123B2087F
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 08:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAaIAs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:00:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42067 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaIAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 03:00:48 -0500
Received: by mail-qt1-f196.google.com with SMTP id d19so2488996qtq.9;
        Thu, 31 Jan 2019 00:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBNBDT1LiiLRanuMOG7grYKDhg9zCn26KY0jpTT73kI=;
        b=tvy0GTzi+HN1UzewF1OK+I5x5NHkBY6oCjhhiXeDjB36+V1E8LMKm4NuI5eb5oQHRf
         yVeiO00AnDGVi4q0bmmD0tzt5CEduk88ULIYUnZgk5WCz9iuN8YlNUTkgOce2agSWiX6
         oLq2dSq5nRukXxl/dL0Omq/fxhHg1lchP7PMj7MAG5I0cgjYOefSb1b2v3e39CyQ5yjl
         DYklKE5xo4Dc3ZRgAIqOzRVnnvFIMvgwRuWt4grR0Qe8rshD6Bd6fYf9/TyY8zMQuzC8
         ls1UcIThcF+fEfSlxL/bY0UR5t1EJeHvIKPCy4v+jWWXaNF/Lsj3uQv+RgkT6MmzB4+/
         IL1g==
X-Gm-Message-State: AJcUukc8JcR4Xff0n19vWTb7uZ8sbKzylaH0rnb8mZFTxTa27zfZu2Gh
        a/vBqlgtErhYBKknWo4K+oPaj8dIApQujb5WdYpfsQ==
X-Google-Smtp-Source: ALg8bN6FefpahWBFSjDrFIrH4tu4OMDtIQmPbNKO7/+Ob/8mVyRl4d6H9o2RN5faLFkN8Pl1dLVtPiGfKkVinrA9smw=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr32585171qtr.319.1548921647369;
 Thu, 31 Jan 2019 00:00:47 -0800 (PST)
MIME-Version: 1.0
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com> <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com> <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
 <20190130230604.GM229773@google.com>
In-Reply-To: <20190130230604.GM229773@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Jan 2019 09:00:30 +0100
Message-ID: <CAK8P3a3tLtCee6p38iXNp5Amktguucgb23UcQFF-Z8Vn8zTgZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Olof Johansson <olof@lixom.net>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 12:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 30, 2019 at 11:08:04PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > > > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > > > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:
> > > > Purely for my information:
> > > >
> > > > Testing on a lot of devices here shows a huge improvement towards stability.
> > > > Is it possible to get it merged sooner?
> > > > Does "queued for 5.1" also mean that backporting to stables only will happen
> > > > at 5.1_rc1 release?
> > >
> > > Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> > > (so effectively you will get them in v5.0 and propagated to stable
> > > earlier), I do not think it is that urgent either though, let me handle
> > > that.
> >
> > We can take them through the soc tree if that's easier, but
> > going through Bjorn's tree is also fine.
>
> I have the following on my for-linus branch and I'll ask Linus to pull them
> this week, so they will appear in v5.0:
>
>   b8b592a3a8d1 ARM: cns3xxx: use actual size reads for PCIe
>   b3a32f359397 ARM: cns3xxx: fix writing to wrong PCI registers after alignment

Ok, thanks!

> Neither is currently marked for stable, but I'll add that if you like.

Yes, I think that would be good, along with

Acked-by: Arnd Bergmann <arnd@arndb.de>

     Arnd
