Return-Path: <SRS0=+EjW=US=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BBC31E5B
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 19:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C67B214AF
	for <linux-pci@archiver.kernel.org>; Wed, 19 Jun 2019 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560970817;
	bh=4tS97Pr0ErmEJ0dmGIvn8yN7CXskzmYBi9RKCDD/s08=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IyWfVLPoacQJUqOaiHECzdfWIRO7l+EqE71vO3QjR5VFyts7JIUAqTu9XcOXONBFE
	 R9Lvgx5W6m4AH87526/VWMgdSRRaRHUiuYrfTwGAn6MpMra7daeeuvap4/qhpDAo3O
	 0uwvrFDxjLaObYVqlZ30cUrNfQ1uFH/PMIwNWRwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbfFSTAI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfFSTAI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 15:00:08 -0400
Subject: Re: [GIT PULL] Power management fix for v5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560970807;
        bh=4tS97Pr0ErmEJ0dmGIvn8yN7CXskzmYBi9RKCDD/s08=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LqRnENBAOgDXl4L9WT6B/fIPEo5qn6eZ7cBNIEG89mB9cZRMB7SHbKVQhZntHr1jS
         2QP7V29Be0cDEBixDu6gwiuihQF5ylq6aWsFQ7ZfQW2xx/8N20f3FfW1TClseS6T0g
         UJQu8rFoq5rdJj5GW30qM44FrtlFg/UYNya9WWjo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hbF4i-mJ6thnu8HRNcAXBrw4=vqQG+ikufB2z3q82F4g@mail.gmail.com>
References: <CAJZ5v0hbF4i-mJ6thnu8HRNcAXBrw4=vqQG+ikufB2z3q82F4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hbF4i-mJ6thnu8HRNcAXBrw4=vqQG+ikufB2z3q82F4g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc6
X-PR-Tracked-Commit-Id: 3e26c5feed2add218046ecf91bab3cfa9bf762a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abf02e2964b3aaf1d5197c5d7c671e771b0e109e
Message-Id: <156097080742.11094.7724722899824028829.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jun 2019 19:00:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Wed, 19 Jun 2019 11:51:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abf02e2964b3aaf1d5197c5d7c671e771b0e109e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
