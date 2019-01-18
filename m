Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0DBC07EBF
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1062087E
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 19:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547840414;
	bh=cG/suexhWnoVG4agRKnj7UzX2DiXnZWCiDrC4IpfWAM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OR4dTP8AIorJ3YUZKixTkKQogmrhxhyAYbMLEgUrkQFRO9pxQWXPo7/2Bzekq4unJ
	 V31E/SLNPijZHOnl6Q6GEPEEH9qDpmgAyhx+OB1/M30cizjVaMT2qARVGVlZB9sbGN
	 EmIDVOgrGTOx2pWXB3nicCNHdKxp1J++wlmbCKGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfARTkJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbfARTkD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jan 2019 14:40:03 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547840402;
        bh=cG/suexhWnoVG4agRKnj7UzX2DiXnZWCiDrC4IpfWAM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lSC6TWqEpK0LZsfeQST1NAXJytARHs0fc88gXBIuAiz6z+nPXFUNuyKIekEz/skeu
         AZLnPqDxff/sw8B7enyXZ8nvXfre0BkCyNFoIy56VBjCTYWik95/xRiPyohg08Y3Hg
         KgsyeYYdTtwGJqbbt2mtNM2Ao3It6Nxeu9TJYFZs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190118190722.GA52844@google.com>
References: <20190118190722.GA52844@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190118190722.GA52844@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.0-fixes-2
X-PR-Tracked-Commit-Id: d2fd6e81912a665993b24dcdc1c1384a42a54f7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d28f3e721974378c404f16d17638d9ae5c0db0d2
Message-Id: <154784040279.4383.7377265306457026268.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Jan 2019 19:40:02 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 18 Jan 2019 13:07:22 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d28f3e721974378c404f16d17638d9ae5c0db0d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
