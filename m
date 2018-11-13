Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF1EC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D297A21582
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsQPpXPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbeKNBht (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:37:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45432 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKNBht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 20:37:49 -0500
Received: by mail-io1-f68.google.com with SMTP id w7so1528958iom.12;
        Tue, 13 Nov 2018 07:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSIJ+oKbA1WotNsQCWWl1qO+2qp88o+N6SAZHL37ang=;
        b=qsQPpXPjUXnbRphMNbROnbtE9gQi4UUn228kO/kkx0bY+irAtFmilzjHummMoTs6oj
         DSDRonAziEwiO7Det4zBfHqG8AsE2pX4ZaAO0MV6qaQjImLCARdu1ExV0JzDdRRh59oU
         usb0OX7ZQ5Wq9X/mPImhd58inZXEYEShngUIpYkevV4v95AYwG8khZRohPKiBPd2eD7D
         ZbVZLE8AsAyOrUbrauDwrrgA8is9kOHggI1AFZ2jJ4IVzLx7LqT/zyAssS96eR8xDOSU
         /y1m+/4tY+ovfkS39NCD0aLTJFldJncGypNJnfoEyzhHQm3rI/IXdj2uCOJEcwF28s7Y
         TBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSIJ+oKbA1WotNsQCWWl1qO+2qp88o+N6SAZHL37ang=;
        b=as+Nz06lMrqieT7kUQNXukMNf4GzIEfvMF6tGVgRFlNFprURdVqrSHsLnwwnULQ8Ps
         VfPg/EEtaNVmRNKTxPSqXxR3hCCG6uO6yIHytzj0ml5ht4tZg2ogqjR9KJ67kSOJ4vsE
         6XwnmT0M/vQ/jmDRnZ+b3sye2PLmvYYnVF9PU+mppjpMsCkMBDutSKwJZGzL7Tu5KWtV
         Za+HCfY2Z6G0UG4X1qZfr323I54O/kimwP9dEF7pCn0xhhO/A1sPkDRh49dw65Al+IA0
         RPNQbjczJ2zY72AaHVGWz8Z81vH3X54p7EE/RfIHZuy8jOJslcm8VFckg2005QjWmWyn
         hJRQ==
X-Gm-Message-State: AGRZ1gIdgypPTU735dTTlhWwFScPEdtHCYYzEONyqMoQb5/Xd4QBr++Z
        IKKn+nuno/jLrDty/oY6BvatnY/jCn6jKxqZ0Ws=
X-Google-Smtp-Source: AJdET5cPF4hn5erMbhrxRplgJ0U/+CxA+U/9a/+PDCd9eWraM44pGaKcFABuoj366kqxVRnCGQroxW9DCXw6OmtWg9U=
X-Received: by 2002:a6b:d117:: with SMTP id l23-v6mr4401302iob.146.1542123550491;
 Tue, 13 Nov 2018 07:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com> <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com> <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
 <20181113114020.GV2500@lahna.fi.intel.com> <CA+CmpXt1cfqjz94=WsggKpNCUw3761-cewa_HTa0ETcYK7o+Hw@mail.gmail.com>
 <20181113152038.GD2500@lahna.fi.intel.com>
In-Reply-To: <20181113152038.GD2500@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 13 Nov 2018 17:38:53 +0200
Message-ID: <CA+CmpXteN1PJEHMV8rvfeBXK6Eb4z6BgZwa8Ojavi1y9pKN-jA@mail.gmail.com>
Subject: Re: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        David Woodhouse <dwmw2@infradead.org>,
        baolu.lu@linux.intel.com, ashok.raj@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        jacob.jun.pan@intel.com, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, lukas@wunner.de,
        Christian Kellner <ckellner@redhat.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 13, 2018 at 5:20 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Nov 13, 2018 at 04:42:58PM +0200, Yehezkel Bernat wrote:
> > On Tue, Nov 13, 2018 at 1:40 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > On Tue, Nov 13, 2018 at 01:13:31PM +0200, Yehezkel Bernat wrote:
> > > > On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
> > > > <mika.westerberg@linux.intel.com> wrote:
> > > > >
> > > > > > Just one point:
> > > > > > Have you considered the option to add this property per (TBT?) device?
> > > > >
> > > > > No. ;-)
> > > > >
> > > > > You mean that one device uses security levels and another IOMMU? I don't
> > > > > think it is possible without having some sort of table in the IOMMU
> > > > > driver telling which devices it needs identity map and which not. Also
> > > > > not sure what would be the benefit?
> > > >
> > > > For performance, of course. If some devices are considered safe (maybe a list
> > > > communicated by platform firmware), the kernel may decide to configure them to
> > > > passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
> > > > wrong.)
> > >
> > > At least I'm not aware of such an option. Windows for example enables
> > > IOMMU for everything and I think macOS does the same. In Linux (with
> > > these patches) we put all internal devices already passthrough mode so
> > > things like internal graphics should not be affected. eGPUs are
> > > different thing, though.
> >
> > So your point here is "currently we do the IOMMU decisions system-wide; we can
> > always add a per-device attribute if needed"?
>
> Well, let me elaborate a bit :) I think it is possible to put certain
> devices into IOMMU passthrough mode even if they are "external" but I'm
> not that familiar with the guts of Intel IOMMU (Baolu or Ashok are the
> experts). Assuming it is possible we could have a table or similar in
> the kernel that can be used to identify devices that are allowed to be
> in passthrough mode.
>
> I'm not sure if it can be per-device sysfs attribute because at the time
> the PCIe device is enumerated it is already put to its IOMMU group.

Good point. But I thought about per-TBT-device decision. If the platform is
configured for IOMMU+"user" security level, while approving the device the user
may want to set also in which IOMMU group to put all the PCIe devices connected
to it. The same goes if kernel is supposed to auto-approve such devices based on
an internal table. The point is that we can think on a configuration where the
devices aren't tunneled yet and the decision about IOMMU can still be changed.

As you mentioned this isn't the common configuration anyway, so it probably
doesn't worth all this hassle.
