Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6B1C433F5
	for <linux-pci@archiver.kernel.org>; Wed, 16 Feb 2022 06:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbiBPGAt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Feb 2022 01:00:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344695AbiBPGAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 01:00:48 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E311111FB3;
        Tue, 15 Feb 2022 22:00:36 -0800 (PST)
Received: from [192.168.55.37] (ip68-111-137-238.sd.sd.cox.net [68.111.137.238])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4Jz6km67fwz193F;
        Wed, 16 Feb 2022 01:00:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1644991235; bh=WHDwGF8eJzpXUzB5NB3DZN9sBFwhmfASyytRMPy2sXo=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=dSp2aF6+xDjkstjilYz3T6w4LWOK9SOB5+r8ZpyV2wGPkvxn2BKWFrBvF4c4duUVe
         /h4ekfys1Xml1YC392ReI4WGz4Gv9N8EjTKlnBd3CEP2LcF+MkCl6SONKkH0a5xvXv
         SKuwsL19SVEEopnrtRGTK+EefnRV188F6ztDdGE0=
Date:   Tue, 15 Feb 2022 22:00:31 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Vidya Sagar <vidyas@nvidia.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
In-Reply-To: <0ccd43af-0293-521b-86d3-ea2ea1c70e5c@nvidia.com>
Message-ID: <75a48fb6-3913-ccaf-3c-6d41bbbda533@panix.com>
References: <20220207163332.GA397884@bhelgaas> <79a41832-12e2-2ed-f3af-da3bac90d941@panix.com> <3ca14a7-b726-8430-fe61-a3ac183a1088@panix.com> <0ccd43af-0293-521b-86d3-ea2ea1c70e5c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 16 Feb 2022, Vidya Sagar wrote:

> I see that the ASPM-L1 state of Realtek NIC which was in disabled state before
> hibernate got enabled after hibernate.

That's actually my SD-Card reader; there's a good chance the BIOS does "something"
to it at boot time, as it's possible to boot from SD-Card on my laptop.

> This patch doesn't do anything to LnkCtl register which has control for ASPM L1
> state.

> Could you please check why ASPM L1 got enabled post hibernation?

I wouldn't know how to do that; if you're still interested in that let me know
what to do to determine that.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
