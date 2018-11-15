Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1020DC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C3B2086B
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 15:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V6KG/vDK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C3B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388576AbeKPCCp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:02:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33238 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbeKPCCp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 21:02:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id w22-v6so9687040plk.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Nov 2018 07:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LeBsOofA2UhTi1KfnUYz8etx06r1hUEa9jBx4Io3vqw=;
        b=V6KG/vDKKUn2Mecz+5hcevEYUmwt1aQ15/s4Ysq/cf5Gk/sPnT66R30a+cFdPyYoVC
         iNOVvHQ5E60wZ2l40VQ5hZt/sYbhsiNZeW63C1V9oafTCPOY/SqRbXplUXkhz4+I226N
         wSKsszErlUj7AGgUha4ZhiKIqMgtmbTm0DvSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LeBsOofA2UhTi1KfnUYz8etx06r1hUEa9jBx4Io3vqw=;
        b=BzJybACEyk4KVAgzMeaRmUP1AZ5anVvqqsh+cmp9Bbekm5iGQPwHRAEvKxdi2+kXer
         +dg1NVRTgGX87AN817t6LlBjK2+obZc9GnniCggAKgNNySY8OzosAYGBKMGB52I+0lES
         OuyyM5Ve2m0ITiHCSn9ePSVa0Nu+UUWsfKhAY5IF/rNJxn/FKFZrJeP2hbsT5/+GXh6N
         l83fFvnjy6DzylM/pH3tUhxaC+tXh5RAPQIg5QocF4VzQAcHlLFKOlWp9z9nfRpzUJWC
         8RTQRBvMneKrAMZdCCPk557yQRguG/omv3C0W2y4h9keY3KKyT8WNixz08qoyADms5Lt
         epdw==
X-Gm-Message-State: AGRZ1gKnxmcxRwvwCV6Iuo2v/bsFZQ9itdwOc+33Q33+WPVmJq/37Cl9
        pxo+YAdaywaLUck4QKxXyola+w==
X-Google-Smtp-Source: AJdET5dWJSIFttZLvCPEqEDGy9Z503E1JNmCTFqsHbj9CPDT3Bxnkl1JPobiOUklUG5W7zsWxM77tw==
X-Received: by 2002:a17:902:481:: with SMTP id e1-v6mr6782175ple.132.1542297261537;
        Thu, 15 Nov 2018 07:54:21 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id y1sm31137524pfi.123.2018.11.15.07.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 07:54:20 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:54:18 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181115155418.GA25764@pure.paranoia.local>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
 <20181115075330.GA32162@pure.paranoia.local>
 <20181115150321.GB207836@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115150321.GB207836@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 09:03:21AM -0600, Bjorn Helgaas wrote:
> > You didn't really do anything wrong. In *general* I prefer to see
> > public URLs if they are sent to public lists, so if you're cc'ing
> > something to LKML, I would generally expect the pull request to have a
> > public URL like https://git.kernel.org/ instead of a private ssh:// URL
> > that is only accessible to people with a kernel.org account.
> > 
> > That's basically all there is to it. It doesn't *really* matter, since
> > Linus is the one who will be merging the actual pull request, and he
> > certainly has access to internal ssh:// URLs. However, in case someone
> > else was interested in reviewing the pull request, it would be more
> > friendly to have a public URL for them.
> 
> OK, I think I'll remove the insteadOf chunk from my .gitconfig.  Should
> https://korg.wiki.kernel.org/userdoc/gitolite be updated to remove or
> expand that recommendation?  The only reason I added insteadOf in the first
> place was because it sounded like a security improvement.

It is. Does adding the insteadOf rules result in ssh:// URLs when using
git-request-pull? I didn't expect that it would.

-K
