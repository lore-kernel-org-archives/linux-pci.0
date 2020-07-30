Return-Path: <SRS0=ks55=BJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124BCC433E0
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jul 2020 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89E62173E
	for <linux-pci@archiver.kernel.org>; Thu, 30 Jul 2020 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596151204;
	bh=JrVLk0o6CVFXaktFz8Isdnj+a6/M8IzZuwzm05xKqDE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZCTX8FS6af8CQm+spYk2s5isv8CNbL5WuKpDumFHtguILtUANk38HUbJrl4iXQf5M
	 4V7C4Ab/F+V3FJ6fR3DZT3QR41U2kxYLpjCKbb1mzmapT30F48/ouzOU3gwX5sXDak
	 CU7nEBVfC9WizmZVIDKJttSzFzKY4am21WhafOpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgG3XUE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgG3XUE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 19:20:04 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596151203;
        bh=JrVLk0o6CVFXaktFz8Isdnj+a6/M8IzZuwzm05xKqDE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xn6q/yF06S8cfLB+dwL12IXCIH0nTn9xvHpbZXvLRL28X/rHNR9f7p50fryimIofK
         YCy8pZg7cP0eQvKbfmdh7uyfSyp163dM8K/f2lPj88yfkUCPJhnmSx88KrBpQbH2Kh
         21CcOi99TRtK3P+X3HSaC1yj5msh2A5JVA2qzLw4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200730185123.GA2057610@bjorn-Precision-5520>
References: <20200730185123.GA2057610@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200730185123.GA2057610@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v5.8-fixes-3
X-PR-Tracked-Commit-Id: b361663c5a40c8bc758b7f7f2239f7a192180e7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9644712a243ac47af4fe9cf65472d85c57753c7
Message-Id: <159615120377.31670.3867744662766130111.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jul 2020 23:20:03 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Hancock <hancockrwd@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Thu, 30 Jul 2020 13:51:23 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.8-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9644712a243ac47af4fe9cf65472d85c57753c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
