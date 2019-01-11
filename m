Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51529C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2A720878
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 18:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547229635;
	bh=CPkdzIJwCCTL4kV7PRBTf1UhJSkuzrkMfwXamgOd9hU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Y7AALIXeHGhGQuzXu3GDKRl94E9TRNZVTEkYahITyZmeQ6mAn1erbw3P7DKW45NN3
	 ajm7yrd+X7uWKyEbQ/Abve+r9G1ooATicYLSSyXDlSkJwLwxJ1Av77XzFRUrGexuLG
	 fDx0tlIenNyQ4mKZTtIiYWHRU9K5ml+dslMVZoLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbfAKSA3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733147AbfAKSAD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 13:00:03 -0500
Subject: Re: [GIT PULL] ACPI fixes for v5.0-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547229603;
        bh=CPkdzIJwCCTL4kV7PRBTf1UhJSkuzrkMfwXamgOd9hU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0yMcaGeGJ27jyZDGZZbB4sfkFpR36vHlTEWWIA3jB3uUu/FRtPUcxLeE0Tavyi0UL
         LqvZwnYNNUH7nZ3Ald+oakbj83QyK9T8nznC4J04WW3RtE2JwcDBZd58qXFTiaoElH
         iQ5UPepm5qsau/cVt95TCCPNPQM8UE87lgaH1DoM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jRxHZJW5aW5NPLx2pcD1g5dhYzdyUw_PUTRekhOsqeyQ@mail.gmail.com>
References: <CAJZ5v0jRxHZJW5aW5NPLx2pcD1g5dhYzdyUw_PUTRekhOsqeyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jRxHZJW5aW5NPLx2pcD1g5dhYzdyUw_PUTRekhOsqeyQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.0-rc2
X-PR-Tracked-Commit-Id: 65a4f3a1efda8e0cc2516301fc3ad64e3eca716c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e1b295b693cbf2d8499c24fbb1f8f50c58771e3
Message-Id: <154722960324.6916.158646042501178948.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jan 2019 18:00:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 11 Jan 2019 11:22:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e1b295b693cbf2d8499c24fbb1f8f50c58771e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
