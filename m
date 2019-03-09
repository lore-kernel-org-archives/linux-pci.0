Return-Path: <SRS0=rJvA=RM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25102C43381
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 23:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CDE20836
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552173317;
	bh=rerwvCREAWCea6IKEtYgW4w18VuIv4790HI8FPdbJC4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gj865o1zWUL7PyuPr5tp25FpUr/okwEHegFt/vvuEE3AtoeFO1YjLatTeooSozwkf
	 jKclaoa7svX3LLWQSm0SRfdpCNVH/B5MObir9G88Vfb+8QdTgFgdV7WHwutwl03UyK
	 DHVfLcrSzVyCARekvaRTjaRdfH35ptV1nKRsCg2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfCIXPQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 9 Mar 2019 18:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfCIXPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Mar 2019 18:15:15 -0500
Subject: Re: [GIT PULL] PCI changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552173315;
        bh=rerwvCREAWCea6IKEtYgW4w18VuIv4790HI8FPdbJC4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tdUNKG7Z4uP8Vj2xPQEvYTwGRh4xke6uDt6ySehVVtGMIvgE/AzZUxIbC5MWdQybq
         Krhopoc2dfm+RfTbgwkH1Sb4w6FEdzx6FF/KnHaii4pWMCi6ArsxpDVw4w6XOVHpZ5
         tyGAyYsE3s3r1l5FhrxRBoKqyqMnjuSVbwWjCkRQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190308173154.GC214730@google.com>
References: <20190308173154.GC214730@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190308173154.GC214730@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.1-changes
X-PR-Tracked-Commit-Id: dd92b6677e3d0d78e261a7f00f28e753bab41d24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2901752c14b8e1b7dd898d2e5245c93e531aa624
Message-Id: <155217331537.3273.469447299803230387.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 23:15:15 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 11:31:54 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2901752c14b8e1b7dd898d2e5245c93e531aa624

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
