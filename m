Return-Path: <SRS0=tXem=ZZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F88C432C0
	for <linux-pci@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B5920833
	for <linux-pci@archiver.kernel.org>; Tue,  3 Dec 2019 22:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575411324;
	bh=pj39nrOFe4ea65wljyfcc7xFstiw+bxs5FMiUkLk6AI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NjzkBT774jLHCGKqHamyKlu+1eYQb9Hwkdd90ypG4GlYbkQ2zl/HHU/4RE5Di6Jnf
	 IIyl8JoJ3uWPx+//c1uvhm8boGC9rbrFXh30+EWxXxoAN0ga+kZzK2HlU0HPB6Ymxm
	 1xLSDCC850htEszY2/hm7h2uoWoR61CjzPO1GSbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfLCWPY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfLCWPY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 17:15:24 -0500
Subject: Re: [GIT PULL] PCI changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575411323;
        bh=pj39nrOFe4ea65wljyfcc7xFstiw+bxs5FMiUkLk6AI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1fRMOR7fgozNo7pYi66IRj6zoajymfMi3CWRe8qxSeTENVQUkJsHaPs3xjP9hs7f6
         A1E6f6xl2gpF12CM9067NRzSdFCNzJYsSDGo00o+dLjgcmQMK9v3uUF95CMiPxW/a+
         E6DIH50ssZa7uo5m08nmvDxhIU42omWsdXoDlD5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191202234123.GA146608@google.com>
References: <20191202234123.GA146608@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191202234123.GA146608@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.5-changes
X-PR-Tracked-Commit-Id: 7e124c40517218e079e580909de2652bddb60ff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3bed3b20e40ab44b98ac5f0471a5bd92a802f5a
Message-Id: <157541132361.3528.5996115518433913641.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:15:23 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 2 Dec 2019 17:41:23 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.5-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3bed3b20e40ab44b98ac5f0471a5bd92a802f5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
