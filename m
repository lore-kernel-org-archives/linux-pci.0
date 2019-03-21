Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE284C43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 20:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEE72183E
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 20:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="Dr/nrM5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfCUUgw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:36:52 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41303 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfCUUgw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 16:36:52 -0400
Received: by mail-wr1-f50.google.com with SMTP id p1so21502wrs.8
        for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2019 13:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9TUHNNhIFPRruMpNBvLXXoiBksqjasnExFQM6+gEFsw=;
        b=Dr/nrM5VHTXBNGY+uTuXCZCKtpRCErX/JUVh+KubKeDp8xNCq1694QU1giIfIM577Q
         AtluSpckxtkbx4V9gsh2/Q/YTAI7TnBaTGjmq8ztsbL/CkNHN7m3m+o6dyEqgeB7aEmz
         /H4FpvCt67H73KVUbCD59xCE2unOLRxfxcFzH34K7Lp3RvQv4ksYDmUujJifb4UNJPWT
         prKSfQOzF7RZCYHWEzxqtkuZwphJ5xZhwA4sIiSlY/FP8em4eq5UEUTqHqX0a4tw3yAT
         wTXGs6lT0N9whEM4owNd2yrA1orAj8C1N2Si3dcI45fyQhC82aFEROjJf/vcFtTmJz2y
         0zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9TUHNNhIFPRruMpNBvLXXoiBksqjasnExFQM6+gEFsw=;
        b=SWce046PPtQL4k0Nyq4oG+BtWqew+36n9Ilx0t97lYRXPpgcR7Q1dCW87yjNtiBjtI
         OGjHKHBcmzj+ScBxwQ3KNl3r6Swic4L20DTtGxWkOis3NmN3mzdyVcHwVJp8Ovs/LKWD
         VEwn0qIuh98xLIeO+4DkitXcD8ylJeiZUKjD4Mlp733sk5i+9jMinn8Y3Mr3dr4g9wCa
         y58NDDl3F04A49ohFGMRN2WCD79uZHjkiM7ZZcN+wTOJ4HeDMjPYTepbu8We/NjUTSXs
         J6OmrkCDLrmk2J1putJVkNO5+nxaND2xeqT5w8ncNM2pIR1vQv8YPrWDoz9IuqN2hYE5
         MwQQ==
X-Gm-Message-State: APjAAAVoipTglrwsUQlOaU47cQIdwy23AMP7K6OW0oRhzp8wMCljCrSy
        iO+FOwEWp9Hb9ewtinFTyckg9YRrs3bd2rAK6hAk6w==
X-Google-Smtp-Source: APXvYqwQ/JZdJHRv+wnXk2R807GWJXIaYJpgmhNro3fdZX5HG9uDDxTofYejuuD/AB9eEez9K8oUc8i4i6cBK57MnPY=
X-Received: by 2002:a5d:448b:: with SMTP id j11mr4066253wrq.218.1553200610360;
 Thu, 21 Mar 2019 13:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com> <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
In-Reply-To: <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Thu, 21 Mar 2019 15:36:39 -0500
Message-ID: <CANSNSoWO=51tG4TryLdb8uJhb70LXhQLs3gDy1vfwYM4KdB7DQ@mail.gmail.com>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 14, 2019 at 3:57 PM Jesse Hathaway <jesse@mbuki-mvuki.org> wrote:
> Bug submitted along with the requested logs,
> https://bugzilla.kernel.org/show_bug.cgi?id=202927

Bjorn is there anything else that I can include on the bug report that would be
helpful?
