Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F159BC43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8BF218FE
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 20:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="P3w7P9NB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCVUCY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:02:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41441 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCVUCY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 16:02:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so3623080wrs.8
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2019 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap5o+tpn9OtFrN8fvD2s704ORsBw+ecBVyZ08vMFyXc=;
        b=P3w7P9NBzwxqvpiAgCWiiWVf5FPKSLkD8sq1m+sMhA28iRqGhFlMCQ5d/9v24QJJF8
         bS+iEg22otoDjF3waHdWyvHpMSV9f1GCieQQs6J43ifTZ+/KtUj8qK0EFbA8Ae6dSkLp
         dpc3cv4bJcTCvrishP2nWXTLBiw8LUkQeSWOlsB6Q0t8UL7r7G8DS65ZIGbmAh4gTyNb
         7lr630bxk+srk/WDp7xzX9EEjxkpDAaR9gHpx1jTh7CtW+h/FYeyfQs17oC6Jzw7wpcr
         WDxSb3qgGD7sOO05sQC8f6twHmoJonys2Yhr2k0xQXSElIvV5zA0HL9HBe96k4W9Nl/s
         syzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap5o+tpn9OtFrN8fvD2s704ORsBw+ecBVyZ08vMFyXc=;
        b=APbY1Ll3kBSjZGxLM0gSWJSNXyi0GN4ZaLpXFNjIjlG/7/KeaNTztWTKqW3xYAKUpl
         4IfkEGoJoEy29vnoTGKsUdVkFJKyem7IvPW0l+C7PzoBL1hH3RsFocAV6QQy34nurK9u
         Iuw5Ll2bT4ctgEQxcxFdHDWYQijqR9NFJUPfuNuLEy0zQ2fAAYwdudxu8lLEvYy1Hfn2
         esa63AFs3ae2gqFee5w5h6xm44nZS/BnuRxEdyNS3ZOSKCJG5fPpdAGhEsg2XJSLnp3U
         fVnPhxgXUqGFxXULJ+o6NAh6+LMu3T/J7bwzLvxKv0Mx1FGvlnCJwQqf12cy7byrqwfz
         23Gg==
X-Gm-Message-State: APjAAAW+EhR6U68qyID6B9pu4SG6X6fBuUbvbTISKtbAPgUGoaWJhUNq
        /GSMoHdaz9ksCOfLl7qdn5hCpjth8QQ2SpQnTpjHuA==
X-Google-Smtp-Source: APXvYqwdZHSyLgAhMoA7chBDfM5toGHV0VUiq62d4vN12G3QYWWYNlprnAUylg0F96eGO38gghyNLTmmJ65hDjZKujs=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr7015877wrt.99.1553284942891;
 Fri, 22 Mar 2019 13:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com> <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
 <20190321232310.GL251185@google.com>
In-Reply-To: <20190321232310.GL251185@google.com>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Fri, 22 Mar 2019 15:02:11 -0500
Message-ID: <CANSNSoXhiYP4Ad3hO1v03aMOX1VtUao2yCLgj_J0z9fCNwWo5w@mail.gmail.com>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> So apparently the hang happens while we're running the "final" PCI
> fixups.  This happens after all the rest of PCI is initialized.
>
> Can you boot v5.0 vanilla with "initcall_debug"?  Maybe we can narrow
> it down to a specific quirk.

yup, added the "initcall_debug" output to the ticket:
https://bugzilla.kernel.org/show_bug.cgi?id=202927, here is the tail end

[   14.896337] NET: Registered protocol family 1
[   14.901314] initcall af_unix_init+0x0/0x4e returned 0 after 4866 usecs
[   14.908694] calling  ipv6_offload_init+0x0/0x7f @ 1
[   14.914238] initcall ipv6_offload_init+0x0/0x7f returned 0 after 1 usecs
[   14.921821] calling  vlan_offload_init+0x0/0x20 @ 1
[   14.927365] initcall vlan_offload_init+0x0/0x20 returned 0 after 0 usecs
[   14.934948] calling  pci_apply_final_quirks+0x0/0x126 @ 1
[   14.941106] pci 0000:00:1a.0: calling  quirk_usb_early_handoff+0x0/0x6a0 @ 1

thanks, Jesse Hathaway
