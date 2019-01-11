Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF0FC43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 17:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E752177B
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 17:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547226003;
	bh=A7S/4cZ2GOyaY1CZB4qTCyLe25snyjkYl8u+33DZU9U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZdvXd5Fmkhj/4AUVZBP5rF+elEHzvodfVLH1XEfLmKkyH8ddX5pRJZCFt5qbMo86K
	 Pd2a+VaqotVrU2jgfKaLoDRv960u2Gf689AO3qEODsDOcd1bThvvzXsWlhmyUcrbsh
	 lvLVrIAwjJTesJzON1UvVmpsJSkwencDkIhBM1xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731083AbfAKRAC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbfAKRAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 12:00:02 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547226002;
        bh=A7S/4cZ2GOyaY1CZB4qTCyLe25snyjkYl8u+33DZU9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A+no5xylYVr+lHQylrJPlT55ROdGIIZjvxfGJJbFOroGMndx/wdkuBlS2RYFy/XTj
         pkF+jLuqNej7IG+0DOe+aaCulFZnNhUDn0QHCASviPKq7Hwg6erd72s5hekWQaUAeD
         Q1F2xjpyqYuTPNlsnbwdt2xdF1soiBRKf6QILkLM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190110213131.GA86782@google.com>
References: <20190110213131.GA86782@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190110213131.GA86782@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.0-fixes-1
X-PR-Tracked-Commit-Id: a3869d43c9800cf39496615361c83635fa3e7c82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de6629eb262e0dc52a2367db38e3d2780cff5427
Message-Id: <154722600201.23433.12008113768993474639.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 17:00:02 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 10 Jan 2019 15:31:31 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de6629eb262e0dc52a2367db38e3d2780cff5427

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
