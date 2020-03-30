Return-Path: <SRS0=Lghl=5P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242B8C2D0F1
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5C820771
	for <linux-pci@archiver.kernel.org>; Mon, 30 Mar 2020 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585607716;
	bh=7IBOz4ePh/jjgfmw3X/FQZqGRPMvQmJNyVifg+HBytY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aATI7PtXwz/h7E6t8V5AzoW/Ur727B06Ozqs8wuBb5ZgMjDZNmf2iXwlac0cA81ru
	 8OU9AZ3pbQYjJjF1KBoY8NUd9e0fRAMsNtrKJ8BOAT5TNR03DVztkBeiH6R4RW9bPc
	 JmopNTa31Szbq1N0nWzuN87cytf338qpkGeMCqeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgC3WfK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgC3WfK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 18:35:10 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585607710;
        bh=7IBOz4ePh/jjgfmw3X/FQZqGRPMvQmJNyVifg+HBytY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HkqyKkM9rsA4QRdy0qixISBiD7fGB/r26nNSA72sFpblStfpZaqXvDp0AhsNzXH8p
         IMXKQe1ArtIph+dmAmlexNC47pRdgJLG5uc5sS32WksOUfmTRjIdQN2xcrsdIvY1DM
         SovMlLIxa89MnQ/XpG9h0I9EOdSn0xtnwqmC8CqI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
References: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ja_cmfL2Rwj-k-__B2QjH8kY-t2pM1Tg+yP0A=6kMYSg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.7-rc1
X-PR-Tracked-Commit-Id: 1da28f032305383a664e5711ba07b7957901a72e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d90508121fd0c92c276ec731ad6109bf2986cc6
Message-Id: <158560771002.3567.6314103050384706394.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Mar 2020 22:35:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 30 Mar 2020 17:25:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d90508121fd0c92c276ec731ad6109bf2986cc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
