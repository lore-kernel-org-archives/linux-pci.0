Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FE3C433FE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Oct 2022 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJKSYE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiJKSWj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 14:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FDB7963A;
        Tue, 11 Oct 2022 11:22:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A846AB81665;
        Tue, 11 Oct 2022 18:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 645B9C433D6;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665512530;
        bh=cA6PTIVJXeIzUWlZ/Ujc6xNSYgkQDgpu8EBLr/Z9E5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fAYLeajpaWv4Yed9IJhufklbS+oF7Gj1UcWB2kJ5Kye2YlhdFDXINuIcxHB/ezDpb
         aRZpJNL4gs89seDm+G02Eq9V96BlRvdQoy+4Dd+5P2B5ELPFZO3Or6yC/hhNeMIC57
         hR7SXUmgSj0dQbeMzo2pU5LeLSSNUcHVGQH9iX9nW9EGg9h2Vq5090ETGBhE3b0o4V
         YnC3QxIqy3+c4N4hALUE9Tg/UixHIBGgzmVdp/R7+sa/UO6g/8AVWjALn1r2dJHO+s
         w1bfEQsN7RfVMC2KbhXH4GnodgmzR+JjMAf/ivPO5OS4bfl9V8nW5LsZ4H/QsWjWxU
         YKa5VhlKo3mQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51AFBE29F33;
        Tue, 11 Oct 2022 18:22:10 +0000 (UTC)
Subject: Re: [GIT PULL] PCI changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221010204746.GA2935311@bhelgaas>
References: <20221010204746.GA2935311@bhelgaas>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221010204746.GA2935311@bhelgaas>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-changes
X-PR-Tracked-Commit-Id: 0e00a3aeae255416577fc69b9b49be4778c05464
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 041bc24d867a2a577a06534d6d25e500b24a01ef
Message-Id: <166551253033.20259.10226390257743370623.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Oct 2022 18:22:10 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 10 Oct 2022 15:47:46 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v6.1-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/041bc24d867a2a577a06534d6d25e500b24a01ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
