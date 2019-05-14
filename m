Return-Path: <SRS0=pnCm=TO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95DC04AB4
	for <linux-pci@archiver.kernel.org>; Tue, 14 May 2019 17:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793FA2168B
	for <linux-pci@archiver.kernel.org>; Tue, 14 May 2019 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557856216;
	bh=ya3JMMh00IKEsS7oUCfYw1X6QIxxjZunEQhizoLuqJ8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=siFNMxfcDPFuFa+J2i/q9moC23DUFhxqNYuOzEjpyWHCGT4DwWwh2lWN3n3miDJ0T
	 0Tl9iKssuqwNFAH/WC+uakNbAw6hrlHsc/0okGNoN15Nrv8CAU5dkmDA3zc3QUb9Q6
	 hAdO8VlxAIXnrSLqKxq3Zq83PlHdZNo9b/8JQMfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfENRuP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 14 May 2019 13:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfENRuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 13:50:15 -0400
Subject: Re: [GIT PULL] PCI changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557856215;
        bh=ya3JMMh00IKEsS7oUCfYw1X6QIxxjZunEQhizoLuqJ8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XHNK+blq7Slq6BhEzYuajQzV1kABvHICgc+z4GRZHvER7THbaKfEC1HZGqLxCfWpw
         tJjhpMg54jk3N18s0gSDuc8mv6whmpYNKR3ooXWquvtTeH5TtIkV9axWOINNUCZ0+D
         fQBnIVs5RQK5iLY5IA9RI/D1NON1clc/tlnbxfHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513235721.GA157967@google.com>
References: <20190513235721.GA157967@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513235721.GA157967@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.2-changes
X-PR-Tracked-Commit-Id: c7a1c2bbb65e25551d585fba0fd36a01e0a22690
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 414147d99b928c574ed76e9374a5d2cb77866a29
Message-Id: <155785621504.23900.1392426879614602636.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:50:15 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 18:57:21 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.2-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/414147d99b928c574ed76e9374a5d2cb77866a29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
