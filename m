Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E69C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 07:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AA522419
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 07:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWvyC1dR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2AA522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeKORTa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Nov 2018 12:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeKORTa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Nov 2018 12:19:30 -0500
Received: from localhost (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 603B32089D;
        Thu, 15 Nov 2018 07:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542265973;
        bh=dlOfBE0R8mRtUk17WzorsPptGLnXRABAUkpO3GkYN+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWvyC1dRSFSg/btrGEtn2iOjqwGL+2qN1MPEOSoJzhgwW3AyW0QgV1G3oNm0GaN3P
         l6c8Ta+qeM8Ge37ymxK9Mr5O3V8uSmKiA6uev/WzbQ85/45bAECd+N6ETAdHMAKKnB
         fHo+k1zL5nJpfz+Q/3ZINDImHZd9lGuaVpkHUgeo=
Date:   Thu, 15 Nov 2018 01:12:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        pr-tracker-bot@kernel.org,
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
Message-ID: <20181115071252.GB94998@google.com>
References: <20181114062010.GA189193@google.com>
 <20181114200003.14496.1490.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20181114201214.GM13926@zn.tnic>
 <20181114201658.GB25069@pure.paranoia.local>
 <20181114214601.GO13926@zn.tnic>
 <20181114222154.GA22445@pure.paranoia.local>
 <20181114224839.GP13926@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114224839.GP13926@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 14, 2018 at 11:48:39PM +0100, Borislav Petkov wrote:
> On Wed, Nov 14, 2018 at 05:21:54PM -0500, Konstantin Ryabitsev wrote:
> > For the record, there's nothing wrong with that, it's just a condition
> > that I didn't expect. I have a fix in place that should avoid this in
> > the future.
> 
> Actually, I meant the pull request URL.

My pull request URL was this:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

> Here's some background info:
> 
> https://lkml.kernel.org/r/CA%2B55aFyMxkS=8JzZ%2BROOAFkwR45EKBnQ0GUMQS4f%2Br_-fFWiEA@mail.gmail.com
> 
> and I kinda see the point of maybe not having your ssh username in the
> URL. Not that it is a big deal for us, k.org users though.

Sorry, I don't understand the problem.  I have this in my .gitconfig:

    [url "ssh://git@gitolite.kernel.org"]
	    insteadOf = https://git.kernel.org
	    insteadOf = http://git.kernel.org
	    insteadOf = git://git.kernel.org

because I thought that was the recommended way (see the end of
https://korg.wiki.kernel.org/userdoc/gitolite). But that also makes my
request-pull:

    $ git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v4.20-fixes-1

generate the ssh URL above.  If I remove the insteadOf stuff from
.gitconfig, request-pull produces this instead:

    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-1

I'm happy to do either; just tell me which :)

Bjorn
