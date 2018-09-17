Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA2ECE563
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 07:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AFB214DD
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 07:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmsL7lGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AFB214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbeIQM4M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:56:12 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38756 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQM4L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 08:56:11 -0400
Received: by mail-qt0-f193.google.com with SMTP id x7-v6so14386616qtk.5;
        Mon, 17 Sep 2018 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L69OiDB1DjfNChCf5xaS2FuxuNO8x8dFoOla52BnSRE=;
        b=AmsL7lGiVmoNNMLb51HOb6hMws9uTnx4VsTb3bUioT9/NBiWZHf2PZUGJr2gGHulqr
         BqvwSsbfQXlFtWaV217GwlPBLj9Jaw2JAtL+nZSsDjxAkdxTQ3TKj/iDZJpKL0YVltAt
         S1sjpmMKmQ019dc4HSxs/Pa99mPo/PedmSOkxLNyeVvRE9m2tbOabZ4rYaIe91N4Fqub
         yxOyyPbmTga/KeTPi5xfMeyhLxnDv+nhn0lvNwLt0tXThhEayUWQkhqxUMX+WLkQ57hE
         TRNKufUWP+ZTM8qu0hZvxscSwrt8XQ/2mCLJMCPBTlXSjw5iTpWgNmITe/nyfYfcYA56
         7jDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L69OiDB1DjfNChCf5xaS2FuxuNO8x8dFoOla52BnSRE=;
        b=YHHshkzHKtPWK7ZujG4ZM0gya1gE+5pfTTzDLquIE7Px3rkWnjy3YxOTrURKspoAGU
         RcFRuUkFCHJNnUoP4wrqEC8hHbEoepeh38VUNplrboXCG8IsfPRnJBvWcMuzs2938Mt4
         Ew0BSJDlRHitFWvENOqigFLRiGJXzG6hT5wQphj0000tgFnwNROCueHWvPZbCNvUvRWX
         3Z+PeLQxYQvWYfL2NAn/NueBM05yOFme0K1jXOCl1sELWGayxyFo+1SdQRNYn5ofW36b
         Z7VAXzFSj7fBT/kvC+bVlQjlgOKqqqXdestR9qY9Up/4rR98swQGLSORkH1ue1INL7qG
         Jj0w==
X-Gm-Message-State: APzg51AXgsScU3ZvPIPq0WwX0YW2OUOgdgvLr/SXa+xz901ewoDnAuP+
        jsTQ4Br/T/541p5TEOJA0kRRtctp7xyEZS4DVA==
X-Google-Smtp-Source: ANB0VdbaijLes657/TlRCTOxI2NV/JNigNWiZQwdY2iWh/J/S3PiIYcymzSjJv7mFQQrHXYx2cGbUnXWliERkoRSUBM=
X-Received: by 2002:a0c:abca:: with SMTP id k10-v6mr16631892qvb.140.1537169402547;
 Mon, 17 Sep 2018 00:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFtaAxE8G15vU40jCKzqzuwpt_-bDfVpWuaeuy6cQ-sh=Ap2XQ@mail.gmail.com>
 <20180917061217.GI14465@lahna.fi.intel.com>
In-Reply-To: <20180917061217.GI14465@lahna.fi.intel.com>
From:   Peter Anemone <peter.anemone@gmail.com>
Date:   Mon, 17 Sep 2018 10:29:50 +0300
Message-ID:
 <CAFtaAxFazzhS++yFE7ByUxpMV=h-sC1DCPdg88OApPCW+9NMSQ@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Boot stall related to drivers/pci/hotplug/acpiphp_glue.c
To:     mika.westerberg@linux.intel.com
Cc:     rjw@rjwysocki.net, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917072950.6ijZ3iHBrW-wHWVd0o7YFpQRhWWrD_-iStBvkadn0BM@z>

I think I can't get a dmesg as I can't boot the kernel. My screen
stays completely black when I try to boot.
-Peter

On Mon, 17 Sep 2018 at 09:13, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Sep 17, 2018 at 08:58:50AM +0300, Peter Anemone wrote:
> > Dear kernel developers
> > I reported a bug at Bugzilla, but Greg Kroah-Hartman pointed me in
> > mailing lists. Here's my bug report:
> >
> > Linux has been unbootable for me from 4.18 upwards. Even the fallback
> > image does not boot. This has not been fixed yet in 4.19-rc3. acpi=off
> > kernel parameter lets me boot 4.18.6 and 4.19-rc3.
> >
> > I used git bisect to track down the first bad commit:
> > 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> >
> > The commit is about:
> > "ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug"
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=84c8b58ed3addf17d3beb2e5037b001ffa65c5ef
> >
> > Linux 4.17 booted fine. Reverting commit
> > 84c8b58ed3addf17d3beb2e5037b001ffa65c5ef makes 4.18 and 4.19-rc3
> > bootable again (without the acpi=off parameter).
> >
> > Information about my system:
> > Model: HP 6730b laptop
> > CPU: Intel Core 2 Duo P8600
> > Boot manager: systemd-boot (UEFI)
> > More information of my system as attachments on the bug report at Bugzilla.
> >
> > Link to the bug report:
> > https://bugzilla.kernel.org/show_bug.cgi?id=201127
>
> Thanks for the report. Since there is bugzilla about the issue already,
> let's continue investigation there.
>
> Can you also attach full dmesg of the failure (if possible) to the bug?
