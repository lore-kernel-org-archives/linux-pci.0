Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE2ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE80214C3
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 07:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE80214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJQPul (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:50:41 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35653 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQPul (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 11:50:41 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A9FE4300803A1;
        Wed, 17 Oct 2018 09:56:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 82716E1BF9; Wed, 17 Oct 2018 09:56:12 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:56:12 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>
Subject: Re: [Bug report] NVMe and RAID probe fail with commit cdf6b7362108
Message-ID: <20181017075612.eie3i44myjyj6r6d@wunner.de>
References: <ce7332ed-0dfb-da20-40e8-702c755d3e08@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce7332ed-0dfb-da20-40e8-702c755d3e08@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 11:38:11AM +0800, Hanjun Guo wrote:
> We met NVMe and RAID probe failure on 4.19-rc1+ based kernel on
> Hisilicon D06, then we bisect to this commit:
> 
> cdf6b7362108 "PCI: pciehp: Always enable occupied slot on probe"
> 
> Reverting this patch makes the system back to functional, I'm not
> sure why this lead some regression on our board, could you share
> some idea on this?
> 
> Boot log below, [0] is the failure one, [1] is the good one,
> please let me you if you need something more.

Please cherry-pick the following linux-next commit and test if the
issue goes away:

    commit 80696f991424d05a784c0cf9c314ac09ac280406
    Author: Lukas Wunner <lukas@wunner.de>
    Date:   Sat Sep 8 09:59:01 2018 +0200
    
    PCI: pciehp: Tolerate Presence Detect hardwired to zero

If this does not fix the issue, please provide full dmesg output for
the working and non-working case with "pciehp.pciehp_debug=1" on the
kernel command line, preferrably attached to a bugzilla entry.

Detailed analysis of the dmesg output you've already provided:

There are 9 hotplug ports but devices are only present below 4 of them:
a RAID adapter, a BMC with VGA, a 2x 10G Ethernet adapter and the NVMe drive:

0000:00:00.0 [19e5:a120] bridge to [bus 01]
0000:00:04.0 [19e5:a120] bridge to [bus 02]
0000:00:08.0 [19e5:a120] bridge to [bus 03]: 0000:03:00.0 [1000:0097] mpt3sas *
0000:00:10.0 [19e5:a120] bridge to [bus 04]: 0000:04:00.0 [19e5:1711] hibmc   *
0000:00:12.0 [19e5:a120] bridge to [bus 05]: 0000:05:00.0 [8086:10fb] ixgbe
                                             0000:05:00.1 [8086:10fb] ixgbe
0000:80:00.0 [19e5:a120] bridge to [bus 81]: 0000:81:00.0 [19e5:0123] nvme    *
0000:80:08.0 [19e5:a120] bridge to [bus 82]
0000:80:0c.0 [19e5:a120] bridge to [bus 83]
0000:80:10.0 [19e5:a120] bridge to [bus 84]

Of the 4 occupied hotplug ports, 3 exhibit a hardware bug wherein the link
is reported to be up but the Presence Detect State bit in the Slot Status
register is zero.  Consequently pciehp deems the slot unoccupied.
I've marked the broken ports with an asterisk *.

The above-mentioned commit works around such broken hardware but so far
we knew only of a single affected chip, the Wilocity/QCA wil6210.
It looks like this bug is more common than we thought, so it might be
worth applying it already to v4.19.  However v4.19 is expected to be
released in 4 days, so backporting to a 4.19 stable release might be
more practical than squeezing the commit in before the coming Sunday.

For some reason the hotplug port 0000:00:12.0 with the 2x 10G Ethernet
adapter does not exhibit the hardware bug.

HTH,

Lukas
