Return-Path: <SRS0=KYvh=7P=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D1FC433DF
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6277F20663
	for <linux-pci@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130129;
	bh=6cCiFyMRcZFVDUkImbtj3s9jMcNm754T1C6+u8hcetU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vjkeqjfNuPgsjVji9iUr/J9OkA1IT5tcsXvY2f5n5FUvXNurIVHEY8pH0191C3Pdg
	 flRvhceG2TUJVNcx9HGsi9QMVVT4zWImmIPckLOBnhr8rzJHswzvTO6RQPpBEwr/we
	 znOcELPCN1LcgYuzyBBm52BDjjPvfSUvpDsT40N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFBUfX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgFBUfH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:07 -0400
Subject: Re: [GIT PULL] ACPI updates for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130107;
        bh=6cCiFyMRcZFVDUkImbtj3s9jMcNm754T1C6+u8hcetU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OJmJVUGDLnJZzfRUFMnNG8qW8+oZFSMK+R7idcNOnv72uDUaEwm63Njz++pGnpOXA
         o2zdZpDYwPU0Oza6Xi9kW0gibzFH4povFeZUTKB4QA7DOGVe/vQsHWlfJhBniwJC9T
         IXYE06rnwFwTRx9W1mvKyCewGve/VMFetc9tur3k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
References: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gfVaNkSvDCXghKKXL34cLTwyC5jWBX8TYZjPVUOEvdjw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.8-rc1
X-PR-Tracked-Commit-Id: 48ccdeddc54771ecdc46fac098bac689e9df24ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 118d6e98293b30aee378a6b08d27a35320a3e34f
Message-Id: <159113010703.19446.16764361401557635752.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:07 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 17:50:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/118d6e98293b30aee378a6b08d27a35320a3e34f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
