Return-Path: <SRS0=Q3Ib=NZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F1FC43441
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96672243E
	for <linux-pci@archiver.kernel.org>; Wed, 14 Nov 2018 22:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96672243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeKOIx4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:53:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54412 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbeKOIx4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 03:53:56 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9VCBWLqO_nYH; Wed, 14 Nov 2018 23:48:43 +0100 (CET)
Received: from zn.tnic (p200300EC2BD0D200D5714500C00E26FD.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:d200:d571:4500:c00e:26fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 462A11EC06FB;
        Wed, 14 Nov 2018 23:48:43 +0100 (CET)
Date:   Wed, 14 Nov 2018 23:48:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, pr-tracker-bot@kernel.org,
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
Message-ID: <20181114224839.GP13926@zn.tnic>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114222154.GA22445@pure.paranoia.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 05:21:54PM -0500, Konstantin Ryabitsev wrote:
> For the record, there's nothing wrong with that, it's just a condition
> that I didn't expect. I have a fix in place that should avoid this in
> the future.

Actually, I meant the pull request URL.

Here's some background info:

https://lkml.kernel.org/r/CA%2B55aFyMxkS=8JzZ%2BROOAFkwR45EKBnQ0GUMQS4f%2Br_-fFWiEA@mail.gmail.com

and I kinda see the point of maybe not having your ssh username in the
URL. Not that it is a big deal for us, k.org users though.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
