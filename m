Return-Path: <SRS0=9tGp=3U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B46C2D0DB
	for <linux-pci@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5185215A4
	for <linux-pci@archiver.kernel.org>; Fri, 31 Jan 2020 23:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580512221;
	bh=A9zDSHkPt5djVFhXJVI200zBLGeM7r/vLu6ZohRK4JQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zMLKPVbQsrTmmv6ee7rR/ZBFImEQ2fOymJ9gmOs75cfIBPQTl4+MkLV3CasJ8/J6h
	 I2X7ssmcVEeKmOfHyI/rXUK3QwgrzC/nEHGSfZ02qV7GKeodtl5jopuOoiZ1o1znuT
	 gSQtUqor3EuH7D78WveTLVovZrdlAG/CX9Bh9lNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAaXKV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 31 Jan 2020 18:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgAaXKU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 18:10:20 -0500
Subject: Re: [GIT PULL] PCI changes for v5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580512220;
        bh=A9zDSHkPt5djVFhXJVI200zBLGeM7r/vLu6ZohRK4JQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b/pmDiQmYX3Z++86Ijn9Gh06tkXRHiAJ8pN20iB4UYkXc+Ze/Ayi8SH+nSieNrHQf
         Js5j12XbwYuEZi4TLkcIHD1iiMXv3pn0GBwmd87SRLAmjUjsaf+W/xFZ5q+5/6T+W5
         c+KENBPemcxzsgSXahooszJclyriydfm0oXwO168=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131223407.GA105848@google.com>
References: <20200131223407.GA105848@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131223407.GA105848@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187
X-PR-Tracked-Commit-Id: 01b810ed71878785d189d01e4d7425a11203d7a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26dca6dbd62d74a5012cafab6b2d6d65a01ea69c
Message-Id: <158051222017.10603.3475601442315291583.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 23:10:20 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 31 Jan 2020 16:34:07 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26dca6dbd62d74a5012cafab6b2d6d65a01ea69c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
