Return-Path: <SRS0=MTzy=AO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FDCC433DF
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D522145D
	for <linux-pci@archiver.kernel.org>; Fri,  3 Jul 2020 21:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593810913;
	bh=3RFNe7O4/XnANe+AF6v/cwBPi/6xSUP2qXTlQ9fyF5U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ixa8Slb/mwuWR0ZHDGu065odVBik8AAVsomMQBOtZlUMnsm7xh5K/ccDFmKJuZnJ8
	 +MJxCuobRrEQRBwPpMu0wYFl9Sg/Oixrp+MmWHqDe6ndwK4c605A4d0Cre6vDUImzh
	 dCwH8oOXvY2YAAzJLTBGX80yv+5CStDeg2xx8HXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGCVPL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgGCVPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jul 2020 17:15:09 -0400
Subject: Re: [GIT PULL] PCI fixes for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593810908;
        bh=3RFNe7O4/XnANe+AF6v/cwBPi/6xSUP2qXTlQ9fyF5U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TR/2R00xpe3/z5oOJT+t/HuRWfrIQEoG+ePGRlZfkf1u8Hao0vaQl6EOMckdcs11V
         MyESI1LXCUt3dduXDL5v1QJ9Tcw17GTovlaa1V00feNUoLEm226nJrKJrSOdwH55uy
         Y2hoLdbRk930d5XNzctJXQswZA5p/SeOmO0eQFS0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200703160455.GA3899841@bjorn-Precision-5520>
References: <20200703160455.GA3899841@bjorn-Precision-5520>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200703160455.GA3899841@bjorn-Precision-5520>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
 pci-v5.8-fixes-1
X-PR-Tracked-Commit-Id: 5396956cc7c6874180c9bfc1ceceb02b739a6a87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fec3ce50a5d3fc54de9c0e9d43682ea9320b199
Message-Id: <159381090863.9451.6625199989743957374.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jul 2020 21:15:08 +0000
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pull request you sent on Fri, 3 Jul 2020 11:04:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci-v5.8-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fec3ce50a5d3fc54de9c0e9d43682ea9320b199

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
