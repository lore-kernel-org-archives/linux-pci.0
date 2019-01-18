Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E2C5AC81
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7544E20850
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547834718;
	bh=irQFFP4LrlUkNMKUw2NcmrlhHiQwWxJYH/vR1inXTw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iQAegnyJEzkICOJZGfAWqaf/oOBKwTHBhTWaQQuTeKDRm5LCWiBadBJCw5XpNTWB2
	 SbPcVrj7ezqQaYp5bKeYajPHStkxrTqqxnvyJgy1FG4SznB1va4EqNZAkylD/yTtXB
	 2hhU2FjGFu605RnA23kRX52CDbZ2Ca3kuVIqReWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfARSFE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbfARSFD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 13:05:03 -0500
Subject: Re: [GIT PULL] ACPI fixes for v5.0-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547834703;
        bh=irQFFP4LrlUkNMKUw2NcmrlhHiQwWxJYH/vR1inXTw4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N59OPuuBk3CmPMVFhCqKeCUf3pyJNJwRm9DbM/dZjg6vFd1TSXpKpxiZKE55hN5uE
         c5eIk5JMpqLo6xi1KiysQlIa7ZWuE9/tE3AJmrqhy6FOiypxDe8VSQo6PmU2mm8tFW
         TCrYrQhNgdbNmapeKwIZPN/+nqb0lOsky59Vncb0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com>
References: <CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jiK=zLP4cUsw=y9ea7PLHHgy=xshAsHFhTgyDJH+kOiQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.0-rc3
X-PR-Tracked-Commit-Id: 11ee2a3808aebbec73096551a716dea03d417fcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e434bf2e36b8a111c4dea6c1d1e355ad39ec01b
Message-Id: <154783470310.23992.1452854172956846260.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 18:05:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 12:24:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e434bf2e36b8a111c4dea6c1d1e355ad39ec01b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
