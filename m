Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD33C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC5921582
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9wCopL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC5921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeKPEWD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:22:03 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:36498 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeKPEWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 23:22:03 -0500
Received: by mail-pg1-f180.google.com with SMTP id n2so2187195pgm.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Nov 2018 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0upDZ2mFAUdjDXMYp+S4KJ1R74hWPx56On0E4nZmIs=;
        b=e9wCopL2F24XiwBGWdhfkGc6Sy8Vg7P6NDKBnEWrEQcKk8LXyEtLMyLtDODDiDShET
         Tgp9Zik6CwQesmlIHXieWgnjBEi3ZvRg5eRiKa2Dl/I/W70T1804vHb0RQi2MVI/udya
         34yOTdlN1RW+DTkaAYFGAB1jGU7FwvFWpME8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0upDZ2mFAUdjDXMYp+S4KJ1R74hWPx56On0E4nZmIs=;
        b=bGkefobS6/zQzTSmcSkJHmRZgfCBdifMEy3/hW+OMbbDzMuTNm7ClF9qYgZC85RgVh
         U8ikV+oMYIoERCWE7AJY0PGddz2SvfG4FE+fOiqs+FVx+0SOieZ/dk+UeMqIX4gWScHc
         2P7TRx0TaD94JR6WAcexLD2zpnXVm2j8TiCEI7YGmHMMW1Of0r/ANRZlNEyMN8ubTOdz
         2SVFdHOPfA5yR6lZOB04P7x8tU/gH9YdIxyHlgD0kVKnjSaQ9bju++BsGhRzxFdXSEmN
         /dSKgvP5NbSpmdwdYULJqpuWEV8ArFsBSrodwnY4xdcOsjSgOlELbb+H/ZpEV4KtH/gm
         ajgA==
X-Gm-Message-State: AGRZ1gKnD0vVg2dHQXs9OJJ79XRVrCbwjaHmuxFPGIf85WTuJuMxnpNT
        P1u/f7I/yyMUeNMZY9ebsNtUaw==
X-Google-Smtp-Source: AJdET5cfLmgZtlZbg+yDFPLI/N6InjIU4J17K2lyvtZfEqwO1+v6RLmuQhhVo87XEA5o+3wADZbZaw==
X-Received: by 2002:a65:55ca:: with SMTP id k10mr6694049pgs.448.1542305590785;
        Thu, 15 Nov 2018 10:13:10 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id w2-v6sm30490745pfw.26.2018.11.15.10.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 10:13:10 -0800 (PST)
Date:   Thu, 15 Nov 2018 13:13:07 -0500
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
Message-ID: <20181115181307.GA25806@pure.paranoia.local>
References: <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
 <20181115075330.GA32162@pure.paranoia.local>
 <20181115150321.GB207836@google.com>
 <20181115155418.GA25764@pure.paranoia.local>
 <20181115172706.GA229449@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115172706.GA229449@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 11:27:06AM -0600, Bjorn Helgaas wrote:
> > > OK, I think I'll remove the insteadOf chunk from my .gitconfig.  Should
> > > https://korg.wiki.kernel.org/userdoc/gitolite be updated to remove or
> > > expand that recommendation?  The only reason I added insteadOf in the first
> > > place was because it sounded like a security improvement.
> > 
> > It is. Does adding the insteadOf rules result in ssh:// URLs when using
> > git-request-pull? I didn't expect that it would.
> 
> Yep, it seems to for me.  Maybe I'm doing something else weird, because I
> don't see many other pull requests with ssh:// URLs.

Hmm, you're right -- I just tested this and it does. I can't imagine
that's the intended effect of insteadOf -- it's supposed to alter URLs
behind the scenes, not permanently transform them. I'll talk to git
folks about it.

For now, you should probably remove that from your gitconfig so that
your pull requests have public URLs in them.

Best,
-K
