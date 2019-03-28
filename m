Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B33BC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1147D21850
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 21:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553807713;
	bh=/lto3nblCoJ/xB5kUfMaXciGkMPHNcezsgZ/OYEh0Z4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C83T81ZgQv/FGHhtwPMbMFa3+ZF0jmDOLdaPMfiuoNZ8vFYPcX1lQTnnkcy4TtDkZ
	 SOPZk8gmy2iK0w+0CnKxTfnmZkZ+A0lqfsmqPxmzqLh5LdY9zMXi9MjIXiy88ew7/v
	 sD+yGCf0G/DsbkGlDQR2KZHb3mJ2LnFo72VytA8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfC1VPM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfC1VPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Mar 2019 17:15:12 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553807711;
        bh=/lto3nblCoJ/xB5kUfMaXciGkMPHNcezsgZ/OYEh0Z4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mnmkfglvwftvUc1MHTvAiyvenHrIc8GTkgcrKQAKeZEjma9G9uYW8GqYR6mlkm1X4
         wzISlbVYjwi6ClmQpf5/sEvtZyO1LwSipMEU9vJPXsk/UcKNHtBlzUUxTOIFoJkJJt
         yB2zBE8SimHt3INZsxw5m+Q4Im2l8gHeZ6HDfcno=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190328190340.GD24180@google.com>
References: <20190328190340.GD24180@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190328190340.GD24180@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.1-fixes-1
X-PR-Tracked-Commit-Id: 0fa635aec9abd718bd18c0bda2261351a0811efc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9936328b41ce4bce8f20269dcac8cb476c8d0820
Message-Id: <155380771171.15619.13089115974206525840.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Mar 2019 21:15:11 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Borislav Petkov <bp@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 28 Mar 2019 14:03:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9936328b41ce4bce8f20269dcac8cb476c8d0820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
