Return-Path: <SRS0=6VBI=NY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D99AC43441
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549C7223DD
	for <linux-pci@archiver.kernel.org>; Tue, 13 Nov 2018 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP9jrKkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549C7223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeKNAlm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:41:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51552 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732401AbeKNAlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Nov 2018 19:41:42 -0500
Received: by mail-it1-f193.google.com with SMTP id m34-v6so18501887iti.1;
        Tue, 13 Nov 2018 06:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV4rqa3fvX2pFeaOjQTSbx+QYwt27qebk0roPH5fBLA=;
        b=XP9jrKkJExoPBGkUSCClFsXZlBniO/+vA2A+YMPBkQ+s5pP+DtHzVZ7i60Zr2zveqq
         ZEaPcNCDTeXSNT6FkEy6fsbVey4bYqdfifkhldVHcEqrsARBNazDxUgHsI2GovGMTMnp
         JtlcxAuIPcb8u7k8mNB/x+De4PaQnclAIKNl5PGJ1bJTXRQf9K2sQVoQ49Se6h35+m+x
         DPmQ/TRVemtlLtbR7Tu05+MOKwRPQuiq+E5o+sEr/6B97xZItK40fbg4Jm83Vc4Qcbpr
         wmFP8xbux54qhyLAa2xJWY7CN/hfhV6MyYZukDb1lsyfPBtpLXcFryfBj8PmxQ2PAuR0
         9tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV4rqa3fvX2pFeaOjQTSbx+QYwt27qebk0roPH5fBLA=;
        b=YZCKFFrwyt5iOZc9Rql639fT5rfwAUaFOt+iqsKwdUKa131QGnUbuz2MQhctqHl1nJ
         Ov82Jw/vLrrooue3K5W7MdUGTWt6fvFnZ7kppJy8jrBuaB8P6DEp7BRdyH/man/D5nhF
         HT6V6GvByOPp0k2YC03tfVj8477qXTRbZKuoqEymVWxW14I9wPRHEF3yPCkbq6or1uW3
         IV6/1jpQzJGSrmZ2uzsFuI/2P+amxVKcTNuQ638j8zr65999kjDJSySsI3/qpleF5Gbj
         HsLAEc6cKdVxwRJ7FwkJInAWbQ2BQiIVRpEtP9dhWfsnMEAZTaRv8x4ubziS46lBf6mJ
         i7jQ==
X-Gm-Message-State: AGRZ1gIQEkinonZbl8P9GqZV+Ff+HyIVUvuK0dvfIVImTnfDOG6f5+os
        dABQGitSySOtq8NggV0L1vmG7bpgvqL2aQCu4fM=
X-Google-Smtp-Source: AJdET5eHM0rc/kZtBUY98kEgnk+gTjAdfM83l7aCNMItL7CT3/FHzemmQtNBnHtcNnZji26XTq3Fj/Fi3F/1H7LgC/s=
X-Received: by 2002:a24:a0cb:: with SMTP id o194mr3486527ite.115.1542120194996;
 Tue, 13 Nov 2018 06:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com> <CA+CmpXvZJFk=kYvZybgTtqDWBVP_jSE37tdkQbyGA8U9WOrkoQ@mail.gmail.com>
 <20181113105558.GR2500@lahna.fi.intel.com> <CA+CmpXtre+A-sNT0XBWfdkuq9xJ+j34EGZ0nEpahJCSe3Kvg9A@mail.gmail.com>
 <20181113114020.GV2500@lahna.fi.intel.com>
In-Reply-To: <20181113114020.GV2500@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Tue, 13 Nov 2018 16:42:58 +0200
Message-ID: <CA+CmpXt1cfqjz94=WsggKpNCUw3761-cewa_HTa0ETcYK7o+Hw@mail.gmail.com>
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

On Tue, Nov 13, 2018 at 1:40 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Tue, Nov 13, 2018 at 01:13:31PM +0200, Yehezkel Bernat wrote:
> > On Tue, Nov 13, 2018 at 12:56 PM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > > Just one point:
> > > > Have you considered the option to add this property per (TBT?) device?
> > >
> > > No. ;-)
> > >
> > > You mean that one device uses security levels and another IOMMU? I don't
> > > think it is possible without having some sort of table in the IOMMU
> > > driver telling which devices it needs identity map and which not. Also
> > > not sure what would be the benefit?
> >
> > For performance, of course. If some devices are considered safe (maybe a list
> > communicated by platform firmware), the kernel may decide to configure them to
> > passthrough the IOMMU (I think I remember there is such an option, but maybe I'm
> > wrong.)
>
> At least I'm not aware of such an option. Windows for example enables
> IOMMU for everything and I think macOS does the same. In Linux (with
> these patches) we put all internal devices already passthrough mode so
> things like internal graphics should not be affected. eGPUs are
> different thing, though.

So your point here is "currently we do the IOMMU decisions system-wide; we can
always add a per-device attribute if needed"?
Fair enough.

So for this patch,
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
