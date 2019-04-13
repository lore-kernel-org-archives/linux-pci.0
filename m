Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94FCC282CE
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75987218C3
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555192822;
	bh=1vTvPIxs+K5a/z+5OpkDbJ+D9avwhyLeZDX0kfpch0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Z3063CeC4fn4oK58Yn4Qjr3vDwdNOJb8Q9SvYb1tlCMhGRsIRXKzaxLEkn0tootgl
	 72qVQfTwlLwb3pG2e02LDRe3C5AbE+7UTcop8osGtV001E5bB6S8huLkDSXNTbr902
	 7658Iaupf1lC32/zRS+zPZN4jhWLkF77rUwwa4rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDMWAG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfDMWAG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 18:00:06 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555192806;
        bh=1vTvPIxs+K5a/z+5OpkDbJ+D9avwhyLeZDX0kfpch0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pPgf154FbQQLMv2+G7FgmIMWZJidHBYGxEF4SIfbpC9v0DgT0s0t5qFsVaYjU8B/k
         kNj31cSWZhTMnLFgqAsQzos8zi20ON9DL1L7Yp5SyfNjOcV8Q7STBxb2PpJeTgU/f7
         gP8yW5kHHpGx8N26f6V6F+/0GTfoO3QBdaVi96Ko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412153838.GA126710@google.com>
References: <20190412153838.GA126710@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412153838.GA126710@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.1-fixes-2
X-PR-Tracked-Commit-Id: 3943af9d01e94330d0cfac6fccdbc829aad50c92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3b84248628df52c39c8724fb69da1ea0f2c0dc7
Message-Id: <155519280582.8399.4770215658924154204.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 22:00:05 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>,
        Micah Parrish <micah.parrish@hpe.com>,
        Andre Przywara <andre.przywara@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 10:38:38 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.1-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3b84248628df52c39c8724fb69da1ea0f2c0dc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
