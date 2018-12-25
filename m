Return-Path: <SRS0=LLyr=PC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193BC43387
	for <linux-pci@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54F1218C3
	for <linux-pci@archiver.kernel.org>; Tue, 25 Dec 2018 23:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545780075;
	bh=b5Fh1jRt2HDuJR/inF6v5s/HeQfOfFBXS5UnQuSVeaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c9V6oUZBoueM/eeWF6w+OTUHgJPC/mKzFcI/CV2ThdImqfRHbP71vqzxSderC37nD
	 PyckgX0SkQCkycpkKp9A6x4oEou30kc2Gilwh9bPp0BtJ6N83CijHllOCrxnFH/Rmc
	 80o7Oz/EG3n/vu1vtnAmwGEol8up8waSU+rsePUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeLYXVG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Dec 2018 18:21:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbeLYXUG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Dec 2018 18:20:06 -0500
Subject: Re: [GIT PULL] ACPI updates for v4.21-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545780005;
        bh=b5Fh1jRt2HDuJR/inF6v5s/HeQfOfFBXS5UnQuSVeaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ENARSGB8yAhWakcieVxM2qcQipBn5iD3Ymf5gvrGJNbEb0s33BmWh9kvCMnh7HFoP
         o85nZuIG+XIQk7geoJLxAOXOS4bLwciK6J6csROk6NkPwa7+cBg1+ejX9zSqvUwIVu
         X3DAFk3l7x27inBiMGUCQph+oRzzyPh+q5bCcjBE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iskAJZADqKOncZ01wAD4CysUwUwqtTB-3kAu8umMfGBQ@mail.gmail.com>
References: <CAJZ5v0iskAJZADqKOncZ01wAD4CysUwUwqtTB-3kAu8umMfGBQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iskAJZADqKOncZ01wAD4CysUwUwqtTB-3kAu8umMfGBQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-4.21-rc1
X-PR-Tracked-Commit-Id: 3eb85368460d942005ba305829e279d0fe4767e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6d1315006383e525595bb3337d08bccec373ccc
Message-Id: <20181225232005.23808.55336.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 25 Dec 2018 23:20:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 21 Dec 2018 12:08:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-4.21-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6d1315006383e525595bb3337d08bccec373ccc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
