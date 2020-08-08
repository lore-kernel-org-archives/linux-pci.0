Return-Path: <SRS0=R5hS=BS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D206C433DF
	for <linux-pci@archiver.kernel.org>; Sat,  8 Aug 2020 03:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02255221E5
	for <linux-pci@archiver.kernel.org>; Sat,  8 Aug 2020 03:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596856550;
	bh=dyGGaahz2m+KP91EeZUlKEt1HoMOeGkK62y6euhywpM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ijc/qBbZ1WSPEB/2zm8hUeThO4tcEOXlHr5KZeVi7JuUedcHa3tL8RkjrcCcVjiky
	 Ag7ppmu/HiWS60Wc7z/SfHKUk1Mc5ak04eWowInPgBIjiDqBt0ui9ApmP1ZGgDNfbq
	 y5+H95d8ZwasGOyPYTX3xJ5QgYt5361dBtaLxmGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHHDPt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Aug 2020 23:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHDPt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Aug 2020 23:15:49 -0400
Subject: Re: [GIT PULL] PCI changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596856548;
        bh=dyGGaahz2m+KP91EeZUlKEt1HoMOeGkK62y6euhywpM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gKke5w7+XFEROp1X7h1dwOj135HAH0/X9S0TtVUtzh6x6x49f4VLWn4P6FnUWGBGF
         5c5GmLFkTEpFrRPN+us4WOSUWfojz1sbozPAveao7WLOBafVzQRCjexhziKGGuhQW+
         JWf5b6HAy2EFWwZGHpkCFGFGwqBXV3R0mPSOUTV0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807220453.GA778258@bjorn-Precision-5520>
References: <20200807220453.GA778258@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-pci.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807220453.GA778258@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-changes
X-PR-Tracked-Commit-Id: 6f119ec8d9c8f68c0432d902312045a699c3e52a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 049eb096da48db0421dd5e358b9b082a1a8a2025
Message-Id: <159685654878.14222.4386114819592333282.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 03:15:48 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 17:04:53 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v5.9-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/049eb096da48db0421dd5e358b9b082a1a8a2025

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
