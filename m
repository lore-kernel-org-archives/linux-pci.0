Return-Path: <SRS0=2reG=3V=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27A5C33CB3
	for <linux-pci@archiver.kernel.org>; Sat,  1 Feb 2020 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C714206F0
	for <linux-pci@archiver.kernel.org>; Sat,  1 Feb 2020 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580582242;
	bh=L1oWW7bjUkXQenIeIriylRV6qBs/WeIf1Cxjf5yvoSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=rMGedB12upJpxap3/44KhBjN2dGAyAwFupX5NGCmBH+OJK2M+BHfHBdhf3Axs+X24
	 xYvogUBeRLty9TaWSMdpcTzchrdgylaVBHe9JE4G6JWvA1DHitOw9byopA6Mg9WZG5
	 9z15SsUF7IIBzmFdRB1Y4aDvi+n52ANK/Nd/ahRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgBAShW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBAShW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 1 Feb 2020 13:37:22 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCD52067C;
        Sat,  1 Feb 2020 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580582241;
        bh=L1oWW7bjUkXQenIeIriylRV6qBs/WeIf1Cxjf5yvoSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HG3k9it1hMbZzXMu+RijtOLRsG3eoUyADxvf+4R6lnA7B1rKbE7rHCgahkL9eOvLg
         LPlbznA6i/VwV3be5cfcZAw5OldJmhvojvay4RiNYg35tIJbCMP/FdHPaV+93UOhsM
         ujngX+fV5o2kElmD9EKT42OJVkZVkrGNQVYfX/Bg=
Date:   Sat, 1 Feb 2020 12:37:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [GIT PULL] PCI changes for v5.6
Message-ID: <20200201183719.GA6704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxMB3UYR5iUHB6+NXT7awOF4DD5=QQrskJ8yocyO+Ebw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 02:49:52PM -0800, Linus Torvalds wrote:
> On Fri, Jan 31, 2020 at 2:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187
> 
> You must have screwed up your git request-pull somehow.
> 
> Yes, yes, the above works, and a branch is just a named SHA1. You can
> give the SHA1 directly.
> 
> But it's not what you meant to do, I'm sure. Especially since you
> pointed to the SHA1 of the top commit, not the tag that you have that
> points to it.
> 
> I can see what you _meant_ to ask me to pull with "git ls-remote". I
> clearly should - and will - pull the 'pci-v5.6-changes' tag, which
> points to that commit.
> 
> But can you check what in your workflow went wrong for the above to happen?

Oooh, I'm sorry, that's my fault; I did screw it up.  I usually do
this:

  git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git $COMMIT > msg.txt
  git tag -s $TAG $COMMIT
  git push pci $TAG
  git request-pull origin/master git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git $TAG > msg.txt

so I can look over the updates one last time before tagging, but I got
distracted in the middle and I think I forgot to do the second
request-pull after pushing the tag.

Thanks for compensating.

Bjorn
