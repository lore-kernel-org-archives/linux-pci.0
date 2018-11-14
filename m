Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B938C43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 20:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80372250F
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 20:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8cBqgkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80372250F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeKOGVm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:21:42 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:35684 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbeKOGVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Nov 2018 01:21:42 -0500
Received: by mail-pg1-f180.google.com with SMTP id 32-v6so7872332pgu.2
        for <linux-pci@vger.kernel.org>; Wed, 14 Nov 2018 12:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2BS6wjGA2OgHT7tX6ZWN2tHABauH2PkpyYy8AeEJrUU=;
        b=M8cBqgkC+jQuIlkNg+Qtp/pRBLsFkVQRK9b1okZBE/9VXoOa5rXpxH5miAz5H3RWxR
         UlKcp6YERYkFIgoVG1C8FwW4N3p1xobv6Ffee+lL/rmBC/AuZkIWuS/tcSlRtGp0K8XV
         I421f4ZqVMcrWrtUz5xgf1Eqqi1PTGsoe4Gwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2BS6wjGA2OgHT7tX6ZWN2tHABauH2PkpyYy8AeEJrUU=;
        b=BGXkbXTGWxgyJvpJ2ePpQ7qpEMzImP3zc4HfZ+5o1oMfrPYNQMG4RjFxMMlFz46HSs
         zCgABjub45alNb6xDwZPWyiMpBbyR6EVtkLOaR32Oj7RXvTFmKaeGI8mqbLDsWgLhV6H
         FKEzkwlqs+umDS5cAdnFe/p3RpYvMow7AmXMFJCbqyQ+0b2xFv/cVNIH0ZeihFRcvEQd
         avmyVe4V/H7Kdose9/j2goHJh0SyPXnk4xpB5vfW8t/apCpVh51tDkrmL7rdaH98q6vf
         JKhV5AwSu++wu98J4asSsAtQr5LdSIP3zrXQWT2aWu27EazMiJ9G3PiQiPOfEMnAqIfa
         sr8w==
X-Gm-Message-State: AGRZ1gJTj2DMuj0pNQZAfcetY2yXZ9vKpvDNbxTj/E+WbMsGVLeIspf0
        BoQw+qUD96k1MtbmOLR4EmkjuA==
X-Google-Smtp-Source: AJdET5f+QpWU07qfZuLZ8z3C0C8Pnmx3SMcWfdvXlWtCGTzeo4cHJ+f4ppIrKujxYOHUojNYhHGIsg==
X-Received: by 2002:a63:4c6:: with SMTP id 189mr3097232pge.391.1542226621592;
        Wed, 14 Nov 2018 12:17:01 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id h62-v6sm30985890pfg.27.2018.11.14.12.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 12:17:00 -0800 (PST)
Date:   Wed, 14 Nov 2018 15:16:58 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     pr-tracker-bot@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
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
Message-ID: <20181114201658.GB25069@pure.paranoia.local>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>, pr-tracker-bot@kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114201214.GM13926@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 09:12:14PM +0100, Borislav Petkov wrote:
> Hey Konstantin,
> 
> that bot needs some parsing improvs: "None None".

Correct, this is because the original pull request was for an ssh://
URL, which I'm not properly handling for the purposes of generating
responses. I will add some logic to deal with that.

-K
