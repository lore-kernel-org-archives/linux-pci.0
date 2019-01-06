Return-Path: <SRS0=pf5Q=PO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29701C43387
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E946B222A9
	for <linux-pci@archiver.kernel.org>; Sun,  6 Jan 2019 02:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546742444;
	bh=rezS+zYbN0k4ywPFmy+CdY/TqBeHhtPBP4M7yatUiXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=fGHL+lEWYCrRj/EV5gtdNXOnmKA7w9vYLoTnYYtUT9hqbBbHoaXPUC6BknP14/5/c
	 NBixlInyqz/oiAuzexrdgIlVTOuCwC58Pb+MhJ1bCKV53uatbaxgTV/t96ICWl+Kzw
	 afZ7OqjX8oiik2xHiM94d28PLTqcYTYn4ZVymkSo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfAFCkF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfAFCkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Jan 2019 21:40:04 -0500
Subject: Re: [GIT PULL] PCI changes for v4.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546742404;
        bh=rezS+zYbN0k4ywPFmy+CdY/TqBeHhtPBP4M7yatUiXw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BLlwpQuUkIWPApOm78qY3+kvXMuRIa2x+8rmp1xov8hL6KF6G+285fwvEvW2QXkrK
         MASNsmA/tqSlPfNL45a6tZNrqkU/8po9u7H200GvHBnkfHQzgutX6CV4RmGT2oQg3D
         qUUfT+G9r9DC5QtB9G2nJuZj33tQ8gBC6KSPj63w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190103150552.GA168876@google.com>
References: <20190103150552.GA168876@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190103150552.GA168876@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v4.21-changes
X-PR-Tracked-Commit-Id: 72199051af6205049e96ee7ed34f4fc5f44d1baf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 926b02d3eb547daa1d56cf9b586f31b270488b77
Message-Id: <20190106024004.13237.32005.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sun, 06 Jan 2019 02:40:04 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 3 Jan 2019 09:05:52 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.21-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/926b02d3eb547daa1d56cf9b586f31b270488b77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
