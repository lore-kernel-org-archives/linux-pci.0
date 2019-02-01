Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31798C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 07:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F357720B1F
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549005905;
	bh=IgHiGttKxYvvdC+g6uGXuvQ/rI4C6JUS+6XKsTY8ra0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pUvKZSFgwrOH5g186fztAfiRozuRA/9P4urGyvJjdNxnC1uU2HlzsrPf/HEToOW13
	 o0MxDGgbrlx3MIL1AqwTEB7rP6//LHSH+TzwnXUXcaPglWGM5rxYkDpX3NhtnG1Wmm
	 WRdcCGuYIaWseOo2nprrO3SijPxciQ+cpgMqIF6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfBAHZE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfBAHZE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 02:25:04 -0500
Subject: Re: [GIT PULL] PCI fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549005903;
        bh=IgHiGttKxYvvdC+g6uGXuvQ/rI4C6JUS+6XKsTY8ra0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UOLroitmYXcTOZv+TViWcDCRofCcAmNiLhJfMFhJ6k/DJb4oAxSX4oVBnT6m0gxvO
         bSmRvKV4Td/QbVG6otdm08NTbebEP6kPP9QMWYP/K+LdoQNj6lKPr144xLPfS/+314
         bjO7wOJOSf98NXDfodLHwBW+tTB3Maw0ZuQEDAho=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190131220332.GQ229773@google.com>
References: <20190131220332.GQ229773@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190131220332.GQ229773@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.0-fixes-3
X-PR-Tracked-Commit-Id: f14bcc0add3abecceca1a3fe538c4ec9566893f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44e56f325b7d63e8a53008956ce7b28e4272a599
Message-Id: <154900590354.3378.10205924401343881674.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Feb 2019 07:25:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Leonard Crestez <leonard.crestez@nxp.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 31 Jan 2019 16:03:32 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.0-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44e56f325b7d63e8a53008956ce7b28e4272a599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
