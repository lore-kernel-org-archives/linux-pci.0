Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91432C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 02:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA122077C
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 02:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfDOC7L (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:59:11 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:42827 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfDOC7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 22:59:11 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 245E3100DECAB;
        Mon, 15 Apr 2019 04:59:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id BE35337FB4; Mon, 15 Apr 2019 04:59:08 +0200 (CEST)
Date:   Mon, 15 Apr 2019 04:59:08 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Spencer Lingard <spencer@mellanox.com>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] PCI: pciehp: Fix false command timeouts on boot
Message-ID: <20190415025908.bd45jqtp62eeuiuz@wunner.de>
References: <1554919668-24873-1-git-send-email-spencer@mellanox.com>
 <20190414193641.xo7yf4uqh7ci7lci@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414193641.xo7yf4uqh7ci7lci@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 14, 2019 at 09:36:41PM +0200, Lukas Wunner wrote:
> I suppose this can happen if a write to the Slot Control register is
> performed while HPIE and/or CCIE is disabled, the two notifications
> are subsequently enabled and another write to the Slot Control is
> performed.  That second write will then call wait_event_timeout()
> because of the stale ctrl->cmd_busy == 1, but the Command Complete
> notification has already happened and was cleared by pcie_poll_cmd(),
> hence it times out.
> 
> Sounds reasonable, I'm a little suprised though that I've never seen
> this myself.  I guess we've been doing this wrong for years, so:

On second thought, it's not surprising at all that I never saw this
because Thunderbolt sets NoCompl+, so doesn't use Command Complete
notifications.

I suspect that even though we've been doing this wrong for a long time,
the bug was exposed by a recent change to pciehp.  Do you happen to
know since which kernel version or commit you've been witnessing the
timeouts?

Thanks,

Lukas
