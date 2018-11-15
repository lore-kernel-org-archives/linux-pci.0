Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26FC43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B51223CB
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 17:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AImjR5ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B51223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbeKPDfu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbeKPDfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 22:35:50 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 070AB21582;
        Thu, 15 Nov 2018 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542302827;
        bh=1reHk8rzPIXfPFVU4bVw9tOimZHvDusADjmKwb6c854=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AImjR5uae2PtAW6kTJU7tmTAdEUwQe3CSc+EVZLTS/rYMmQk0/BIS4Nd5WllGUowm
         TLk2y6xUarEc6/MQdmfJTzEJ2K9WoDhq/Z72I2OaNQuLOW4OYTV5w02t2uUtZdv4ed
         PBssftX4fZXwo1x5xwRY1kyK5FFIQe8BdxmieGsE=
Date:   Thu, 15 Nov 2018 11:27:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [GIT PULL] PCI fixes for v4.20
Message-ID: <20181115172706.GA229449@google.com>
References: <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
 <20181115071252.GB94998@google.com>
 <20181115075330.GA32162@pure.paranoia.local>
 <20181115150321.GB207836@google.com>
 <20181115155418.GA25764@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115155418.GA25764@pure.paranoia.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 10:54:18AM -0500, Konstantin Ryabitsev wrote:
> On Thu, Nov 15, 2018 at 09:03:21AM -0600, Bjorn Helgaas wrote:
> > > You didn't really do anything wrong. In *general* I prefer to see
> > > public URLs if they are sent to public lists, so if you're cc'ing
> > > something to LKML, I would generally expect the pull request to have a
> > > public URL like https://git.kernel.org/ instead of a private ssh:// URL
> > > that is only accessible to people with a kernel.org account.
> > > 
> > > That's basically all there is to it. It doesn't *really* matter, since
> > > Linus is the one who will be merging the actual pull request, and he
> > > certainly has access to internal ssh:// URLs. However, in case someone
> > > else was interested in reviewing the pull request, it would be more
> > > friendly to have a public URL for them.
> > 
> > OK, I think I'll remove the insteadOf chunk from my .gitconfig.  Should
> > https://korg.wiki.kernel.org/userdoc/gitolite be updated to remove or
> > expand that recommendation?  The only reason I added insteadOf in the first
> > place was because it sounded like a security improvement.
> 
> It is. Does adding the insteadOf rules result in ssh:// URLs when using
> git-request-pull? I didn't expect that it would.

Yep, it seems to for me.  Maybe I'm doing something else weird, because I
don't see many other pull requests with ssh:// URLs.
