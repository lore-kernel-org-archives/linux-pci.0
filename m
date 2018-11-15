Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111AEC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 07:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA71224E0
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 07:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="icw4r83v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA71224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKOSAS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:00:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43396 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbeKOSAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 13:00:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id g7-v6so9278333pfo.10
        for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2018 23:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E+d4mnnheKWEDa0BjZsSxw4ixCHorNP6QfyAu2vE08I=;
        b=icw4r83v6AIUBHz4AwnWpkA2SOGBY1ks0MMqCm+mApspcNyuXY0S/iEwyUigPCGfGX
         LNytjxauy9KmdbPOIxnNoW3zUxhAYC7R+bR/C0DuUizv+wXqiYuHwLiiUQywJlZTMWAR
         P6iZD+RRA2TZk70DM5k8jGKTfeW8G1mkbH6DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=E+d4mnnheKWEDa0BjZsSxw4ixCHorNP6QfyAu2vE08I=;
        b=YVCojarrzyjyGOC5dynVaqtjYxCPluj5U8pnlqE4+WCKLlL9ltWmxUc8RRg3iFt95a
         hO1nZQPAr/n6SS95OwEnPnp6AiSQKiHYAfOkCYzuDkFiNYK3HmrZ3db5V51N73hDR3dz
         pUDAzvn+ox8j7aVJ87zgqz2sfzHPEelJjzbrtzqx/G/8JIto/d68xWFoQ7dfC6RU/UZ/
         c1f254NUqmymqRboqcyyG+L6Q5Av9SUnC+EuG567L5v5xDLTuQM7aj1FxO07d1FFKLs7
         43njSMGnpdouhQGI7wbbK8RGgcO6FSmhKOcIEkFHhuExVpyGKv4ivEfkjBndf062LYQa
         cl2A==
X-Gm-Message-State: AGRZ1gKdsbEBOXsxpRm9E44RKRM1vnAqiJOIsA1hQTUljWa2cT1qYEbT
        kWXKXM72wzaizItkEuCgWwbunw==
X-Google-Smtp-Source: AJdET5fim4LowC4uVLuJMSRQ2J2VVq4jlwdDnI9OwfhN8kXHmsLOdICix9J+JdFbJdzTOqZNsT4EwA==
X-Received: by 2002:a62:4502:: with SMTP id s2-v6mr5386289pfa.31.1542268413597;
        Wed, 14 Nov 2018 23:53:33 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id 11-v6sm36337093pfr.55.2018.11.14.23.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 23:53:32 -0800 (PST)
Date:   Thu, 15 Nov 2018 02:53:30 -0500
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
Message-ID: <20181115075330.GA32162@pure.paranoia.local>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org,
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
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181115071252.GB94998@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 01:12:53AM -0600, Bjorn Helgaas wrote:
> > and I kinda see the point of maybe not having your ssh username in the
> > URL. Not that it is a big deal for us, k.org users though.
> 
> Sorry, I don't understand the problem.  I have this in my .gitconfig:
> 
>     [url "ssh://git@gitolite.kernel.org"]
> 	    insteadOf = https://git.kernel.org
> 	    insteadOf = http://git.kernel.org
> 	    insteadOf = git://git.kernel.org
> 
> because I thought that was the recommended way (see the end of
> https://korg.wiki.kernel.org/userdoc/gitolite). But that also makes my
> request-pull:
> 
>     $ git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.20-fixes-1
> 
> generate the ssh URL above.  If I remove the insteadOf stuff from
> .gitconfig, request-pull produces this instead:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1
> 
> I'm happy to do either; just tell me which :)

You didn't really do anything wrong. In *general* I prefer to see
public URLs if they are sent to public lists, so if you're cc'ing
something to LKML, I would generally expect the pull request to have a
public URL like https://git.kernel.org/ instead of a private ssh:// URL
that is only accessible to people with a kernel.org account.

That's basically all there is to it. It doesn't *really* matter, since
Linus is the one who will be merging the actual pull request, and he
certainly has access to internal ssh:// URLs. However, in case someone
else was interested in reviewing the pull request, it would be more
friendly to have a public URL for them.

Best,
-K
