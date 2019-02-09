Return-Path: <SRS0=+kTV=QQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F14C169C4
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DE220844
	for <linux-pci@archiver.kernel.org>; Sat,  9 Feb 2019 00:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549672847;
	bh=iU/WEY2Y/Kx/W2pVXjZX6VWbNDdfqAKdCamjPfxO1RY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MS1mMEw6HUWLJK61aDSbOPnTp6i6Et6tjcbFWBBX892PQxTKcRO7kI+3nTHPLzdyj
	 YVwv4svcWv++G5ke4s1vYzbFk3lR864yXRliH3XMArDbcA8U3ywz8zTgvhgXMnVjat
	 JqJUmcqx3zPWQROQGA88VKfoDm9b2PnZimTfLshg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfBIAkc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:40:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:55760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfBIAkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Feb 2019 19:40:04 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549672804;
        bh=iU/WEY2Y/Kx/W2pVXjZX6VWbNDdfqAKdCamjPfxO1RY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0jB5+Qwt1EGGVztszEjePPD6ypB1iwvJgRj87RumyDfsrCpHTDRYRJlLYwbpp0/iC
         mxbvdQOwASvrNtjpBJuLjJdf6ozHmU1vsQTWrcO7b9q6MmVXZffkCfU0mbDRA7ZYEO
         fgA3KdZGjXZn7up2cSTIY468xB+BVcfdxMGHpsU0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190208142353.GV7268@google.com>
References: <20190208142353.GV7268@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190208142353.GV7268@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.0-fixes-4
X-PR-Tracked-Commit-Id: f57a98e1b71357713e44c57268a53d9c803f0626
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70be9ac2b64c0d0db4f0e3004b764df33b1098e2
Message-Id: <154967280419.26526.9991256886487805721.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Feb 2019 00:40:04 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thinh Nguyen <thinh.nguyen@synopsys.com>,
        "Lukas F. Hartmann" <lukas@mntmn.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Lucas Stach <l.stach@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 8 Feb 2019 08:23:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70be9ac2b64c0d0db4f0e3004b764df33b1098e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
