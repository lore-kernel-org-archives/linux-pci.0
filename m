Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97DDC433E6
	for <linux-pci@archiver.kernel.org>; Mon, 28 Dec 2020 06:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E4D221F9
	for <linux-pci@archiver.kernel.org>; Mon, 28 Dec 2020 06:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgL1GbH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:31:07 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:51016 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgL1GbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 01:31:07 -0500
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4D472h4wLnzg13;
        Mon, 28 Dec 2020 01:30:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1609137021; bh=rqwwdRE/V+Ax8uR0N/Jf/w4DFnhxOTyyJ01rCAeMMHY=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=HB1IKYwHu0ICvhA5ESYu9KAOTKZH1Q7Bc4dnYb9IHg5QXyxGqVwgmd8g2BZjrX26A
         xLplP/fTZxsHcvH9eNwIkRu2fcl+Jqqryk9X/Qlxqxm/yySw2Lbmq+4FjsrkTQ+/Kq
         VV+c31IHEiQQaFN4dhL3FV3+9pAkeqzFWnWlOaEo=
Date:   Sun, 27 Dec 2020 22:30:19 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
In-Reply-To: <88d569d8-09c-6bfc-c246-f4989bfbc1@panix.com>
Message-ID: <cb32b83e-108b-47e5-812-9c26712de9a0@panix.com>
References: <20201228040513.GA611645@bjorn-Precision-5520> <88d569d8-09c-6bfc-c246-f4989bfbc1@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Sun, 27 Dec 2020, Kenneth R. Crudup wrote:

> I'll try your patch after the revert and see if anything changes.

I just realized today's patch makes no sense if it's reverted, so nevermind.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
