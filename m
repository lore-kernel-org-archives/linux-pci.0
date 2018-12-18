Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC795C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998B2218AC
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 23:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545177303;
	bh=8tk9jzuqeq3NB4zwAIsXpYQgu/X42DMz8I6osu04jEg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eypJfwHCyrxkmBimMCRQtcknfRFNsaFw8Sk32b7e25fLmeckIEB3g04RUapP0uGbS
	 bOCXm7+Xna204se+cFsoN0jQIY+m2hqFsMwWpfW2OpChTBksZG2YftZ+YeMpyBxLG9
	 PhFABzlZsWlOW8hjir8zkxXN2aHEtjd5j0MrdAi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLRXzD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbeLRXzC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 18:55:02 -0500
Subject: Re: [GIT PULL] PCI fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545177302;
        bh=8tk9jzuqeq3NB4zwAIsXpYQgu/X42DMz8I6osu04jEg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FQclNDVnIvYmlvG8qunGipQl9e7X9pLH/d0xjGNTwCiBpyL1lUBDtDhbI5jGWWU3b
         bE7Bg7vVng3r6Lz5p9dAUbnSn95CLIKh/XSA6sI2Iqu6PSQGPaX0onE9byv2W4DaMA
         PJbjOz80THmDaq66xaUfxDi71IoVUKucLM6b3l5A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181218214043.GA22610@google.com>
References: <20181218214043.GA22610@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181218214043.GA22610@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v4.20-fixes-4
X-PR-Tracked-Commit-Id: 1063a5148ac9d1606e80886fa53ee57d45fb4589
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e738441e803db6b61d5119df8f758396914fafd8
Message-Id: <20181218235502.14649.78248.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Tue, 18 Dec 2018 23:55:02 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yanjiang Jin <yanjiang.jin@hxt-semitech.com>,
        Keith Busch <keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Tue, 18 Dec 2018 15:40:43 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e738441e803db6b61d5119df8f758396914fafd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
