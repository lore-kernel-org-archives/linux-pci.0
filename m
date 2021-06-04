Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D099C4743C
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 22:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2EA61402
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jun 2021 22:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDWYm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jun 2021 18:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhFDWYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 18:24:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F1A9B613EA;
        Fri,  4 Jun 2021 22:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622845374;
        bh=jSrWRIr09kTLc4LxiFgIRW8Tl73YDsG/oZ2mL8odDKo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TuTAgjZysdbc+iCj6pUckQAuZnE8c9zLvrCrjejnH7vqJBjLYWqEi4OqJFSJkJOVV
         N6/xotTqbzO0QEwqD6f2zbcTx1A5TZZlxP6q3/7C3Frm191b6Tf6b16zDE7XmG3APR
         2QDFjAi+PwiX2c4huHKnnxb2xhRM53Bd+4+JgdMuwPysU/vdr4qjDjEUSKjkdz6GZF
         3MAH/kJTnNhdZuGJuXiXoVtc+8bvIqM4iMHTNnmNlkqvrWz+VlUZJpxqvPoxJxMRiG
         ARFwJhk0qjbN+QeWFi5ysuqkIfV+yOy4vQ4IQwHq7iTlObE1ZCKA1oOzTSmHyn09G9
         zQ1w+OQzYWcoA==
Subject: Re: [GIT PULL] PCI fixes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210604201235.GA2233426@bjorn-Precision-5520>
References: <20210604201235.GA2233426@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210604201235.GA2233426@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-1
X-PR-Tracked-Commit-Id: 85aabbd7b315c65673084b6227bee92c00405239
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff6091075a687676d76b3beb24fa77389b387b00
Message-Id: <162284537384.19859.18440839311960107769.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Jun 2021 22:22:53 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 4 Jun 2021 15:12:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.13-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff6091075a687676d76b3beb24fa77389b387b00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
