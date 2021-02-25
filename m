Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6804EC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CED764F27
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhBYSiQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Feb 2021 13:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233984AbhBYSha (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Feb 2021 13:37:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F80864F27;
        Thu, 25 Feb 2021 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614278205;
        bh=VobkIFVTdagdQFJoXDl2ODTK74l3/TAVlyqpuXbPn+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tgy6l4r2KX/GB6n30BhVrT3LzgNfht29NehwrhvfqBVvBPoHqSimNYkuGsUfOWueW
         gmdbAw1SUvfsoG+tVacYL/tRvCW4Qtt6zNo7a2rGvDEKAkfBlUpFHvXmrTE6SbEMcG
         Rcz9wjCXd7nN2UjjlivFMU5QQmvw5kG2zotWtzKxW/Kx5rnU91zHSqKuV1urUnJP2x
         UhsrEWtvvsgCNShNCBdvXF6vkCKICZjOyIhKFmFcsjWCgw7H5CfCbFMx/hfJLW+X7w
         tiyHkINLrzN+tMEKp7pmL/LkWBDseqdyspZoaykUFYgMuHwktqkYIHjDCtNTRELpQk
         3tAi+mNCV7ykw==
Subject: Re: [GIT PULL v2] PCI changes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210225153738.GA1730576@bjorn-Precision-5520>
References: <20210225153738.GA1730576@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210225153738.GA1730576@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes
X-PR-Tracked-Commit-Id: e18fb64b79860cf5f381208834b8fbc493ef7cbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b47b10e8fb92f8beca6aa8a7d97fc84e090384c
Message-Id: <161427820549.26451.13322892856799080814.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Feb 2021 18:36:45 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 09:37:38 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.12-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b47b10e8fb92f8beca6aa8a7d97fc84e090384c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
