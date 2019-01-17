Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787D9C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 18:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5223020657
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 18:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfAQSau (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:30:50 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:58207 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfAQSau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 13:30:50 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4A3942800B488;
        Thu, 17 Jan 2019 19:30:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EA80814075A; Thu, 17 Jan 2019 19:30:46 +0100 (CET)
Date:   Thu, 17 Jan 2019 19:30:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC PATCH] PCI: hotplug: Fix surprise removal report card
 present and link failed
Message-ID: <20190117183046.gvwf7rwi7eqgtkbg@wunner.de>
References: <1547649064-19019-1-git-send-email-liudongdong3@huawei.com>
 <20190116142235.6drd6avwk3e7rtwd@wunner.de>
 <aeec5f59-1f41-65d0-b2c1-7a606e32e58b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeec5f59-1f41-65d0-b2c1-7a606e32e58b@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 08:07:13PM +0800, Dongdong Liu wrote:
> ??? 2019/1/16 22:22, Lukas Wunner ??????:
> > On Wed, Jan 16, 2019 at 10:31:04PM +0800, Dongdong Liu wrote:
> > > The lspci -tv topology is as below.
> > >  +-[0000:80]-+-00.0-[81]----00.0  Huawei Technologies Co., Ltd. Device 3714
> > >  |           +-02.0-[82]----00.0  Huawei Technologies Co., Ltd. Device 3714
> > >  |           +-04.0-[83]----00.0  Huawei Technologies Co., Ltd. Device 3714
> > >  |           +-06.0-[84]----00.0  Huawei Technologies Co., Ltd. Device 3714
> > >  |           +-10.0-[87]----00.0  Huawei Technologies Co., Ltd. Device 3714
> > > 
> > > Then surprise removal 87:00.0 NVME SSD card. The message is as below.
> > > 
> > > pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
> > > iommu: Removing device 0000:87:00.0 from group 12
> > > pciehp 0000:80:10.0:pcie004: Slot(36): Card present
> > > pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec
> > > pciehp 0000:80:10.0:pcie004: Failed to check link status
> > 
> > What is the problem that you're trying to fix?  That these messages
> > are logged?  Or is there a bigger issue?  If the only problem are the
> > messages, then I feel that the current behavior is a feature, not a bug.
> > We could probably tone down the "Failed to check link status" message's
> > severity.  (Currently it's KERN_ERR, all the other messages are KERN_INFO.)
> 
> Yes, the only problem is the messages, looks not good,
> as the card have been removed from board, the message still show
> card present and failed to check link status.
> Only tone down the "Failed to check link status" message's severity
> seems not good enough.

Well, getting messages like this is par for the course with PCIe hotplug.

E.g. some older Thunderbolt controllers do not support MSI on their
hotplug ports, but only INTx.  If multiple such devices are daisy-
chained, they'll share an interrupt, so whenever a device is hot-removed,
a "pciehp_isr: no response from device" message is logged with
KERN_INFO severity because the hot-removed device was inaccessible
for its interrupt handler.  The interrupt didn't come from the
hot-removed device of course but from another one further upstream
in the daisy-chain where the plug event occurred.  We can't do much
better with such broken hardware.

The reason you're seeing messages is because it takes an unusually
long time for the controller to clear the Presence Detect State bit
after a Data Link Layer State Changed event upon hot-removal.
That's arguably a quirk of the hardware you're dealing with.

pciehp cannot tell whether the Presence Detect State bit is set
because a new card is already present in the slot or if it's trailing
hot-removal and will be cleared shortly.  The protocol doesn't allow
for a clear disambiguation, so pciehp copes by optimistically trying
to bring up the slot, and giving up after a certain delay.

There is other quirky hardware out there which flaps the Presence
Detect State and Data Link Layer Link Active bits a couple of times
before they become stable, which is why pciehp needs to try for a
certain period to bring up the slot.

Again, we could probably tone down or remove some of the messages,
but that might make it harder to diagnose when something really
doesn't work.  It's Bjorn's call anyway.

Thanks,

Lukas
