Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906ECC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 11:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5823620832
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 11:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeK1WZ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:25:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45292 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeK1WZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Nov 2018 17:25:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so23128050ota.12;
        Wed, 28 Nov 2018 03:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAdBPut4U254Qc3OeASQF1V+oPJFPrXK2/GMxPl77rI=;
        b=pDC6Rcg4L6mhtbokcpRbrZ+BuBgevt6LoxIoxbczVHFRfeP/S+r+10rxoxDWkDi8Ei
         XtmBRwUmJLol0z5QpuUKJvX8rEnP+/e/NfCwbx9tscgrKwpAJvElJ5tm2VimfRGHe4/l
         u0oVkG3HAPSbQoewc8pxsE8r7Kyjm2aNYwRWlAFSt/ycSjk5UcYypi8wr3gWe+3IXNm5
         L9X117pBvWd7MXpEDFw3waFWwa0Q2D4hRa2u0aUQqXg6BkylRkO9HQxRagif/9/Xyr1j
         DHH/zErI1xYOv/mzfhgJIqrIlOlxB+I/vRBlP+h6I7droxCirioThocap8J/ht5wYcMv
         6cSA==
X-Gm-Message-State: AA+aEWZqeI6HS6Vp7+SbnfbpHyE/J/+9IOOBEoPuVCUZEWdUAfGALMKZ
        S5HQt+ymgYrj2W8Tx7yhy8zniVS0fQyQTD+oTwg=
X-Google-Smtp-Source: AFSGD/UZMKrzCCPyP9MM04AMyahQ7oCK2v0XbIo7T4TOYqMZKEh5E9IfLtaDutRBybj93pGoKr8T2OkLZD6utL0s9NE=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr19156172otq.119.1543404279011;
 Wed, 28 Nov 2018 03:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20181126111526.56340-1-mika.westerberg@linux.intel.com>
 <20181126111526.56340-2-mika.westerberg@linux.intel.com> <CAJZ5v0he4BmyJ97=uwVpJtojhe0f5pTq81LBdAQG6RFy6edKrQ@mail.gmail.com>
 <20181128105415.GV2296@lahna.fi.intel.com>
In-Reply-To: <20181128105415.GV2296@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Nov 2018 12:24:27 +0100
Message-ID: <CAJZ5v0g5h42G-Svc_DZafucb0SyNQGE2ZhnnKnJ5UTjCWCMgxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI / ACPI: Identify untrusted PCI devices
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, ckellner@redhat.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 28, 2018 at 11:54 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Nov 27, 2018 at 06:14:43PM +0100, Rafael J. Wysocki wrote:
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 8c7c4583b52d..4bdad32f62c8 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -31,6 +31,9 @@ static const guid_t prp_guids[] = {
> > >         /* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> > >         GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> > >                   0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> > > +       /* External facing port GUID: efcc06cc-73ac-4bc3-bff0-76143807c389 */
> > > +       GUID_INIT(0xefcc06cc, 0x73ac, 0x4bc3,
> > > +                 0xbf, 0xf0, 0x76, 0x14, 0x38, 0x07, 0xc3, 0x89),
> > >  };
> >
> > One observation here.  Note that I really have no strong opinion on
> > that, so this is not an objection, but IMO it is fair to make things
> > clear for everybody.
> >
> > So this causes the External facing port GUID (which already is the
> > case with the Hotplug in D3 GUID for that matter) to be practically
> > equivalent to the ACPI _DSD device properties GUID.  This means that
> > Linux will consider a combination of any of these GUIDs with any
> > properties defined for any of them as valid, which need not be the
> > case in Windows.
> >
> > For example, since the ExternalFacingPort property is defined along
> > with the External facing port GUID, Windows will likely ignore it if
> > it is used in a combination with the Hotplug in D3 GUID or the ACPI
> > _DSD device properties GUID.  If the firmware combines the Hotplug in
> > D3 GUID or the ACPI _DSD device properties GUID with that property,
> > Windows will not regard it as valid, most likely, but Linux will use
> > it just fine.  In the face of ASL bugs, which are inevitable (at least
> > just because ASL is code written by humans), that may become a real
> > problem, as systems successfully tested with Windows may not work with
> > Linux as expected and vice versa because of it.
>
> That's a fair point.
>
> > >From the ecosystem purity perspective this should be avoided, but then
> > I do realize that this allows code to be re-used and avoids quite a
> > bit of complexity.  The likelihood of an ASL bug that will expose this
> > issue is arguably small, so maybe it is not a practical concern after
> > all.
>
> One option assuming we want to prevent the potential discrepancy you
> described above is to add ACPI specific property accessors that take
> GUID as parameter. Then it would only look properties inside that
> particular _DSD entry. I'm not sure if it is worth the added complexity,
> though.

I'm not sure if this is worth the extra complexity either, which is
why I have no strong opinion here. :-)

Maybe you can add a comment, next to the prp_guids[] definition, to
explain that the GUIDs are made equivalent to each other in order to
avoid extra complexity in the properties handling code, with the
caveat that the kernel will accept certain combinations of GUIDs and
properties that are not defined strictly speaking without warning, but
those combinations of GUIDs and properties are not expected to be used
by firmware and they should be caught by firmware validation tools and
reported as errors anyway.
