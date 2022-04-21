Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36200C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 21 Apr 2022 21:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441920AbiDUVYk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiDUVYk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Apr 2022 17:24:40 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6910A4BFE3;
        Thu, 21 Apr 2022 14:21:49 -0700 (PDT)
Received: from [192.168.125.3] (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Kkr853YyLz1BtK;
        Thu, 21 Apr 2022 17:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1650576108; bh=fVX3MybKfqxHVC1WTpeImN5OO1kCXc9ZMVIQAFODbxE=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=Zsq1WiIZciZv4GGp62D/tglpwK1U1NUJ+6hjUpt+nQqq09lXQ2Kz11NquQiI8QEG4
         YlL7RHRQGDqJEEaejN+C81Tiit7FUGDAgJaAs1hNCkoNbeK8oH8h6UXRi/YT0pehoX
         riM3wVlh6GYI72Pz5k9LOLiviKudPfU46zChvT5k=
Date:   Thu, 21 Apr 2022 14:21:38 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        chris.packham@alliedtelesis.co.nz, yangyicong@hisilicon.com,
        treding@nvidia.com, jonathanh@nvidia.com, abhsahu@nvidia.com,
        sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Ricky Wu <ricky_wu@realtek.com>,
        Rajat Jain <rajatja@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Victor Ding <victording@google.com>,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <20220421211103.GA1426981@bhelgaas>
Message-ID: <2ff87bc9-2061-d0c-8cdf-13266a6b1343@panix.com>
References: <20220421211103.GA1426981@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Thu, 21 Apr 2022, Bjorn Helgaas wrote:

> Vidya's original patch [1] is not upstream, at least AFAIK.  Well, it
> *was* merged as 4257f7e008ea [2] in v5.11-rc1, but then reverted by
> 40fb68c7725a [3] in v5.11-rc7.

Ah, you're absolutely right- now that I think of it, you guys had me cherry-
pick the commit and IIRC it didn't fail when I'd done so:

----
Date: Sat, 5 Feb 2022 09:30:07 -0800 (PST)
From: Kenneth R. Crudup <kenny@panix.com>
To: Vidya Sagar <vidyas@nvidia.com>
Message-ID: <12fe557f-7336-1970-d8f0-5a93529cf8c1@panix.com>
...

I just reapplied it on top of Linus' master and not only did it go in cleanly(!),
NOW I'm not getting any issues after a suspend/resume. I've attached the output
of "lspci -vvvvnn" before a hibernation (but not the very *first* one; if you
need that output, let me know) and will submit the same post-hibernation (which
is the same as the pre-hibernation case) and the post-suspend case (which is
slightly different) in subsequent E-mails (due to attachment size).
----

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
