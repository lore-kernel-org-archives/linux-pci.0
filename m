Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E786AC64EB1
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97B4208E7
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544217017;
	bh=G51QpWafA3KuMMRGPw1+aCnQsGh4lV8hM6NyFcvplLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aMbxjIJ0ic3s1tjygM2/ByCXgBNKGl6V6N8t8vgwc+3gC/R6RGaDt/RPRRatM5C6v
	 qAm+4/o4dsWBUE48F/BlOZbqvGk/5CtjGJApv+QFr58XZoefEM7iCKEOk33PTE0MvI
	 xK4CW/2fPFXoDk4r9MD8ew5T1LBe7qKP4tEyXdUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97B4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbeLGVKD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 16:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeLGVKC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 16:10:02 -0500
Subject: Re: [GIT PULL] PCI fixes for v4.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544217001;
        bh=G51QpWafA3KuMMRGPw1+aCnQsGh4lV8hM6NyFcvplLk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V2eLvoqWxSCQTtcPjt860gFut4fyAUueaAGcWdacQ4lSHmQpewtXIyuyfCtJD6Ilw
         xJODr7dMOsIDz918Y6meHTQQmWrNtnU6+WzDkrnwp7PyXse7rEzZpzkFlRnC5IEUUi
         qXPBqDaXOEyqhfzEickeSu+6IkMUWoiGop+bkZ6k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20181207204453.GA578@google.com>
References: <20181207204453.GA578@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181207204453.GA578@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 tags/pci-v4.20-fixes-3
X-PR-Tracked-Commit-Id: b07b864ee4232b03125992a8f6a490b040adcb6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b24f6c082b3777749ccd19c9beb8643fa718480
Message-Id: <20181207211001.8019.50466.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date:   Fri, 07 Dec 2018 21:10:01 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Patrick Talbert <ptalbert@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 7 Dec 2018 14:44:53 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.20-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b24f6c082b3777749ccd19c9beb8643fa718480

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
