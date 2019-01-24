Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606B3C282C6
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 09:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C1A2184C
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 09:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfAXJZq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:25:46 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:32931 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfAXJZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 04:25:46 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 1FA2F2800B6DE;
        Thu, 24 Jan 2019 10:25:44 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 67152562EF; Thu, 24 Jan 2019 10:25:44 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:25:44 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex_Gagniuc@Dellteam.com
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, Austin.Bolen@dell.com
Subject: Re: PCI: hotplug: Erroneous removal of hotplug PCI devices
Message-ID: <20190124092544.of7xrgrjb4tfejgx@wunner.de>
References: <356432a0556d4da59f8ba5cf1d750019@ausx13mps317.AMER.DELL.COM>
 <20190123185420.2pennvzvkuhqfmtj@wunner.de>
 <20190123190723.rnt5llkek5st7ddt@wunner.de>
 <c43a8be3d0754d78a8c10b2ddb0a5c37@ausx13mps317.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43a8be3d0754d78a8c10b2ddb0a5c37@ausx13mps317.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 23, 2019 at 11:50:30PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> nvme issue aside, the device is removed. Then, a few seconds later, we 
> see Link Up and Card Present events, but no pciehp_isr() invocation. I 
> think it all happens in one pciehp_handle_presence_or_link_change(), so 
> pciehp_ist() is held up for a few seconds -- but that's a matter for a 
> different thread.

Yes, that's normal and expected.  The rationale is that we only know that
link or presence has changed.  It could even have changed multiple times.
Even if the link is now back up, we don't know if it's still the same card.
So the slot is brought down and if it's currently occupied or the link is
up, the slot is brought up again.

It would of course be possible to come up with more complicated schemes to
try to handle odd behavior such as a belated presence change after a link
change, but then it also becomes more complicated to reason about the
scheme's correctness and ensure that other types of odd behavior (such as
presence hardwired to zero) are still handled correctly.

Thanks,

Lukas

> [  785.007640] nvme 0000:b1:00.0: enabling device (0000 -> 0002)
> [  785.099567] pcieport 0000:b0:04.0: ZOPA: Status(0x00000040): 
> presence-detected
> [  785.099574] pcieport 0000:b0:04.0: ZOPA: Events(0x00000008): 
> presence-detect-changed
> [  785.099580] pcieport 0000:b0:04.0: ZOPA: Queued up(0x00000008): 
> presence-detect-changed
> [  785.099582] pcieport 0000:b0:04.0: ZOPA: pciehp_isr: exiting
> [  785.099611] pcieport 0000:b0:04.0: ZOPA: pciehp_ist: Entered with 
> events(0x00000008): presence-detect-changed
> [  785.099615] pciehp 0000:b0:04.0:pcie204: ZOPA: 
> pciehp_handle_presence_or_link_change: locked &ctrl->state_lock
> [  785.099618] pciehp 0000:b0:04.0:pcie204: ZOPA: 
> pciehp_handle_presence_or_link_change unlocked (POWEROFF)
> [  785.099621] pciehp 0000:b0:04.0:pcie204: Slot(178): Card not present
> [  788.756953] nvme nvme4: failed to mark controller CONNECTING
> [  788.756958] nvme nvme4: Removing after probe failure status: 0
> [  788.763317] pciehp 0000:b0:04.0:pcie204: ZOPA: 
> pciehp_handle_presence_or_link_change unlocked (POWERON)
> [  788.763322] pciehp 0000:b0:04.0:pcie204: Slot(178): Card present
> [  788.763349] pciehp 0000:b0:04.0:pcie204: Slot(178): Link Up
> [  788.892432] pci 0000:b1:00.0: [8086:0a55] type 00 class 0x010802
> [  788.892474] pci 0000:b1:00.0: reg 0x10: [mem 0xe1500000-0xe1503fff 64bit]
> 
