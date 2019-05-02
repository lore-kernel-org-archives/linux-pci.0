Return-Path: <SRS0=2y5r=TC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798AC43219
	for <linux-pci@archiver.kernel.org>; Thu,  2 May 2019 16:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6718B2089E
	for <linux-pci@archiver.kernel.org>; Thu,  2 May 2019 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556813706;
	bh=wo0T+i0/yTZST/FKctVVAfz0yPcbLbsb2iLsgbMQRWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Qjeh0DgcnqldUXUg2jwfyBtEA2o5gL6v0g+ls5xKs8dtUghtox6l0mGmUnIsBS/GW
	 dtoQL5GB3aTdR29sy9mJ7PZ/8+HPWd9aEO8l4TA5+inv/RWnpzbQIxdFAMV6EbquOm
	 AJ7ZrOrjffhHwRhUpb2QI5zFyRk73nykG2VqKC00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfEBQPF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 2 May 2019 12:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbfEBQPE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 12:15:04 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556813704;
        bh=wo0T+i0/yTZST/FKctVVAfz0yPcbLbsb2iLsgbMQRWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YOYH6T3jP+T0gniTK8g8PoZ8RzyBh7+5qkYBFFCCpkd2gm0iSSZWL7Z18GXO5Onhx
         kL5ScO6zhZVDdd2iUqlOrXNDCPN3XvI1be9qW8jL+UtxoXJNZEF5e2ZsOFeVvsgkjc
         nV68Z2niGaoe+H76JBva5fN6d/8XN3u6zerwLF7Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190502135538.GB11579@google.com>
References: <20190502135538.GB11579@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190502135538.GB11579@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.1-fixes-3
X-PR-Tracked-Commit-Id: 2078e1e7f7e0e21bd0291908f3037c39e666d27b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7a5b22b05472704ca3e891a3a3c7769c057413a
Message-Id: <155681370399.16515.9939074321887955249.pr-tracker-bot@kernel.org>
Date:   Thu, 02 May 2019 16:15:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <alex.gagniuc@dellteam.com>,
        Lukas Wunner <lukas@wunner.de>,
        Logan Gunthorpe <logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 2 May 2019 08:55:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7a5b22b05472704ca3e891a3a3c7769c057413a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
