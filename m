Return-Path: <SRS0=+1WX=V6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A77C433FF
	for <linux-pci@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8D721726
	for <linux-pci@archiver.kernel.org>; Fri,  2 Aug 2019 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564761925;
	bh=3rMZaXbQ41/dbreVvWj6reoVXIkk+yBfu5l630T1gKY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1OXsKQUCwPLkrv1SbyifB++DCkIbUrFUXPwTYG6xYOJYBLat7vXqg6HL5tWpCQT2d
	 07+nDFwTYgz5kNJqfxA7MjBwfrIShwgoP+tMBUJ4cDgy1DBA4VRntZmvZWEQqi12MK
	 +Dk1GMlCjZ5RVXnBsdrzPWVV7+WPrjNR2GYLLPOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbfHBQFT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388999AbfHBQFO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:14 -0400
Subject: Re: [GIT PULL] Power management fix for v5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564761913;
        bh=3rMZaXbQ41/dbreVvWj6reoVXIkk+yBfu5l630T1gKY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vEpwfarRPNtcJ/ojIlXH1CthZUvzPjolvFJDkSMPiLq/GgYRbENby6zmo3otakS17
         xt75TK5D/3MupqGg1hR/wzCPLzFxjNXGpyB1eyzPW7tOWJhQMc/7fn2dk3weoqYrXp
         pX9+2qEGeAOvanMb7xJhXahtiS/GDSOOEZUIn7RA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i+ZJEdVw=sZfB1KUuqJFWA=mSfB6jL66c1HFfZN9MR6g@mail.gmail.com>
References: <CAJZ5v0i+ZJEdVw=sZfB1KUuqJFWA=mSfB6jL66c1HFfZN9MR6g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i+ZJEdVw=sZfB1KUuqJFWA=mSfB6jL66c1HFfZN9MR6g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc3
X-PR-Tracked-Commit-Id: 42787ed79638dc7f0f8d5c164caba1e87bfab50f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 755f1fed27f4b1d57dd8b2856c06086636cd7284
Message-Id: <156476191344.27663.6822076135265555352.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 16:05:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 11:45:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/755f1fed27f4b1d57dd8b2856c06086636cd7284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
