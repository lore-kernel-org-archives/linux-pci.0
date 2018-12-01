Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B3C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2BC2147D
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 20:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2BC2147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725739AbeLBHSU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeLBHSU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 02:18:20 -0500
Subject: Re: [GIT PULL] PCI fixes for v4.20
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621E02147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181201055953.GA207198@google.com>
References: <20181201055953.GA207198@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181201055953.GA207198@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v4.20-fixes-2
X-PR-Tracked-Commit-Id: c74eadf881ad634c68880e2c1b504989d95993ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c734b42583bc391d86ed64e3be25fd5f2c464124
Message-Id: <20181201200502.20294.18733.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Sat, 01 Dec 2018 20:05:02 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 30 Nov 2018 23:59:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c734b42583bc391d86ed64e3be25fd5f2c464124

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
